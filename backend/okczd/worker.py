import datetime, math

import redis
from aiohttp import web
from settings import priority
from mapping import jobList


def recommederWorker(dbMarc, r, rec, debug, bookT001):
    dtStart = datetime.datetime.now()
    books = {}

    bookT001X = bookT001.split('#')
    bookMarcType = []
    for bookT001 in bookT001X:
        #print(bookT001)
        # najdi zaznam knihy v mongodb
        bookMarc = dbMarc.find_one({'fields.001': bookT001})

        if debug:
            diff = datetime.datetime.now() - dtStart
            rec['log'].append(
                str(diff.microseconds / 1000) + 'ms dbMarc.find_one({ \'fields.001\': \'' + bookT001 + '\' })')

        # http:200 zaznam knihy sa nenasiel aj ked je v redisDB nacachovany; toto by sa nemalo stat
        if not bookMarc:
            if debug: print('DEBUG > no res { \'fields.001\': \'' + bookT001 + '\' }')
            return web.Response(text='[]')

        # typ bibiliografickeho zaznamu
        # Navesti 06- Typ zaznamu
        # Navesti 07- Bibliograficka uroven
        bookMarcType.append(bookMarc['leader'][6:8])

        ############################################################################
        # CACHE MARC ZAZNAMU
        # Ulohou je vybrat data co nas zaujimaju z marc zaznamu a vlozit do objektu
        ############################################################################

        if debug:
            diff = datetime.datetime.now() - dtStart
            rec['log'].append(str(diff.microseconds / 1000) + 'ms [ START ] CACHE MARC ZAZNAMU')

        bookTag = {}

        for job in jobList:
            if job['name'] == 'IDENTIFIKATORY ZAZNAMU':
                continue
            tag = job['tag']
            fieldX = [x for x in bookMarc['fields'] if tag in x]
            if fieldX:
                for subtag in job['subtags']:
                    bookField = []
                    i = 0
                    for field in fieldX:
                        sub = field[tag]['subfields']
                        subfieldX = [x for x in sub if subtag['subtag'] in x]
                        if subfieldX:
                            j = 0
                            for subfield in subfieldX:
                                foundSubfield = subfield[subtag['subtag']]
                                if foundSubfield:
                                    bookField.append(foundSubfield)
                                if subtag['number'] != 'all' and j >= subtag['number']:
                                    break
                                j += 1
                        i += 1
                        if job['number'] != 'all' and i >= job['number']:
                            break
                    if bookField:
                        bookTag[subtag['key']] = bookField

                if job.get('priority', None) is not None and job['priority'] != 'all':
                    priorityTag = job['priority']
                    priorityKey = None
                    for subtag in job['subtags']:
                        if subtag['subtag'] == priorityTag:
                            priorityKey = subtag['key']
                            break
                    if priorityKey:
                        if bookTag.get(priorityKey, None) is not None:
                            for subtag in job['subtags']:
                                if subtag['key'] != priorityKey:
                                    del bookTag[subtag['key']]

        if debug:
            diff = datetime.datetime.now() - dtStart
            rec['log'].append(str(diff.microseconds / 1000) + 'ms [ END ] CACHE MARC ZAZNAMU')

        ############################################################################
        # TA ISTA KNIHA PODLA IDENTIFIKATORA
        ############################################################################

        if debug:
            diff = datetime.datetime.now() - dtStart
            rec['log'].append(str(diff.microseconds / 1000) + 'ms [ START ] TA SAMA KNIHA')

        ###
        # Najdi citatelov, ktory citali tu istu knihu a ziskaj knihy co citali tito ini citatelia
        # Prirad prioritu tymto kniham podla toho, ako sa podobaju na nasu knihu
        ###

        # nacachovat podobne knihy podla sledovanych tagov
        similarBooks = {}
        print(bookTag)
        for key in bookTag:
            if key not in similarBooks:
                similarBooks[key] = {}
            for value in bookTag[key]:
                ret = r.hget(key, value)
                if ret:
                    similarBooks[key][value] = set(ret.split('#'))

        hkey1 = 'book:user'
        hkey2 = 'user:book'
        i1 = 0
        if bookT001:

            # citatelia, ktori citali tu istu knihu
            resUsers = r.hget(hkey1, bookT001)
            if resUsers:
                resUsersX = resUsers.split('#')
                for resUser in resUsersX:
                    i1 += 1

                    # ine knihy, ktore cital ten isty citatel
                    resT001s = r.hget(hkey2, resUser)
                    if resT001s:
                        i2 = 0
                        resT001X = resT001s.split('#')
                        for resT001 in resT001X:
                            i2 += 1
                            if resT001 == bookT001: continue
                            if books.get(resT001, None) is None:
                                for key in bookTag:
                                    for value in bookTag[key]:
                                        if similarBooks[key]:
                                            if similarBooks[key].get(value,None) is not None:
                                                if resT001 in similarBooks[key][value]:
                                                    cachedBookByT001(key, bookT001, priority[key], debug, resT001, books)
                                if books.get(resT001, None) is not None:
                                    books[resT001]['all'] = True
                            elif books[resT001]['all']:
                                cachedBookByT001('all', bookT001, books[resT001]['score'], debug, resT001, books)

                            if i2 >= 500: break  # nie viac ako 50 knih jedneho citatela
                            if len(books) > 100: break

                        if i1 >= 500: break
                        if len(books) > 100: break
                        print('user:' + str(i1) + ' cnt:' + str(i2))

    if debug:
        diff = datetime.datetime.now() - dtStart
        rec['log'].append(str(diff.microseconds / 1000) + 'ms [ END ] TA SAMA KNIHA')


    ############################################################################
    # Znizit skore kniham s rozdielnymi klucovymi slovami
    ############################################################################

    bookKeywords = []

    """
    if t600X:
        for t600 in t600X:
            sub = t600['600']['subfields']
            t6007X = [x for x in sub if '7' in x]
            if t6007X: bookKeywords.append(t6007X[0]['7'])
    if t610X:
        for t610 in t610X:
            sub = t610['610']['subfields']
            t6107X = [x for x in sub if '7' in x]
            if t6107X: bookKeywords.append(t6107X[0]['7'])
    if t611X:
        for t611 in t611X:
            sub = t611['611']['subfields']
            t6117X = [x for x in sub if '7' in x]
            if t6117X: bookKeywords.append(t6117X[0]['7'])
    if t630X:
        for t630 in t630X:
            sub = t630['630']['subfields']
            t6307X = [x for x in sub if '7' in x]
            if t6307X: bookKeywords.append(t6307X[0]['7'])
    if t648X:
        for t648 in t648X:
            sub = t648['648']['subfields']
            t6487X = [x for x in sub if '7' in x]
            if t6487X: bookKeywords.append(t6487X[0]['7'])
    if t650X:
        for t650 in t650X:
            sub = t650['650']['subfields']
            t6507X = [x for x in sub if '7' in x]
            if t6507X: bookKeywords.append(t6507X[0]['7'])
    if t651X:
        for t651 in t651X:
            sub = t651['651']['subfields']
            t6517X = [x for x in sub if '7' in x]
            if t6517X: bookKeywords.append(t6517X[0]['7'])
    if t655X:
        for t655 in t655X:
            sub = t655['655']['subfields']
            t6557X = [x for x in sub if '7' in x]
            if t6557X: bookKeywords.append(t6557X[0]['7'])
    """

    ############################################################################
    # Zoradit podla priority
    ############################################################################
    booksSortedTmp = {}
    for book in books:
        if book == bookT001: continue
        booksSortedTmp[book] = books[book]['score']

    booksSorted = sorted(booksSortedTmp.items(), key=lambda kv: kv[1], reverse=True)
    booksSortedTmp = {}

    """
    if debug:
        diff = datetime.datetime.now() - dtStart
        rec['log'].append(str(diff.microseconds/1000) + 'ms [ END ] Collaborative')
        print(str(diff.microseconds/1000) + 'ms [ END ] Collaborative')
        #for tmpBook in booksCollab: print(booksCollab[tmpBook])
    """

    return {'booksSorted': booksSorted, 'books': books, 'bookKeywords': bookKeywords, 'bookMarcType': bookMarcType}


def recommederKonsWorker(r, debug, kons, excludeBooks):
    groups = []
    # vytvorenie zoznamu skupin konspektu
    for mdt in kons:
        if mdt.startswith('k'):
            mapped = r.hget('kons:map', mdt)
            mapped = mapped.split('#')
            groups.extend(mapped)
        else:
            groups.append(mdt)

    # odstranenie duplicit
    groups = set(groups)
    groups = list(groups)

    T001x = []
    for group in groups:
        resBooks = r.hget('auth:072:group', group)
        if resBooks is None:
            continue
        T001x.extend(resBooks.split('#'))

    # odstranenie duplicit
    T001x = set(T001x)
    T001x = list(T001x)

    # odfiltrovanie knih ktore citatel uz cital
    for book in excludeBooks:
        if book in T001x:
            T001x.remove(book)

    # urcenie popularity knihy
    popularity = {}
    for T001 in T001x:
        pop = r.hget('book:pop', T001)
        if pop is None:
            popularity[T001] = 0
        else:
            popularity[T001] = int(pop)

    booksSorted = sorted(popularity.items(), key=lambda kv: kv[1], reverse=True)

    books = {}

    for bookTmp in booksSorted:
        book = bookTmp[0]
        books[book] = {'t001': book, 'score': bookTmp[1], 'log': []}
        if debug: books[book]['log'].append('+' + str(bookTmp[1]))
    return {'booksSorted': booksSorted, 'books': books}


############################################################################
# POMOCNE FUNKCIE
############################################################################

#
# Pridanie knihy do zoznamu podobnych knih
# Ak kniha este nie je v zozname, pridaj a nastav prioritu identifikatora
# Ak kniha uz v zozname je, pripocitaj/zvecsi prioritu
#
# @param hkey      Kluc v hash databaze redis (tento parameter je iba kvoli ladeniu)
# @param bookT001  Tag 001 aktualne spracovavaneho zaznamu
# @param priority  Priorita s ktorou pridat zaznam do zoznamu
# @param debug     Priznak ladenia
# @param resT001   Serializovane pole s identifikatormi ziskanymi z redis. String je formatu t001#t001#t001#t001
#                  Tieto identifikatory sa doplnia do pola najdenych podobnych knih (@param books) so zadanou prioritou (@param priority)
# @param books     Vystupny zoznam
#
def cachedBookByT001(hkey, bookT001, priority, debug, resT001, books):
    # if resT001 == bookT001: return
    if resT001 not in books: books[resT001] = {'t001': resT001, 'score': 0, 'all': False, 'log': []}
    books[resT001]['score'] += priority
    if debug: books[resT001]['log'].append('+' + str(priority) + ' ' + hkey)

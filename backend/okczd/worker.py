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
        print(bookT001)
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
                            print(resT001)
                            if books.get(resT001, None) is None:
                                for key in bookTag:
                                    for value in bookTag[key]:
                                        foundByKeys = r.hget(key, value)
                                        if foundByKeys:
                                            foundByKeyX = foundByKeys.split('#')
                                            if resT001 in foundByKeyX:
                                                cachedBookByT001(key, bookT001, priority[key], debug, resT001, books)
                                if books.get(resT001, None) is not None:
                                    books[resT001]['all'] = True
                            elif books[resT001]['all']:
                                cachedBookByT001('all', bookT001, books[resT001]['score'], debug, resT001, books)

                            if i2 >= 500: break  # nie viac ako 500 knih jedneho citatela

                        print('user:' + str(i1) + ' cnt:' + str(i2))

    if debug:
        diff = datetime.datetime.now() - dtStart
        rec['log'].append(str(diff.microseconds / 1000) + 'ms [ END ] TA SAMA KNIHA')

    ############################################################################
    # AUTOR
    ############################################################################

    """
    if debug:
        diff = datetime.datetime.now() - dtStart
        rec['log'].append(str(diff.microseconds/1000) + 'ms [ START ] Autority')

    ###
    # TAGy 100$a a 100$7
    ###
    t100X = [x for x in bookMarc['fields'] if '100' in x]
    if t100X:
        sub = t100X[0]['100']['subfields']
        t100a = t1007 = None
        t100aX = [x for x in sub if 'a' in x]
        if t100aX: t100a = t100aX[0]['a']
        t1007X = [x for x in sub if '7' in x]
        if t1007X: t1007 = t1007X[0]['7']

        if t1007:
            hkey = 'auth:100:code'
            resT001 = r.hget(hkey, t1007)
            if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
            if debug: rec['log'].append(hkey)

        elif t100a:
            hkey = 'auth:100:name'
            resT001 = r.hget(hkey, t100a)
            if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
            if debug: rec['log'].append(hkey)
    """

    """
    ###
    # TAGy 110$a a 110$7
    ###
    t110X = [x for x in bookMarc['fields'] if '110' in x]
    if t110X:
        sub = t110X[0]['110']['subfields']
        t110a = t1107 = None
        t110aX = [x for x in sub if 'a' in x]
        if t110aX: t110a = t110aX[0]['a']
        t1107X = [x for x in sub if '7' in x]
        if t1107X: t1107 = t1107X[0]['7']

        if t1107:
            hkey = 'auth:110:code'
            resT001 = r.hget(hkey, t1107)
            if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
            if debug: rec['log'].append(hkey)

        elif t110a:
            hkey = 'auth:110:name'
            resT001 = r.hget(hkey, t110a)
            if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
            if debug: rec['log'].append(hkey)

    ###
    # TAGy 700$a a 700$7
    ###
    t700X = [x for x in bookMarc['fields'] if '700' in x]
    if t700X:
        for t700 in t700X:
            sub = t700['700']['subfields']
            t7007X = [x for x in sub if '7' in x]
            t700aX = [x for x in sub if 'a' in x]
            if t7007X:
                for t7007Subtag in t7007X:
                    t7007 = t7007Subtag['7']
                    if t7007:
                        if debug: print('DEBUG > t7007: ' + t7007)
                        hkey = 'auth:700:code'
                        resT001 = r.hget(hkey, t7007)
                        if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
                        if debug: rec['log'].append(hkey)
            elif t700aX:
                for t700aSubtag in t700aX:
                    t700a = t700aSubtag['a']
                    if t700a:
                        if debug: print('DEBUG > t700a: ' + t700a)
                        hkey = 'auth:700:name'
                        resT001 = r.hget(hkey, t700a)
                        if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
                        if debug: rec['log'].append(hkey)

    if debug:
        diff = datetime.datetime.now() - dtStart
        rec['log'].append(str(diff.microseconds/1000) + 'ms [ END ] Autority')
    """

    ############################################################################
    # MDT
    ############################################################################
    """
    if debug:
        diff = datetime.datetime.now() - dtStart
        rec['log'].append(str(diff.microseconds/1000) + 'ms [ START ] MDT')

    ###
    # TAG 080$a
    ###

    t080X = [x for x in bookMarc['fields'] if '080' in x]
    if t080X:
        sub = t080X[0]['080']['subfields']
        t080a = None
        t080aX = [x for x in sub if 'a' in x]
        if t080aX: t080a = t080aX[0]['a']

        if t080a:
            hkey = 'mdt:080:code'
            resT001 = r.hget(hkey, t080a)
            if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
            if debug: rec['log'].append(hkey)

    if debug:
        diff = datetime.datetime.now() - dtStart
        rec['log'].append(str(diff.microseconds/1000) + 'ms [ END ] MDT')
    """

    ############################################################################
    # KLUCOVE SLOVA
    ############################################################################

    """
    if debug:
        diff = datetime.datetime.now() - dtStart
        rec['log'].append(str(diff.microseconds/1000) + 'ms [ START ] Klicova slova')

    ###
    # TAG 600$7
    ###
    t600X = [x for x in bookMarc['fields'] if '600' in x]
    if t600X:
        sub = t600X[0]['600']['subfields']
        t6007 = None
        t6007X = [x for x in sub if '7' in x]
        if t6007X: t6007 = t6007X[0]['7']

        if t6007:
            hkey = 'auth:600:code'
            resT001 = r.hget(hkey, t6007)
            if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
            if debug: rec['log'].append(hkey)

    ###
    # TAG 610$7
    ###
    t610X = [x for x in bookMarc['fields'] if '610' in x]
    if t610X:
        sub = t610X[0]['610']['subfields']
        t6107 = None
        t6107X = [x for x in sub if '7' in x]
        if t6107X: t6107 = t6107X[0]['7']

        if t6107:
            hkey = 'auth:610:code'
            resT001 = r.hget(hkey, t6107)
            if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
            if debug: rec['log'].append(hkey)

    ###
    # TAG 611$7
    ###
    t611X = [x for x in bookMarc['fields'] if '611' in x]
    if t611X:
        sub = t611X[0]['611']['subfields']
        t6117 = None
        t6117X = [x for x in sub if '7' in x]
        if t6117X: t6117 = t6117X[0]['7']

        if t6117:
            hkey = 'auth:611:code'
            resT001 = r.hget(hkey, t6117)
            if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
            if debug: rec['log'].append(hkey)

    ###
    # TAG 630$7
    ###
    t630X = [x for x in bookMarc['fields'] if '630' in x]
    if t630X:
        sub = t630X[0]['630']['subfields']
        t6307 = None
        t6307X = [x for x in sub if '7' in x]
        if t6307X: t6307 = t6307X[0]['7']

        if t6307:
            hkey = 'auth:630:code'
            resT001 = r.hget(hkey, t6307)
            if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
            if debug: rec['log'].append(hkey)

    ###
    # TAG 648$7
    ###
    t648X = [x for x in bookMarc['fields'] if '648' in x]
    if t648X:
        sub = t648X[0]['648']['subfields']
        t6487 = None
        t6487X = [x for x in sub if '7' in x]
        if t6487X: t6487 = t6487X[0]['7']

        if t6487:
            hkey = 'auth:648:code'
            resT001 = r.hget(hkey, t6487)
            if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
            if debug: rec['log'].append(hkey)

    ###
    # TAG 650$7
    ###
    t650X = [x for x in bookMarc['fields'] if '650' in x]
    if t650X:
        sub = t650X[0]['650']['subfields']
        t6507 = None
        t6507X = [x for x in sub if '7' in x]
        if t6507X: t6507 = t6507X[0]['7']

        if t6507:
            hkey = 'auth:650:code'
            resT001 = r.hget(hkey, t6507)
            if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
            if debug: rec['log'].append(hkey)

    ###
    # TAG 651$7
    ###
    t651X = [x for x in bookMarc['fields'] if '651' in x]
    if t651X:
        sub = t651X[0]['651']['subfields']
        t6517 = None
        t6517X = [x for x in sub if '7' in x]
        if t6517X: t6517 = t6517X[0]['7']

        if t6517:
            hkey = 'auth:651:code'
            resT001 = r.hget(hkey, t6517)
            if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
            if debug: rec['log'].append(hkey)

    ###
    # TAG 655$7
    ###
    t655X = [x for x in bookMarc['fields'] if '655' in x]
    if t655X:
        sub = t655X[0]['655']['subfields']
        t6557 = None
        t6557X = [x for x in sub if '7' in x]
        if t6557X: t6557 = t6557X[0]['7']

        if t6557:
            hkey = 'auth:655:code'
            resT001 = r.hget(hkey, t6557)
            if resT001: cachedBookByT001(hkey, bookT001, priority[hkey], debug, resT001, books)
            if debug: rec['log'].append(hkey)

    if debug:
        diff = datetime.datetime.now() - dtStart
        rec['log'].append(str(diff.microseconds/1000) + 'ms [ END ] Klicova slova')
    """

    ############################################################################
    # ZORADIT PODLA PRIORITY
    ############################################################################
    """
    contentSortedTmp = {}
    j = 0
    for book in books:
        # nechceme knihy s nizsim score content filtra ako 0.5
        #if books[book]['score'] < 0.5: continue
        # nechceme viac odporucani content filtra ako 50
        if j >= 100: continue
        contentSortedTmp[book] = books[book]['score']
        j += 1

    contentSorted = sorted(contentSortedTmp.items(), key=lambda kv: kv[1], reverse=True)
    contentSortedTmp = {}
    """

    ############################################################################
    # COLLABORATIVE FILTER - vytvorit zoznam knih
    ############################################################################
    """
    if debug:
        diff = datetime.datetime.now() - dtStart
        rec['log'].append(str(diff.microseconds/1000) + 'ms [ START ] Collaborative')

    # pridaj knihu - samu seba
    # score take, ako najvecsie skore knihy vyhladanej podla content-based filtra
    tmpBookScore = 5
    if contentSorted and contentSorted[0] and contentSorted[0][1]: tmpBookScore = contentSorted[0][1]
    books[bookT001] = { 't001': bookT001, 'score': tmpBookScore, 'log': [] }
    # ziskany zoznam knih z kolaborativneho filtra
    booksCollab = {}
    ###
    # Collaborative filter
    # 1) Najdi uzivatelov, ktory vypozicali tu istu knihu
    # 2) Najdi knihy, ktore vyssie zistany citatelia vypozicali
    ###
    jTotal=0
    kTotal=0
    for sortedBook in contentSorted:
        book = sortedBook[0]
        ### print(book)
        if debug: print(' > Collaborative filter of book T001: ' + book)
        baseScore = books[book]['score']
        # vyhladaj citatelov, ktory vypozicali tu istu knihu
        resUsers = r.hget('book:user', book)
        if not resUsers: continue
        if debug: print(' > Other users who read same book: ' + resUsers)
        resUsersX = resUsers.split('#')

        # tuto knihu vypozical aj iny citatel, teraz prejdeme jedneho za druhym
        j=0
        for user in resUsersX:
            j+=1
            jTotal+=1
            if debug: print(' > User: ' + user)
            # vyhladaj knihy, ktore si vypozical tento citatel
            resBooks = r.hget('user:book', user)
            if not resBooks: continue
            resBooksX = resBooks.split('#')
            # nezahrnut knihy od uzivatelov s velkym poctom vypoziciek
            if len(resBooksX) > 1000: continue
            ### print('#'+str(len(resBooksX)))

            # knihy, co si tento citatel pozical
            k=0
            for book in resBooksX:
                k+=1
                kTotal+=1
                if book == bookT001: continue
                if book not in booksCollab:
                    if debug: print(' > Adding book: ' + book)
                    booksCollab[book] = { 't001': book, 'basescore':baseScore, 'cnt': 1 }
                else:
                    if debug: print(' > Increasing cnt: ' + book)
                    booksCollab[book]['cnt'] += 1
                if k>=50: break
            if j>=50: break
        ### print('j=' + str(jTotal) + ', k=' + str(kTotal))
    ### print('jTotal: ' + str(jTotal))
    ### print('kTotal: ' + str(kTotal))
    """

    """
    ############################################################################
    # COLLABORATIVE FILTER - popularita knih podla collaborative filtra
    ############################################################################
    # zistenie max. poctu zhodnych knih kvoli urceniu 100%
    maxCnt = 1
    for tmpBook in booksCollab:
        if maxCnt<booksCollab[tmpBook]['cnt']: maxCnt=booksCollab[tmpBook]['cnt']
    #uz pozname maximum, prepocitame percenta u kazdej knihy
    for tmpBook in booksCollab:
        booksCollab[tmpBook]['percent'] = math.ceil(booksCollab[tmpBook]['cnt'] / (maxCnt/100))


    ############################################################################
    # COLLABORATIVE FILTER - zlucit knihy s content based filtrom
    ############################################################################
    for book in booksCollab:
        bookCollab = booksCollab[book]
        collabScore = bookCollab['basescore'] * (bookCollab['percent']*2/100)
        if book not in books:
            books[book] = { 't001': book, 'score': collabScore, 'log': '+'+str(collabScore)+' base:'+str(bookCollab['basescore'])+' cnt:'+str(bookCollab['cnt'])+' percent:'+str(bookCollab['percent']) }
        else:
            if debug: books[book]['log'].append('+'+str(collabScore)+' base:'+str(bookCollab['basescore'])+' cnt:'+str(bookCollab['cnt'])+' percent:'+str(bookCollab['percent']))
            books[book]['score'] += collabScore
    """

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

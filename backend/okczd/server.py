import redis, json, datetime, math, aiohttp_jinja2, jinja2, argparse, re

from random import random
from pprint import pprint
from pymongo import MongoClient
from bson.objectid import ObjectId
from aiohttp import web

from settings import priority
from views import index
from worker import recommederWorker, recommederKonsWorker

################################################################################
#   INICIALIZACIA
################################################################################

# connection to mongo
client = MongoClient(port=27017)
db = client["okczd"]
dbMarc = db["marc"]

# redis
r = redis.StrictRedis(host='localhost', port=6380, db=0, decode_responses=True)

# podporne funkcie
def toEan (str):
    str = str.upper()
    m = re.search(r'(\d*\-*X{0,1})*', str)
    code = m[0].replace('-','')

    # ISSN
    if len(code) == 8:
        code = '977' + code[:-1] + '00'
        return code + getCheckSumMod10(code)

    # ISBN10
    elif len(code) == 10:
        code = '978' + code[:-1]
        return code + getCheckSumMod10(code)

    # EAN + ISBN13 without check digit
    elif len(code) == 11:
        return '00' + code
    elif len(code) == 12:
        return '0' + code
    else:
        return code

def getCheckSumMod10 (codeCommon):
    sum = 0
    code = codeCommon[:-1] if len(codeCommon)==13 else codeCommon

    # from left most significat digit to right less significant digit
    for i in range(len(codeCommon)):
        # multiply by 1 every odd digit, by 3 every even digit
        char = '10' if code[i]=='X' else code[i]
        sum += int(char) * (3 if i%2 else 1)

    mod = 10 - (sum % 10)
    return '0' if (mod == 10) else str(mod)

def cleanOclc (code):
    m = re.search(r'(\d)+', code)
    return m[0] if m else code


################################################################################
#   API
################################################################################

async def handleApiBook(request):
    query = request.rel_url.query
    rec = {} # vystup
    debug = 0

    if 'debug' in query:
        debug = 1
        rec = { 'log': [] }
        dtStart = datetime.datetime.now()

    # pozadovane identifikatory
    ean13 = nbn = oclc = user = sigla = kons = None
    if 'nbn' in query:
        nbn = query['nbn']
    if 'isbn' in query:
        ean13 = query['isbn']
    if 'oclc' in query:
        oclc = query['oclc']
    if 'user' in query:
        user = query['user']
    if 'sigla' in query:
        sigla = query['sigla']
    if 'kons' in query:
        kons = query['kons']
    if 'multi' in query:
        multi = json.loads(query['multi'])
        if 'nbn' in multi: nbn = multi['nbn']
        if 'isbn' in multi: ean13 = multi['isbn']
        if 'oclc' in multi: oclc = multi['oclc']
        if 'user' in multi: user = multi['user']
        if 'sigla' in multi: sigla = multi['sigla']
        if 'kons' in multi: kons = multi['kons']

    # err:400 neni identifikator
    if not ean13 and not nbn and not oclc and not user and not kons:
        raise web.HTTPBadRequest(text='Book identifier is required')

    ############################################################################
    # ODPORUC PODLA JEDNEJ KNIHY
    ############################################################################

    print(user)
    print(sigla)
    if nbn or ean13 or oclc:
        # hladanie zaznamu knihy
        # 1) NBN
        # 2) ISBN + ISSN + EAN
        # 3) OCLC
        bookT001 = None
        if nbn:
            bookT001 = r.hget('id:nbn', nbn)
            if debug: rec['log'].append('redis id:nbn')
        if ean13 and not bookT001:
            ean13 = toEan(ean13)
            bookT001 = r.hget('id:ean13', ean13)
            if debug: rec['log'].append('redis id:ean13')
        if oclc and not bookT001:
            oclc = cleanOclc(oclc)
            bookT001 = r.hget('id:oclc', oclc)
            if debug: rec['log'].append('redis id:oclc')

        print(bookT001)
        # http:200 zaznam knihy sa nenasiel
        if not bookT001:
            if debug: print('DEBUG > http:200 zaznam knihy sa nenasiel')
            return web.Response(text='[]')

        if debug:
            diff = datetime.datetime.now() - dtStart
            rec['log'].append(str(diff.microseconds/1000) + 'ms redis biblio record found ' + bookT001)

        bookT001x = bookT001.split('#')
        for bookT001 in bookT001x:
            recommendations = recommederWorker(dbMarc, r, rec, debug, bookT001)
            books = recommendations['books']
            booksSorted = recommendations['booksSorted']
            bookKeywords = recommendations['bookKeywords']
            bookMarcType = recommendations['bookMarcType']


    ############################################################################
    # ODPORUC PODLA HISTORIE VYPOZICIEK
    ############################################################################

    elif user and sigla and not kons:
        user = sigla.upper() + '|' + user
        print(user)
        # hladanie zaznamov knihy poslednych vypoziciek
        resUserBooks = r.hget('user:book', user)
        if not resUserBooks:
            if debug: print('DEBUG > http:200 uzivatel neexistuje')
            return web.Response(text='[]')

        listUserBooks = resUserBooks.split('#')
        listUserBooks = listUserBooks[0:10]

        if not len(listUserBooks):
            if debug: print('DEBUG > http:200 uzivatel nema vypozicanu ziadnu knihu')
            return web.Response(text='[]')

        for bookT001 in listUserBooks:
            # TODO ma to takto byt, lebo podla mna sa zakazdym prepise posledny recommendations a teda na konci
            #  zostane len odporucanie podla poslednej knihy v listUserBooks - Hagara
            print('book: '+bookT001)
            recommendations = recommederWorker(dbMarc, r, rec, debug, bookT001)
            books = recommendations['books']
            booksSorted = recommendations['booksSorted']
            bookKeywords = recommendations['bookKeywords']
            bookMarcType = recommendations['bookMarcType']
            print('booksSorted: '+str(len(booksSorted)))

    ############################################################################
    # ODPORUC PODLA PREDMETOVEHO VYHLADAVANIA
    ############################################################################

    elif kons:
        print(kons)
        listUserBooks = []
        if user:
            user = sigla.upper() + '|' + user
            print(user)
            # hladanie zaznamov knihy poslednych vypoziciek
            resUserBooks = r.hget('user:book', user)
            if not resUserBooks:
                if debug: print('DEBUG > http:200 uzivatel neexistuje')
                return web.Response(text='[]')

            listUserBooks = resUserBooks.split('#')

        recommendations = recommederKonsWorker(dbMarc, r, rec, debug, kons, listUserBooks)
        books = recommendations['books']
        booksSorted = recommendations['booksSorted']
        print('booksSorted: ' + str(len(booksSorted)))

    ############################################################################
    # PREKLOPIT NAJDENE KNIHY NA VYSTUP
    ############################################################################
    i = 0
    j = 0
    booksOut = []
    usedAllready = {}
    booksLQ = [] # zoznam knih, ktore nebudu mat zhodu klucovych slov (sluzi pre pozdejsie doplnenie do prilis kratkeho vysledneho zoznamu)

    if kons:
        for bookTmp in booksSorted:
            j += 1
            if j > 500: break  # ochrana pred dlhou odozvou
            book = bookTmp[0]
            if book[0] == 'z': continue  # vyrad zrusene zaznamy

            bookOutMarc = dbMarc.find_one({'fields.001': book})
            haveAnyId = 0

            # ISBN
            t020X = [x for x in bookOutMarc['fields'] if '020' in x]
            if t020X:
                sub = t020X[0]['020']['subfields']
                t020aX = [x for x in sub if 'a' in x]
                if t020aX:
                    val = t020aX[0]['a']
                    if val not in usedAllready and ean13 != toEan(val):
                        books[book]['isbn'] = val
                        usedAllready[val] = 1
                        haveAnyId = 1

            # NBN
            t015X = [x for x in bookOutMarc['fields'] if '015' in x]
            if t015X:
                sub = t015X[0]['015']['subfields']
                t015aX = [x for x in sub if 'a' in x]
                if t015aX:
                    val = t015aX[0]['a']
                    if val not in usedAllready and nbn != val:
                        books[book]['nbn'] = val
                        usedAllready[val] = 1
                        haveAnyId = 1

            # OCLC
            t035X = [x for x in bookOutMarc['fields'] if '035' in x]
            if t035X:
                sub = t035X[0]['035']['subfields']
                t035aX = [x for x in sub if 'a' in x]
                if t035aX:
                    val = t035aX[0]['a']
                    if val not in usedAllready and oclc != cleanOclc(val):
                        books[book]['oclc'] = val
                        usedAllready[val] = 1
                        haveAnyId = 1

            # bereme iba dokumenty s identifikatorom
            if not haveAnyId: continue

            # Titul
            t245X = [x for x in bookOutMarc['fields'] if '245' in x]
            if t245X:
                sub = t245X[0]['245']['subfields']
                t245aX = [x for x in sub if 'a' in x]
                if t245aX:
                    books[book]['title'] = t245aX[0]['a']
                t245bX = [x for x in sub if 'b' in x]
                if t245bX:
                    books[book]['title'] += ' ' + t245bX[0]['b']
                t245cX = [x for x in sub if 'c' in x]
                if t245cX:
                    books[book]['title'] += ' ' + t245cX[0]['c']

            booksOut.append(books[book])
            if i > 50: break
            i += 1

        if debug:
            dtFinish = datetime.datetime.now()
            diff = dtFinish - dtStart
            rec['log'].append(str(diff.microseconds / 1000) + 'ms [ DONE ]')
            booksOut.append(rec['log'])

        return web.Response(content_type='application/json', text=json.dumps(booksOut))

    for bookTmp in booksSorted:
        j += 1
        if j>500: break # ochrana pred dlhou odozvou
        book = bookTmp[0]
        if book[0] == 'z': continue # vyrad zrusene zaznamy
        if book == bookT001: continue # vyrad semeho seba
        bookOutMarc = dbMarc.find_one({ 'fields.001': book })
        haveAnyId = 0

        # ISBN
        t020X = [x for x in bookOutMarc['fields'] if '020' in x]
        if t020X:
            sub = t020X[0]['020']['subfields']
            t020aX = [x for x in sub if 'a' in x]
            if t020aX:
                val = t020aX[0]['a']
                if val not in usedAllready and ean13 != toEan(val):
                    books[book]['isbn'] = val
                    usedAllready[val] = 1
                    haveAnyId = 1

        # NBN
        t015X = [x for x in bookOutMarc['fields'] if '015' in x]
        if t015X:
            sub = t015X[0]['015']['subfields']
            t015aX = [x for x in sub if 'a' in x]
            if t015aX:
                val = t015aX[0]['a']
                if val not in usedAllready and nbn != val:
                    books[book]['nbn'] = val
                    usedAllready[val] = 1
                    haveAnyId = 1

        # OCLC
        t035X = [x for x in bookOutMarc['fields'] if '035' in x]
        if t035X:
            sub = t035X[0]['035']['subfields']
            t035aX = [x for x in sub if 'a' in x]
            if t035aX:
                val = t035aX[0]['a']
                if val not in usedAllready and oclc != cleanOclc(val):
                    books[book]['oclc'] = val
                    usedAllready[val] = 1
                    haveAnyId = 1

        # bereme iba dokumenty s identifikatorom
        if not haveAnyId: continue

        # Titul
        t245X = [x for x in bookOutMarc['fields'] if '245' in x]
        if t245X:
            sub = t245X[0]['245']['subfields']
            t245aX = [x for x in sub if 'a' in x]
            if t245aX:
                books[book]['title'] = t245aX[0]['a']
            t245bX = [x for x in sub if 'b' in x]
            if t245bX:
                books[book]['title'] += ' ' + t245bX[0]['b']
            t245cX = [x for x in sub if 'c' in x]
            if t245cX:
                books[book]['title'] += ' ' + t245cX[0]['c']

        # bereme iba dokumenty rovnakeho typu
        if bookOutMarc['leader'][6:8] != bookMarcType: continue

        # vylucit knihy, ktore nemaju aspon jedno rovnake klucove slovo
        keywordMatch = 0

        out600X = [x for x in bookOutMarc['fields'] if '600' in x]
        if out600X:
            for out600 in out600X:
                sub = out600['600']['subfields']
                out6007X = [x for x in sub if '7' in x]
                if out6007X and out6007X[0]['7'] in bookKeywords: keywordMatch = 1

        out610X = [x for x in bookOutMarc['fields'] if '610' in x]
        if out610X:
            for out610 in out610X:
                sub = out610['610']['subfields']
                out6107X = [x for x in sub if '7' in x]
                if out6107X and out6107X[0]['7'] in bookKeywords: keywordMatch = 1

        out611X = [x for x in bookOutMarc['fields'] if '611' in x]
        if out611X:
            for out611 in out611X:
                sub = out611['611']['subfields']
                out6117X = [x for x in sub if '7' in x]
                if out6117X and out6117X[0]['7'] in bookKeywords: keywordMatch = 1

        out630X = [x for x in bookOutMarc['fields'] if '630' in x]
        if out630X:
            for out630 in out630X:
                sub = out630['630']['subfields']
                out6307X = [x for x in sub if '7' in x]
                if out6307X and out6307X[0]['7'] in bookKeywords: keywordMatch = 1

        out648X = [x for x in bookOutMarc['fields'] if '648' in x]
        if out648X:
            for out648 in out648X:
                sub = out648['648']['subfields']
                out6487X = [x for x in sub if '7' in x]
                if out6487X and out6487X[0]['7'] in bookKeywords: keywordMatch = 1

        out650X = [x for x in bookOutMarc['fields'] if '650' in x]
        if out650X:
            for out650 in out650X:
                sub = out650['650']['subfields']
                out6507X = [x for x in sub if '7' in x]
                if out6507X and out6507X[0]['7'] in bookKeywords: keywordMatch = 1

        out651X = [x for x in bookOutMarc['fields'] if '651' in x]
        if out651X:
            for out651 in out651X:
                sub = out651['651']['subfields']
                out6517X = [x for x in sub if '7' in x]
                if out6517X and out6517X[0]['7'] in bookKeywords: keywordMatch = 1

        out655X = [x for x in bookOutMarc['fields'] if '655' in x]
        if out655X:
            for out655 in out655X:
                sub = out655['655']['subfields']
                out6557X = [x for x in sub if '7' in x]
                if out6557X and out6557X[0]['7'] in bookKeywords: keywordMatch = 1

        books[book]['id'] = str(bookOutMarc['_id'])
        if not debug:
            del books[book]['log']
            del books[book]['score']
            del books[book]['t001']

        # vylucit knihy, ktore nemaju aspon jedno rovnake klucove slovo
        if i > 2 and not keywordMatch:
            booksLQ.append(books[book])
            continue

        booksOut.append(books[book])
        if i > 46: break
        i += 1

    #####
    # Ak je prilis malo odporucani, prejdi zoznam este raz a dopln bez zhody keyword
    #####
    if i < 20:
        for bookTmp in booksLQ:
            booksOut.append(bookTmp)
            if i > 46: break
            i += 1

    if debug:
        dtFinish = datetime.datetime.now()
        diff = dtFinish - dtStart
        rec['log'].append(str(diff.microseconds/1000) + 'ms [ DONE ]')
        booksOut.append(rec['log'])

    return web.Response(content_type='application/json', text=json.dumps(booksOut))


################################################################################
#   Informacie o knihe
################################################################################

async def handleInfo(request):
    nbn = ean13 = oclc = rec = None
    query = request.rel_url.query
    if 'id' in query: id = query['id']
    if 'multi' in query:
        multi = json.loads(query['multi'])
        if 'nbn' in multi: nbn = multi['nbn']
        if 'isbn' in multi: ean13 = multi['isbn']
        if 'oclc' in multi: oclc = multi['oclc']

    if nbn or ean13 or oclc:
        bookT001 = None
        if nbn: bookT001 = r.hget('id:nbn', nbn)
        if ean13 and not bookT001:
            m = re.search(r'(\d*\-*)*', ean13)
            code = m[0].replace('-','')
            bookT001 = r.hget('id:ean13', code)
        if oclc and not bookT001: bookT001 = r.hget('id:oclc', oclc)
        if '#' in bookT001:
            bookT001List = bookT001.split('#')
            bookT001 = bookT001List[0]
        rec = dbMarc.find_one({ 'fields.001': bookT001 })

    else:
        if not id: return web.Response(text='[]')
        rec = dbMarc.find_one({ '_id': ObjectId(id) })

    if not rec: return web.Response(text='[]')

    context = {}
    identsList = []
    bookKeywords = []

    # ISBN
    t020X = [x for x in rec['fields'] if '020' in x]
    if t020X:
        sub = t020X[0]['020']['subfields']
        t020aX = [x for x in sub if 'a' in x]
        if t020aX:
            context['isbn'] = t020aX[0]['a']
            identsList.append(context['isbn'])
    # NBN
    t015X = [x for x in rec['fields'] if '015' in x]
    if t015X:
        sub = t015X[0]['015']['subfields']
        t015aX = [x for x in sub if 'a' in x]
        if t015aX:
            context['nbn'] = t015aX[0]['a']
            identsList.append(context['nbn'])
    # OCLC
    t035X = [x for x in rec['fields'] if '035' in x]
    if t035X:
        sub = t035X[0]['035']['subfields']
        t035aX = [x for x in sub if 'a' in x]
        if t035aX:
            context['oclc'] = t035aX[0]['a']
            identsList.append(context['oclc'])

    if len(identsList):
        identsJson = json.dumps(context)
        context['idents'] = ', '.join(identsList)
        context['coverUrl'] = 'https://cache.obalkyknih.cz/api/cover?multi=' + identsJson

    # Titul
    t245X = [x for x in rec['fields'] if '245' in x]
    if t245X:
        sub = t245X[0]['245']['subfields']
        t245aX = [x for x in sub if 'a' in x]
        if t245aX:
            context['title'] = t245aX[0]['a']
        t245bX = [x for x in sub if 'b' in x]
        if t245bX:
            context['title'] += ' ' + t245bX[0]['b']
        t245cX = [x for x in sub if 'c' in x]
        if t245cX:
            context['title'] += ' ' + t245cX[0]['c']

    # Vedlajsie vecne zahlavie
    t600X = [x for x in rec['fields'] if '600' in x]
    if t600X:
        for t600 in t600X:
            sub = t600['600']['subfields']
            t6007X = [x for x in sub if 'a' in x]
            if t6007X: bookKeywords.append(t6007X[0]['a'])
    t610X = [x for x in rec['fields'] if '610' in x]
    if t610X:
        for t610 in t610X:
            sub = t610['610']['subfields']
            t6107X = [x for x in sub if 'a' in x]
            if t6107X: bookKeywords.append(t6107X[0]['a'])
    t611X = [x for x in rec['fields'] if '611' in x]
    if t611X:
        for t611 in t611X:
            sub = t611['611']['subfields']
            t6117X = [x for x in sub if 'a' in x]
            if t6117X: bookKeywords.append(t6117X[0]['a'])
    t630X = [x for x in rec['fields'] if '630' in x]
    if t630X:
        for t630 in t630X:
            sub = t630['630']['subfields']
            t6307X = [x for x in sub if 'a' in x]
            if t6307X: bookKeywords.append(t6307X[0]['a'])
    t648X = [x for x in rec['fields'] if '648' in x]
    if t648X:
        for t648 in t648X:
            sub = t648['648']['subfields']
            t6487X = [x for x in sub if 'a' in x]
            if t6487X: bookKeywords.append(t6487X[0]['a'])
    t650X = [x for x in rec['fields'] if '650' in x]
    if t650X:
        for t650 in t650X:
            sub = t650['650']['subfields']
            t6507X = [x for x in sub if 'a' in x]
            if t6507X: bookKeywords.append(t6507X[0]['a'])
    t651X = [x for x in rec['fields'] if '651' in x]
    if t651X:
        for t651 in t651X:
            sub = t651['651']['subfields']
            t6517X = [x for x in sub if 'a' in x]
            if t6517X: bookKeywords.append(t6517X[0]['a'])
    t655X = [x for x in rec['fields'] if '655' in x]
    if t655X:
        for t655 in t655X:
            sub = t655['655']['subfields']
            t6557X = [x for x in sub if 'a' in x]
            if t6557X: bookKeywords.append(t6557X[0]['a'])

    if len(bookKeywords):
        context['keywords'] = ', '.join(bookKeywords)


    # Anotacia
    t520X = [x for x in rec['fields'] if '520' in x]
    if t520X:
        for t520 in t520X:
            sub = t520['520']['subfields']
            t520aX = [x for x in sub if 'a' in x]
            if t520aX: context['annotation'] = t520aX[0]['a']

    response = aiohttp_jinja2.render_template('info.html', request, context)
    response.headers['Content-Language'] = 'cs'
    return response


############################################################################
# SERVER + cesty
############################################################################

parser = argparse.ArgumentParser(description="aiohttp OKCZD server")
parser.add_argument('--port')
args = parser.parse_args()
#port=args.port

app = web.Application()
app.add_routes([web.get('/api/doporuc', handleApiBook),
                web.get('/info', handleInfo),
                web.get('/doporucovani-podle-knihy', index),
                web.get('/', index)])
                #web.get('/{name}', handle)])
app.add_routes([web.static('/js', 'static/js'),
                web.static('/css', 'static/css'),
                web.static('/fonts', 'static/css/fonts'),
                web.static('/css/fonts', 'static/css/fonts'),
                web.static('/images', 'static/images'),
                web.static('/img', 'static/img')])
aiohttp_jinja2.setup(app, loader=jinja2.FileSystemLoader('templates'))
web.run_app(app, port=args.port)

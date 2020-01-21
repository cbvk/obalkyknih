import sys, json, hashlib, math, re
import colorama
import redis

from pprint import pprint
from pymongo import MongoClient
from colorama import Fore, Back, Style

userHashKey = 'user:book'
bookHashKey = 'book:user'
nbnHashKey = 'id:nbn'
ean13HashKey = 'id:ean13'
oclcHashKey = 'id:oclc'
bookPopularityHashKey = 'book:pop'
bookAgeHashKey = 'book:age'
bookCatHashKey = 'book:cat'
ageHistogramTreshold = 55


################################################################################
#   INICIALIZACIA
################################################################################

# colored console output
colorama.init()
# connection to mongo
client = MongoClient(port=27017)
db = client["okczd"]
dbTrans = db["trans"]
# redis
r = redis.StrictRedis(host='localhost', port=6379, db=0, decode_responses=True)
# premazat vsetko co je v pameti
r.delete(userHashKey)
r.delete(bookHashKey)
r.delete(bookPopularityHashKey)
r.delete(bookAgeHashKey)
r.delete(bookCatHashKey)


################################################################################
#   POMOCNE FUNKCIE
################################################################################

def printProgressBar (iteration, total, prefix = '', suffix = '', decimals = 1, length = 50, fill = '█'):
    """
    Call in a loop to create terminal progress bar
    @params:
        iteration   - Required  : current iteration (Int)
        total       - Required  : total iterations (Int)
        prefix      - Optional  : prefix string (Str)
        suffix      - Optional  : suffix string (Str)
        decimals    - Optional  : positive number of decimals in percent complete (Int)
        length      - Optional  : character length of bar (Int)
        fill        - Optional  : bar fill character (Str)
    """
    percent = ("{0:." + str(decimals) + "f}").format(100 * (iteration / float(total)))
    filledLength = int(length * iteration // total)
    bar = fill * filledLength + '-' * (length - filledLength)
    print('\r%s |%s| %s%% %s' % (prefix, bar, percent, suffix + '                                '), end = '\r')
    #if iteration == total: print() # Print New Line on Complete

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
#
#   Prechadza zaznamy tranzakcii uzivatelov v mongo DB,
#   paruje na knihy a plni ich do redis databazy
#
#   1) Prejdi tranzakcie uzivatelov za posledne obdobie
#   2) Hlada podla identifikatorov ISBN,NBN,OCLC,EAN13 uz existujucu knihu
#   3) Ulozi do redis kluca "user:book" danu knihu k uzivatelovi
#   4) Ulozi do redis kluca "book:user" daneho uzivatela ku knihe
#
################################################################################

recs = dbTrans.find({}).sort('_id', -1)
#recs = dbTrans.find({}).sort('_id', -1).limit(10000)
totalRecs = recs.count()
#totalRecs = 10000
jobTitle = 'Transactions'
printProgressBar(0, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)

i = 0
for rec in recs:
    try:
        id = rec['_id']
        fld = rec['fields']
        library = rec['sigla']
    except:
        continue

    ########################################################################
    #   IDENTIFIKATORY ZAZNAMU
    ########################################################################

    # identifikatory vypozicanej knihy
    bookT001 = userHash = userAge = userCat = None
    for tagX in fld:
        tag = [x for x in tagX]
        tagNo = tag[0]

        if tagNo == '015' and not bookT001:
            t015aX = [x for x in tagX['015']['subfields'] if 'a' in x]
            if t015aX:
                t015a = t015aX[0]['a']
                res = r.hget(nbnHashKey, t015a)
                if res: bookT001 = res

        if tagNo == '020' and not bookT001:
            t020aX = [x for x in tagX['020']['subfields'] if 'a' in x]
            if t020aX:
                t020a = toEan(t020aX[0]['a'])
                if len(t020a)==13:
                    res = r.hget(ean13HashKey, t020a)
                    if res: bookT001 = res

        if tagNo == '022' and not bookT001:
            t022aX = [x for x in tagX['022']['subfields'] if 'a' in x]
            if t022aX:
                t022a = toEan(t022aX[0]['a'])
                if len(t022a)==13:
                    res = r.hget(ean13HashKey, t022a)
                    if res: bookT001 = res

        if tagNo == '024' and not bookT001:
            t024aX = [x for x in tagX['024']['subfields'] if 'a' in x]
            if t024aX:
                t024a = toEan(t024aX[0]['a'])
                if len(t024a)==13:
                    res = r.hget(ean13HashKey, t024a)
                    if res: bookT001 = res

        if tagNo == '035' and not bookT001:
            t035aX = [x for x in tagX['035']['subfields'] if 'a' in x]
            if t035aX:
                t035a = cleanOclc(t035aX[0]['a'])
                res = r.hget(oclcHashKey, t035a)
                if res: bookT001 = res

        if tagNo == '100':
            t100rX = [x for x in tagX['100']['subfields'] if 'r' in x]
            if t100rX:
                t100r = t100rX[0]['r']
                if t100r: userHash = t100r
            t100pX = [x for x in tagX['100']['subfields'] if 'p' in x]
            if t100pX:
                t100p = t100pX[0]['p']
                if t100p: userAge = t100p
            t100sX = [x for x in tagX['100']['subfields'] if 's' in x]
            if t100sX:
                t100s = t100sX[0]['s']
                if t100s: userCat = t100s

    #
    # 1. pridat knihu k uzivatelovi
    # 2. pridat uzivatela ku knihe
    # 3. zvysit popularitu knihy
    #
    if bookT001 and userHash:
        resBooksX = bookT001.split('#')
        #m = hashlib.md5()
        userHash = library + '|' + userHash #todo: md5
        #m.update(userHash.encode("UTF-8"))
        #userHash = m.hexdigest()
        for book in resBooksX:
            r.hincrby(bookPopularityHashKey, book, 1)
            resBooks = r.hget(userHashKey, userHash) or ''
            resUsers = r.hget(bookHashKey, book) or ''
            if book not in resBooks:
                if resBooks!='':
                    resBooks = book + '#' + resBooks
                else:
                    resBooks = book
                r.hset(userHashKey, userHash, resBooks)
            if userHash not in resUsers:
                if resUsers!='':
                    resUsers = userHash + '#' + resUsers
                else:
                    resUsers = userHash
                r.hset(bookHashKey, book, resUsers)

    #
    # 4. pridat vek citatela v den tranzakcie ku knihe
    #
    if bookT001 and userAge:
        resReadersAge = r.hget(bookAgeHashKey, bookT001) or ''
        if resReadersAge!='': resReadersAge += '#'
        r.hset(bookAgeHashKey, bookT001, userAge)

    #
    # 5. pridat kategoriu citatela v den tranzakcie ku knihe
    #
    if bookT001 and userCat:
        resReadersCat = r.hget(bookCatHashKey, bookT001) or ''
        if resReadersCat!='': resReadersCat += '#'
        if userCat not in resReadersCat:
            r.hset(bookCatHashKey, bookT001, userCat)

    # progress bar
    i += 1
    if i%1000==0: printProgressBar(i, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)


################################################################################
#
# Zmaz citatelov, ktory citali jedinou knihu
#
################################################################################
"""
jobTitle = 'Mazem neaktivnych citatelov'
rkey = userHashKey
rkeys = r.hkeys(rkey)
totalRecs = len(rkeys)
printProgressBar(0, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)
i = 1
for rec in rkeys:
    val = r.hget(rkey,rec)
    if not '#' in val: r.hdel(rkey,rec)
    if i%1000==0: printProgressBar(i, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)
    i+=1
"""

################################################################################
#
# Zmaz knihy, ktore cital jediny uzivatel
#
################################################################################
"""
jobTitle = 'Mazem malo citane knihy'
rkey = bookHashKey
rkeys = r.hkeys(rkey)
totalRecs = len(rkeys)
printProgressBar(0, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)
i = 1
for rec in rkeys:
    val = r.hget(rkey,rec)
    if not '#' in val: r.hdel(rkey,rec)
    if i%1000==0: printProgressBar(i, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)
    i+=1
"""

################################################################################
#
# Zisti najpopularnejsiu knihu
#
################################################################################

jobTitle = 'Popularita knih'
rkey = bookPopularityHashKey
rkeys = r.hkeys(rkey)
totalRecs = len(rkeys) * 2
maxPopularity = 0
printProgressBar(0, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)
i = 1
for rec in rkeys:
    val = int(r.hget(rkey,rec))
    if val > maxPopularity: maxPopularity = val
    if i%1000==0: printProgressBar(i, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)
    i+=1

# prepocitaj percento popularnosti pre kazdu knihu
printProgressBar(totalRecs/2, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)
i = 1
base = maxPopularity/100
for rec in rkeys:
    val = int(r.hget(rkey,rec))
    r.hset(rkey,rec,math.ceil(val / base))
    if i%1000==0: printProgressBar(totalRecs/2 + i, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)
    i+=1
printProgressBar(totalRecs, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)


################################################################################
#
# Vhodnost knihy podla veku citatelov
#
################################################################################

jobTitle = 'Vhodnost knihy podla veku'
rkeys = r.hkeys(bookAgeHashKey)
totalRecs = len(rkeys)
printProgressBar(0, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)
i = 1
for rkey in rkeys:
    resAge = r.hget(bookAgeHashKey, rkey)
    resAgeX = resAge.split('#')
    resAgeList = {}
    maxAgeScore = 0
    # histogram veku
    for age in resAgeX:
        ageScore = 0
        if age in resAgeList: ageScore = resAgeList[age]
        ageScore += 1
        resAgeList[age] = ageScore
        if ageScore > maxAgeScore: maxAgeScore = ageScore
    # prepocitaj pocty na percenta
    bookAge = ''
    for age in resAgeList:
        agePercentil = math.ceil(resAgeList[age]*100 / maxAgeScore)
        if agePercentil >= ageHistogramTreshold:
            if bookAge: bookAge += '#'
            bookAge += age + ',' + str(agePercentil)
    # prilis siroke vekove urcenie knihy vylucime
    if bookAge.count('#') > 5: bookAge = ''
    # zapis
    if bookAge != '':
        r.hset(bookAgeHashKey,rkey,bookAge)
    else:
        r.hdel(bookAgeHashKey,rkey)

    if i%1000==0: printProgressBar(totalRecs + i, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)
    i+=1
printProgressBar(totalRecs, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)

print('\n[ DONE ]')

import sys, json, math, colorama, redis, re

from pprint import pprint
from pymongo import MongoClient
from colorama import Fore, Back, Style
from threading import Thread


################################################################################
#   INICIALIZACIA
################################################################################

jobList = [
    {
        'name': 'IDENTIFIKATORY ZAZNAMU'
    },
    {
        'name': 'TAG 100',
        'tag': '100',
        'subtags': [
            { 'subtag': '7', 'key': 'auth:100:code' },
            { 'subtag': 'a', 'key': 'auth:100:name' }
        ]
    },
    {
        'name': 'TAG 110',
        'tag': '110',
        'subtags': [
            { 'subtag': '7', 'key': 'auth:110:code' },
            { 'subtag': 'a', 'key': 'auth:110:name' }
        ]
    },
    {
        'name': 'TAG 700',
        'tag': '700',
        'subtags': [
            { 'subtag': '7', 'key': 'auth:700:code' },
            { 'subtag': 'a', 'key': 'auth:700:name' }
        ]
    },
    {
        'name': 'TAG 710',
        'tag': '710',
        'subtags': [
            { 'subtag': '7', 'key': 'auth:710:code' },
            { 'subtag': 'a', 'key': 'auth:710:name' }
        ]
    },
    {
        'name': 'TAG 080',
        'tag': '080',
        'subtags': [
            { 'subtag': 'a', 'key': 'mdt:080:code' }
        ]
    },
    {
        'name': 'TAG 600',
        'tag': '600',
        'subtags': [
            { 'subtag': '7', 'key': 'auth:600:code' }
        ]
    },
    {
        'name': 'TAG 610',
        'tag': '610',
        'subtags': [
            { 'subtag': '7', 'key': 'auth:610:code' }
        ]
    },
    {
        'name': 'TAG 611',
        'tag': '611',
        'subtags': [
            { 'subtag': '7', 'key': 'auth:611:code' }
        ]
    },
    {
        'name': 'TAG 630',
        'tag': '630',
        'subtags': [
            { 'subtag': '7', 'key': 'auth:630:code' }
        ]
    },
    {
        'name': 'TAG 648',
        'tag': '648',
        'subtags': [
            { 'subtag': '7', 'key': 'auth:648:code' }
        ]
    },
    {
        'name': 'TAG 650',
        'tag': '650',
        'subtags': [
            { 'subtag': '7', 'key': 'auth:650:code' }
        ]
    },
    {
        'name': 'TAG 651',
        'tag': '651',
        'subtags': [
            { 'subtag': '7', 'key': 'auth:651:code' }
        ]
    }
]


################################################################################
#   INICIALIZACIA
################################################################################

# colored console output
colorama.init()
# connection to mongo
client = MongoClient(port=27017)
db = client["okczd"]
dbMarc = db["marc"]
# redis
r = redis.StrictRedis(host='localhost', port=6380, db=0, decode_responses=True)
# premazat vsetko co je v pameti
r.flushall()


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
#   Prechadza zaznamy bibliografickych zaznamov v mongo DB a
#   plni ich do redis databazy do operacnej pamete
#
#   Vnorene cykly:
#   1) Vsetkymi polozkami jobList
#   2) Select vsetkych zaznamov z MongoDB
#
################################################################################

# zaciname od nulteho jobu (prveho v zozname)
jobId = 0
# iba kvoli progress-baru, aby sa vedelo kolky job z kolkych sa spracuva
jobCount = len(jobList)
# zoznam T001, ktore sa oplati spracovat, lebo maju niektory z identifikatorov
flagAnyList = []
# pocet vlakien
workersCount = 4
# zisti pocet vsetkych zaznamov bibliografickych zaznamov
recs = dbMarc.find({})
    #recs = dbMarc.find({}).limit(1000)
totalRecs = recs.count()
    #totalRecs = 1000
# pocet zaznamov na vlakno
workerRecs = math.ceil(totalRecs / workersCount)


################################################################################
#
#   Prechadza zaznamy bibliografickych zaznamov v mongo DB a
#   plni ich do redis databazy do operacnej pamete
#
################################################################################
def fillWorker(recRange, index):
    try:
        if index==0: printProgressBar(0, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)

        recordsToSkip = recRange[0]
        recordsToLimit = recRange[1]
        recs = dbMarc.find({}).skip(recordsToSkip).limit(recordsToLimit)
        skipsCount = 0

        i = 0
        for rec in recs:
            try:
                fld = rec['fields']
                t001 = fld[0]['001']
                flagAnyId = 0
            except:
                skipsCount+=1
                continue

            ########################################################################
            #   IDENTIFIKATORY ZAZNAMU
            ########################################################################

            if jobId == 0:

              ####################################################################
              #   tag 015 - CNB
              ####################################################################

              t015X = [x for x in fld if '015' in x]
              if t015X:
                  for t015 in t015X:
                      sub = t015['015']['subfields']
                      t015aX = [x for x in sub if 'a' in x]
                      for t015a in t015aX:
                          if t015a:
                              t015a = t015a['a']
                              rt015a = r.hget('id:nbn',t015a)
                              newVal = t001
                              if rt015a != None: newVal = rt015a + '#' + t001
                              r.hset('id:nbn',t015a,newVal)
                              flagAnyId = 1

              ################################################################################
              #   tag 020 - ISBN
              ################################################################################

              t020X = [x for x in fld if '020' in x]
              if t020X:
                  for t020 in t020X:
                      sub = t020['020']['subfields']
                      t020aX = [x for x in sub if 'a' in x]
                      for t020a in t020aX:
                          if t020a:
                              t020a = toEan(t020a['a'])
                              rt020a = r.hget('id:ean13',t020a)
                              newVal = t001
                              if rt020a != None: newVal = rt020a + '#' + t001
                              r.hset('id:ean13',t020a,newVal)
                              flagAnyId = 1


              ################################################################################
              #   tag 022 - ISSN
              ################################################################################

              t022X = [x for x in fld if '022' in x]
              if t022X:
                  for t022 in t022X:
                      sub = t022['022']['subfields']
                      t022aX = [x for x in sub if 'a' in x]
                      for t022a in t022aX:
                          if t022a:
                              t022a = toEan(t022a['a'])
                              rt022a = r.hget('id:ean13',t022a)
                              newVal = t001
                              if rt022a != None: newVal = rt022a + '#' + t001
                              r.hset('id:ean13',t022a,newVal)
                              flagAnyId = 1


              ################################################################################
              #   tag 024 - EAN13
              ################################################################################

              t024X = [x for x in fld if '024' in x]
              if t024X:
                  for t024 in t024X:
                      sub = t024['024']['subfields']
                      t024aX = [x for x in sub if 'a' in x]
                      for t024a in t024aX:
                          if t024a:
                              t024a = toEan(t024a['a'])
                              rt024a = r.hget('id:ean13',t024a)
                              newVal = t001
                              if rt024a != None: newVal = rt024a + '#' + t001
                              r.hset('id:ean13',t024a,newVal)
                              flagAnyId = 1


              ################################################################################
              #   tag 035 - OCLC
              ################################################################################

              t035X = [x for x in fld if '035' in x]
              if t035X:
                  for t035 in t035X:
                      sub = t035['035']['subfields']
                      t035aX = [x for x in sub if 'a' in x]
                      for t035a in t035aX:
                          if t035a:
                              t035a = cleanOclc(t035a['a'])
                              rt035a = r.hget('id:oclc',t035a)
                              newVal = t001
                              if rt035a != None: newVal = rt035a + '#' + t001
                              r.hset('id:oclc',t035a,newVal)
                              flagAnyId = 1

              # pridat do zanzmau zaznamov, ktore sa oplati spracovat
              #if flagAnyId: flagAnyList.append(t001)
              if flagAnyId:
                  r.hset('id:any',t001,1)


            ########################################################################
            #   DALSIE TAGY
            ########################################################################

            else:
              # preskakuj zaznamy, ktore nemaju ziadny z pouzitelnych identifikatorov 015,020,022,024,035
              #if not t001 in flagAnyList: continue
              if r.hexists('id:any',t001):

                  tagX = [x for x in fld if job['tag'] in x]
                  if tagX:
                      for tag in tagX:
                          jobTag = job['tag']
                          sub = tag[jobTag]['subfields']
                          subtagList = job['subtags']
                          for subtagItem in subtagList:
                              subtagX = [x for x in sub if subtagItem['subtag'] in x]
                              if subtagX:
                                  subtag = subtagX[0][subtagItem['subtag']]
                                  if subtag:
                                      rt = r.hget(subtagItem['key'],subtag)
                                      newVal = t001
                                      if rt != None: newVal = rt + '#' + t001
                                      r.hset(subtagItem['key'],subtag,newVal)
                                      #print('>>> ' + subtagItem['key'] + ' : ' + subtag + ' = ' + newVal)


            # progress bar
            i += 1
            if i%100==0 and index==0: printProgressBar(i, math.ceil(totalRecs/workersCount), prefix = jobTitle, suffix = 'Complete |'+str(skipsCount)+'|', length = 50)

    except:
        logging.error('Error with filling data to Redis!')

    if index==0: printProgressBar(totalRecs, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)
    return True


################################################################################
#
#   Hlavny cyklus, ktory vytvara vlakna pre kazdy task z jobList
#
################################################################################
for job in jobList:
    jobTitle = str(jobId+1) + '/' + str(jobCount) + ' ' + job['name'] + ': '

    # pripravit rozsahy zaznamov pre thread workery
    recRanges = []
    for threadId in range(workersCount):
        recRanges.append([threadId*workerRecs, workerRecs])

    # spustit vlakna
    threads = []
    for threadId in range(workersCount):
        process = Thread(target=fillWorker, args=[recRanges[threadId], threadId])
        process.start()
        threads.append(process)

    # pozastavime vykonanie tohto hlavneho vlakna za pomocou 'join'
    # neviem presne ako toto funguje, ale mame zaistene, ze vykonavanie dalsieho kodu bude pokracovat az po dobehnuti vsetkych vlakien
    for process in threads:
        process.join()

    # precisti data tohoto tagu
    # odstran vsetky "single" kluce - zaznamy, ktore maju odkaz iba na jednu knihu
    if jobId > 0:
        tagCode = job['tag']
        subtagList = job['subtags']
        for subtag in subtagList:
            rkey = subtag['key']
            # cyklys vsetkymi hodnotami v redis kluci daneho subtagu
            rkeys = r.hkeys(rkey)
            for rec in rkeys:
                val = r.hget(rkey,rec)
                if not '#' in val:
                    r.hdel(rkey,rec)

    # dalsi job = dalsi tag
    jobId += 1


r.delete('id:any')

print('\n[ DONE ]')

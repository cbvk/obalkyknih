import sys, json, hashlib, math
import redis

from pprint import pprint
from pymongo import MongoClient


################################################################################
#   INICIALIZACIA
################################################################################

relHashKey = 'rel:other'

# connection to mongo
client = MongoClient(port=27017)
db = client["okczd"]
dbMarc = db["marc"]
# redis
r = redis.StrictRedis(host='localhost', port=6380, db=0, decode_responses=True)
# premazat vsetko co je v pameti
r.delete(relHashKey)


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


################################################################################
#
#  MAIN
#
################################################################################

recs = dbMarc.find()
#recs = dbMarc.find({'$or':[{'fields.001':'87783'}, {'fields.001':'nkc20172962978'}, {'fields.001':'nkc20172898887'}, {'fields.001':'nkc20162799891'}, {'fields.001':'nkc20152756176'}, {'fields.001':'000699802'}, {'fields.001':'nkc20142627554'}]})
totalRecs = recs.count()
#totalRecs = 1
jobTitle = 'Dalsi relace'
printProgressBar(0, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)

i = 0
for rec in recs:
    try:
        fld = rec['fields']
        id = rec['_id']
        t001 = [x for x in fld if '001' in x]
        t001 = t001[0]['001']
    except:
        continue

    firstAuth = None
    relName = None
    partName = None

    t245X = [x for x in fld if '245' in x]
    if len(t245X):
        t245 = t245X[0]
        sub = t245['245']['subfields']
        t245aX = [x for x in sub if 'a' in x]
        t245pX = [x for x in sub if 'p' in x]
        t245nX = [x for x in sub if 'n' in x]
        if len(t245aX):
            if 'a' in t245aX[0]: relName = t245aX[0]['a']
        if len(t245nX):
            if 'n' in t245nX[0]:
                partName = t245nX[0]['n']
        if len(t245pX):
            if 'p' in t245pX[0]:
                partName = '' if not partName else partName + ' '
                partName += t245pX[0]['p']

    """
    t787X = [x for x in fld if '787' in x]
    if len(t787X):
        t787 = t787X[0]
        sub = t787['787']['subfields']
        t787iX = [x for x in sub if 'i' in x]
        t787tX = [x for x in sub if 't' in x]
        t787gX = [x for x in sub if 'g' in x]
        if len(t787iX):
            if 'i' in t787iX[0]: relName = t787iX[0]['i']
        if len(t787tX):
            if 't' in t787tX[0]:
                relName = '' if not relName else relName + ' '
                relName += t787tX[0]['t']
        if len(t787gX):
            if 'g' in t787gX[0]: partName = t787gX[0]['g']
    """

    if relName and partName:
        t100X = [x for x in fld if '100' in x]
        if len(t100X):
            t100 = t100X[0]
            sub = t100['100']['subfields']
            t1007X = [x for x in sub if '7' in x]
            t100aX = [x for x in sub if 'a' in x]
            if len(t1007X):
                if '7' in t1007X[0]: firstAuth = t1007X[0]['7']
            elif len(t100aX) and not firstAuth:
                if 'a' in t100aX[0]: firstAuth = t100aX[0]['a']

        if not firstAuth:
            t110X = [x for x in fld if '110' in x]
            if len(t110X):
                t110 = t110X[0]
                sub = t110['110']['subfields']
                t1107X = [x for x in sub if '7' in x]
                t110aX = [x for x in sub if 'a' in x]
                if len(t1107X):
                    if '7' in t1107X[0]: firstAuth = t1107X[0]['7']
                elif len(t110aX) and not firstAuth:
                    if 'a' in t110aX[0]: firstAuth = t110aX[0]['a']

        if not firstAuth:
            t700X = [x for x in fld if '700' in x]
            if len(t700X):
                t700 = t700X[0]
                sub = t700['700']['subfields']
                t7007X = [x for x in sub if '7' in x]
                t700aX = [x for x in sub if 'a' in x]
                if len(t7007X):
                    if '7' in t7007X[0]: firstAuth = t7007X[0]['7']
                elif len(t700aX) and not firstAuth:
                    if 'a' in t700aX[0]: firstAuth = t700aX[0]['a']

        if not firstAuth:
            t710X = [x for x in fld if '710' in x]
            if len(t710X):
                t710 = t710X[0]
                sub = t710['710']['subfields']
                t7107X = [x for x in sub if '7' in x]
                t710aX = [x for x in sub if 'a' in x]
                if len(t7107X):
                    if '7' in t7107X[0]: firstAuth = t7107X[0]['7']
                elif len(t710aX) and not firstAuth:
                    if 'a' in t710aX[0]: firstAuth = t710aX[0]['a']

    i += 1
    if i%1000==0: printProgressBar(i, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)

    if not firstAuth or not relName or not partName: continue
    if len(partName) <= 2: continue

    if partName[-2]==' ':
        partName = partName[:-2]

    relKey = firstAuth + '|' + relName
    edval = t001 + '|' + partName
    ed = r.hget(relHashKey,relKey)
    if ed == None:
        r.hset(relHashKey,relKey, edval)
    else:
        # neopakovat vyskyty toho isteho
        if '|' + partName not in ed:
            edval = ed + '#' + edval
            r.hset(relHashKey,relKey, edval)


# Precisti knihy iba s jednou ediciou
rkeys = r.hkeys(relHashKey)
for rec in rkeys:
    val = r.hget(relHashKey,rec)
    if not '#' in val:
        r.hdel(relHashKey,rec)

printProgressBar(totalRecs, totalRecs, prefix = jobTitle, suffix = 'Complete', length = 50)

print('\n[ DONE ]')

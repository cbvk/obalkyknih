import sys, json
import colorama
import datetime

from pprint import pprint
from pymongo import MongoClient
from colorama import Fore, Back, Style
from oaipmh.client import Client
from io import BytesIO
from lxml.etree import tostring
from pymarc import marcxml
from bson.objectid import ObjectId

################################################################################
#   INICIALIZACIA
################################################################################

# colored console output
colorama.init()
# connection to mongo
client = MongoClient(port=27017)
db = client["okczd"]
dbTrans = db["trans"]

# definicia metadata readera

class MARCXMLReader(object):
    # vracia PyMARC zaznam z OAI struktury
    def __call__(self, element):
        #debug print(element[0][1].text)
        handler = marcxml.XmlHandler()
        marcxml.parse_xml( BytesIO( tostring(element[0]) ), handler)
        return handler.records[0]

marcxml_reader = MARCXMLReader()

from oaipmh import metadata

registry = metadata.MetadataRegistry()
registry.registerReader('oai_marctrx', marcxml_reader)


################################################################################
#   ZBER DAT tranzakcii uzivatelov
################################################################################

"""recs = dbTrans.find({ 'sigla': 'CBA001' }).sort('_id', -1).limit(1)"""

dtfrom = datetime.datetime(2015, 10, 10, 0, 0)
now = datetime.datetime.now()

"""
if recs:
    for rec in recs:
        print(rec)

print(dtfrom)
print(dtfrom + datetime.timedelta(1,0,0,0,0,0,0))
sys.exit()
"""

#oai = Client('https://katalog.cbvk.cz/i2/i2.ws.oai.cls', registry)
#oai = Client('https://ipac.svkkl.cz/i2/i2.ws.oai.cls', registry)
oai = Client('https://katalog.kjm.cz/i2/i2.ws.oai.cls', registry)

i = 0
while now > dtfrom:
    try:
        dtnextday = dtfrom + datetime.timedelta(1,0,0,0,0,0,0) # +1d
        dtuntil = dtnextday - datetime.timedelta(0,1,0,0,0,0,0) # +1d -1s
        print(dtfrom)

        try:
            recs = oai.listRecords(metadataPrefix='oai_marctrx', set='OKCZ', from_=dtfrom, until=dtuntil)

            j = 0
            for rec in recs:
                id = rec[0].identifier() # identifikator v OAI
                recMarc = rec[1] # pyMARC reprezentacia
                if str(type(recMarc)) != "<class 'pymarc.record.Record'>": continue;
                recJson = recMarc.as_dict() # JSON
                recJson['_id'] = id
                #recJson['sigla'] = 'KLG001'
                #recJson['sigla'] = 'LIA001'
                recJson['sigla'] = 'BOG001'
                recJson['datestamp'] = rec[0].datestamp()
                dbTrans.update_one({ '_id': id }, { '$set': recJson }, upsert=True)
                i += 1
                j += 1
                if j%100==0: print('.', sep='', end='', flush=True)
                if j%1000==0: print(' ' + Fore.GREEN + str(j) + Style.RESET_ALL, sep=' ', end=' ', flush=True)
                if j%5000==0: print('')
                #if i==100: sys.exit()

            print(' ' + Fore.GREEN + str(j) + Style.RESET_ALL + ' (total:' + str(i) + ')')

        except:
            print(' NO DATA TODAY')

        dtfrom = dtnextday

    except KeyboardInterrupt:
        print('[CTRL+C detected]')
        sys.exit()

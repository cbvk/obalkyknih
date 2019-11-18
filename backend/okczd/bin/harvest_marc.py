import sys, json, re, colorama, datetime, urllib.request

from pprint import pprint
from pymongo import MongoClient
from colorama import Fore, Back, Style
from oaipmh.client import Client
from io import BytesIO
from lxml.etree import tostring
from pymarc import marcxml

################################################################################
#   INICIALIZACIA
################################################################################

# colored console output
colorama.init()
# connection to mongo
client = MongoClient(port=27017)
db = client["okczd"]
dbMarc = db["marc"]

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
registry.registerReader('marc21', marcxml_reader)


################################################################################
#   ZBER DAT
#   Ziskanie OAI setu SKC a ukladanie do mongodb
################################################################################

oai = Client('http://aleph.nkp.cz/OAI', registry)

dtfrom = datetime.datetime(2019, 5, 30, 0, 0)
now = datetime.datetime.now()
sess = seq = ''
i = 0
while now > dtfrom:
    try:
        dtnextinterval = dtfrom + datetime.timedelta(1,0,0,0,0,0,0) # +1d
        dtuntil = dtnextinterval - datetime.timedelta(0,1,0,0,0,0,0) # +1d -1s
        #dtnextinterval = dtfrom + datetime.timedelta(0,0,0,0,1,0,0) # +1d
        #dtuntil = dtnextinterval - datetime.timedelta(0,1,0,0,0,0,0) # +1d -1s
        print('[  NOVY INTERVAL  ]')
        print(dtfrom)
        print(dtuntil)

        try:
            recs = oai.listRecords(metadataPrefix='marc21', set='SKC', from_=dtfrom, until=dtuntil)
        except:
            dtfrom = dtnextinterval
            continue

        try:
            j = 0
            for rec in recs:
                #print(rec[0].identifier()) # identifikator v OAI
                recMarc = rec[1] # pyMARC reprezentacia
                if str(type(recMarc)) != "<class 'pymarc.record.Record'>": continue;
                recJson = recMarc.as_dict() # JSON

                # sysno zaznamu
                fld = recJson['fields']
                t998X = [x for x in fld if '998' in x]
                if t998X:
                    for t998 in t998X:
                        sub = t998['998']['subfields']
                        t998aX = [x for x in sub if 'a' in x]
                        for t998a in t998aX:
                            if t998a:
                                t998a = t998a['a']
                                m = re.search('doc_number=(\d+)&local_base', t998a)
                                if m:
                                    sysno = m.group(1)
                                    recJson['sysno'] = sysno

                                    # ziskaj citaciu z SKC, pre kazdych 20. zaznam
                                    if j%20==0:
                                        if sess=='':
                                            #req.add_header('cookie', sess)
                                            resp = urllib.request.urlopen('https://aleph.nkp.cz/F/')
                                            respHtml = resp.read().decode('utf8')
                                            sessRegexp = re.search('\/F\/(.*)\-(.*)\?func=file&file_name=find\-b&local_base=SKC"', respHtml)
                                            if sessRegexp:
                                                sess = sessRegexp.group(1)
                                                seq = sessRegexp.group(2)
                                                resp = urllib.request.urlopen('https://aleph.nkp.cz/F/' + sess + '-' + seq + '?func=file&file_name=find-b&local_base=SKC')
                                                print('<NEW SESSION: ' + sess + ' seq:' + seq + '>')

                                        citHtml = urllib.request.urlopen('https://aleph.nkp.cz/aleph-cgi/get_cit?sid=' + sess + '&sn=' + sysno).read()
                                        citHtml = citHtml.decode('utf8')
                                        citRegexp = re.search('innerHTML = "(.*)";', citHtml)
                                        if citRegexp:
                                            cit = citRegexp.group(1)
                                            recJson['citSKC'] = cit
                                        else:
                                            print('<SESSION EXPIRED: ' + sess + '>')
                                            sess = ''

                recJson['dtfrom'] = dtfrom
                recJson['dtuntil'] = dtuntil
                try:
                    dbMarc.insert_one(recJson)
                except:
                    print(recJson)
                i += 1
                j += 1
                if j%100==0: print('.', sep='', end='', flush=True)
                if j%1000==0: print(' ' + Fore.GREEN + str(j) + Style.RESET_ALL, sep=' ', end=' ', flush=True)
                if j%5000==0: print('')
                #if i==100000: sys.exit()

            print(' ' + Fore.GREEN + str(j) + Style.RESET_ALL + ' (total:' + str(i) + ')')
            dtfrom = dtnextinterval

        except:
            # problem so strankovanim v OAI, pokracujeme na dalsi den
            dtfrom = dtnextinterval

    except KeyboardInterrupt:
        print('[CTRL+C detected]')
        sys.exit()

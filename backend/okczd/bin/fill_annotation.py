import re

import redis
from pymongo import MongoClient
from preprocessing import Preprocessor
from vectorizer import Vectorizer
import mysql.connector
from mysql.connector import errorcode
from langdetect import detect
from langdetect import lang_detect_exception


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


def fill_anotation():
    """
    Naplni marc kolekciu annotation anotaciamy. Primarne sa pouzivaju anotacie z MySQL. Ak anotacia pre zaznam nie je
    alebo je v inom jazyku pouzije sa anotacia z marc kolekcie.

    Musi byt naplnena redis DB - aspon fill_marc.py
    :return:
    """
    client = MongoClient(port=27017)
    db = client["okczd"]
    dbMarc = db["marc"]
    dbAnnotation = db["annotation"]

    # redis
    r = redis.StrictRedis(host='localhost', port=6379, db=0, decode_responses=True)
    cnx = None
    try:
        cnx = mysql.connector.connect(host="localhost",
                                      port=3308,
                                      user="root",
                                      passwd="",
                                      database="okcz")
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your user name or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(err)
    else:
        print(cnx)
    mycursor = cnx.cursor()

    mycursor.execute("SELECT * FROM `tmp_review`")  # TODO upravit DB v selekte @lubo

    myresult = mycursor.fetchall()
    pre = Preprocessor()

    # Najprv pouzijeme anotacie z MySQL
    for x in myresult:
        annotation = x[2]
        ean13 = x[3]
        nbn = x[4]
        oclc = x[5]
        bookT001 = None
        if nbn:
          bookT001 = r.hget('id:nbn', nbn)
        if ean13 and not bookT001:
          ean13 = toEan(ean13)
          bookT001 = r.hget('id:ean13', ean13)
        if oclc and not bookT001:
          oclc = cleanOclc(oclc)
          bookT001 = r.hget('id:oclc', oclc)
        if bookT001:
            try:
                lang = detect(annotation)
            except lang_detect_exception.LangDetectException as langexeption:
                print(langexeption)
                print(annotation)
                continue
            if lang == 'cs':
                new_annotation = {}
                new_annotation['001'] = bookT001
                new_annotation['annotation'] = annotation
                annotation_pre = pre.remove_stop_words(annotation)
                annotation_pre = pre.lemmatize(annotation_pre)
                new_annotation['annotation_pre'] = ' '.join(annotation_pre)
                dbAnnotation.insert_one(new_annotation)

    # Potom pouzijeme pole 520 z marc kolekcie z MongoDB ak zaznam nema anotaciu vyplnenu
    found = dbMarc.find({'fields.520': {'$exists': True}})
    for f in found:
        new_annotation = {}
        fld = f['fields']
        id = f['fields'][0]['001']
        bookannotation = dbAnnotation.find_one({'fields.001': id})
        if not bookannotation:
            t520X = [x for x in fld if '520' in x]
            annotation = ""
            if t520X:
                for t520 in t520X:
                    sub = t520['520']['subfields']
                    t520aX = [x for x in sub if 'a' in x]
                    for t520a in t520aX:
                        if t520a:
                            t520a = t520a['a']
                            annotation += t520a
            try:
                lang = detect(annotation)
            except lang_detect_exception.LangDetectException as langexeption:
                print(langexeption)
                print(annotation)
                continue
            if lang == 'cs':
                new_annotation['001'] = id
                new_annotation['annotation'] = annotation
                annotation_pre = pre.remove_stop_words(annotation)
                annotation_pre = pre.lemmatize(annotation_pre)
                new_annotation['annotation_pre'] = ' '.join(annotation_pre)
                dbAnnotation.insert_one(new_annotation)


def generate_vectorizer(path, name):
    """
    Vytvori tf-idf vektorizator, ktory sa pouziva pre zoradenie zaznamov podla kosinusovej podobnosti
    Pred spustenim treba spustit fill_annotation pre naplnenia anotacii a ich predspracovanie
    :param path: Priecinok kam sa ulozi vektorizator
    :param name: Meno suboru kam sa vektorizator ulozi
    :return:
    """
    client = MongoClient(port=27017)
    db = client["okczd"]
    dbAnnotation = db["annotation"]

    found = dbAnnotation.find({})
    texts = []
    for f in found:
        annotation = f['annotation_pre']
        texts.append(annotation)

    vectorizer = Vectorizer()
    vectorizer.fit(texts)
    vectorizer.save(path, name)

fill_anotation()
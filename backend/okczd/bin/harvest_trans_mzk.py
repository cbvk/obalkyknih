from pymongo import MongoClient
import argparse
from tinydb import TinyDB, Query
from os import listdir
from os.path import isfile, join
import os


def harvest_trans_mzk_directory(directory, db, collection, work_dir=None):
    """
    Importuje vestky .txt subory v zadanom priecinku, ak este nie su v tinyDB
    tinyDB uklada zaznamy do db.json v priecinku v ktorom je tento skript
    :param work_dir: Kam sa uklada subor db.json
    :param directory: Priecinok z ktoreho sa budu subory importovat
    :param db: Mongo databaza kam sa maju zaznamy naimportovat
    :param collection: Mongo colekcia kam sa maju zaznamy naimportovat
    :return:
    """
    if work_dir is None:
        work_dir = os.path.dirname(os.path.realpath(__file__))
    files = [f for f in listdir(directory) if (isfile(join(directory, f)) and f.endswith(".txt"))]
    tinyDB = TinyDB(work_dir + '/db.json')
    # pripojenie na Mongo
    client = MongoClient(port=27017)
    db = client[db]
    dbTrans = db[collection]
    # prejdenie vsetkych suborov v priecinku
    for file in files:
        if not check_if_already_imported(file, tinyDB):
            # subor sa naimportuje ak este nie je v tinyDB
            print("Importujem subor:" + join(directory, file))
            imp, not_imp = harvest_trans_mzk(join(directory, file), db, dbTrans, work_dir)
            print("Importovanych zaznamov: " + str(imp))
            print("Neimportovanych zaznamov " + str(not_imp))
            # ulozenie do tinyDB ak vsetko zbehlo
            tinyDB.insert({'name': file})


def check_if_already_imported(file_name, tinyDB):
    """
    Skontroluje ci uz bol subor naimportovany
    :param file_name: Subor ktory sa zistuje ci bol uz naimportovany
    :param tinyDB: tinyDB
    :return: Vrati True ak uz subor je v tinyDB inak vrati False
    """
    files = Query()
    result = tinyDB.search(files.name == file_name)
    if not result:
        return False
    else:
        return True


def harvest_trans_mzk(export, db, dbTrans, work_dir):
    """
    Metoda pre ukladanie zaznamov zo suboru 'export' do MongoDB
    :param work_dir: Priecinok ka sa uklada not_imported.txt
    :param export: subor v ktorom su zaznamy - moze byt objekt file alebo cesta k suboru
    :param db: databaza do ktorej sa ulozia zaznamy
    :param dbTrans: kolekcia do ktorej sa ulozia zaznamy
    :return: pocet ulozenych zaznamov
    """
    if work_dir is None:
        work_dir = os.path.dirname(os.path.realpath(__file__))
    # pripojenie na Mongo
    if isinstance(db, str):
        client = MongoClient(port=27017)
        db = client[db]
        dbTrans = db[dbTrans]
    sigla = "CBA001"
    if isinstance(export, str):
        # otvorenie suboru
        file = open(export, 'r')
    else:
        file = export
    file_not_imported = open(work_dir + "/not_imported.txt", "a+")
    i = 0
    imported = 0
    not_imported = 0
    # extrakcia zaznamov kde jeden riadok = jeden zaznam
    for line in file.readlines():
        i += 1
        try:
            line = line.strip('\n')
            result = parse_line(line)
            result['sigla'] = sigla
            dbTrans.insert_one(result)
            imported += 1
        except Exception as exc:
            not_imported += 1
            print("Line" + str(i) + " " + line + "was not imported because of exception: " + str(exc))
            file_not_imported.write(line + '\n')
    file.close()
    return imported, not_imported


def parse_line(line):
    """
    Parsuje riadok do dokumentu, ktory je mozne nasledne ulozit do Monga
    :param line: riadok zo suboru
    :return: dokument ako dictionary
    """
    identifiers = ["015a", "020a", "022a", "024a", "035a", "902a"]  # zoznam moznych indentifikatorov
    fields = line.split('@')
    if not fields[0].startswith('001'):
        return None
    result = {"fields": []}
    others = {}
    # kazde pole sa prida do result['fields']
    for field in fields:
        parts = field.split(' ')
        if parts[0] == '001':
            new_field = {'001': parts[1]}
            result['fields'].append(new_field)
        elif parts[0] in identifiers:
            if parts[1] == '':
                continue
            values = parts[1].split('#')
            tag = parts[0][0:3]
            subtag = parts[0][3]
            for value in values:
                new_field = {tag: {"subfields": [{subtag: value}]}}
                result["fields"].append(new_field)
        else:
            if parts[1] == '':
                continue
            tag = parts[0][0:3]
            subtag = parts[0][3]
            value = parts[1]
            if others.get(tag, None) is None:
                others[tag] = {"subfields": []}
            others[tag]["subfields"].append({subtag: value})

    for key in others:
        result["fields"].append({key: others[key]})
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Skript pre import dat o pozickach do MongoDB')
    parser.add_argument('path', help='Ak je cesta subor importuje sa jeden subor, ak je cesta priecinok importuju sa '
                                     'vsetky subory v priecinku')
    args = parser.parse_args()
    path = args.path
    if isfile(path):
        print("Importujem subor:" + path)
        imported, not_imported = harvest_trans_mzk(path, 'okczd', 'trans', None)
        print("Importovanych zaznamov: " + str(imported))
        print("Neimportovanych zaznamov " + str(not_imported))
    else:
        harvest_trans_mzk_directory(path, 'okczd', 'trans')

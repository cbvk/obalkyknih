from pymongo import MongoClient
import argparse


def harvest_trans_mzk(export, db, collection):
    client = MongoClient(port=27017)
    db = client[db]
    dbTrans = db[collection]
    sigla = "CBA001"
    if isinstance(export, str):
        file = open(export, 'r')
    else:
        file = export
    i = 0
    for line in file.readlines():
        line = line.strip('\n')
        result = parse_line(line)
        result['sigla'] = sigla
        dbTrans.insert_one(result)
        i += 1
    file.close()
    return i


def parse_line(line):
    identifiers = ["015a", "020a", "022a", "024a", "035a", "902a"]  # zoznam moznych indentifikatorov
    fields = line.split('@')
    if not fields[0].startswith('001'):
        return None
    result = {"fields": []}
    others = {}
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
    parser.add_argument('file', help='Subor z ktoreho sa importuju data')
    args = parser.parse_args()
    export = args.file
    print("Importujem subor:" + export)
    number = harvest_trans_mzk(export, 'okczd', 'trans')
    print("Importovanych zaznamov: " + str(number))

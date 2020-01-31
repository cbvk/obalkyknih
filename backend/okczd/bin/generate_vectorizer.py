from pymongo import MongoClient
from vectorizer import Vectorizer
import argparse


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
        print(annotation)
        texts.append(annotation)

    vectorizer = Vectorizer()
    vectorizer.fit(texts)
    vectorizer.save(path, name)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Skript pre vytvorenie vektorizatora')
    parser.add_argument('dir', help='Priecinok kam sa vektorizator ulozi')
    parser.add_argument('name', help='Meno suboru')
    args = parser.parse_args()
    directory = args.dir
    name = args.name
    generate_vectorizer(directory, name)
    print("DONE")

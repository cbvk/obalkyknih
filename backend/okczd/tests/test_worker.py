import unittest

import redis
from pymongo import MongoClient
from worker import recommederWorker, annotation_score, cachedBookByT001
from settings import priority


class TestWorker(unittest.TestCase):
    def test_recommenderWorker(self):
        # connection to mongo
        client = MongoClient(port=27017)
        db = client["okczd"]
        dbMarc = db["marc"]
        dbAnnotation = db["annotation"]

        # redis
        r = redis.StrictRedis(host='localhost', port=6379, db=0, decode_responses=True)

        rec = {'log': []}
        debug = 1
        bookT001 = 'gk00101619'
        response = recommederWorker(dbMarc, dbAnnotation, r, rec, debug, bookT001)
        print("response" + str(response))
        print("rec" + str(rec))

    def test_recommenderWorker_multi(self):
        # connection to mongo
        client = MongoClient(port=27017)
        db = client["okczd"]
        dbMarc = db["marc"]
        dbAnnotation = db["annotation"]

        # redis
        r = redis.StrictRedis(host='localhost', port=6379, db=0, decode_responses=True)

        rec = {'log': []}
        debug = 1
        bookT001 = 'bk195806328#bk195806328'
        response = recommederWorker(dbMarc, dbAnnotation, r, rec, debug, bookT001)
        print(response)
        print(rec)

    def test_recommenderWorker_user(self):
        #         LIA001|iwkt1fxsyXgwBdHbq8E821rdnEBbncOfOeoBoF+dEAn0tCCqA8MktjXt4pD8GLDpLPSj34y95uAOoQFeHa5DiA==
        # connection to mongo
        client = MongoClient(port=27017)
        db = client["okczd"]
        dbMarc = db["marc"]
        dbAnnotation = db["annotation"]

        # redis
        r = redis.StrictRedis(host='localhost', port=6379, db=0, decode_responses=True)

        resUserBooks = r.hget('user:book', "LIA001|iwkt1fxsyXgwBdHbq8E821rdnEBbncOfOeoBoF+dEAn0tCCqA8MktjXt4pD8GLDpLPSj34y95uAOoQFeHa5DiA==")
        if not resUserBooks:
            print('DEBUG > http:200 uzivatel neexistuje')
            return

        listUserBooks = resUserBooks.split('#')
        listUserBooks = listUserBooks[0:50]

        if not len(listUserBooks):
            print('DEBUG > http:200 uzivatel nema vypozicanu ziadnu knihu')
            return

        listUserBooks = '#'.join(listUserBooks)

        rec = {'log': []}
        debug = 1
        response = recommederWorker(dbMarc, dbAnnotation, r, rec, debug, listUserBooks)
        print(response)
        print(rec)

    def test_annotation_score(self):
        client = MongoClient(port=27017)
        db = client["okczd"]
        dbAnnotation = db["annotation"]
        bookT001X = ["gk63120073", "gk68261274"]
        books = {}
        res = ["gk71100852", "0000599400"]
        for resT001 in res:
            books[resT001] = {'t001': resT001, 'score': 0, 'all': False, 'log': []}

        sorted_books = annotation_score(dbAnnotation, bookT001X, books)
        # print(books)
        print(sorted_books)

    def test_annotation_big(self):
        client = MongoClient(port=27017)
        db = client["okczd"]
        dbAnnotation = db["annotation"]
        bookT001X = ["gk63120073", "gk68261274"]
        books = {}
        found = dbAnnotation.find()
        debug = 1
        number = 0
        res = []
        for f in found:
            res.append(f['001'])
            number += 1
            if number == 100:
                break
        print(len(res))
        for resT001 in res:
            books[resT001] = {'t001': resT001, 'score': 0, 'all': False, 'log': []}

        cosine_sorted = annotation_score(dbAnnotation, bookT001X, books)
        # priradenie priority podla podobnosti
        if cosine_sorted:
            for cosine_book in cosine_sorted:
                if cosine_book[1] >= 0.75:
                    cachedBookByT001("cosine:075", bookT001X, priority["cosine:075"], debug, cosine_book[0], books)
                elif 0.5 <= cosine_book[1] < 0.75:
                    cachedBookByT001("cosine:050", bookT001X, priority["cosine:050"], debug, cosine_book[0], books)
                elif 0.25 <= cosine_book[1] < 0.5:
                    cachedBookByT001("cosine:025", bookT001X, priority["cosine:025"], debug, cosine_book[0], books)
                elif cosine_book[1] < 0.25:
                    cachedBookByT001("cosine:000", bookT001X, priority["cosine:000"], debug, cosine_book[0], books)
        # print(books)
        print(cosine_sorted)
        print(books)


if __name__ == '__main__':
    unittest.main()

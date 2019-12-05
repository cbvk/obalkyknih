import unittest

import redis
from pymongo import MongoClient
from worker import recommederWorker


class TestWorker(unittest.TestCase):
    def test_recommenderWorker(self):
        # connection to mongo
        client = MongoClient(port=27017)
        db = client["okczd"]
        dbMarc = db["marc"]

        # redis
        r = redis.StrictRedis(host='localhost', port=6380, db=0, decode_responses=True)

        rec = {'log': []}
        debug = 1
        bookT001 = 'bk195806328'
        response = recommederWorker(dbMarc, r, rec, debug, bookT001)
        print(response)
        print(rec)

    def test_recommenderWorker_multi(self):
        # connection to mongo
        client = MongoClient(port=27017)
        db = client["okczd"]
        dbMarc = db["marc"]

        # redis
        r = redis.StrictRedis(host='localhost', port=6380, db=0, decode_responses=True)

        rec = {'log': []}
        debug = 1
        bookT001 = 'bk195806328#bk195806328'
        response = recommederWorker(dbMarc, r, rec, debug, bookT001)
        print(response)
        print(rec)


if __name__ == '__main__':
    unittest.main()

import os

import redis
from pymongo import MongoClient

################################################################################
#
#   Nacita mapovanie zo suboru rules.tx a ulozi ich do Mongo
#
################################################################################


def save_rules_mongo():
    rules = {}
    for i in range(1, 27):
        rules['k' + str(i)] = []
    k = 0
    dir_path = os.path.dirname(os.path.realpath(__file__))
    with open(dir_path + "/rules.txt", "r", encoding="utf8") as file:
        for line in file:
            parts = line.split("$$")
            if "b1" == parts[2]:
                k += 1
                continue

            pattern = parts[1][1:]
            rules['k' + str(k)].append(pattern)

    client = MongoClient(port=27017)
    db = client["okczd"]
    dbMap = db["map"]
    dbMap.insert_one(rules)

################################################################################
#
#   Nacita mapovanie zo suboru rules.tx a ulozi ich do Redis
#
################################################################################


def save_rules_redis():
    rules = {}
    for i in range(1, 27):
        rules['k' + str(i)] = []
    k = 0
    dir_path = os.path.dirname(os.path.realpath(__file__))
    with open(dir_path + "/rules.txt", "r", encoding="utf8") as file:
        for line in file:
            parts = line.split("$$")
            if "b1" == parts[2]:
                k += 1
                continue

            pattern = parts[1][1:]
            rules['k' + str(k)].append(pattern)

    r = redis.StrictRedis(host='localhost', port=6380, db=0, decode_responses=True)
    for key in rules:
        r.hset('kons:map', key, '#'.join(rules[key]))


save_rules_redis()
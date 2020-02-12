import unittest
from bin.harvest_trans_mzk import harvest_trans_mzk, harvest_trans_mzk_directory
from pymongo import MongoClient
import os


class TestHarvestTransMZK(unittest.TestCase):
    def test_harvest_trans_mzk(self):
        try:
            with open("mzk-test2.txt", 'r') as file:
                imported, not_imported = harvest_trans_mzk(file, 'test_db', 'trans', '.')
                print(imported)
            self.assertEqual(5807, imported)
        finally:
            client = MongoClient(port=27017)
            client.drop_database('test_db')
            os.remove("./not_imported.txt")

    def test_harvest_mzk_directory(self):
        try:
            harvest_trans_mzk_directory('.', 'test_db', 'trans', '.')
        finally:
            client = MongoClient(port=27017)
            client.drop_database('test_db')
            os.remove("./not_imported.txt")
            os.remove("./db.json")


if __name__ == '__main__':
    unittest.main()

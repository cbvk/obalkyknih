import unittest
from bin.harvest_trans_mzk import harvest_trans_mzk
from pymongo import MongoClient


class TestHarvestTransMZK(unittest.TestCase):
    def test_harvest_trans_mzk(self):
        try:
            with open("mzk-test2.txt", 'r') as file:
                number = harvest_trans_mzk(file, 'test_db', 'trans')
                print(number)
            self.assertEqual(5807, number)
        finally:
            client = MongoClient(port=27017)
            client.drop_database('test_db')


if __name__ == '__main__':
    unittest.main()

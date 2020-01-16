from pymongo import MongoClient
from preprocessing import Preprocessor
from vectorizer import Vectorizer

client = MongoClient(port=27017)
db = client["okczd"]
dbMarc = db["marc"]
dbAnnotation = db["annotation"]
# found = dbMarc.find({'fields.520': {'$exists': True}})
# pre = Preprocessor()
# for f in found:
#     new_annotation = {}
#     fld = f['fields']
#     id = f['fields'][0]['001']
#     t520X = [x for x in fld if '520' in x]
#     annotation = ""
#     if t520X:
#         for t520 in t520X:
#             sub = t520['520']['subfields']
#             t520aX = [x for x in sub if 'a' in x]
#             for t520a in t520aX:
#                 if t520a:
#                     t520a = t520a['a']
#                     annotation += t520a
#     new_annotation['001'] = id
#     new_annotation['annotation'] = annotation
#     annotation_pre = pre.remove_stop_words(annotation)
#     annotation_pre = pre.lemmatize(annotation_pre)
#     new_annotation['annotation_pre'] = ' '.join(annotation_pre)
#     dbAnnotation.insert_one(new_annotation)

found = dbAnnotation.find({})
texts = []
for f in found:
    annotation = f['annotation_pre']
    # print(annotation)
    texts.append(annotation)

vectorizer = Vectorizer()
vectorizer.fit(texts)
vectorizer.save('.')

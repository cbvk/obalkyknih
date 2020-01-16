import errno
import os

from sklearn.feature_extraction.text import TfidfVectorizer, CountVectorizer
import pickle
from pathlib import Path


class Vectorizer():
    def __init__(self, vectorizer='tfidf', ngram=1, vocabulary=None, load_vec=None, input='content'):
        if load_vec is not None:
            with open(load_vec, "rb") as file:
                self.vectorizer = pickle.load(file)
            return
        if vectorizer == 'tfidf':
            self.vectorizer = TfidfVectorizer(vocabulary=vocabulary, ngram_range=(1, ngram), input=input)
        elif vectorizer == 'bow':
            self.vectorizer = CountVectorizer(vocabulary=vocabulary, ngram_range=(1, ngram), input=input)
        else:
            raise Exception("Unknown vectorizer")

    def fit(self, data):
        self.vectorizer.fit(data)

    def transform(self, data):
        matrix = self.vectorizer.transform(data)
        return matrix

    def get_matrix(self, data):
        matrix = self.vectorizer.fit_transform(data)
        return matrix

    def save(self, path):
        vec_path = str(Path(path) / "vectorizer.pickle")
        try:
            os.makedirs(path)
        except OSError as e:
            if e.errno != errno.EEXIST:
                raise
        with open(vec_path, "wb") as file:
            pickle.dump(self.vectorizer, file)



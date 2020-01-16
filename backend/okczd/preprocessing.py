from multiprocessing import Process

from ufal.morphodita import *
from pathlib import Path


class Preprocessor(Process):
    def __init__(self, dictionary=None, stop_words=None):
        super(Preprocessor, self).__init__()
        dir_path = Path(__file__).resolve().parent
        if dictionary is not None:
            self.dictionary = dictionary
        else:
            self.dictionary = str(dir_path / "dict/czech-morfflex-161115-pos_only.dict")
        if stop_words is not None:
            self.stop_words = stop_words
        else:
            self.stop_words = ["a sice", "a to", "a", "aby", "aj", "ale", "ani", "aniz", "aniž", "ano", "asi", "az",
                               "až", "bez", "bude", "budem", "budes", "budeš", "by", "byl", "byla", "byli", "bylo",
                               "byt", "být", "ci", "clanek", "clanku", "clanky", "co", "coz", "což", "cz", "či",
                               "článek", "článku", "článků", "články", "dalsi", "další", "diskuse", "diskuze", "dnes",
                               "do", "fora", "fóra", "forum", "fórum", "ho", "i", "ja", "já", "jak", "jako", "je",
                               "jeho", "jej", "jeji", "její", "jejich", "jen", "jenz", "jenž", "jeste", "ještě", "ji",
                               "jí", "jine", "jiné", "jiz", "již", "jsem", "jses", "jseš", "jsme", "jsou", "jste", "k",
                               "kam", "kazdy", "každý", "kde", "kdo", "kdyz", "když", "ke", "ktera", "která", "ktere",
                               "které", "kteri", "kterou", "ktery", "který", "kteří", "ku", "ma", "má", "mate", "máte",
                               "me", "mě", "mezi", "mi", "mit", "mít", "mne", "mně", "mnou", "muj", "můj", "muze",
                               "může", "my", "na", "ná", "nad", "nam", "nám", "napiste", "napište", "nas", "nasi",
                               "náš", "naši", "ne", "nebo", "necht", "nechť", "nejsou", "neni", "není", "nez", "než",
                               "ni", "ní", "nic", "nove", "nové", "novy", "nový", "o", "od", "ode", "on", "pak", "po",
                               "pod", "podle", "pokud", "polozka", "polozky", "položka", "položky", "pouze", "prave",
                               "právě", "pred", "prede", "pres", "pri", "prispevek", "prispevku", "prispevky", "pro",
                               "proc", "proč", "proto", "protoze", "protože", "prvni", "první", "před", "přede", "přes",
                               "při", "příspěvek", "příspěvku", "příspěvků", "příspěvky", "pta", "ptá", "ptat", "ptát",
                               "re", "s", "se", "si", "sice", "strana", "sve", "své", "svuj", "svůj", "svych", "svých",
                               "svym", "svým", "svymi", "svými", "ta", "tak", "take", "také", "takze", "takže", "tato",
                               "te", "té", "tedy", "tema", "téma", "těma", "temat", "témat", "temata", "témata",
                               "tematem", "tématem", "tematu", "tématu", "tematy", "tématy", "ten", "tento", "teto",
                               "této", "tim", "tím", "timto", "tímto", "tipy", "to", "tohle", "toho", "tohoto", "tom",
                               "tomto", "tomuto", "toto", "tu", "tuto", "tvuj", "tvůj", "ty", "tyto", "u", "uz", "už",
                               "v", "vam", "vám", "vas", "vase", "váš", "vaše", "ve", "vice", "více", "vsak", "vsechen",
                               "však", "všechen", "vy", "z", "za", "zda", "zde", "ze", "ze", "zpet", "zpět", "zprav",
                               "zpráv", "zprava", "zpráva", "zpravy", "zprávy", "že"]

        self.morpho = Morpho.load(self.dictionary)
        if not self.morpho:
            raise Exception("Cannot load dictionary " + self.dictionary)
        self.tokenizer = self.morpho.newTokenizer()

    def lemmatize(self, text):
        if isinstance(text, str):
            text = self.tokenize(text)

        result = []
        lemmas = TaggedLemmas()
        converter = TagsetConverter.newPdtToConll2009Converter()
        for word in text:
            self.morpho.analyze(word, self.morpho.GUESSER, lemmas)
            converter.convert(lemmas[0])
            result.append(lemmas[0].lemma)
        return result

    def remove_stop_words(self, text):
        if isinstance(text, str):
            text = self.tokenize(text)

        result = []

        for word in text:
            if word not in self.stop_words and 1 < len(word) < 25:
                result.append(word)

        return result

    def tokenize(self, text):
        self.tokenizer.setText(text)
        forms = Forms()
        ranges = TokenRanges()
        tokens = []
        while self.tokenizer.nextSentence(forms, ranges):
            for word in forms:
                tokens.append(word.lower())

        return tokens

# pre = Preprocessor()
# text = pre.remove_stop_words("Nástroják je nepravidelný seriál, který vás seznámí s hromadou užitečných nástrojů. Předchozí díl se "
#               "věnoval ASCII artu, tenhle se zaměří na generování slepého textu, a nejen textu. Pokud vám perex "
#               "„Internet pás by smyšlená…“ nedával smysl, není třeba hledat očního lékaře, jednalo se o nesmyslný "
#               "slepý text vygenerovaný českým generátorem Blábotem.")
# print(text)
# text = pre.lemmatize(text)
# print(text)

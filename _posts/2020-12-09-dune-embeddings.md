---
title: "Dune Embeddings"
date: "2020-12-09"
tages: [Word Embeddings, Word2Vec, Science Fiction, Natural Language Processing]
header:
  overlay_image: "/images/dune/dune2.png"
  teaser: "/images/dune/dune1.jpg"
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Word Embeddings, Word2Vec, Science Fiction, Natural Language Processing"
mathjax: "true"
image:
  thumb: "/images/dune/dune1.jpg"
---
# Dune Embeddings
This blog post covers some experimental word embeddings on the book series called Dune. I am writing this post just for fun. As you may know that, Dune has distinctive linguistic features (the universal language in Dune Universe is Galach), mostly based on varieties of Arabic. I trained a corpus of six main books of Dune: Dune (1), Dune Messiah (2), Children Of Dune (3), God Emperor Of Dune (4), Heretics of Dune (5), Chapterhouse Dune (6). Before dive in the code and analysis, here is the dependencies:

- gensim == 3.6.0
- re == 2.2.1
- pandas == 1.1.4
- numpy == 1.18.5
- spacy == 2.2.4
- nltk == 3.2.5

As you may know, word2vec \[1\] is proposed in the paper called [Distributed Representations of Words and Phrases and their Compositionality](https://arxiv.org/abs/1310.4546) (Mikolov et al., 2013). It allows you to learn the high-quality distributed vector representations that capture a large number of precise syntactic and semantic word relationships. Word2vec algorithm uses Skip-gram [Mikolov et al., 2013](https://arxiv.org/abs/1301.3781) model to learn efficient vector representations. Those learned word vectors has interesting property, words with semantic and syntactic affinities give the necessary result in mathematical similarity operations. In Skip-gram connections we have an objective to minimize:

$$\max \limits_{\theta} \prod_{\text{center}} \prod_{\text{context}} p(\text{context}|\text{center} ;\theta)$$

$$= \max \limits_{\theta} \prod_{t=1}^T \prod_{-c \leq j \leq c, j \neq c} p(w_{t+j}|w_t; \theta)$$

$$= \min \limits_{\theta} -\frac{1}{T} \prod_{t=1}^T \prod_{-c \leq j \leq c, j \neq c} p(w_{t+j}|w_t; \theta)$$

$$= \min \limits_{\theta} -\frac{1}{T} \sum_{t=1}^T \sum_{-c \leq j \leq c, j \neq c} \log p(w_{t+j}|w_t; \theta)$$


The term *center* and *context* can be expressed as an example (with a fixed window size): w = "to learn word vector representations"

x (center)     | y (context)
:-------------:|:-------------:
word (w2)      | learn (w1)
word (w2)      | vector (w3)
vector (w3)    | word (w2)
vector (w3)    | representations (w4)


Skip-gram objective is to find word representations that are useful for predicting the surrounding words in a sentence or a document. We maximize the probability of "this words (context) for these word (center)". Of course, increased fixed window size can give us better accuracy.

How can we calculate those probabilities? With a single softmax?

$$p(w_O, | w_I) = \frac{\exp(V_{w_O}' V_{w_I}^T)}{\sum_{w'=1}^{\mid V \mid} \exp(V_{w'} V_{w_I}^T)}$$

This softmax is class probability of context words in the entire vocabulary, we maximize this class probabilities. But this is impractical due to the cost of computing gradient of this term is proportional to size of our vocabulary V, which is about 60k in our case. In order to computational efficiency, we use a simplified version of Noise Constrastive Estimation: Negative Sampling. This Negative Sampling objective is defined as

$$ \log \sigma(V_{w_O}' V_{w_I}^T) + \sum_{i=0}^{k} \mathbb{E}_{w_i \sim P_n(w)} \left[\log \sigma(- V_{w_i}' V_{w_I}^T) \right]$$

This objective says that, "I want to classify the word sampling against the other classes higher". The term $$V_{w_O}'$$ is for "word around it", the term $$V_{w_I}$$ is for "word I considered". The sampling $$w_i \sim P_n(w)$$ means "sample word from your vocabulary at random and sample $$k$$ of them". When you maximize this objective, you also minimize the summation term. But what is $$P(w_i)$$?

Authors of the paper said that, in very large corpora, the most frequent words can easily occur hundreds of millions of times. Such words usually provide less information value than the rare words. For example, while the Skip-gram model benefits from observing co-occurrences of "Fremen" and "Crysknife", it benefits much less from observing the frequent co-occurrences of "Fringe" and "the", as nearly every word co-occurs frequently within a sentence "the". To counter the imbalance between the rare and frequent words, such a subsampling approach is proposed:

$$ P(w_i) = 1 - \sqrt{\frac{t}{frequency(w_i)}}$$

Where $$t$$ is the temperature, chosen $$10^{-5}$$. This formulation aggressively subsamples words whose frequency is greater than t while preserving the ranking of the frequencies.

Let's play with Dune Embeddings. Firstly, as always, you cannot escape from it, we have imports:

```python
from gensim.models import Word2Vec
from time import time
import re
import pandas as pd
import numpy as np
from collections import defaultdict
import spacy
import nltk
from gensim.models.phrases import Phrases, Phraser
from nltk.tokenize import word_tokenize
from nltk.tokenize import sent_tokenize
nltk.download('punkt')
import warnings  
warnings.filterwarnings(action='ignore',category=UserWarning,module='gensim')  
warnings.filterwarnings(action='ignore',category=FutureWarning,module='gensim') 
```

Then we read our book data, served as .txt file. We apply nltk's sentence tokenizer sent_tokenize() to tokenize the sentences in this text files.

```python
with open(base+'dune2.txt') as f1:
  data1 = f1.read()

with open(base+'dune3.txt') as f2:
  data2 = f2.read()

with open(base+'dune4.txt') as f3:
  data3 = f3.read()

with open(base+'dune5.txt') as f4:
  data4 = f4.read()

with open(base+'dune6.txt') as f5:
  data5 = f5.read()

with open(base+'dune7.txt') as f6:
  data6 = f6.read()

data1 = sent_tokenize(data1)
data1 = pd.DataFrame(data1,columns=['sentences'])
data2 = sent_tokenize(data2)
data2 = pd.DataFrame(data2,columns=['sentences'])
data3 = sent_tokenize(data3)
data3 = pd.DataFrame(data3,columns=['sentences'])
data4 = sent_tokenize(data4)
data4 = pd.DataFrame(data4,columns=['sentences'])
data5 = sent_tokenize(data5)
data5 = pd.DataFrame(data5,columns=['sentences'])
data6 = sent_tokenize(data6)
data6 = pd.DataFrame(data6,columns=['sentences'])

frames = [data1, data2, data3, data4, data5, data6]
data = pd.concat(frames)
```

From now, we use spacy for other processing techniques. When you call nlp on a text, spacy first tokenizes the text to produce a Doc object. The Doc is then processed in several different steps. This is also referred to as the processing pipeline. We’ll disable all other statistical components (in this case, parser) during processing for speed. Then we lemmatize the words and remove stop words. 

```python
nlp = spacy.load('en', disable=['parser'])

def preprocess(doc):
    txt = [token.lemma_ for token in doc if not token.is_stop] # doc \in spacy.doc object
    if len(txt) > 2:
        return ' '.join(txt)

data_preprocess = (re.sub("[^A-Za-z']+", ' ', str(row)).lower() for row in data['sentences']) # removes non-alphabetic characters
txt = [preprocess(doc) for doc in nlp.pipe(data_preprocess, batch_size=5000, n_threads=-1)]
df_cleaned = pd.DataFrame({'cleaned': txt})
df_cleaned = df_cleaned.dropna().drop_duplicates()
```

In function preprocess(), we also not to choose sentences longer than 2. Word2Vec uses context words to learn the vector representation of a target word, if a sentence is only one or two words long, the benefit for the training is very small. We use regular expression to remove non-alphabetic characters for each line.

Other processing technique is detect common phrases (bigrams). For example Muad Dib is a bigram that is very useful for Dune context. Or bigram Bene Gesserit is indispensable. We use gensim to automatically detect common phrases (bigrams) from a list of sentences.

```python
sentence = [row.split() for row in df_cleaned['cleaned']] # gensim.models.phrases.Phrases() takes a list of list of words as input
phrases = Phrases(sentence, min_count=30, progress_per=10000) # detect common phrases (bigrams) from a list of sentences (why we do this: working class, communist party etc)
sentences = phrases[sentence];
```

Then we calculate the frequencies.

```python
word_freq = defaultdict(int)
for sent in sentences:
    for i in sent:
        word_freq[i] += 1
```

Now it is time to create our word2vec model.

```python
w2v_model = Word2Vec(min_count=20,
                     window=2,
                     size=300,
                     sample=6e-5, 
                     alpha=0.03, 
                     min_alpha=0.0007, 
                     negative=20,
                     workers=cores-1)
```

Hyperparameters that we learnt:

- min_count: Ignores all words with total absolute frequency lower than this.
- window: The maximum distance between the current and predicted word within a sentence. (as you can see in the paper)
- size: Dimensionality of the feature vectors.
- sample: The threshold for configuring which higher-frequency words are randomly downsampled. (as you can see in the paper)
- alpha: The initial learning rate
- in_alpha: changing learning rage
- negative: negative sampling, the int for negative specifies how many "noise words" should be drown.



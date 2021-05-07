---
title: "Language And Representation"
date: "2021-04-20"
tages: [Computational Linguistics, Natural Language Processing]
header:
  overlay_image: "/images/language_representation/header.jpg"
  teaser: "/images/language_representation/teaser.png"
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Computational Linguistics, Natural Language Processing"
mathjax: "true"
image:
  thumb: "/images/language_representation/teaser.png"
---

{: .text-justify}
>> “Every choice of phrasing and spelling and tone and timing carries countless signals and contexts and subtexts and more... and every listener interprets those signals in their own way. Language isn't a formal system. Language is glorious chaos.”

{: .text-justify}
Words and meanings are ambigious. ~85% of words are unambigious, however, accounting for only ~15% of the vocabulary, are very common words, and hence ~55% of word tokens in running text are ambigious \[1\]:

- earnings growth took a **back/JJ** seat
- a small building in the **back/NN**
- a clear majority of senators **back/VBP** at bill
- Dave began to **back/VB** toward the door
- enable the country to buy **back/RP** about debt
- I was twenty-one **back/RB** then

{: .text-justify}
Even though many words are easy to disambiguate linguistically, it is not always easy to represent this words computationally. Grammar is a mental system, a cognitive part of the brain/mind, which, if
it is one’s first native language, is acquired as a child without any specific instruction. Children develop language rapidly and efficiently, that is, with relatively few errors, because the basic form of language is given to them by human biology (the logical problem of language acquisition, Noam Chomsky, 1955) \[2\]. So, imagine that how hard it is to represent well while we have ambiguity in our brain's understanding. In this post, I will introduce and compare a comprehensive typology of word representation models.

## Frequency Matrices

{: .text-justify}
The most simple yet efficient method of representing words is, as traditionally, term-document matrix. It is basically a frequency matrix of "how many times  has this word been in this document". For example, term-document matrix for some of Shakespeare's play.

...    | As You Like It | Twelfth Night | Julius Caesar     | Henry V  |
:---   | :---:          |    :----:     |          :---:    |  :---:   |
battle | 1              | 0             | 7                 | 13       |
god    | 114            | 80            | 62                | 89       |
fool   | 36             | 58            | 1                 | 4        |
wit    | 20             | 15            | 2                 | 3        |

{: .text-justify}
The dimensionality of this matrix is $$\mid V \mid \times \mid d \mid$$, where $$\mid V \mid$$ is our vocabulary length and $$\mid d \mid$$ is document number. With this approach, the document "Julius Caesar" can be represented with \[7, 62, 1, 2, ...\] with dimensionality $$\mid V \mid$$. Also words can be represented with term-document matrix: the word "battle" can be represented with \[1, 0, 7, 13, ...\] with dimensionality $$\mid d \mid$$. 

{: .text-justify}
Also, word-word co-occurence matrix can be used for representing words.  It is basically a frequency matrix of "how many times has this word been with this word, in some context".

...           | aardvark       | ...           | computer          | data     | sugar  |
:---          | :---:          |    :----:     |          :---:    |  :---:   | :---:  |
cherry        | 0              | ...           | 2                 | 8        | 25     |
strawberry    | 0              | ...           | 0                 | 0        | 19     |
fool          | 0              | ...           | 1670              | 1683     | 4      |
information   | 0              | ...           | 3325              | 3982     | 13     |

{: .text-justify}
The dimensionality of this matrix is $$\mid V \mid \times \mid V \mid$$.  With this approach, the word "cherry" can be represented with \[0, ..., 2, 8, 25\] with dimensionality $$\mid V \mid$$. This approach still gives acceptable good analogies with cosine similarity. Cosine similarity is normalized dot product between two word vectors:

$$\text{cosine-sim}(\vec{w_1},\vec{w_2}) = \frac{\vec{w_1} \cdot \vec{w_2}}{\lVert \vec{w_1} \rVert \lVert \vec{w_2} \rVert}$$

It ranges from 1 to -1. Orthogonal vectors (not similar) gives 0.

### TF-IDF

{: .text-justify}
TF-IDF is just a weighing method for co-occurence matrix. Words that occur nearby frequently (pie nearby cherry) are more important than words that only appear once or twice. Yet words that are too frequent (the, good, that etc.) are unimportant. TF-IDF captures that information. The term frequency (tf) is defined as the frequency of the word $$w$$ in the document $$d$$:

$$\text{tf}_{w,d} = \text{count}(w, d)$$

and the inverse document frequency (idf) is defined as 

$$\text{idf}_{w} = \log_{10} \left( \frac{N}{\text{df}_w} \right)$$

{: .text-justify}
where $$N$$ is the total number of documents, $$\text{df}_w$$ is is the total number of documents that includes $$w$$. Soi the TF-IDF weighted value for word $$w$$ is defined as

$$w_d = \text{tf}_{w,d} \times \text{idf}_{w}$$

### Positive Pointwise Mutual Information (PPMI)

{: .text-justify}
Positive Pointwise Mutual Information (PPMI) is an alternative for TF-IDF model. It is defined as 

$$\text{PPMI}(w, c) = \max\left(\log_2\frac{p(w,c)}{p(w)\cdot p(c)}, 0\right)$$

{: .text-justify}
Assume that we have a co-occurence matrix $$CO$$ with $$\mid V \mid$$ rows (words), $$C$$ columns (contexts). $$CO_{i,j}$$ is "number of times word $$w_i$$ occurs in context $$c_j$$. So,

$$p(w_i,c_j) = \frac{CO_{i,j}}{\sum_{i=1}^{\mid V \mid} \sum_{j=1}^{C} CO_{i,j}}$$

$$p(w_i) = \frac{\sum_{j=1}^{C} CO_{i,j}}{\sum_{i=1}^{\mid V \mid} \sum_{j=1}^{C} CO_{i,j}}$$
 
$$p(c_j) = \frac{\sum_{i=1}^{\mid V \mid}CO_{i,j}}{\sum_{i=1}^{\mid V \mid} \sum_{j=1}^{C} CO_{i,j}}$$

### Singular Value Decomposition

{: .text-justify}
Singular Value Decomposition (SVD) is a central matrix decomposition technique in linear algebra. The problem of PPMI and TF-IDF vectors are sparsity. They have too many zero values. Like SVD, Matrix factorization techniques also give good vector representations. In Linear Algebra, any rectangular matrix can be decomposed into three matrices

$$ \begin{bmatrix} X \end{bmatrix}_{\in \mathbb{R}^{\mid V \mid \times \mid V \mid}} = \begin{bmatrix} W \end{bmatrix}_{\in \mathbb{R}^{\mid V \mid \times \mid V \mid}} \begin{bmatrix} 
\sigma_1 & \cdots & 0 \\ \vdots & \ddots &  \vdots\\ 0 &\cdots & \sigma_V \end{bmatrix}_{\in \mathbb{R}^{\mid V \mid \times \mid V \mid}}  \begin{bmatrix} C \end{bmatrix}_{\in \mathbb{R}^{\mid V \mid \times \mid V\mid}}$$

{: .text-justify}
So, our goal is now to create more sophisticated good word vectors, suppose that $$X$$ is our word-word co-occurence matrix. We can get good vector representations by factorizing this matrix, or reducing the dimensionality. It allows us to represent our vectors more densely in lower cost memory.

$$ \begin{bmatrix} X \end{bmatrix}_{\in \mathbb{R}^{\mid V \mid \times \mid V \mid}} = \begin{bmatrix} W \end{bmatrix}_{\in \mathbb{R}^{\mid V \mid \times k}} \begin{bmatrix} 
\sigma_1 & \cdots & 0 \\ \vdots & \ddots &  \vdots\\ 0 &\cdots & \sigma_k \end{bmatrix}_{\in \mathbb{R}^{k \times k}}  \begin{bmatrix} C \end{bmatrix}_{\in \mathbb{R}^{k \times \mid V\mid}}$$

{: .text-justify}
The matrix $$W$$ tells us how to map our input sparse feature vectors into these k-dimensional dense feature vectors. SVD (and other factorization methods) had an good role on comparisons. For example, in [GloVe: Global Vectors for Word Representation](https://nlp.stanford.edu/pubs/glove.pdf), authors compared their novel model with Singular Value Decomposition as a baseline.

## Distributional Hypothesis

{: .text-justify}
Suppose that we have a set $$E = \{e_{w_i}: w_i \in V\}$$. This is a set of our word representations. Say that, those representations are a collection of vectors, that are dense. What are the dimensions of these vectors? Take a look word "queen". Since the word "queen" means "the female ruler of an independent state", should it has a dimension that represents "royality" or "gender"? Or, the word "teeth", should it has a dimension that represents "plurality"? Maybe we should define more common dimensions. For example, words can have affective meanings \[1\]. Osgood et al. 1957, proposed that words varied along three important dimensions of affective meaning: *valence*, *arousal*, *dominance*:

- valence: the pleasantness of the stimulus.

- arousal: the intensity of emotion provoked by the stimulus.

- dominance: the degree of control exerted by the stimulus.

{: .text-justify}
For instance, the word "delighted" has high valence while the word "upset" does not. Or, the word "thrilling" has high arousal while the word "serene" does not. More examples can be given. Actually, we don't know exactly what are the dimensions of those vector. Now, our question is "how to get them" or "how can we *learn* those word vectors". The discipline called Distributional Hypothesis plays a big role here. Distributional Hypothesis is mainly introduced by John Rupert Firth in 1957. It basically says, words with similar distributions have similar meanings. Words that occur in similar contexts tend to have similar meanings. The link between similarity and words are distributed and similarity in what they mean is called distributional hypothesis or distributional semantics in the field of Computational Linguistics \[1\]. So what can be counted when we say similar contexts? For example if you surf on the Wikipedia page of Johann Sebastian Bach, the words in this page somehow related with each other in the context of Bach. Or maybe an essay about Johann Sebastian Bach, suppose that you don't know the exact meaning of the word "composer", but you know that Bach is an classical musician and writes music pieces. While reading this essay, you will encounter the word "composer" so many times: "Johann Sebastian Bach is the smartest composer of Baroque period". Then your brain does some kind of acquisition: "Bach writes music and the paragraph says, Bach is a composer. Then the meaning of composer would be the person who writes music. But what is Baroque? The word period comes after Baroque. So Baroque is some kind of period and related with Bach in a comparison way. So Baroque is a historical period that is related with classical music". And, this is the Distributional Hypothesis. But where are the vectors and dimensions?

### word2vec

{: .text-justify}
word2vec is a word representation algorithm, proposed in the paper called [Distributed Representations of Words and Phrases and their Compositionality (Mikolov et al., 2013)](https://arxiv.org/abs/1310.4546). It allows you to learn the high-quality distributed vector representations that capture a large number of precise syntactic and semantic word relationships \[3\]. word2vec algorithm uses skip-gram [Efficient Estimation of Word Representations in Vector Space](https://arxiv.org/abs/1301.3781) model **to learn efficient vector representations**. Those learned word vectors has interesting property, words with semantic and syntactic affinities give the necessary result in mathematical similarity operations. Suppose that you have a sliding window of a fixed size moving along a sentence: the word in
the middle is the “target” and those on its left and right within the sliding window are the context words. The skip-gram model is used to predict the probabilities of a word being a context word for
the given target. 

Target - Context pairs 1         | Target - Context pairs 2
:-------------------------:|:-------------------------:
![](/images/language_representation/sent1.png)   |  ![](/images/language_representation/sent2.png)

image source \[5\].

For example consider this sentence,

> "A change in Quantity also entails a change in Quality"

Our target and context pairs for window size of 5:

| Sliding window (size = 5)       | Target word | Context                   |
|---------------------------------|-------------|---------------------------|
| \[A change in\]                 | a           | change, in                |
| \[A change in Quantity \]       | change      | a, in, quantitiy          |
| \[A change in Quantity  also\]  | in          | a, change, quantitiy,also |
| ...                             | ...         | ...                       |
| \[entails a change in Quality\] | change      | entails, a, in, Quality   |
| \[a change in Quality\]         | in          | a, change, Quality        |
| \[change in Quality\]           | quality     | change, in                |

{: .text-justify}
Each context-target pair is treated as a new observation in the data. For each position $$t=1, ..., T$$ predict context words within a window of fixed size $$m$$ given center word $$w_j$$. In Skip-gram connections we have an objective to maximize, likelihood (or minimize
negative log-likelihood):

$$\max \limits_{\theta} \prod_{\text{center}} \prod_{\text{context}} p(\text{context}|\text{center} ;\theta)$$

$$= \max \limits_{\theta} \prod_{t=1}^T \prod_{-c \leq j \leq c, j \neq c} p(w_{t+j}|w_t; \theta)$$


$$= \min \limits_{\theta} -\frac{1}{T} \prod_{t=1}^T \prod_{-c \leq j \leq c, j \neq c} p(w_{t+j}|w_t; \theta)$$


$$= \min \limits_{\theta} -\frac{1}{T} \sum_{t=1}^T \sum_{-c \leq j \leq c, j \neq c} \log p(w_{t+j}|w_t; \theta)$$

{: .text-justify}
So, How can we calculate those probabilities? Softmax gives the normalized probabilities. 

$$p(w_c \mid w_t) = \frac{\exp(v_{w_c}^T v_{w_t})}{\sum_{i=0}^{\mid V \mid} \exp(v_{w_i}^T v_{w_t})}$$

maximizing this log-likelihood function under $$v_{w_t}$$ gives you the most likely value of the $$v_{w_t}$$ given the data.

$$ \frac{\partial}{\partial v_{w_t}}\cdot \log \frac{\exp(v_{w_c}^T v_{w_t})}{\sum_{i=0}^{\mid V \mid} \exp(v_{w_i}^T v_{w_t})}$$

$$ = \frac{\partial}{\partial v_{w_t}}\cdot \log \underbrace{\exp(v_{w_c}^T v_{w_t})}_{\text{numerator}} - \frac{\partial}{\partial v_{w_t}}\cdot \log \underbrace{\sum_{i=0}^{\mid V \mid} \exp(v_{w_i}^T v_{w_t})}_{\text{denominator}}$$

$$ \frac{\partial}{\partial v_{w_t}} \cdot v_{w_c}^T v_{w_t} =  v_{w_c} \; \; (\text{numerator})$$

Now, it is time to derive denominator.

$$\frac{\partial}{\partial v_{w_t}}\cdot \log \sum_{i=0}^{\mid V \mid} \exp(v_{w_i}^T v_{w_t}) = \frac{1}{\sum_{i=0}^{\mid V \mid} \exp(v_{w_i}^T v_{w_t})} \cdot \frac{\partial}{\partial v_{w_t}} \sum_{i=0}^{\mid V \mid} \exp(v_{w_i}^T v_{w_t})$$

$$ = \frac{1}{\sum_{i=0}^{\mid V \mid} \exp(v_{w_i}^T v_{w_t})} \cdot  \sum_{i=0}^{\mid V \mid} \frac{\partial}{\partial v_{w_t}} \cdot \exp(v_{w_i}^T v_{w_t})$$

$$ = \frac{1}{\sum_{i=0}^{\mid V \mid} \exp(v_{w_i}^T v_{w_t})} \cdot  \sum_{i=0}^{\mid V \mid} \exp(v_{w_i}^T v_{w_t}) \frac{\partial}{\partial v_{w_t}} v_{w_i}^T v_{w_t}$$

$$ = \frac{\sum_{i=0}^{\mid V \mid} \exp(v_{w_i}^T v_{w_t}) \cdot v_{w_i}}{\sum_{i=0}^{\mid V \mid} \exp(v_{w_i}^T v_{w_t})} \;\; (\text{denominator}) $$

To sum up,

$$\frac{\partial}{\partial w_t} \log p(w_c \mid w_t) = v_{w_c} - \frac{\sum_{j=0}^{\mid V \mid} \exp(v_{w_j}^T v_{w_t}) \cdot v_{w_j}}{\sum_{i=0}^{\mid V \mid} \exp(v_{w_i}^T v_{w_t})}$$

$$ = v_{w_c} - \sum_{j=0}^{\mid V \mid} \frac{\exp(v_{w_j}^T v_{w_t})}{\sum_{i=0}^{\mid V \mid} \exp(v_{w_i}^T v_{w_t})} \cdot v_{w_j}$$

$$ \underbrace{= v_{w_c} - \sum_{j=0}^{\mid V \mid} p(w_j \mid w_t) \cdot v_{w_j}}_{\nabla_{w_t}\log p(w_c \mid w_t)}$$

{: .text-justify}
This is the observed representation subtract $$\mathop{\mathbb{E}}[w_j \mid w_t]$$.


### GloVe

## Subword Models

### FastText

### Byte Pair Encoding

## Contextual Representation

### ELMo

### BERT

## References

\[1\] Speech and Language Processing (2nd Edition), Jurafsky, Daniel and Martin, James H. 2009. Prentice-Hall, Inc. ISBN: 0131873210

\[2\] Linguistics: An Introduction to Linguistic Theory	Victoria, A. Fromkin, 2011. ISBN: 0631197117

\[3\] Distributed Representations of Words and Phrases and their Compositionality, Mikolov et al., 2013. arXiv: 1310.4546

\[4\] Efficient Estimation of Word Representations in Vector Space, Mikolov et al., 2013. arXiv: 1301.3781

\[5\] Learning word embedding. Weng, Lilian, 2017. URL: [https://lilianweng.github.io/lil-log/2017/10/15/learning-word-embedding.html](https://lilianweng.github.io/lil-log/2017/10/15/learning-word-embedding.html)

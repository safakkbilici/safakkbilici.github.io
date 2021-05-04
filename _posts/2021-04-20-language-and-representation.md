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
it is one’s first native language, is acquired as a child without any specific instruction. Children develop language rapidlt nd efficiently, that is, with relatively few errors, because the basic form of language is given to them by human biology (the logical problem of language acquisition, Noam Chomsky, 1955). So, imagine that how hard it is to represent well while we have ambiguity in our brain's understanding. In this post, I will introduce and compare a comprehensive typology of word representation models.

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



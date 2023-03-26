---
title: "Neural Information Retrieval"
date: "2023-03-26"
tages: [Information Retrieval, Contrastive Learning]
header:
  overlay_image: "/images/neuralir/overlay.png"
  teaser: "/images/neuralir/teaser.png"
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Information Retrieval, Contrastive Learning"
mathjax: "true"
image:
  thumb: "/images/neuralir/teaser.png"
---

{: .text-justify}
In recent years, with the rise of the pre-trained Transformer \[1\] models, we are switching (or using in hybrid fashion) traditional models such as BM-25, RankSVM, and LambdaMART with deep neural models. These models can be used for retrieval and (re)-ranking. In this post; I am going to introduce some of the Neural Information Retrieval models and show some practical use cases. However, this post does not include all of the methods in the literature, only the ones that I learned (heavily based on contrastive learning models).
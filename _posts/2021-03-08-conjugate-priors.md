---
title: "Conjugate Priors"
date: "2021-03-08"
tages: [Prior Distributions, Bayesian Learning, Probability Distributions]
header:
  overlay_image: "/images/priors/header.jpg"
  teaser: "/images/priors/thumbnail.png"
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Prior Distributions, Bayesian Learning, Probability Distributions"
mathjax: "true"
image:
  thumb: "/images/priors/thumbnail.png"
---

This post is my playground for prior distributions. Do not expect a formal post.

# Introduction

{: .text-justify}
We would like to ask what is the probability of my parameter $$\theta$$'s true value is higher than 0.75?

{: .text-justify}
In Bayesian Inference, parameters are not fixed constant as in classical statistical learning. We treat parameters as a random variable. This allows us to make probabilistic statements about the parameter values.

Bayes' theorem is the cornerstone of making probabilistic statements about the parameter values,

$$\underbrace{p_{\Theta | Y}(\theta | y)}{\text{posterior}} = \frac{\overbrace{p_{Y | \Theta}(y | \theta)}{\text{likelihood}} \cdot \overbrace{p_{\Theta}(\theta)}{\text{prior}}}{\underbrace{p_{Y}(y)}{\text{marginal likelihood}}}
---
title: "Weekly Problem 1: Sum of Independent Gaussians"
date: "2020-07-06"
tages: [Gaussians]
header:
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Weekly, Gaussian"
mathjax: "true"
---
![test image size](/images/WeeklyP1/gaussians1.png){:height="70%" width="80%"}
## The Problem
This is the start of "Weekly Problems". I will upload selected problems, that are my favorite ones (mostly about mathematics), to my blog.
So, this week's problem is:

*Sum of independent Gaussian random variables is Gaussian.*

### Proof

What do I mean by independent? Why a must? Firstly let's say $$y \sim \mathcal{N}(\mu_1,\boldsymbol\Sigma_1)$$ and $$z \sim \mathcal{N}(\mu_2,\boldsymbol\Sigma_2)$$, for mean matrix $$\mu_1, \mu_2 \is R^n}$$ and covariance matrix $$\boldsymbol\Sigma_1, \boldsymbol\Sigma_2 \is \boldsymbol S_{+ +}^n$$ (also note that they are multivariate). And our problem says that $$y+z \sim \mathcal{N}(\mu_1 +\mu_2,\boldsymbol\Sigma_1+\boldsymbol\Sigma_2)$$ is also Gaussian.


To show independency, say that $$y=-z$$, clearly we can say $$z \sim \mathcal{N}(-\mu_1,\boldsymbol\Sigma_1)$$.

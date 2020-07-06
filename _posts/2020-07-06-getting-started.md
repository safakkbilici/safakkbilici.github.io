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

What do I mean by independent? Why a must? Firstly let's say $$y \sim \mathcal{N}(\mu_1,\boldsymbol\Sigma_1)$$ and $$z \sim \mathcal{N}(\mu_2,\boldsymbol\Sigma_2)$$, for mean matrix $$\mu_1, \mu_2 \in \mathbb{R}^n$$ and covariance matrix $$\boldsymbol\Sigma_1, \boldsymbol\Sigma_2 \in \boldsymbol S_{+ +}^n$$ (also note that they are multivariate). And our problem says that $$y+z \sim \mathcal{N}(\mu_1 +\mu_2,\boldsymbol\Sigma_1+\boldsymbol\Sigma_2)$$ is also Gaussian.


To show independency, say that $$y=-z$$, clearly we can say $$z \sim \mathcal{N}(-\mu_1,\boldsymbol\Sigma_1)$$, but $$y+z$$ is zero! So our independency property is important for our proof. Now, recall that, Gaussian distribution is fully specified by its mean and covariance matrix. If we can determine what these are, we are done! We will use properties of expectations.
- For the mean and the "dummy" index $$i$$ (just a notation for showing arbitrary member of a vector), we have:
 $$\mathop{\mathbb{E}}[y_i + z_i] =  \mathop{\mathbb{E}}[y_i] + \mathop{\mathbb{E}}[z_i] = \mu_1 + \mu_2$$

...as we said, this is the linearity property of expactation. We showed that the mean of $$y+z$$ is simply $$\mu_1 + \mu_2$$.

- Also for the covariance and the "dummy" index $$(i,j)$$ entry of the covariance matrix $$\boldsymbol\Sigma$$:
$$\mathop{\mathbb{E}}[(y_i + z_i)(y_j+z_j)] - \mathop{\mathbb{E}}[y_i + z_i]\mathop{\mathbb{E}}[y_j + z_j]$$
$$= \mathop{\mathbb{E}}[y_i y_j+z_i y_j+y_i z_j+z_i z_j] - (\mathop{\mathbb{E}}[y_i]+\mathop{\mathbb{E}}[z_i])(\mathop{\mathbb{E}}[y_j]+\mathop{\mathbb{E}}[z_j])$$
$$=\mathop{\mathbb{E}}[y_iy_j]+\mathop{\mathbb{E}}[z_iy_j]+\mathop{\mathbb{E}}[y_iz_j]+\mathop{\mathbb{E}}[z_iz_j]-\mathop{\mathbb{E}}[y_i]\mathop{\mathbb{E}}[y_j]-\mathop{\mathbb{E}}[z_i]\mathop{\mathbb{E}}[y_j]$$
$$-\mathop{\mathbb{E}}[y_i]\mathop{\mathbb{E}}[z_j]-\mathop{\mathbb{E}}[z_i]\mathop{\mathbb{E}}[z_j]$$
$$=(\mathop{\mathbb{E}}[y_iy_j] - \mathop{\mathbb{E}}[y_i]\mathop{\mathbb{E}}[y_j]) + (\mathop{\mathbb{E}}[z_iz_j]-\mathop{\mathbb{E}}[z_i]\mathop{\mathbb{E}}[z_j])$$
$$ + (\mathop{\mathbb{E}}[z_iy_j]-\mathop{\mathbb{E}}[z_i]\mathop{\mathbb{E}}[y_j])+(\mathop{\mathbb{E}}[y_iz_j] - \mathop{\mathbb{E}}[y_i]\mathop{\mathbb{E}}[z_j])$$

Oh! Remember that we said they are independent Gauissans. So we can use the fact that

$$(\mathop{\mathbb{E}}[z_iy_j]-\mathop{\mathbb{E}}[z_i]\mathop{\mathbb{E}}[y_j])+(\mathop{\mathbb{E}}[y_iz_j] - \mathop{\mathbb{E}}[y_i]\mathop{\mathbb{E}}[z_j])$$

is just zero! Because for independent variables of $$y$$ and $$z$$, $$\mathop{\mathbb{E}}[zy] = \mathop{\mathbb{E}}[z]\mathop{\mathbb{E}}[y]$$. This last two terms dropout. Therefore, we have lastly:

$$(\mathop{\mathbb{E}}[y_iy_j] - \mathop{\mathbb{E}}[y_i]\mathop{\mathbb{E}}[y_j]) + (\mathop{\mathbb{E}}[z_iz_j]-\mathop{\mathbb{E}}[z_i]\mathop{\mathbb{E}}[z_j])$$
$$=\boldsymbol\Sigma_{1_{ij}} + \boldsymbol\Sigma_{2_{ij}}$$

From this, we can say that the covariance matrix of $$y+z$$ is simply $$=\boldsymbol\Sigma_{1} + \boldsymbol\Sigma_{2}$$.
$$Q.E.D$$

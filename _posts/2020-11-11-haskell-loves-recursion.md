---
title: "Haskell Loves Recursion"
date: "2020-11-11"
tages: [Haskell, Functional Programming, Recursion, Lamda Calculus]
header:
  overlay_image: "/images/haskellrecursion/header.jpg"
  teaser: "/images/haskellrecursion/header.jpg"
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Haskell, Functional Programming, Recursion, Lamda Calculus"
mathjax: "true"
image:
  thumb: "/images/haskellrecursion/header.jpg"
---

Some of us love while loops or for loops. Well... Haskell does not. There are no for or while loops in Haskell. Unlike imperative languages (like Java, C++ etc.), you do computations in Haskell by declaring what something is instead of declaring how you get it. That's why there are no while loops or for loops in Haskell. It seems quite weird right now. 

Let's go traditional by writing recursive factorial.

```haskell
factorial :: (Integral a) => a->a
factorial 0 = 1
factorial n = n * factorialRecursive (n-1)
```

We define our initial condition with pattern matching "factorial 0 = 1". Most imperative languages don't have pattern matching so you have to make a lot of if else statements to test for edge conditions, and it will getting unreadable. For now, it is easy to read Haskell recursion, the factorial one is nearly same as in C. In factorial, we have 1 fixed point that is $$factorial(0)= = 1$$. It can be read as

$$
factorial(n)= 
\begin{cases}
    n \times factorial(n-1),& \text{if }  n\geq 1\\
    1,              & \text{if } n = 0
\end{cases}
$$

One can look at the [fixed-point combinator](https://sookocheff.com/post/fp/recursive-lambda-functions/) in lambda calculus

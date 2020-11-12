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

We define our initial condition with pattern matching "factorial 0 = 1". Most imperative languages don't have pattern matching so you have to make a lot of if else statements to test for edge conditions, and it will getting unreadable. For now, it is easy to read Haskell recursion, the factorial one is nearly same as in C. In factorial, we have 1 fixed point that is $$factorial(0)= 1$$. It can be read as

$$
factorial(n)= 
\begin{cases}
    n \times factorial(n-1),& \text{if }  n\geq 1\\
    1,              & \text{if } n = 0
\end{cases}
$$

One can look at the [fixed-point combinator](https://sookocheff.com/post/fp/recursive-lambda-functions/) in lambda calculus.


Let's move on to another example, equivalent to factorial one, the power operation:

```haskell
power' :: Int -> Int -> Int
power' n 0 = 1
power' n x= n * (power' n (x-1))
```

As in factorial, we have a fixed point $$power(n,0) = 1$$. It can be read as again 

$$
power(n,x)= 
\begin{cases}
    n \times power(n, x-1),& \text{if }  x\geq 1\\
    1,              & \text{if } x = 0
\end{cases}
$$

And yes, you can use [apostrophe](https://www.youtube.com/watch?v=zXP_pr7np-o) (') in function names.


Let's make a length function for lists in Haskell

```haskell
lengthrec' :: (Num b) => [a] -> b
lengthrec' [] = 0
lengthrec' (_:ls) = 1 + lengthrec' ls
```

Now it seems quite bit different. The expression (_:ls) is common in Haskell recursions on lists. Haskell lists can be defined as

```haskell
let list = 137 : [15,16,17]
```

Now the list will be [137,15,16,17]. In the expresion (_:ls), _:ls refers to the whole list. And the expression _ refers to first element of our list. In above example:

- _ == 137
- ls == [15,16,17]
- list == [137,15,16,17]

So our recursive function *lengthrec'* takes a list like (_:ls). And in its recursive definition, it takes a parameter ls. This ls parameter can be seen as (something:ls2), and (something:ls2) is equal to ls. In above list definition we show our parameters. Now the ls in "lengthrec' ls" will be

- something == 15
- ls2 == [16,17]
- ls == [15,16,17]

And so on. This recursion reduces our list elements in someway. At the initial condition, we have empty list [] with length of 0. Recursion definition have a addition function "+1", this helps us to compute the length of list. In every single parameter "reducing" we add 1 to initial zero.

$$length'([137,15,16,17]) = 1 + length'([15,16,17])$$

$$ =  1 + (1 + length'([16,17]))$$

$$ = 1 + (1 + (1 + length'([17])))$$

$$ = 1 + (1 + (1 + ( 1 + length'([]))))$$

$$ = 1 + (1 + (1 + ( 1 + 0)))$$

$$ = 4$$

Let's move on to another example, maximum of the list

```haskell
max' :: (Ord a) => [a] -> a  
maximum' [] = error "maximum of empty list"  
max' [x] = x  
max' (x:xs) = max x (maximum' xs) 
```

$$ max' [137,15,16] = max 137 (max' [15,16]$$

$$ = max \;137 (max \;15 max' \;[16])$$

$$ = max \;137 (max \;15 \;16) = 137$$ 

It is easy to read! What about some replication?

```haskell
replicate' :: (Num i, Ord i) => i-> a -> [a]
replicate' n x
  | n <= 0 = []
  | otherwise = x: replicate' (n-1) x
```

I hope that you know [pattern guards](https://wiki.haskell.org/Pattern_guard) in Haskell, actually it can be seen as if-else statements.

$$ replicate' \;5 \;3 = 5 : replicate' \;5 \;2$$

$$ = 5 : 5 : replicate' \;5 \;1$$

$$ = 5 : 5 : 5 : replicate' \;5 \;0$$

$$ = 5 : 5 : 5 : [] = [5,5,5]$$


More list example, let's make a reverse function for lists

```haskell
reverse' :: [a] -> [a]
reverse' [] = error "empty list"
reverse' (x:xs) = reverse' xs ++ [x]
```

You already know that plus plus (++) operator means list concatenation. We dont have initial conditions except the error one, it will look like this

$$reverse' [1,2,3,4] = reverse' [2,3,4] ++ [1]$$

$$= reverse' [3,4] ++ [2] ++ [1]$$

$$= reverse' [4] ++ [3] ++ [2] ++ [1]$$

$$= [4] ++ [3] ++ [2] ++ [1] = [4,3,2,1]$$


So, there was an error called stack overflow. Do you remember? If your recursion goes to infinity in C programming, you mostly see that error. Well... You know Haskell is lazy. It won’t try to evaluate lists immediately. It will wait to see what you want to get out of that infinite list. So does in recursions.

```haskell
repeat' :: a -> [a]
repeat' x = x:repeat' x
```

When calling repeat' 15, it will give you an infinite list with elements 15. But it do not store it in your computer's memory, Haskell do not make a computation until you want. If you want a index of $i$, then Haskell will do this computation.

Let's go harder with high order functions plus recursion! Can I write a recursive function that have a argument of function? Before this, here is a simple high order function that takes a function and returns this function.

```haskell
applyTwice :: (a -> a) -> a -> a -- (+3) == (a->a)
applyTwice foo x = foo (foo x)
```

How should I call this function? Well, like this

```haskell
applyTwice (+2) 8
```

Wait, what? Is '+2' is a function? Actually, this is the main idea in pure functional programming languages. **Everything is a function**. What will be the answer of appylyTwice (+2) 8? Yes, 12. '(+2)' is a function that returns its parameter + 2. 

Every function in Haskell officially only takes one parameter... For example max function. Doing max 9 7 first creates a function that takes a parameter and returns either 9 or that parameter, depending on which is bigger. Then, 7 is applied to that function and that function produces our desired result. So, (max 9) 7 and max 9 7 are same. Max is defined as max :: (Ord a) => a -> a -> a but also can be defined as max :: (Ord a) => a -> a -> a. I know, it is hard to digest.

What about another shot?

```
mul3 :: (Num a) => a -> a -> a -> a
mul3 x y z = x * y * z
``` 

This function takes 3 parameters and gives you the multiplication of them. Lets define another function

```haskell
let mul3'9 = mul3 9
```

mul3 9 returns a function that needs 2 parameters. We assing this function to mul3'9. Now, mul3'9 takes two parameters and returns multiplication of 9 and other 2 parameters. So, mul3'9 2 2 is equal to 36. You can do the same thing as

```haskell
let mul3'9 = mul3 9
let mul3'9'2 = mul3'9 2
let mul3'9'2'2 = mul3'9'2 2
```

If you call the function let mul3'9'2'2, it returns 32. (Do not forget that the apostrophe just a naming convesion).


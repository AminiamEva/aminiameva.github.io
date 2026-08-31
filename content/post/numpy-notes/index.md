---
title: "Note for Numpy"
description: ""
slug: numpy-notes
date: 2026-08-31 19:27:00+0800
image:
categories:
    - 筆記
tags:
    - Python
---

## The basics

NumPy's array class is called `ndarray`.

Properties:

1. `ndarray.ndim`: dimansions/axes of the arrary.

2. `ndarray.shape`: $(x, y, z, t, \cdots) : tuple?$

3. `ndarray.size`: the total number of elements of the array.

4. `ndarray.dtype`: ?

5. `ndarray.itemsize`: ?

```python
>>> import numpy as np
>>> a = np.arange(15).reshape(3, 5)
>>> a
array([[ 0,  1,  2,  3,  4],
       [ 5,  6,  7,  8,  9],
       [10, 11, 12, 13, 14]])
>>> a.shape
(3, 5)
>>> a.ndim
2
>>> a.dtype.name
'int64'
>>> a.itemsize
8
>>> a.size
15
>>> type(a)
<class 'numpy.ndarray'>
>>> b = np.array([6, 7, 8])
>>> b
array([6, 7, 8])
>>> type(b)
<class 'numpy.ndarray'>
```

## Array creation

- using `array()`:

```python
>>> import numpy as np
>>> a = np.arrary([2, 3, 4])
>>> a
array([2, 3, 4])
```

- the type of the array can also be explicitly specified at creation time:

```python
>>> c = np.array([[1, 2], [3, 4]], dtype=np.complex128)
```

- Often, the elements of an array are originally unknown, but its size is known. Hence, NumPy offers several functions to create arrays with initial placeholder content. These minimize the necessity of growing arrays, an expensive operation.

- the function `zeros()` creates an array full of zeros, while `ones()` ones.

```python
>>> np.zeros((3, 4))
array([[0., 0., 0., 0.],
       [0., 0., 0., 0.],
       [0., 0., 0., 0.]])
>>> np.ones((2, 3, 4), dtype=np.int16)
array([[[1, 1, 1, 1],
        [1, 1, 1, 1],
        [1, 1, 1, 1]],

       [[1, 1, 1, 1],
        [1, 1, 1, 1],
        [1, 1, 1, 1]]], dtype=int16)
>>> np.empty((2, 3)) 
array([[3.73603959e-262, 6.02658058e-154, 6.55490914e-260],  # may vary
       [5.30498948e-313, 3.14673309e-307, 1.00000000e+000]])
```

- a sequence of numbers ($arange(m, n, step)([m,n))$):

```python
>>> np.arange(10, 30, 5)
array([10, 15, 20, 25])
```

- `linespace(begin, end, count)`$[\text{begin},\space \text{end}]$

```python
x = np.linspace(0, 2, 10)
array(
    [0.        , 0.22222222, 0.44444444,
     0.66666667, 0.88888889, 1.11111111, 
     1.33333333, 1.55555556, 1.77777778, 2.        ]
     )
```

## Printing arrays

`print(nparray)`

## Basic operations

Arithmetic operators on arrays apply *elementwise*. A new array is created and filled with the result.

elementwise product:

```python
A * B
```

matrix product:

```python
A @ B
```

When operating with arrays of different types, the type of the resulting array corresponds to the more general or precise one (a behavior known as upcasting).

## Universal functions

NumPy provides familiar mathematical functions such as $\sin,\space\cos$, and $\text{exp}$. In NumPy, these are called "universal functions"(`ufunc`). Within NumPy, these functions operate elementwise on an array, producing an array as output.

```python
>>> B = np.arange(3)
>>> B
array([0, 1, 2])
>>> np.exp(B)
array([1.        , 2.71828183, 7.3890561 ])
```

## Indexing, slicing and iterating

- One-dimensional arrays can be indexed, sliced and iterated over, much like lists and other Python sequences.

```python
>>> a = np.arange(10)**3
>>> a
array([  0,   1,   8,  27,  64, 125, 216, 343, 512, 729])
>>> a[2]
8
>>> a[2:5]
array([ 8, 27, 64])
>>> # equivalent to a[0:6:2] = 1000;
>>> # from start to position 6, exclusive, set every 2nd element to 1000
>>> a[:6:2] = 1000
>>> a
array([1000,    1, 1000,   27, 1000,  125,  216,  343,  512,  729])
>>> a[::-1]  # reversed a
array([ 729,  512,  343,  216,  125, 1000,   27, 1000,    1, 1000])
>>> for i in a:
...     print(i**(1 / 3.))
...
9.999999999999998  # may vary
1.0
9.999999999999998
3.0
9.999999999999998
4.999999999999999
5.999999999999999
6.999999999999999
7.999999999999999
8.999999999999998
```

- Multidimensional arrays can have one index per axis. Thesse indices are given in a tuple separated by commas:

```python
>>> def f(x, y):
...     return 10 * x + y
...
>>> b = np.fromfuction(f, (5, 4), dtype=np.int_)
>>> b
array([[ 0,  1,  2,  3],
       [10, 11, 12, 13],
       [20, 21, 22, 23],
       [30, 31, 32, 33],
       [40, 41, 42, 43]])
>>> b[2, 3]
23
>>> b[0:5, 1]  # each row in the second column of b
array([ 1, 11, 21, 31, 41])
>>> b[:, 1]    # equivalent to the previous example
array([ 1, 11, 21, 31, 41])
>>> b[1:3, :]  # each column in the second and third row of b
array([[10, 11, 12, 13],
       [20, 21, 22, 23]])
```

... (skip) (more ways to get a slice)

## Shape manipulation

### Changing the shape of an array

An array has a shape given by the number o felements along each axis:

```python
>>> a = np.floor(10 * rg.random((3, 4)))
>>> a
array([[3., 7., 3., 4.],
       [1., 4., 2., 2.],
       [7., 2., 4., 9.]])
>>> a.shape
(3, 4)
```

The shape of an array can be changed with various commands. Note that the following three commands all return a modified array, but do not change the original array:

```python
>>> a.ravel() # returns the flattened array
array([3., 7., 3., 4., 1., 4., 2., 2., 7., 2., 4., 9.])
>>> a.reshape(6, 2)  # returns the array with a modified shape
array([[3., 7.],
       [3., 4.],
       [1., 4.],
       [2., 2.],
       [7., 2.],
       [4., 9.]])
>>> a.T  # returns the array, transposed
array([[3., 1., 7.],
       [7., 4., 2.],
       [3., 2., 4.],
       [4., 2., 9.]])
```

### By the way: of `np.random`

init the seed:

```python
>>> np.random.seed(int(hashlib.sha256("Aminiam".encode()).hexdigest(), 16) % (2**32))
```

print:

```python
>>> print(np.random.random((3,3)))
[[0.59908781 0.55341069 0.73192068]
 [0.61572755 0.97373193 0.27759232]
 [0.53090874 0.57221723 0.63055102]]
```

### By the way: of `random`

```python
>>> import random as rd
>>> rd.seed(10086)
>>> rd.random()
0.043562757723543566
```

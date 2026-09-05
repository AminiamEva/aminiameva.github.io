---
title: "Notes for Matplotlib"
description: ""
slug: matplotlib-notes
date: 2026-09-05 10:13:30+0800
image:
categories:
    - 筆記
tags:
    - Python
    - Matplotlib
    - MATLABFormatString
    - SequenceUnpacking
---

## Pyplot Basics

### Introduction to pyplot

`matplotlib.pyplot` is a collection of functions that make matplotlib work like MATLAB. Each `pyplot` function makes some change to a figure: e.e., creates a figure, creates a plotting area in a figure, plots some lines in a plotting area, decorates the plot with labels, etc.

In `matplotlib.pyplot` various states are preserved across function calls, so that it keeps track of things like the current figure and plotting area, and the plotting functions are directed to the current Axes (please note that we user uppercase Axes to refter to the `Axes` concept, which is a central part of a figure and not only the plural of axis).

```python
import matplotlib.pyplot as plt
plt.plot([1, 3, 3, 4])
plt.ylabel('some numbers')
plt.show()
```

If your provide a single list or array to `plot`, matplotlib assumes it i a sequence of y values, and automatically generates the x values for you. Since python ranges start with 0, the default x vector has the same length as y but starts with 0; there fore, the x data are `[0, 1, 2, 3]`.

`plot` is a versatile function, and will take an arbitrary number of arguments. For example, to plot x versus y, you can write:

```python
plt.plot([1, 2, 3, 4], [1, 4, 9, 16])
```

### Formatting the style of you plot

For every x, y pair of arguments, there is an optional third argument which is the format string that indicates the color and line type of the plot. The letters and symbols of the format string are from MATLAB, and you concatenate a color string with a line style string. The default format string is 'b-', which is a solid blue line. For example, to plot the above with red circles, you would issue.

```python
plt.plot([1, 2, 3, 4], [1, 4, 9, 16], 'ro')
plt.axis((0, 6, 0, 20))
plt.show()
```

The axis function in the example above takes a list of [xmin, xmax, ymin, ymax] and specifies the viewport of the Axes.

Generally, you will use numpy arrays.

```python
import numpy as np
# evenly sampled time at 200ms intervals
t = np.arange(0., 5., 0.2)
# red dashes, blue squares and green triangles
plt.plot(t, t, 'r--', t, t**2, 'bs', t, t**3, 'g^')
plt.show()
```

### Plot with keyword strings

There are some instances where you have data in a format theat lets you access particular variables with strings. For example, with strctured arrays or `pandas.DataFrame`.

Matplotlib allows you to provide such an object with the `data` keyword argument. I fprovided, the you may generate plots with the strings corresponding to these variables.

```python
data = {'a': np.arange(50),
        'c': np.random.randint(0, 50, 50),
        'd': np.random.randn(50)}
data['b'] = data['a'] + 10 * np.random.randn(50)
data['d'] = np.abs(data['d']) * 100
plt.scatter('a', 'b', c='c', s='d', data=data)
plt.xlabel('entry a')
plt.ylabel('entry b')
plt.show()
```

### Plotting with categorical variables

It is also possible to create a plot using categorical variables. Matplotlib allows you to pass categorical variables directly to many plotting functions. For example:

```python
names = ['group_a', 'group_b', 'group_c']
values = [1, 10, 100]
plt.figure(figsize=(9, 3))
plt.subplot(131)
plt.bar(names, values)
plt.subplot(132)
plt.scatter(names, values)
plt.subplot(133)
plt.plot(names, values)
plt.suptitle('Categorical Plotting')
plt.show()
```

### Controlling line properties

Lines have many attributes that you can set: linewidth, dash style, antialiased, etc. There are several ways to set line properties:

- Use keyword arguments

```python
plt.plot(x, y, linewidth=2.0)
```

- Use the setter methods of a `Line2D` instance. `plot` returns a list of `Line2D` objects; e.g., `line1, line2 = plot(x1, y1, x2, y2)`. In the code below we will suppose that we have only one line so that the list returned is of length 1. We use tuple unpacking with `line,` to get the first element of that list:

```python
line, = plt.plot(x, y, '-')
line.set_antialiased(False) # turn off antialiasing
```

- Use `setp`. The example below uses a MATLAB-style function to set multiple properties on a list of lines. `setp` works transparently with a list of objects or a single object. You can either use python keyword arguments or MATLAB-style string/value pairs:

```python
lines = plt.plot(x1, y1, x2, y2)
# use keyword arguments
plt.setp(lines, color='r', linewidth=2.0)
# or MATLAB style string value pairs
plt.setp(lines, 'color', 'r', 'linewidth', 2.0)
```

More in [Matplotlib.Line2D](https://matplotlib.org/stable/api/_as_gen/matplotlib.lines.Line2D.html#matplotlib.lines.Line2D)

### Working with multiple figures and Axes

MATLAB, and `pyplot`, have the concept of the current figure and the current Axes. All plotting functions apply to the current Axes. The gunction `gca` returns the current figure (A `matplotlib.axes.Axes` instance), and `gcf` returns the current figure (a `matplotlib.figure.Figure` instance). Normally, you don't have to worry about this, becase it is all taken care of behind the scenes. Below is a script to create two subplots.

```python
def f(t):
    return np.exp(-t) * np.cos(2 * np.pi * t)
t1 = np.arange(0.0, 5.0, 0.1)
t2 = np.arange(0.0, 5.0, 0.02)
plt.figure()
plt.subplot(211)
plt.plot(t1, f(t1), 'bo', t2, f(t2), 'k')
plt.subplot(212)
plt.plot(t2, np.cos(2 * np.pi * t2), 'r--')
plt.show()
```

The `figure` call here is optional because a figure will be created if none exists, just as an Axes will be created (equivalent to an explicit `subplot()` call) if none exists. The subplot call specifies numrows, numcols, plot_number where plot_number ranges from 1 to numrows*numcols. The commas in the subplot call are optional if numrows*numcols<10. So subplot(211) is identical to `subplot(2, 1, 1)`.

```python
plt.subplot(
    [nrows](n rows of plots will be created),
    [ncols](n cols of plots will be created),
    [index](start from 1, L2R, T2B)
)
```

You can create an arbitrary number of subplots and Axes. If you want to place an Axes manually, i.e., not on a rectangular grid, use `axes`, which allows you to specify the location as `axes([left, bottom, width, height])` where all values are in fractional (0 to 1) coordinates. See Axes Demo for an example of placing Axes manually and Multiple subplots for an example with lots of subplots.

You can create multiple figures by using multiple `figure` calls with an increasing figure number. Of course, each figure can contain as many Axes and subplots as your heart desires:

```python
import matplotlib.pyplot as plt
plt.figure(1)                # the first figure
plt.subplot(211)             # the first subplot in the first figure
plt.plot([1, 2, 3])
plt.subplot(212)             # the second subplot in the first figure
plt.plot([4, 5, 6])

plt.figure(2)                # a second figure
plt.plot([4, 5, 6])          # creates a subplot() by default

plt.figure(1)                # first figure current;
                             # subplot(212) still current
plt.subplot(211)             # make subplot(211) in the first figure
                             # current
plt.title('Easy as 1, 2, 3') # subplot 211 title
```

You can clear the current figure with `clf` and the current Axes with `cla`. If you find it annoying that states (specifically the current image, figure and Axes) are being maintained for you behind the scenes, don't despair: this is just a thin stateful wrapper around an object-oriented API, which you can use instead (see Artist tutorial)

If you are making lots of figures, you need to be aware of one more thing: the memory required for a figure is not completely released until the figure is explicitly closed with `close`. Deleting all references to the figure, and/or using the window manager to kill the window in which the figure appears on the screen, is not enough, because pyplot maintains internal references until `close` is called.

### Working with text

`text` can be used to add text in an arbitrary location, and `xlabel`, `ylabel` and `title` are used to add text in the indicated locations.

```python
mu, sigma = 100, 15
x = mu + sigma * np.random.randn(10000)
# the histogram // TODO from here
```

## MATLAB format string

```python
plt.plot(x, y, fmt)
```

here:

```python
fmt = '[marker][line][color]'
```

### Marker styles

| Code | Marker         | Meaning   |
| ---- | -------------- | --------- |
| `.`  | point          | small dot |
| `o`  | circle         | ○         |
| `s`  | square         | □         |
| `^`  | triangle up    | △         |
| `v`  | triangle down  | ▽         |
| `<`  | triangle left  |           |
| `>`  | triangle right |           |
| `*`  | star           | ★         |
| `+`  | plus           | +         |
| `x`  | cross          | ×         |
| `D`  | diamond        | ◇         |

### Line styles

| Code | Style    | Appearance |
| ---- | -------- | ---------- |
| `-`  | solid    | ━━━━━      |
| `--` | dashed   | - - - -    |
| `-.` | dash-dot | -·-·-      |
| `:`  | dotted   | ·····      |

### Colour codes

| Code | Colour  | Example |
| ---- | ------- | ------- |
| `b`  | blue    | `'b'`   |
| `g`  | green   | `'g'`   |
| `r`  | red     | `'r'`   |
| `c`  | cyan    | `'c'`   |
| `m`  | magenta | `'m'`   |
| `y`  | yellow  | `'y'`   |
| `k`  | black   | `'k'`   |
| `w`  | white   | `'w'`   |

## 序列解包

```python
line, = plt.plot(x, y, '-')
```

`plt.plot()`返回一个列表，其中包含所绘制的`line2D`对象（即使只有一条线，也是长度为$1$的列表）

`line,`是一个单元素元组（逗号作为必须的标识符），它要求右侧的可迭代对象恰好有一个元素

解包过程将列表中的唯一一个`line2D`对象提取出来，赋值给`line`

等价于：

```python
line = plt.plot(x, y, '-')[0]
```

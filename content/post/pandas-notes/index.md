---
title: "Notes for Pandas"
description: ""
slug: pandas-notes
date: 2026-09-09 11:30:40+0800
image:
categories:
    - 筆記
tags:
    - Python
    - Pandas
---

## Pandas Basics

Here we import `numpy`, `pandas` as:

```python
import numpy as np
import pandas as pd
```

### Basic data structures in pandas

pandas provides two types of classes fro handling data:

1. `Series`: a one-dimansional labeled array holding data of any type, such as integers, strings, Python objects, etc.

2. `DataFrame`: a two-dimensional data structure that holds data like a two-dimension array or a table with rows and columns.

### Object creation

Creating a `Series` by passing a list of values, letting pandas create a default `RangeIndex`

```python
>>> import numpy as np
>>> import pandas as pd
>>> s = pd.Series([1, 3, 5, np.nan, 6, 8])
>>> s
0    1.0
1    3.0
2    5.0
3    NaN
4    6.0
5    8.0
dtype: float64
```

Creating a DataFrame by passing a NumPy array with a datetime index using `date_range()` and labeled columns:

```python
>>> dates = pd.date_range("20260909", periods=6)
>>> dates
DatetimeIndex(['2026-09-09', '2026-09-10', '2026-09-11', '2026-09-12',
               '2026-09-13', '2026-09-14'],
              dtype='datetime64[ns]', freq='D')
>>> df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))
>>> df
                   A         B         C         D
2026-09-09  0.956212  0.496608  1.031761  0.439333
2026-09-10 -0.283260  0.644414 -0.352740 -0.617138
2026-09-11  0.667249  1.570810 -1.711173  1.114610
2026-09-12 -0.324996 -0.441097  0.821568 -0.425018
2026-09-13  0.981316  0.504753  1.098882  0.498294
2026-09-14  0.433741  0.992282 -0.737600  1.621099
```

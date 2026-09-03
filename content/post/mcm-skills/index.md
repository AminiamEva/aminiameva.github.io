---
title: "MCM 常用方法 Python 版"
description: ""
slug: mcm-skills
date: 2026-09-02 21:35:33+0800
image:
categories:
    - 筆記
tags:
    - Python
    - MCM
---

## 層次分析法 AHP（Analytic Hierarchy Process）

### 問題背景

決策目標涉及多個難以統一量綱衡量的因素時，需要有一種方法把專家的主管判斷轉化爲客觀權重。

> 與其直接問某因素的權重，不如讓專家兩兩比較“A比B”重要多少倍。

兩兩比較的結果構成判斷矩陣$(A_{ij}) _ {n\times n}$，其中$a_{ij}$表示因素$i$相對於$j$的重要程度，採用如下標度法：

| 標度   | 含義   |
|--------|--------|
|1       |同等重要|
|3       |稍微重要|
|5       |明顯重要|
|7       |強烈重要|
|9       |極端重要|
|2,4,6,8 | 中間值 |

### 性質

矩陣滿足互反性：$a_{ij}a_{ji}=1$，對角線$a_{ii}=1$

若專家的判斷具有完全一致性，則存在權重向量$(\omega)_n$使得：

$$
a_{ij} = \frac{\omega_i}{\omega_j}
$$

此時矩陣$A$可以寫成列向量與行向量的乘積形式。

下面證明權重向量就是特徵向量：

$$
(A\omega)_i=\sum_j{a_{ij}\omega_j}=n\omega_i\space\square
$$

現實中專家判斷難免有偏差，矩陣不完全已知，但可以證明此時最大的特徵值$\lambda_{max}\ge n$，且當$\lambda_{max}$越接近$n$，矩陣一致性越好。於是去最大特徵值對應的特徵向量，歸一化後作爲權重。

### 一致性檢驗

定義一致性指標：

$$
CI=\frac{\lambda_{max}-n}{n-1}
$$

再用隨機一致性指標$RI$（查表可知，反映隨機矩陣的平均$CI$）做歸一化：

$$
CR=\frac{CI}{RI}
$$

當$CR<0.1$認爲矩陣一致性可以接受。

### Python實現

```python
import numpy as np

def ahp_analysis(A):
    n = A.shape[0]
    eigvals, eigvecs = np.linalg.eig(A) # 計算特徵值和特徵向量
    max_idx = np.argmax(eigvals.real) # 數值計算可能有小虛部，並找到最大特徵值位置
    lambda_max = eigvals[max_idx].real # 提取最大特徵值
    w = eigvecs[:, max_idx].real # 提取對應特徵向量
    weights = w / w.sum() # 歸一化
    # 一致性檢驗：
    CI = (lambda_max - n) / (n - 1)
    RI_table = {1:0, 2:0, 3:0.58, 4:0.90, 5:1.12, 6:1.24, 7:1.32, 9:1.41}
    RI = RI_table[n]
    CR = CI / RI
    # return
    return weights, CR
```

```python
>>> import numpy as np
>>> A = np.array([[1, 3, 1.0 / 3.0], [1.0 / 3.0, 1\
, 1.0 / 5.0], [3, 5, 1]])
>>> n = A.shape[0]
>>> eigvals, eigvecs = np.linalg.eig(A)
>>> print(eigvals)
[ 3.03851109+0.j         -0.01925555+0.34153419j -0.01925555-0.34153419j]
>>> print(eigvecs)
[[ 0.37147738+0.j          0.18573869-0.32170885j  0.18573869+0.32170885j]
 [ 0.1506267 +0.j          0.07531335+0.13044655j  0.07531335-0.13044655j]
 [ 0.916142  +0.j         -0.916142  +0.j         -0.916142  -0.j        ]]
>>> max_idx = np.argmax(eigvals.real)
>>> print(max_idx)
0
>>> lambda_max = eigvals[max_idx].real
>>> print(lambda_max)
3.0385110905581696
>>> w = eigvecs[:, max_idx].real
>>> print(w)
[0.37147738 0.1506267  0.916142  ]
>>> weights = w / w.sum()
>>> print(weights)
[0.25828499 0.10472943 0.63698557]
>>> CI = (lambda_max - n) / (n - 1)
>>> print(CI)
0.019255545279084796
>>> RI_table = {1:0, 2:0, 3:0.58, 4:0.90, 5:1.12, \
6:1.24, 7:1.32, 9:1.41}
>>> RI = RI_table[n]
>>> CR = CI / RI
>>> print(CR)
0.033199215998422064
```

```python
np.argmax(...) // 找到數組中最大值的索引位置
```

## TOPSIS法（逼近理想解排序法）

TOPSIS (Tecnique for Order Preference by Similarity to Ideal Solution)

> 一個好的方案，應該離最優解情況最近，同時離最差情況最遠。

### 性質

設有$m$個評價對象，$n$個指標，決策矩陣爲$X=(x_{ij})_{m\times n}$。

1. 正向化：若指標是“越小越好”型，先轉化爲“越大越好”型，常用取倒數或者$max-x$的方式

2. 歸一化（消除兩綱影響），常用向量歸一化：$\displaystyle z_{ij}=\frac{x_{ij}}{\sqrt{\sum_{i=1}^m{x_{ij}^2}}}$。

3. 加權（結合AHP或熵權法得到的權重$\omega_j$）：$v_{ij}=\omega_j z_{ij}$。

4. 確定正負理想解：$Z^+=(\max_iv_{i1},\cdots,\max_iv_{in}$，$Z^+=(\min_iv_{i1},\cdots,\min_iv_{in}$

5. 計算歐氏距離與貼近度：

    $$
    D_i^+=\sqrt{\sum_j{(v_{ij}-Z_j^+)^2}}
    $$

    $$
    D_i^-=\sqrt{\sum_j{(v_{ij}-Z_j^-)^2}}
    $$

    $$
    C_i=\frac{D_i^-}{D_i^++D_i^-}\in[0,1]
    $$

顯然$C_i$越接近$1$，該方案越優。

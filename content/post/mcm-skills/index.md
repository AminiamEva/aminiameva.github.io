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

### Python實現

```python
import numpy as np

def topsis(data, weights, indicator_types):
    X = data.astype(float) # 將數據強制轉化成float
    m, n = X.shape
    # 1. 正向化（如果是極小性，則翻轉）
    for j in range(n):
        if indicator_types[j] == 'min':
            X[:, j] = np.max(X[:, j]) - (X[:, j])
    # 2. 向量歸一化（按列歸一化）
    norm-factor = np.sqrt(np.sum(X**2, axis=0)) # axis=0是列，1是行
    Z = X / norm_factor # 廣播
    # 3. 加權
    V = Z * weights # 區別@，這裏是對應元素相乘
    # 4. 正負理想解
    Z_pos = V.max(axis=0)
    Z_neg = V.min(axis=0)
    # 5. 計算歐氏距離
    D_pos = np.sqrt(np.sum((V - Z_pos)**2, axis=1))
    D_neg = np.sqrt(np.sum((V - Z_neg)**2, axis=1))
    # 6. 貼近度
    C = D_neg / (D_pos + D_neg + 1e-8)
    # return
    return C
```

```python
>>> import numpy as np
>>> data = np.array([[5, 5, 10], [8, 8, 5]])
>>> weights = [0.25828499, 0.10472943, 0.63698557]
>>> X = data.astype(float)
>>> m, n = X.shape
>>> norm_factor = np.sqrt(np.sum(X**2,axis=0))
>>> Z = X / norm_factor
>>> V = Z * weights
>>> Z_pos = V.max(axis=0)
>>> Z_neg = V.min(axis=0)
>>> D_pos = np.sqrt(np.sum((V - Z_pos)**2, axis=1)\
)
>>> D_neg = np.sqrt(np.sum((V - Z_neg)**2, axis=1)\
)
>>> C = D_neg / (D_pos + D_neg + 1e-8)
>>> print(C)
[0.76270391 0.23729606]
```

## 最小二乘擬合與迴歸

### 性質

設擬合模型爲$\hat{y}=P_k(x)=\sum_i\beta_ix^k$，定義殘差平方和：

$$
S(\beta) = \sum_i(y_i-\hat{y}_i)^2
$$

最小二乘法的目標是找到使$S(\beta)$最小的參數$\beta$。

推導正規方程：將模型寫作$y=X\beta+\varepsilon$，其中$X$是範德蒙德矩陣（每行爲：$[1,x_i,x_i^2,\cdots,x_i^k]$），展開$S(\beta)$：

$$
S(\beta)=(y-X\beta)^T(y-X\beta)=y^Ty-2\beta^TX^Ty+\beta^TX^TX\beta
$$

對$\beta$求梯度並令其爲零：

$$
\frac{\partial S}{\partial\beta}=-2X^Ty+2X^TX\beta=0
$$

解得正規方程：

$$
X^TX\beta=X^Ty
$$

當$X$列滿秩時，$\beta=(X^TX)^{-1}X^Ty$

證明其最優性（高斯-馬爾可夫定理，BLUE）：略

### Python實現

```python
import numpy as np

class LinearRegression:
    def __init__(self):
        self.coef_ = None
        self.intercept_ = None
        self.r2_ = None

    def fit(self, X, y):
        # X: （樣本數，特徵數），y: （樣本數，）
        # 構造增廣矩陣：在X左邊加一列1，用來計算解決
        X_design = np.c_[np.ones(X.shape[0]), X]
        
        beta = np.linalg.inv(X_design.T @ X_design) @ X_design.T @ y
        self.intercept_ = beta[0]
        self.coef_ = beta[1:]
        
        y_pred = self.predict(X)
        ss_res = np.sum((y - y_pred)**2)
        ss_tot = np.sum((y - np.mean(y))**2)
        self.r2_ = 1 - ss_res / ss_tot
        
        return self
    
    def predict(self, X):
        return X @ self.coef_ + self.intercept_
```

```python
import numpy as np

# 一维数组（形状: (3,) ）
a1 = np.array([1, 2, 3])
b1 = np.array([4, 5, 6])

# 二维数组（形状: (2, 2) ）
a2 = np.array([[1, 2], 
               [3, 4]])
b2 = np.array([[5, 6], 
               [7, 8]])
# 第一部分：按列左右拼接 (Horizontal / 增加列数)
# np.hstack —— 对一维数组：保持一维，直接延长（拼接元素）
res_hstack_1d = np.hstack((a1, b1))
# 输出: [1 2 3 4 5 6] (6,)

# np.c_ —— 对一维数组：转成列向量，形成二维矩阵（增加列数）
# 相当于把 a1 和 b1 看作两列特征，形状从 (3,) + (3,) -> (3, 2)
res_c_1d = np.c_[a1, b1]
# 输出: [[1 4] (3, 2)
#        [2 5]
#        [3 6]]

# np.column_stack —— 和 np.c_ 效果完全一样（一维数组当列处理）
res_col_stack = np.column_stack((a1, b1))
print(f"column_stack 一维结果: \n{res_col_stack}, 形状: {res_col_stack.shape}")

# 针对二维数组：hstack、c_、concatenate(axis=1) 三者等价
res_hstack_2d = np.hstack((a2, b2))
res_c_2d = np.c_[a2, b2]
res_concat_axis1 = np.concatenate((a2, b2), axis=1)  # axis=1 代表列方向
{res_hstack_2d.shape}")
# 输出: [[1 2 5 6] (2, 4)
#        [3 4 7 8]]

# 不要对一维数组用 concatenate(axis=1)，因为一维没有 axis=1 维度

# np.vstack —— 对一维数组：转成行向量，上下堆叠（增加行数）
# 相当于把 a1 和 b1 看作两行样本，形状从 (3,) + (3,) -> (2, 3)
res_vstack_1d = np.vstack((a1, b1))
# 输出: [[1 2 3] (2, 3)
#        [4 5 6]]

#  np.r_ —— 对一维数组：直接合并延长（和 vstack 不同！r_ 对一维是延长）
# r_ 对一维数组的行为是“合并元素”，类似 hstack（特殊）
res_r_1d = np.r_[a1, b1]
# 输出: [1 2 3 4 5 6] (6,)

# 针对二维数组：vstack、r_、concatenate(axis=0) 三者等价
res_vstack_2d = np.vstack((a2, b2))
res_r_2d = np.r_[a2, b2]
res_concat_axis0 = np.concatenate((a2, b2), axis=0)  # axis=0行方向（默认值）
# 输出: [[1 2] (4, 2)
#        [3 4]
#        [5 6]
#        [7 8]]

# np.row_stack —— np.vstack 的别名
res_row_stack = np.row_stack((a2, b2))

# 增加新维度拼接 (np.stack)
# np.stack 会在指定位置创建一个新的维
res_stack_axis0 = np.stack((a1, b1), axis=0)  # 新维度在第0层（第0轴变成2）
res_stack_axis1 = np.stack((a1, b1), axis=1)  # 新维度在第1层（第1轴变成2）
# 输出: [[1 2 3] (2, 3)
#        [4 5 6]]
# 输出: [[1 4] (3, 2)
#        [2 5]
#        [3 6]]
```

```python
X.T # 转置
np.linalg.inv() # 求逆
x.reshape(-1, 1) # 将一维数组变成二维列向量。`-1`表示自动计算行数
```

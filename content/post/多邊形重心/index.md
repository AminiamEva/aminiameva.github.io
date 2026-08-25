---
title: "多邊形重心"
description: ""
slug: 多邊形重心
date: 2026-08-25 23:30:24+0800
image:
categories:
    - 筆記
tags:
    - ACM
    - AtCoder
    - Cpp
---

## 原題

AtCoder 原題：[F - Centroid of a Slice](https://atcoder.jp/contests/abc472/tasks/abc472_f)

## 多边形重心坐标

對有$N$個頂點的平面多邊形的每個頂點有$(x_i,y_i)$有：

$$
G_x = \frac{\sum_i{(x_i+x_{i+1})S_i}}{3\sum_i{S_i}}
\newline
G_y = \frac{\sum_i{(y_i+y_{i+1})S_i}}{3\sum_i{S_i}}
$$

其中：

$$
S_i = \frac{1}{2}(x_iy_{i+1}-x_{i+1}y_i)
\newline
x_{N+1} = x_1
\newline
y_{N+1} = y_1
$$

## 注意事項

使用前綴和時，記得閉合最後一條邊。

## AC代碼

```cpp
#include <cstdio>

const int SIZE = (1e6 + 10);
typedef long double ld;

int main()
{
    //read
    int N, Q; scanf("%d%d", &N, &Q);
    int x[SIZE] = {0}, y[SIZE] = {0};
    ld ax[SIZE] = {0}, ay[SIZE] = {0}, b[SIZE] = {0};
    for (int i = 1; i <= N; i++)
        scanf("%d%d", &x[i], &y[i]);
    x[N + 1] = x[1]; y[N + 1] = y[1];
    for (int i = 1; i <= N; i++)
    {
        ax[i] = ax[i - 1] + ((ld)x[i] + (ld)x[i + 1]) * ((ld)x[i] * (ld)y[i + 1] - (ld)x[i + 1] * (ld)y[i]);
        ay[i] = ay[i - 1] + ((ld)y[i] + (ld)y[i + 1]) * ((ld)x[i] * (ld)y[i + 1] - (ld)x[i + 1] * (ld)y[i]);
        b[i] = b[i - 1] + (ld)x[i] * (ld)y[i + 1] - (ld)x[i + 1] * (ld)y[i];
    }
    //output
    for (int i = 0; i < Q; i++)
    {
        int u, v; scanf("%d%d", &u, &v);
        ld ans_x, ans_y, sb, sax, say;
        if (u < v)
        {
            sb = b[v - 1] - b[u - 1];
            sax = ax[v - 1] - ax[u - 1];
            say = ay[v - 1] - ay[u - 1];
        }
        else
        {
            sb = b[N] - b[u - 1] + b[v - 1];
            sax = ax[N] - ax[u - 1] + ax[v - 1];
            say = ay[N] - ay[u - 1] + ay[v - 1];
        }
        //close
        ld c = (ld)x[v] * (ld)y[u] - (ld)x[u] * (ld)y[v];
        sb += c;
        sax += ((ld)x[v] + (ld)x[u]) * c;
        say += ((ld)y[v] + (ld)y[u]) * c;
        ans_x = sax / sb / 3.0L;
        ans_y = say / sb / 3.0L;
        printf("%.12Lf %.12Lf\n", ans_x, ans_y);
    }
    return 0;
}
```

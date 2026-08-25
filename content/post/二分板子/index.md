---
title: "二分板子"
description: ""
slug: 二分板子
date: 2026-08-22 16:15:06+0800
image:
categories:
    - 筆記
tags:
    - cpp
    - ACM
---

## 檢查左端點

```cpp
int l = 1, r = n;
while (l < r)
{
    int mid = (l + r) / 2;
    if(check(mid)) r = mid;
    else l = mid + 1;
}
```

## 檢查右端點

```cpp
int l = 1, r = n;
while (l < r)
{
    int mid = (l + r + 1) / 2;
    if(check(mid)) l = mid;
    else r = mid - 1;
}
```

---
title: "tree板子"
description: ""
slug: tree板子
date: 2026-08-22 16:18:53+0800
image:
categories:
    - 筆記
tags:
    - cpp
    - ACM
---

## 方案一：vector 鄰接表

使用`vector<int> n;`，`n[i]`儲存了第$i$個節點的所有鄰居。

### `add(a, b)` (vector)

```cpp
a.push_back(b);
b.push_back(a);
```

### DFS (vector)

遞歸實現，首先定義`bool st[SIZE] = {false};`來記錄節點是否被訪問過。

```cpp
void dfs(head)
{
    st[head] = true; //標記當前節點
    run(head);       //執行操作
    for (auto v : n[head])
        if (!st[v])
            dfs(v);
}
```

### BFS (vector)

使用隊列`queue<int> q;`

```cpp
st[head] = true;            //先記錄head已經被訪問
q.push(head);               //將head插入隊尾
while (!q.empty())          //開始循環
{
    int f = q.front();
    q.pop();
    run(f);
    for (auto v : n[f])     
        if (!st[v])
        {
            st[v] = true;
            q.push(v);
        }
}
```

## 方案二：鏈式前向星

定義：

```cpp
int h[N];
int e[2 * N];
int ne[2 * N];
int id = 0;
```

### `add(a, b)` (static)

```cpp
id++;             //分配內存
e[id] = b;        //儲存值
ne[id] = h[a];    //頭插
h[a] = id;        //頭插
id++
e[id] = a;
ne[id] = h[b];
h[b] = id;
```

### DFS (static)

遞歸實現：

```cpp
void dfs(head)
{
    st[head] = true;
    run(head);
    for (int i = n[head]; i; i = ne[i])
    {
        int v = e[i];
        if (!st[v])
        {
            st[v] = true;
            dfs(v);
        }
    }
}
```

### BFS (static)

使用隊列`queue<int> q;`

```cpp
st[head] = true;
q.push_front(head);
while (!q.empty())
{
    int f = q.front();
    q.pop();
    run(f);                            //在此處run
    for (int i = n[f]; i; i = ne[i])
    {
        int v = e[i];
        if (!st[v])
        {
            st[v] = true;
            q.push(v);                 //這裏是push不是run
        }
    }
}
```

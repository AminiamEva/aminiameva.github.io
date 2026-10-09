---
title: "C CPP 解包"
description: ""
slug: c-cpp-args
date: 2026-10-09 14:49:53+0800
image:
categories:
    - 筆記
tags:
    - C
    - Cpp
    - Args
---

## `C`可變參數解包

示例：

```c
#include <stdio.h>
#include <stdarg.h>

int sum(int n, ...)
{
    va_list ap;
    va_start(ap, n);

    int ans = 0;

    for (int i = 0; i < n; ++i)
        ans += va_arg(ap, int);

    va_end(ap);
    return ans;
}

int main()
{
    printf("%d\n", sum(4, 1, 3, 5, 7));
    return 0;
}
```

```
16
```

## C++ 可變參數模板與遞歸解包

### 方式一：遞歸解包

```cpp
#include <iostream>

using namespace std;

template<typename T>
T maxn(T a) { return a; }

template<typename T, typename... Args>
T maxn(T a, Args... rest)
{
    T b = maxn(rest...);
    return a > b ? a : b;
}

int main()
{
    cout << maxn<double>(1.1, 2.2, 3.3) << endl;
    return 0;
}
```

### 方法二：摺疊表達式

|類型|寫法|展開結果|
|:---|:---|:---|
|一元左摺疊|`(... + args)`|`((a + b) + c)`|
|一元右摺疊|`(args + ...)`|`(a + (b + c))`|
|二元左摺疊|`(0 + ... + args)`|`(((0 + a) + b) + c)`|
|二元右摺疊|`(args + ... + 0)`|`(a + (b + (c + 0)))`|

示例：

```cpp
#include <iostream>

using namespace std;

template<typename T, typename... Args>
T maxn(T a, Args... args)
{
    ((a = a > args ? a : args), ...);
    return a;
}

int main()
{
    cout << maxn<double>(1.1, 2.2, 3.3, 4.4) << endl;
    return 0;
}
```

## 完美轉發

```cpp
#include <utility>

template<typename T>
void wrapper(T&& x)
{
    process(std::forward<T>(x));
}
```

```cpp
template<typename... Args>
void print(Args&&... args) { std::cout << ... <<< std::forward<Args>(args) }
```

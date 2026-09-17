---
title: "Notes for C"
description: ""
slug: c-notes
date: 2026-09-17 13:55:05+0800
image:
categories:
    - 筆記
tags:
    - C
    - Cpp
---

## C

1. `register`

2. `volatile`：指定變量可能被外部修改，每次都應重新讀取，不應相信緩存

3. `1.5`: `double`, `1.5f`: `float`, `1.5L`: `long double`

4. `fabs(x - y) < \varepsilon` $\leftrightarrow$ $|x - y|
<\varepsilon$; `fabs(x - y) < fabs(x * \varepsilon)` $\leftrightarrow$ $|x-y|<|x|\varepsilon$

5. 轉義字符：

    |字符|含義|
    |:---|:---|
    |`\b`|backspace|
    |`\r`|回車，光標移動到行首|
    |`\t`|tab|
    |`\v`|vertical tab|
    |`\f`|走紙換頁|
    |`\\`||
    |`\"`||
    |`\'`||
    |`\ddd`|三位八進制|
    |`\xdd`|兩位十六進制|

6. [格式輸入輸出](https://aminiameva.github.io/p/printf-scanf-format/)

7. 逗號表達式：從左向右依次計算，最後一個表達式的值作爲表達式運算的結果

8. 只有一元、三元、賦值運算的結合性爲從右向左

9. 隱式轉換規則：`short, char -> int -> unsigned int -> long -> unsigned long -> float -> double -> long double`

10. 字符串拼接：

    - 方式一：`'\'`自動拼接

    - 方式二："A ""B" = "A B"：相連的字符串常量自動拼接

11. `scanf("%d", s)`會在空格中止，`gets(s)`會在行尾中止

12. `<cstring>`:

    |function|def|
    |:---|:---|
    |strlen()||
    |strcpy(s1, s2)|s2複製到s1|
    |strncpy(s1, s2, n)|將s2中前n個字符複製到s1|
    |strcat(s1, s2)|將s2追加到s1中|
    |strcmp(s1, s2)|返回字典序`s1 > s2 ? :`|
    |strlwr(s)|覆寫s爲lowercase|
    |strupr(s)|覆寫s爲uppercase|
    |puts(s)|`printf("%s", s)`|
    |gets()||

13. 

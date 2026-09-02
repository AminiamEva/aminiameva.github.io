---
title: "`printf` `scanf` Format Quick Lookup"
description: ""
slug: printf-scanf-format
date: 2026-09-02 13:59:38+0800
image:
categories:
    - Document
tags:
    - Cpp
    - I/O
    - format
---

## 一、格式说明符

| 格式符 | printf 参数类型 | scanf 参数类型 | 说明 |
|--------|-----------------|-----------------|---------------|
| `%d`   | `int`           | `int*`          | 十进制有符号整数 |
| `%u`   | `unsigned int`  | `unsigned int*` | 十进制无符号整数 |
| `%o`   | `unsigned int`  | `unsigned int*` | 八进制          |
| `%x`   | `unsigned int`  | `unsigned int*` | 十六进制（小写） |
| `%X`   | `unsigned int`  | `unsigned int*` | 十六进制（大写） |
| `%f`   | `double`        | `float*`        | 浮点数（printf 用 `%f`/`%lf` 均可，scanf 必须 `%f` 给 float，`%lf` 给 double） |
| `%e`   | `double`       | `float*`      | 科学计数法（小写 e） |
| `%g`   | `double`       | `float*`      | 自动选 `%f` 或 `%e`（较短） |
| `%c`   | `char`         | `char*`       | 单个字符 |
| `%s`   | `const char*`  | `char[]`      | 字符串（遇空白停止） |
| `%p`   | `const void*`  | `void**`      | 指针地址（十六进制） |
| `%n`   | `int*`         | `int*`        | 写入已输出/读取的字符数 |
| `%%`   | -              | -             | 输出字面量 `%` |

## 二、长度修饰符

| 修饰符 | 适用类型示例 | 格式 |
|--------|-------------|------|
| `hh`   | `signed char` / `unsigned char` | `%hhd`, `%hhu` |
| `h`    | `short` / `unsigned short`      | `%hd`, `%hu` |
| `l`    | `long` / `unsigned long`        | `%ld`, `%lu` |
| `ll`   | `long long` / `unsigned long long` | `%lld`, `%llu` |
| `L`    | `long double`                   | `%Lf`, `%Le` |
| `z`    | `size_t`                        | `%zd` |
| `t`    | `ptrdiff_t`                     | `%td` |

## 三、`printf`常用标志

| 标志 | 作用 | 示例（`%`后加标志） |
|------|------|-------------------|
| `-`   | 左对齐（默认右对齐） | `%-10d` |
| `+`   | 强制显示正负号 | `%+d` |
| 空格  | 正数前加空格 | `% d` |
| `#`   | 八进制前加`0`，十六进制加`0x`/`0X`，浮点数强制小数点 | `%#o`, `%#x`, `%#f` |
| `0`   | 用 `0` 填充宽度（而非空格） | `%08d` |

## 四、宽度与精度

| 格式 | 含义 | 示例 |
|------|------|------|
| `%最小宽度d` | 输出至少占 n 位，不足补空格 | `%5d` |
| `%.精度f`   | 小数位数（浮点）/ 最大字符数（字符串）/ 最少数字位数（整数） | `%.2f`, `%.5s` |
| `%*.*f`     | 宽度和精度由参数提供 | `printf("%*.*f", w, p, val);` |

## 五、scanf 特殊用法

| 用法 | 说明 | 示例 |
|------|------|------|
| `*`   | 抑制赋值（跳过） | `scanf("%*d %d", &n);` |
| `[集合]` | 只读指定字符集 | `%[a-z]`（读小写字母） |
| `[^]`   | 读直到遇到某字符 | `%[^,]`（读逗号前） |

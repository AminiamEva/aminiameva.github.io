---
title: "CPP __Builtin_"
description: ""
slug: Cpp-Built-in
date: 2026-09-02 13:52:32+0800
image:
categories:
    - Document
tags:
    - Cpp
    - __builtin_
---

## CPP Builtin

### 1. 位运算与计数

| 函数 | 功能描述 | 示例 | 注意 |
| :--- | :--- | :--- | :--- |
| **`__builtin_popcount(x)`** | 返回 `x` 的二进制中 **1 的个数** | `__builtin_popcount(15)` → `4` | 有 `popcountl`、`popcountll` 版本 |
| **`__builtin_clz(x)`** | 返回从最高位开始的**前导零**个数 | `__builtin_clz(1)`（32位）→ `31` | 传入 `0` 是 **未定义行为**；有 `clzl`、`clzll` |
| **`__builtin_ctz(x)`** | 返回从最低位开始的**尾随零**个数 | `__builtin_ctz(8)` → `3` | 传入 `0` 是 **未定义行为**；有 `ctzl`、`ctzll` |
| **`__builtin_ffs(x)`** | 返回**最低位 1 的位置**（从 1 开始） | `__builtin_ffs(8)` → `4` | `x=0` 时返回 `0`；有 `ffsl`、`ffsll` |
| **`__builtin_parity(x)`** | 返回 **1 的个数的奇偶性**（奇数个1→1） | `__builtin_parity(15)` → `0` | 有 `parityl`、`parityll` |

### 2. 算术运算与安全

| 函数 | 功能描述 | 示例 | 注意 |
| :--- | :--- | :--- | :--- |
| **`__builtin_add_overflow(a, b, &res)`** | 安全加法，**检测是否溢出** | 溢出返回 `true`，否则存入 `res` 并返回 `false` | 支持 `sub`（减法）和 `mul`（乘法） |
| **`__builtin_abs(x)`** 等 | 计算整数或浮点数的**绝对值** | `__builtin_abs(-10)` → `10` | 有 `labs`、`llabs`、`fabs` 等版本 |

### 3. 优化与调试

| 函数 | 功能描述 | 示例 | 注意 |
| :--- | :--- | :--- | :--- |
| **`__builtin_expect(exp, c)`** | 提供**分支预测**信息，优化代码布局 | 常与 `if` 结合，如 `if (__builtin_expect(ptr == nullptr, 0))` | 错误使用可能降低性能 |
| **`__builtin_trap()`** | 强制执行**陷阱指令**，程序异常终止 | 用于不应执行到的代码路径 | – |
| **`__builtin_unreachable()`** | 告诉编译器某**路径永远不会执行**，辅助优化 | 常用于 `switch` 的 `default` 分支（当所有情况已覆盖） | – |

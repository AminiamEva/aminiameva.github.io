---
title: "Sudoku Solver: Bitmask & MRV"
description: ""
slug: sudoku-solver
date: 2026-09-02 13:28:15+0800
image:
categories:
    - 筆記
tags:
    - ACM
    - Cpp
    - Bitmask
    - MRV
    - "Y-Combinator"
    - "L/RValue"
---

## Sudoku Solver

LeetCode 原题地址：[37. Sudoku Solver](https://leetcode.com/problems/sudoku-solver/description/)

### 狀態壓縮：Bitmask

使用$9$位的二進制整數分別表示$1\to9$。

標記佔用：`rows[r] |= (1 << (d - 1))`

撤銷佔用：`rows[r] ^= (1 << (d - 1))`

計算候選數：`used = rows[r] | cols[c] | boxes[b]`，那麼可用數字：`available = (~used) & 0b111111111`（取反後保留低$9$位）

### MRV(Minimum Remaining Values)：最小剩餘值啓發式

先填最難的。

比如：有一個空格，行裏缺`{1, 2}`，列裏缺`{1, 2, 3}`，宮裏缺`{1}`（唯一解），就優先填它。

這是在“最受限”的位置做決策。如果唯一解的地方都填錯了，說明之前的選擇有無，可以*儘早回溯*（Fail-First 原則）。反之如果先去填有$9$可能的空格，會浪費大量算力。

實現方法：在每一層遞歸開始時，掃描所有剩餘空格，找出`available`裏$1$個數最少的，交換到當前處理位置。

### 遍歷方法：位運算提取候選（Lowbit 技巧）

- 取最低位的`1`：`bit = available & -available`

- Count Trailing Zeros：`d = __builtin_ctz(bit)`

### 算法流程：DFS 回溯

1. 初始化：掃描整個棋盤，將已填數字更新到`rows`，`cols`，`boxes`中，同時記錄所有空格座標。

2. 遞歸入口（`backtrack(idx)`）

    - 終止條件：如果`idx`等於空格總數，說明填完了，返回`true`。

    - MRV 選點：從`idx`到末尾遍歷所有空格，計算每個空格的`available`掩碼，統計`1`的個數，選出最小的那個，並**交換到**`empties[idx]`**位置**。

    - 嘗試填入：獲取當前空格的`available`掩碼，利用`lowbit`去除每一個候選數字。

    - 放置並遞歸：修改棋盤，更新`rows/cols/boxes`掩碼，調用`backtrack(idx + 1)`。

    - 回溯撤銷：如果遞歸返回`false`，說明這條路走不通，撤銷掩碼，將棋盤改回`'.'`，嘗試下一個候選。

3. 結果：一旦找到解，遞歸棧層層返回`true`，完成求解。

### 實現

- `emplace_back(r, c)`就地構造，`push_back(make_pair(r, c))`或者`push_back({r, c})`會產生臨時變量，儘管對於一般的情況會被`-O2`優化。

- `function<bool(int)>`通用函數包裝器，意爲任意一個接受`int`參數，並返回`bool`值的可調用對象（函數、仿函數、Lambda）。

- `[&]`按引用捕獲，`[=]`按值捕獲。

- `std::function`有微小性能損耗，大約$5\%\to10\%$，因爲底層使用了類型擦除，調用時會多一次間接尋址。追求極致可使用`auto` + Y-Combinator（不動點組合子）來替代以消除開銷。

- `idx`表示当前处理到第`idx`个空格。

```cpp
class solution
{
    public:
        void solveSudoku(vector<vector<char>>& board)
        {
            int rows[9] = {0}, cols[9] = {0}, boxes[9] = {0};
            vector<pair<int, int>> empties;

            for (int r = 0; r < 9; ++r)
                for (int c = 0; c < 9; ++c)
                    if (board[r][c] == '.')
                        empties.emplace_back(r, c);
                    else
                    {
                        int d = board[r][c] - '1';
                        int mask = 1 << d;
                        int b = (r / 3) * 3 + (c / 3);
                        rows[r] |= mask;
                        cols[c] |= mask;
                        boxes[b] |= mask;
                    }
            
            function<bool(int)> backtrack = [&](int idx) -> bool
            {
                if (idx == empties.size()) return true;

                int bestIdx = idx;
                int minCandidates = 10;
                for (int i = idx; i < empties.size(); ++i)
                {
                    int r = empties[i].first, c = empties[i].second;
                    int b = (r / 3) * 3 + (c / 3);
                    int used = rows[r] | cols[c] | boxes[b];
                    int available = (~used) & 0b111111111;
                    int cnt = __builtin_popcount(available);
                    if (cnt < minCandidates)
                    {
                        minCandidates = cnt;
                        bestIdx = i;
                        if (cnt == 1) break;
                    }
                }
                if (bestIdx != idx) swap(empties[idx], empties[bestIdx]);
                int r = empties[idx].first, c = empties[idx].second;
                int b = (r / 3) * 3 + (c / 3);
                int used = rows[r] | cols[c] | boxes[b];
                int available = (~used) & 0b111111111;

                while (available)
                {
                    int bit = available & -available;
                    int d = __builtin_ctz(bit);
                    available ^= bit;
                    board[r][c] = char('1' + d);
                    rows[r] |= bit;
                    cols[c] |= bit;
                    boxes[b] |= bit;

                    if (backtrack(idx + 1)) return true;

                    board[r][c] = '.';
                    rows[r] ^= bit;
                    cols[c] ^= bit;
                    boxes[b] ^= bit;
                }
                return false;
            };
            backtrack(0);
        }
};
```

### 不動點組合子

經典錯誤寫法：

```cpp
auto backtrack = [&](int idx) -> bool
{
    if (backtrack(idx + 1)) return true;
};
```

錯誤因爲`backtrack`還沒有聲明完，不能在內部調用。

普通解決方案，用`std::function`，但是存在性能損耗。

解決方案核心思想：把自己作爲參數傳遞進去：

```cpp
auto backtrack = [](auto&& self, int idx) -> bool
{
    if (self(self, idx + 1)) return true;
    return false;
};
```

### 左值、右值和萬能引用`auto&&`

#### 定義

任何一個`cpp`表達式在編譯器視角都有一下兩個獨立屬性：

- 擁有身份（Has Identity）：這個表達式是否代表一塊具體的內存地址？能否用`&`取到它的地址？

- 可被移動（Is Movable）：這個表達式的值是否允許被“竊取”（轉移資源），因爲它馬上就要被銷燬了？

基於以上兩個不二屬性，表達式分爲三大類：

1. 左值：Lvalue，有身份

2. 純右值：Prvalue，沒有（臨時寄存器）

3. 亡值：Xvalue，有（即將被銷燬的對象）

4. 右值：Rvalue，純右值或者亡值（要麼沒有地址，要麼瀕臨死亡）

```cpp
int a = 10;
int b = a; // a 是左值，但是出現在等號右邊
&a; // 合法，取左值的地址
&10; // 非法，取右值的地址
// 但可以將右值轉化爲左值（亡值）：
int&& c = 10; // 將亡值綁定到右值引用上
&c; // 現在 c 有地址，它是亡值，屬於右值但是可取地址
```

#### 分析

```cpp
auto backtrack = [](auto&& self, int idx) { ... };
backtrack(backtrack, 0);
```

對於這裏的`backtrack`：

- 這是一個具名變量，編譯器爲它在棧上分配了內存

- 它擁有確定的內存地址，可以`&backtrack`

- 它不會在函數調用結束時銷燬（它處於外層作用域）

因此`backtrack`是一個左值，傳給`auto&&`後，推導爲左值引用`Type&`

對於`0`：

- 它不佔用靜態或棧上的內存，直接作爲立即數編碼在 CPU 的彙編指令集

- 它沒有任何內存地址

- 它是一個臨時值，函數調用完就丟棄

因此`0`是一個純右值，傳給`int indx`時發生拷貝

#### `T&&`

情況一：`type`是具體類型（無推導），這是一個右值引用，會拒絕左值。

情況二：`type`是推導佔位符（`auto`或`template T`），這是轉發引用，如果傳遞左值，摺疊爲`T&`，傳入右值，摺疊爲`T&&`。

#### std::move

`std::move(a)`是類型強轉，對於基礎類型：

```cpp
int a = 1;
int b = std::move(a);
```

執行第二句時，編譯器查找`int`的構造函數，發現`int`沒有移動構造函數，於是移動退化爲拷貝，結果是`a`和`b`分別指向兩塊內存都儲存了`1`

對於資源類型：

```cpp
vector<int> a = {1, 2, 3};
vector<int> b = std::move(a);
```

執行`std::move(a)`時`a`並未改變，執行`vector<int> b = std::move(a);`時，`vector`的移動構造函數完成三件事：

- 將`b`指向`a`本來指向的地址，並將`a`設置爲`nullptr`

- 將`b`的大小設置爲`a`的大小，並將`a`的大小設置爲`0`

- 將`b`的容量指向`a`的容量，並將`a`的容量歸零

#### 構造函數初始化列表

節省先构造一个默认空對象再赋值數據的冗餘操作，`const`成員、引用成員、無默認構造對象必須使用函數初始化列表

```cpp
class Student
{
private:
    string name;
    int age;
public:
    Student(string n, int a) : name(n), age(a) {}
};
```

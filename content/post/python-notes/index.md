---
title: "Note for Python"
description: ""
slug: python-notes
date: 2026-08-31 19:27:00+0800
image:
categories:
    - 筆記
tags:
    - Python
---

## 本體語法

1. 自定義輸出行爲：

   方法一：

   ```python
   import sys
   sys.stdout.write("Hello!\n")
   ```

   方法二：

   ```python
   def printf(string : str):
       print(string, end='', sep='')
   ```

2. 自定義讀入行爲：

   ```python
   >>> import sys
   >>> line = sys.stdin.read()
   Hello World!
   >>> # line = "Hello World!\n"
   >>> line = sys.stdin.readline().rstrip('\n')
   Hello World!
   >>> # line = "Hello World!"
   >>> char = sys.stdin.read(1)
   Hello World!
   >>> # char = 'H'
   >>> all_content = sys.stdin.read()
   >>> # read to EOF (suitable for pipe)
   >>> for line in sys.stdin:
   ...     print(repr(line)) # to print '\n' explicitly cuz `line` has '\n' surfix
   ```

   

1. `<str>.title()` 以首字母大寫返回每一個單詞，`<str>.upper()`大寫，`<str>.lower()`小寫

2. `+`拼接`str`

3. `\t`製表符

4. `<str>.lstrip(), <str>.rstrip(), <str>.strip()`，返回`str`左右兩端空格，不修改，修改另存儲爲`<str> = <str>.strip()`

5. `""`字符串可以換行，`''`字符串不可換行

6. `print(a, b)`的默認行爲是`a,<space>b\n`

7. `str`拼接需強轉`<strA> + str(10086) + <strB>`

8. `3 / 2 = 1, 3.0 / 2.0 = 1.5, 3.0 / 2 = 1.5, 3 / 2.0 = 1.5`

9. 列表`[elementA, elementB, ...]`

10. `<list>.append()`尾插，`<list>.insert(N)`索引處插入，索引及右右移一位，`<list>.del(N)`刪除索引，`<list>.pop()`彈出隊尾，`<list>.pop(N)`彈出索引

11. `<list>.remove()`根據值刪除元素

12. `<list>.sort()`永久排序，`<list>.sort(reverse=True)`逆序，`<list>.sorted()`返回臨時排序

13. `<list>.reverse()`永久翻轉

14. `<list>.len()`長度

15. `for element in list:`按引用訪問

16. `range(a,b,c)`：$[a,b)(step = c)$

17. 切片`<list>[a:b]`：$[a,b)$

18. `<listA> = <listB>`複製引用

19. Shallow copy:

    ```python
    import copy
    a = [1, 2, [3, 4]]
    b = a.copy()
    b = a[:]
    b = list(a)
    b = copy.copy(a)
    ```

    頂層元素修改不影響，修改嵌套的可變對象（比如`a[2].append(5)`）`b`也會改變

20. Deep copy:

    ```python
    a = [1, 2, [3, 4]]
    b = copy.deepcopy(a)
    ```

21. tuple：`(elementA, elementB)`，不可以修改元組的元素，但是可以重新定義整個元組（修改元組變量）

22. `not > and > or, ==, !=, >/<(=)`

23. 位運算：

    | 運算         | 名稱     |
    | ------------ | -------- |
    | `&`          | 按位與   |
    | `|`          | 按位或   |
    | `~`          | 按位非   |
    | `^`          | 按位抑或 |
    | `<< ` / `>>` | 左右位移 |

24. 位運算 > 比較運算 > 邏輯運算

25. 檢查元素是否在list中：`element (not) in <list, array, tuple> `，返回`True / False`

26. `if-elif-else`

27. 檢查列表是否爲空：`if <list>`，不爲空`True`，空`False`（It says this is Pytholic?）

28. 字典：`{key : value, key : value, ...}`，按`key`訪問`<dict>[key]`，添加元素`<dict.[new_key] = element`，創建空字典`dict = {}`，刪除元素`del <dict>[key]`

29. 遍歷字典：`for key, value in dict`

30. 遍歷字典所有鍵：`for key in dict.keys()`

31. 遍歷字典所有值：`for value in dict.values()`

32. 默認值同`cpp`全部放右側

33. 沒有函數重載

34. 函數傳遞整數、浮點、字符串、元組傳遞地址但是修改時會另外創建新對象，列表、字典、集合傳遞地址，修改時會直接修改元素

35. 禁止函數修改列表：將列表的副本傳遞給函數：`func(<list>[:])`（潛copy）

36. 傳遞任意數量的實參：

    ```python
    >>> def func(*args):
    ...     print(args)
    ...
    >>> func('A')
    ('A',)
    >>> func('B', 'C', 'D')
    ('B', 'C', 'D')
    ```

37. 傳遞任意數量的關鍵字實參：

    ```python
    >>> def func(**args):
    ...     profile = {}
    ...     for key, value in args:
    ...         dict[key] = value
    ...     return dict
    ```

38. 將函數存儲在模塊中：

    ```python
    # ./a.py
    def func_1():
        return # or `return None`
    # ./package/b.py
    def func_2():
        return
    # ./package/__init__.py
    # ./main.py
    import a
    import package.b
    ```

39. 子目錄相對導入：

    ```
    - PROJETC
    - main.py
    - c.py
    - package
      |- a.py
      |- b.py
    # b.py
    import .a
    import ..c
    ```

40. `from module import function`

41. `from module import function as func`

42. 類：

    ```python
    class cls():
        """description"""
        def __init__(a, b):
        	self.a = a
            self.b = b
        def func(self):
            return
    ```

43. 繼承：

    ```python
    class A():
        def __init__(a, b):
            self.a = a
            self.b = b
        def func():
            print("A")
            return
    class B():
        def __init__(a, b, c):
            super().__init__(a, b)
            self.c = c
        def func(): # super().func() is overrided
            super().func()
            print("B")
            return
    ```

44. 讀取文件：

    ```
    # hello.txt
    Hello World!
    ```

     ```python
     with open('hello.txt') as file_object:
         contents = file_object.read()
         print(contents)
     ```

    ```
    Hello World!
    
    ```

45. 關鍵字`with`在不需要訪問文件後將其關閉，也可使用`open(), close()`来控制儘管這是不推薦的

46. 文件訪問的路徑爲當前相對路徑

47. 逐行讀取：

    ```python
    with open('hello.txt') as file_obj:
        for line in file_obj:
            print(line)
    ```

    這樣會多出空行，因爲`line`的結尾有換行符，寫爲：`print(line.rstrip())`即可（？）

48. 創建一個包含文件各行內容的列表（只能在`with`內訪問文件對象，那麼在`with`外需要訪問的時候就需要用列表拷貝一份

    ```python
    with open('Hello.txt') as f:
        lines = f.readlines()
    for line in lines:
        print(line.rstrip())
    ```

49. 寫入文件：

    ```python
    with open("Bye.txt", 'w') as f:
        f.write("Bye World!")
    ```

    讀取：`'r'`，寫入：`'w'`，追加：`'a'`

50. 如果寫入的文件不存在，Python 將自動創建它

51. `write()`默認不寫入`\n`

52. 異常（神了，我`cpp`都沒學異常）

53. 存儲數據（使用`json`）（JavaScript Object Notation）

    使用`json.dump(), json.load()`：
    
    ```python
    import json
    numbers = [1, 0, 0, 8, 6]
    with open('data.json', 'w') as f:
        json.dump(numbers, f)
    ```
    
    ```python
    import json
    with open('data.json') as f:
        numbers = json.load(f)
    print(numbers)
    ```
    
    

##  標準庫


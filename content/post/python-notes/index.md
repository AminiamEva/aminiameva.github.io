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

   

3. `<str>.title()` 以首字母大寫返回每一個單詞，`<str>.upper()`大寫，`<str>.lower()`小寫

4. `+`拼接`str`

5. `\t`製表符

6. `<str>.lstrip(), <str>.rstrip(), <str>.strip()`，返回`str`左右兩端空格，不修改，修改另存儲爲`<str> = <str>.strip()`

7. `""`字符串可以換行，`''`字符串不可換行

8. `print(a, b)`的默認行爲是`a,<space>b\n`

9. `str`拼接需強轉`<strA> + str(10086) + <strB>`

10. `3 / 2 = 1, 3.0 / 2.0 = 1.5, 3.0 / 2 = 1.5, 3 / 2.0 = 1.5`

11. 列表`[elementA, elementB, ...]`

12. `<list>.append()`尾插，`<list>.insert(N)`索引處插入，索引及右右移一位，`<list>.del(N)`刪除索引，`<list>.pop()`彈出隊尾，`<list>.pop(N)`彈出索引

13. `<list>.remove()`根據值刪除元素

14. `<list>.sort()`永久排序，`<list>.sort(reverse=True)`逆序，`<list>.sorted()`返回臨時排序

15. `<list>.reverse()`永久翻轉

16. `<list>.len()`長度

17. `for element in list:`按引用訪問

18. `range(a,b,c)`：$[a,b)(step = c)$

19. 切片`<list>[a:b]`：$[a,b)$

20. `<listA> = <listB>`複製引用

21. Shallow copy:

    ```python
    import copy
    a = [1, 2, [3, 4]]
    b = a.copy()
    b = a[:]
    b = list(a)
    b = copy.copy(a)
    ```

    頂層元素修改不影響，修改嵌套的可變對象（比如`a[2].append(5)`）`b`也會改變

22. Deep copy:

    ```python
    a = [1, 2, [3, 4]]
    b = copy.deepcopy(a)
    ```

23. tuple：`(elementA, elementB)`，不可以修改元組的元素，但是可以重新定義整個元組（修改元組變量）

24. `not > and > or, ==, !=, >/<(=)`

25. 位運算：

    | 運算         | 名稱     |
    | ------------ | -------- |
    | `&`          | 按位與   |
    | `\|`         | 按位或   |
    | `~`          | 按位非   |
    | `^`          | 按位抑或 |
    | `<<` / `>>`  | 左右位移 |

26. 位運算 > 比較運算 > 邏輯運算

27. 檢查元素是否在list中：`element (not) in <list, array, tuple> `，返回`True / False`

28. `if-elif-else`

29. 檢查列表是否爲空：`if <list>`，不爲空`True`，空`False`（It says this is Pytholic?）

30. 字典：`{key : value, key : value, ...}`，按`key`訪問`<dict>[key]`，添加元素`<dict.[new_key] = element`，創建空字典`dict = {}`，刪除元素`del <dict>[key]`

31. 遍歷字典：`for key, value in dict`

32. 遍歷字典所有鍵：`for key in dict.keys()`

33. 遍歷字典所有值：`for value in dict.values()`

34. 默認值同`cpp`全部放右側

35. 沒有函數重載

36. 函數傳遞整數、浮點、字符串、元組傳遞地址但是修改時會另外創建新對象，列表、字典、集合傳遞地址，修改時會直接修改元素

37. 禁止函數修改列表：將列表的副本傳遞給函數：`func(<list>[:])`（潛copy）

38. 傳遞任意數量的實參：

    ```python
    >>> def func(*args):
    ...     print(args)
    ...
    >>> func('A')
    ('A',)
    >>> func('B', 'C', 'D')
    ('B', 'C', 'D')
    ```

39. 傳遞任意數量的關鍵字實參：

    ```python
    >>> def func(**args):
    ...     profile = {}
    ...     for key, value in args:
    ...         dict[key] = value
    ...     return dict
    ```

40. 將函數存儲在模塊中：

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

41. 子目錄相對導入：

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

42. `from module import function`

43. `from module import function as func`

44. 類：

    ```python
    class cls():
        """description"""
        def __init__(a, b):
        	self.a = a
            self.b = b
        def func(self):
            return
    ```

45. 繼承：

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

46. 讀取文件：

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

47. 關鍵字`with`在不需要訪問文件後將其關閉，也可使用`open(), close()`来控制儘管這是不推薦的

48. 文件訪問的路徑爲當前相對路徑

49. 逐行讀取：

    ```python
    with open('hello.txt') as file_obj:
        for line in file_obj:
            print(line)
    ```

    這樣會多出空行，因爲`line`的結尾有換行符，寫爲：`print(line.rstrip())`即可（？）

50. 創建一個包含文件各行內容的列表（只能在`with`內訪問文件對象，那麼在`with`外需要訪問的時候就需要用列表拷貝一份

    ```python
    with open('Hello.txt') as f:
        lines = f.readlines()
    for line in lines:
        print(line.rstrip())
    ```

51. 寫入文件：

    ```python
    with open("Bye.txt", 'w') as f:
        f.write("Bye World!")
    ```

    讀取：`'r'`，寫入：`'w'`，追加：`'a'`

52. 如果寫入的文件不存在，Python 將自動創建它

53. `write()`默認不寫入`\n`

54. 異常（神了，我`cpp`都沒學異常）

55. 存儲數據（使用`json`）（JavaScript Object Notation）

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

56. 列表推导式：

    ```python
    list[expr for var in iteratable_obj]
    ```

    ```python
    a = [x for x in range(5)]
    ```

    等价于：

    ```python
    a = []
    for x in range(5):
        a.append(x)
    ```

    约定：`for _ in range iteratable_object`表示不关心循环变量

    ```python
    [0] * 3 == [0] + [0] + [0] == [0, 0, 0]
    ```

    列表相加表示拼接列表

    因此创建一个$m\times n$的数组只需要：

    ```python
    a = [[0] * n for _ in range(m)]
    ```

    或者这样定义：

    ```python
    def matrix(m, n, val=0):
        return [val * n for _ in range(m)]
    a = matrix(3, 4, 1)
    ```

57. 判断值是否在`dict`中：

    ```python
    if value in dict.values():
        pass
    ```

    

##  標準庫

### math

```python
from math import *
sqrt(16) == 4.0
floor(3.3) == 3
cell(3.3) == 4
gcd(12, 18) == 6
lcm(4, 6) == 12
log(8, 2) == 3.0
log2(8) == 3.0
pi == 3.1415926...
inf == ∞
```

还有一些常见函数直接隶属Python：

```python
abs(-3) == 3
pow(2, 3) == 8.0
round(3.14159, 2) = 3.14
min()
max()
sum([1, 2, 3])
```

### random

```python
from random import *
random() # float in [0, 1)
randint(1, 10) # random integer in [1, 10] # note that it's right closed
randrange(10) # 0 ~ 9 # note that it's right open
choice([0, 1, 2]) # choose from randomly
shuffle(a) # shuffle randomly
sample(a, 3) # get a random sample of 3
seed(10086) # set seed
```

### time

```python
from time import *
t = time() # get UNIX timestamp
print(t)
```

time a programme

```python
start = time.perf_counter()
for i in range(1000000):
    pass
end = time.perf_counter()
print(end - start) # seconds
```

sleep：

```python
sleep(1) # sleep for 1s
```

### datetime

```python
import datetime
now = datetime.now()
print(now)
print(now.year)
print(now.month)
print(now.day)
print(now.hour)
```

```python
2026-09-02 08:43:21.310003
2026
9
2
8
```

同样还有：`now.minute, now.second`

创建时间：

```python
dt = datetime.datetime(2026, 9, 2, 22, 30)
```

时间差：

```python
now = datetime.datetime.now()
tomorrow = now + timedelta(days=1)
```

格式化：

```python
now.strftime("%Y-%m-%d %H:%M:%S")
```

解析字符串：

```python
datetime.strptime(
	"2026-09-02 08:50:29",
    "%Y-%m-%d %H-%M-%S"
)
```

### collections

#### `deque`

```python
from collections import deque
q = deque([1, 2, 3])
q.append(4)
q.appendleft(0)
q.pop()
q.popleft()
```

#### `Counter`

统计元素出现次数：

```python
from collections import Counter
cnt = Counter("hello")
print(cnt)
print(cnt["l"])
```

#### `defaultdict`

```python
from collections import defaultdict
d = defaultdict(list)
d["a"].append(1)
d["a"].append(2)
d["b"].append(3)
```

普通`dict`访问不存在的`key`会报错，`defaultdict`可以自动创建默认值

比如计数：

```python
cnt = defaultdict(int)
for x in [1, 2, 2, 3]:
    cnt[x] += 1
```

### `itertools`

迭代器工具

排列：

```python
>>> from itertools import permutations
>>> list(permutations([1, 2, 3]))
[(1, 2, 3), (1, 3, 2), (2, 1, 3), (2, 3, 1), (3, 1, 2), (3, 2, 1)]
```

组合：

```python
>>> from itertools import combinations
>>> list(combinations([1, 2, 3, 4], 2))
[(1, 2), (1, 3), (1, 4), (2, 3), (2, 4), (3, 4)]
```

笛卡儿积：

```python
>>> from itertools import product
>>> list(product([0, 1], repeat=3))
[(0, 0, 0), (0, 0, 1), (0, 1, 0), (0, 1, 1), (1, 0, 0), (1, 0, 1), (1, 1, 0), (1, 1, 1)]
```

其他：

```python
itertools.chain(...)
itertools.accumulate(...)
itertools.repeat(...)
itertools.count(...)
```

### `heapq`

堆（默认小根堆）

### `bisect`

在有序序列中二分

### `functools`

函数工具，最常见是缓存：

```python
from functools import cache

@cache
def f(n):
    if n <= 1:
        return n
    return f(n - 1) + f(n - 2)
```

`@cache`会自动缓存函数结果

### operator

操作函数：

```python
from operator import add
add(2, 3)
```

常用于排序：

```python
from operator import itemgetter
a = [
	("A", 20),
	("B", 18),
	("C", 22)
]
a.sort(key=temgetter(1))
```

### `string`

字符串常量

```python
import string
string.ascii_lowercase # abcdefghijklmnopqrstuvwxyz
string.ascii_uppercase # ABCDEFGHIJKLMNOPQRSTUVWXYZ
string.digits # 0123456789
```

### `re`

正则表达式

### `os`

操作系统

获取当前目录：

```python
import os
os.getcwd()
```

查看文件：

```python
os.listdir(".")
```

创建目录：

```python
os.mkdir("hello")
```

环境变量：

```python
os.environ["PATH"]
```

尽管现代 Python 更推荐用`pathlib`处理路径

### `pathlib`

文件路径

```python
>>> from pathlib import Path
>>> p = Path("data/test.txt")
>>> print(p.exists())
True
>>> print(p.name)
test.txt
>>> print(p.stem)
test
>>> print(p.suffix)
.txt
```

创建路径：

```python
p = Path("data") / "test.txt"
```

遍历文件：

```python
for p in Path(".").glob("*.py"):
    print(p)
```

递归查找：

```python
Path(".").rglob("*.py")
```

### `sys`

Python 运行环境

命令行参数：

```python
import sys
print(sys.argv)
```

标准输入：

```python
input = sys.stdin.readline
```

标准输出：

```python
print("Hello", file=sys.stdout)
```

退出程序：

```python
sys.exit()
```

运行外部程序：

```python
import subprocess
subprocess.run(["git", "status"])
```

### `copy`

浅复制：`copy.copy()`，深复制：`copy.deepcopy()`

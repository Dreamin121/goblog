---
title: 时间复杂度的分析
date: 2022-11-25 21:41:10
tags:
- code     
- 算法题
categories: 
- 算法
---

## 算法分析

### 时间复杂度分析

**事后分析估算方法**

当执行程序时，想要计算时间最比较容易联想到的方法就是拿个定时器进行计时，但是这个方法有个缺陷：就是机器性能问题很影响计算的时间，两台不同机器运算的时间结果天差地别，所以我们需要采用下面所说的方法更可科学的估算出算法的执行时间。

**事后分析估算方法**

计算机程序在计算机上运行所消耗的时间取决于下列因素：

+ 算法采用的策略和方案
+ ~~编译产生的代码质量~~
+ 问题的输入规模（输入量的多少）
+ ~~机器执行指令的速度~~

抛开上面的软硬件（程序员无法干预）的问题，那么我们可以知道一个软件的运行时间就是依赖于算法的好坏的问题的输入规模。如果算法固定，那么算法的执行时间就只和问题的输入规模有关系了。

EG.分析下面两个算法的执行次数

```java
//利用一层for循环来执行
public class main {
    public static void main(String[] args) {
        int sum = 0;
        int n = 100;
        for (int i = 0; i <= n; i++) {
            sum += i;
        }
        System.out.println(sum);
    }
}
```

```java
//利用等差数列来执行
public class main {
    public static void main(String[] args) {
        int sum = 0;
        int n = 100;
        sum = (n+1)*n/2;
        System.out.println(sum);
    }
}
```

通过以上我们不难分析，同样的一个等差和的算法，两个程序执行的次数并不相同，第一个执行了n次，而第二个只执行了1次，当n足够大时，第二个算法的运行速度远远高于另一个的速度，这个时候就体现了一个优秀算法将大大优化程序的运行时间。

要分析时间复杂度（也即程序运行的时间）的时候我们只需要关心核心操作的次数和输入规模的关联情况。`sum += i;`和`sum = (n+1)*n/2;`很明显为程序的核心计算部分，所以我们可以得出第一个`sun += i` 执行了n次，所以时间复杂度为O(n)，而`sum = (n+1)*n/2;`执行了1次，则时间复杂度为O(1)。

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211252114396.png" alt="image-20221125211412336" style="zoom:33%;" />

#### 函数渐进增长

下面给出算法测试来计算不同函数执行次数的问题。

> EG1：假设测试输入规模都是n，分别执行四个算法，可得到下面结果

![image-20221125213058541](https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211252130586.png)

可以看出，前期时候某些算法的执行次数可以优于其他算法，但是到n取一定大小时，可以渐进增大

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211252138943.png" alt="image-20221125213804883" style="zoom:50%;" />

由此图可以得出结论：**随着输入规模的增大，算法的操作次数趋同，常数操作可以忽略不计。**

> EG2：引入平方根的算法次数分析

![image-20221125213213838](https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211252132884.png)

可以看出：次方才是影响算法执行次数的最大因素

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211252155016.png" alt="image-20221125215539955" style="zoom:50%;" />

由此图可以得出结论：**随着输入规模的增大，与最高次项相乘的常数可以忽略。**

> EG3：不同次方根的执行次数

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211252202991.png" alt="image-20221125220243943" style="zoom: 67%;" />

由此图可以得出结论：**最高次项的指数大的，随着n的增长，结果也会增长特别快。**

> EG4:函数不同次幂的情况

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211252206239.png" alt="image-20221125220634188" style="zoom: 50%;" />

由此图可以得出结论：**算法函数的最高次幂越小，算法效率越高。**

##### 总结:sake:

> 算法随着输入规模的增长量增大，可以有以下规则

1. 常数可以忽略

2. 最高次幂的常数因子可以忽略

3. 最高次幂越小，算法效率越高

#### 大O记法

在进行算法分析时，语句总的执行次数T(n)是关于问题规模n的函数，进而分析T()n随着n的变化情况并确定T(n)的量级。算法的时间复杂度，就是算法的时间量度，记作：T(n)=O(f(n))。它表示随着问题规模n的增大，算法执行时间的增长率和f(n)的增长率相同，称作算法的渐近时间复杂度，简称时间复杂度，其中f(n)是问题规模n的某个函数。

我们需要明确一个事情：执行次数=执行时间

用大写O()来体现算法时间复杂度的记法，我们称之为大O记法,下面给出例子：

> EG1

```java
public class main {
    public static void main(String[] args) {
        int sum = 0; //执行了1次
        int n = 100; //执行了1次
        sum = (n+1)*n/2; //执行了1次
        System.out.println(sum);
    }
}
```

> EG2

```java
public class main {
    public static void main(String[] args) {
        int sum = 0; //执行了1次
        int n = 100; //执行了1次
        for (int i = 0; i <= n; i++) {
            sum += i; //执行了n次
        }
        System.out.println(sum);
    }
}
```

> EG3

```java
public class main {
    public static void main(String[] args) {
        int sum = 0; //执行了1次
        int n = 100; //执行了1次
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= n; j++) {
                sum += i; //执行了n^2次
            }
        }
        System.out.println(sum);
    }
}
```

忽略输入输出语句的执行次数，当输入规模为n时，三个算法の执行次数为：

EG1：3次

EG2：n+3次

EG3：n^2+3次

通过**函数渐进增长**的分析，大O阶的表示法有以下几个规则可以使用：

1. 用常数1取代运行时间中的所有加法常数
2. 在修改后的运行次数中，只保留高阶项
3. 如果最高阶项存在，且常数因子不为1，则去除与这个项相乘的常数

所以，以上算法的大O记法为：

EG1：O(1)

EG2：O(n)

EG3：O(n^2)

##### 常见大O阶

**线性阶**

一般含有非嵌套循环，线性阶随着输入规模的扩大，对应计算的次数呈直线增长。

> EG 时间复杂度为O(n)

```java
public class main {
    public static void main(String[] args) {
        int sum = 0;
        int n = 100;
        for (int i = 0; i < n; i++) {
            sum += i;
        }
        System.out.println(sum);
    }
}
```

**平方阶**

一般嵌套循环属于这种时间复杂度

> EG 时间复杂度为O(n^2)

```java
public class main {
    public static void main(String[] args) {
        int sum = 0;
        int n = 100;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                sum += j;
            }
        }
        System.out.println(sum);
    }
}
```

**立方阶**

三层嵌套循环术语这种时间复杂度

> EG 时间复杂度为O(n^3)

```java
public class main {
    public static void main(String[] args) {
        int sum = 0;
        int n = 100;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < n; k++) {
                    sum += j;
                }
            }
        }
        System.out.println(sum);
    }
}
```

**对数阶**

看下面程序，每次sum*2之后，就距离n更近一步，因为是2^sum=n,所以得到x=log(2)n,所以这个循环的时间复杂度为O(logn)

> EG 时间复杂度为O(logn)

```java
public class main {
    public static void main(String[] args) {
        int sum = 1;
        int n = 100;
        while(sum < n) {
            sum = sum * 2;
        }
        System.out.println(sum);
    }
}
```

对于对数阶，随着n的增大，不管底数为多少，他们的增长趋势是一样的，所以忽略底数

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211261201078.png" alt="image-20221126120145984" style="zoom:50%;" />

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211261214740.png" alt="image-20221126121404669" style="zoom:50%;" />

**常数阶**

一般不涉及循环操作的都是常数阶，因为不会随着n的增长而增加操作次数。

> EG 时间复杂度为O(1)

```java
public class main {
    public static void main(String[] args) {
        int sum = 0;
        int n = 100;
        sum = (n+1)*n/2;
        System.out.println(sum);
    }
}
```

##### 常见时间复杂度

| 描述     | 增长的数量级 | 说明     | 举例           |
| -------- | ------------ | -------- | -------------- |
| 常数级别 | 1            | 普通语句 | 两数相加       |
| 对数级别 | log(n)       | 二分策略 | 二分查找       |
| 线性级别 | n            | 循环     | 找出最大元素   |
| 线性对数 | Nlog(n)      | 分治思想 | 归并排序       |
| 平方级别 | n^2          | 双层循环 | 检查所有元素对 |
| 立方级别 | n^3          | 三层循环 | 检查所有三元组 |
| 指数级别 | 2^n          | 穷举查找 | 检查所有子集   |

> 复杂程度从低到高为 O(1)<O(logn)<O(nlogn)<O(n^2)<O(n^3)

从前面的折线图不难看出，随着输入规模的增大，时间成本会急剧增大，所以当算法的时间复杂度为平方、立方或者更复杂时，我们可以认为该算法为不可取的，需要进行优化。

#### 最坏情况

> EG判断下面循环执行的次数

```java
public class main {
    public static void main(String[] args) {
        int num = ?;
        int[] arr = {1,2,3,4,5,6,7,8,9};
        for (int i = 0; i < arr.length; i++) {
            if(num == arr[i]){
                System.out.println("该循环执行了"+i+"次");
                return;
            }
        }
    }
}
```

**最好情况**

​		查找的第一次数字就是期望的数字，那么算法的时间复杂度为O(1)

**最坏情况**

​		查找的最后一个数字才是期望的数字，那么算法的时间复杂度为O(n)

**平均情况**

 		任何数字查找的平均成本时O(n/2)

最坏情况是一种保证，在应用中，这是一种最基本的保障，即使在最坏情况下，也能够正常提供服务，所以，除非特别指定，不然提到的运行时间都指的是**最坏**情况下的运行时间。




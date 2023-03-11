---
title: Java sorting algorithm Sort source analysis
date: 2022-12-05 11:11:10
tags:
- Java
- code
categories: 
- 算法
---


## 排序算法

学习了数据结构与算法，作为最不能忽略的排序算法，排序可谓门类很多，主要常见的有以下几类：

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211281609568.png" alt="img" style="zoom: 50%;" />

**关于时间复杂度：**

1. 平方阶 (O(n2)) 排序 各类简单排序：直接插入、直接选择和冒泡排序。
2. 线性对数阶 (O(nlog2n)) 排序 快速排序、堆排序和归并排序；
3. O(n1+§)) 排序，§ 是介于 0 和 1 之间的常数。 希尔排序
4. 线性阶 (O(n)) 排序 基数排序，此外还有桶、箱排序。

**关于稳定性**：

1. 稳定的排序算法：冒泡排序、插入排序、归并排序和基数排序。

2. 不是稳定的排序算法：选择排序、快速排序、希尔排序、堆排序。

## Java的sort()包

本文主要讲的是JAVA内置排序`Arrays.sort()`实现的排序的类型。

Java开发中，经常需要进行数组和链表的各种操作，所以数组和链表的排序是重中之重。

`Collections.sort()`方法用来对链表排序，而`Collections.sort()`的底层，其实使用的也是`Arrays.sort()`方法。JAVA内置排序的核心类，都在于Arrays工具类，接下来也重点剖析该类。

### Arrays的工具类

打开JDK9的包先看看Arrays中的sort()方法种类。

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211281720162.png" alt="image-20221128172038129" style="zoom:50%;" />



> 从排序的**范围**角度划分，分为了以下：

1. 针对数组的整体做排序的方法，如
   - `sort(int[] a)`
   - `sort(Object[] a)`
   - `sort(T[] a, Comparator<? super T> c)`
2. 针对数组的局部做排序的方法，如
   - `sort(int[] a, int fromIndex, int toIndex)`
   - `sort(Object[] a , int fromIndex, int toIndex)`
   - `sort(T[] a, int fromIndex, int toIndex,Comparator<? super T> c)`

> 从排序的**类型**角度划分，分为了以下：

1. 对数组按照默认升序的方式进行排序的方法，如
   - `sort(int[] a)`
   - `sort(Object[] a)`
   - `sort(int[] a, int fromIndex, int toIndex)`
   - `sort(Object[] a , int fromIndex, int toIndex)`
2. 对数组按照自定义排序类型进行排序的方法，如
   - `sort(T[] a, Comparator<? super T> c)`
   - `sort(T[] a, int fromIndex, int toIndex,Comparator<? super T> c)`

> 从**操作对象**的角度划分，分为了以下：

1. 对基本类型（byte，int，char等）数组操作的方法
   - `sort(int[] a)`
   - `sort(int[] a, int fromIndex, int toIndex)`
2. 对对象类型（object）数组操作的方法
   - `sort(Object[] a)`
   - `sort(Object[] a , int fromIndex, int toIndex)`
   - `sort(T[] a, Comparator<? super T> c)`
   - `sort(T[] a, int fromIndex, int toIndex,Comparator<? super T> c)`

> 小总结：

最重要的划分是从操作对象的角度进行划分，因为Java对不同类型的数组，实现了不同的实现方法。下面进行分析：

### 基本数据类型的排序

基本数据类型数组对应不同长度时使用的排序算法：

1. 当长度小于47时，采用**插入排序**算法。
2. 当长度介于47以及286中间时，先判断数组是否具备特定结构，如果具备，采用**快速排序**，不具备时采用一种优化形式：**双轴快排**算法。
3. 当长度大于286时，有特定结构的话，就是使用**归并排序**算法。

下图为总结：

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211281746963.png" alt="up-205a0fbd3c9218e765bbbd1a17947a400d9" style="zoom: 67%;" />



### 是否有具有特定结构

在判断是否使用归并排序前，要先判断数组是否具备特定结构，怎么进行判断呢，首先看源码：

```Java
// Check if the array is nearly sorted
    for (int k = left; k < right; run[count] = k) {        
        if (a[k] < a[k + 1]) { // ascending
            while (++k <= right && a[k - 1] <= a[k]);
        } else if (a[k] > a[k + 1]) { // descending
            while (++k <= right && a[k - 1] >= a[k]);            
            	for (int lo = run[count] - 1, hi = k; ++lo < --hi; ) {                
                    int t = a[lo]; a[lo] = a[hi]; a[hi] = t;
            }
        } else { // equal
            for (int m = MAX_RUN_LENGTH; ++k <= right && a[k - 1] == a[k]; ) {                
                if (--m == 0) {
                    sort(a, left, right, true);                    
                    return;
                }
            }
        }        /*
         * The array is not highly structured,
         * use Quicksort instead of merge sort.
         */
        if (++count == MAX_RUN_COUNT) {
            sort(a, left, right, true);            
            return;
        }
    }
```

大概逻辑就是：每个降序序列为一个组。像`1,9,8,7,6,8`，9到6是降序，为一组，称为降序组，将其组成升序`1,6,7,8,9,8`,最后再从8往后找下一组降序组。

每次遇到一个降序组，count都会进行++count的操作，当count的值大于MAX_RUN_COUNT(也即67)时，判定这个数组不具备特定结构，就是说数组的数据时升时降，还是比较适合采用**快速排序**。反之，小于67的时候，则证明该数组有特定结构，就继续采用**归并排序**。

### 对象类型数组的排序

对象类型对应不同长度时使用的排序算法：

1. 如果对象数组的长度小于32，采用不包含并操作的**mini-TimSort**算法。
2. 如果对象数组的长度大于31，采用完整的**TimSort算法**。

**TimSort算法**

这是一种结合了归并排序和插入排序的混合排序算法，设计初衷是为了在真实世界中的各种数据中可以由较好的性能。

基本的运行过程：

1. 扫描数组，确定其中的单调上升段和严格单调下降段，将严格下降段反转。我们将这样的段称之为run。
2. 定义最小run长度，短于此的run通过插入排序合并为长度高于最小run长度；
3. 反复归并一些相邻run，过程中需要避免归并长度相差很大的run，直至整个排序完成；
4. 如何避免归并长度相差很大run呢， 依次将run压入栈中，若栈顶run X，run Y，run Z 的长度违反了X>Y+Z 或 Y>Z 则Y run与较小长度的run合并，并再次放入栈中。 依据这个法则，能够尽量使得大小相同的run合并，以提高性能。注意Timsort是稳定排序故只有相邻的run才能归并。
5. Merge操作还可以辅之以galloping，具体细节可以自行研究。

timsort是工业级算法，其混用插入排序与归并排序，二分搜索等算法，亮点是充分利用待排序数据可能部分有序的事实，并且依据待排序数据内容动态改变排序策略——选择性进行归并以及galloping。

### 不同的算法对于效率的影响

对于较小长度的数组，采用时间复杂度为O(n^2)的插入排序无伤大雅，毕竟n很小，排序的性能也高于快速排序。但是在n较大的情况下，归并排序和快速排序都是性能较优秀的算法，平均时间复杂度都在O(nlogn)之间，区别在于归并排序较为稳定。

对于基本数组类型，稳定性没有太大意义，所以可以使用不稳定的快排，但是对于对象类型，稳定性是比较重要的，对象相等的复杂性让我们没办法保证每个人都回重写正确的equal方法，故使用稳定算法的归并排序和插入排序结合的TimSort算法。

对于归并排序来说，比较次数比快速排序少，移动次数比快排多，而对于对象来说，比较是相对耗时的操作，所以并不适合快排，对于基本数据类型来说，比较和移动都不怎么耗时，所以用归并和快速都可以。

> All in All

基本数据类型数组使用快排+归并:

1. 基本数据类型无所谓稳定性，可以采用非稳定的快排
2. 对于基本数据类型来说，比较和移动都不怎么耗时，所以用归并或者快排都可以

对象数据类型不使用快排:

1. 对象数据类型要求稳定性，需要采用稳定的归并+插入
2. 对于对象来说，比较操作相对耗时，所以用比较操作较少的归并排序

## 三种排序详解

### 插入排序

**1. 基本思想**

> 将整个序列分为两部分：前面 `i` 个元素为有序序列，后面 `n - i` 个元素为无序序列。每一次排序，将无序序列的第 `1` 个元素，在有序序列中找到相应的位置并插入。

**2. 算法步骤**

1. 第 `1` 趟排序：
   1. 第 `1` 个元素为有序序列，后面第 `2` ~ `n `个元素（总共 `n - 1` 个元素）为无序序列。
   2. 从右至左遍历有序序列中的元素，如果遇到「有序序列的元素 > 无序序列的第 `1` 个元素」的情况时，则将向有序序列的元素后移动一位。
   3. 如果遇到「有序序列的元素 <= 无序序列的第 `1` 个元素」的情况或者「到达数组开始位置」时，则说明找到了插入位置。将「无序序列的第 `1` 个元素」插入该位置。
2. 第 `2` 趟排序：
   1. 第 `1` ~ `2` 个元素为有序序列，后面第 `3` ~ `n` 个元素（总共 `n - 2` 个元素）为无序序列。
   2. 从右至左遍历有序序列中的元素，如果遇到「有序序列的元素 > 无序序列的第 `1` 个元素」的情况时，则将向有序序列的元素后移动一位。
   3. 如果遇到「有序序列的元素 <= 无序序列的第 `1` 个元素」的情况或者「到达数组开始位置」时，则说明找到了插入位置。将「无序序列的第 `1` 个元素」插入该位置。
3. 依次类推，对剩余 `n - 3` 个元素重复上述排序过程，直到所有元素都变为有序序列，则排序结束。

简单来说，插入排序的算法步骤为：

1. 先将第 `1` 个元素作为一个有序序列，将第 `2` ~ `n` 个元素作为无序序列。
2. 从左到右遍历一遍无序序列，对于无序序列中的每一个元素：
   1. 遍历有序序列，找到适当的插入位置。
   2. 将有序序列中插入位置右侧的元素依次右移一位。
   3. 将该元素插入到适当位置。

 **3. 动画演示**

![img](https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202212051952620.gif)

**4. 算法分析**

+ 最佳时间复杂度：O(n)
+ 最差时间复杂度：O(n^2)
+ 平均时间复杂度：O(n^2)
+ 稳定性：稳定

**5. 代码实现**

```java
public void toInsertSort(int []arr) {
	for(int i = 1; i<arr.length;i++) {	    //i是当前数
		for(int j = i-1 ; j>=0;j--) {	   //j是从i-1开始向前移动，并每次与arr[i]判断大小
			if(arr[i]<arr[j]) {		     //如果arr[i]小于arr[j]说明arr[i]当前至少是要插入到arr[j]的前面
				int temp = arr[j];
				arr[j] = arr[i];
				arr[i] = temp;
				i = j-1;		     //互换后i也要向前移动一位
			}
			else{
				break;              //直到arr[i]比arr[j]大，因为前面从小到大已经排好序，所以没有必要继续向前判断了					
			}
		}
	}
}
```

### 快速排序

**1. 基本思想**

> 通过一趟排序将无序序列分为独立的两个序列，第一个序列的值均比第二个序列的值小。然后递归地排列两个子序列，以达到整个序列有序。

**2. 算法步骤**

1. 从序列中找到一个基准数 `point`（这里以当前序列第 `1` 个元素作为基准数，即 `point = arr[low]`）。
2. 使用双指针，将序列中比基准数大的元素移动到基准数右侧，比他小的元素移动到基准数左侧：
   1. 使用指针 `i`，指向当前需要处理的元素位置，需要保证位置 `i` 之前的元素都小于基准数。初始时，`i` 指向当前序列的第 `2` 个元素位置。
   2. 使用指针 `j` 遍历当前序列，如果遇到 `arr[j]` 小于基准数 `point`，则将 `arr[j]` 与当前需要处理的元素 `arr[i]` 交换，并将 `i` 向右移动 `1` 位，保证位置 `i` 之前的元素都小于基准数。
   3. 最后遍历完，此时位置 `i` 之前的元素都小于基准数，第 `i - 1` 位置上的元素是最后一个小于基准数 `point` 的元素，此位置为基准数最终的正确位置。将基准数与该位置上的元素进行交换。此时，基准数左侧都是小于基准数的元素，右侧都是大于等于基准数的元素。
   4. 然后将序列拆分为左右两个子序列。
3. 对左右两个子序列分别重复第 `2` 步，直到各个子序列只有 `1` 个元素，则排序结束。

**3. 动画演示**

![img](https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202212052003794.gif)

**4. 算法分析**

+ 最佳时间复杂度：O(n*log2(n))
+ 最差时间复杂度：O(n^2)
+ 平均时间复杂度：O(n*log2(n))
+ 稳定性：不稳定

**5. 代码实现**

```java
public int sortPointer(int[] nums, int low, int high) {
        //定义基准数
        int point = nums[high];
        //定义第二指针元素
        int pointer = low;
        //将指针前后开并记录第二指针的位置
        for (int i = low; i < high; i++) {
            if (center >= nums[i]) {
                int temp = nums[i];
                nums[i] = nums[pointer];
                nums[pointer] = temp;
                pointer++;
            }
        }
        //返回第二指针的位置
        int temp = nums[pointer];
        nums[pointer] = nums[high];
        nums[high] = temp;
        return pointer;
    }

    public void quickSort(int[] nums, int low, int high) {
        //运用递归的方式进行重复操作
        if (low < high) {
            int position = sortPointer(nums, low, high);
            quickSort(nums, low, position - 1);
            quickSort(nums, position + 1, high);
        }
    }
}
```

### 归并排序

**1. 基本思想**

> 采用经典的分治策略，先递归地将当前序列平均分成两半。然后将有序序列两两合并，最终合并成一个有序序列。

**2. 算法步骤**

1. 分割过程：将当前序列平均分成两半，直到子序列长度为 1。
   1. 在一个数组长度为n的数组中找到序列中心位置 `mid`，从中心位置将序列分成左右两个子序列。
   2. 对左右两个子序列分别进行递归分割。
   3. 最终将数组分割为 n 个长度均为 1 的有序子序列。
2. 归并过程：从长度为 1 的有序子序列开始，依次进行两两归并，直到合并成一个长度为 n 的有序序列。
   1. 使用数组变量 `arr `存放归并后的有序数组。
   2. 使用两个指针分别指向两个有序子序列 的开始位置。
   3. 比较两个指针指向的元素，将两个有序子序列中较小元素依次存入到结果数组 `arr` 中，并将指针移动到下一位置。
   4. 重复步骤 3，直到某一指针到达子序列末尾。
   6. 返回归并后的有序数组 `arr`。

**3. 动画演示**

![img](https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202212052023716.gif)

1. 初始序列为 `[6, 2, 1, 3, 7, 5, 4, 8]`。
2. 将序列分解为 `[6, 2, 1, 3]`，`[7, 5, 4, 8]`。
3. 将序列分解为 `[6, 2]`，`[1, 3]`，`[7, 5]`，`[4, 8]`。
4. 将序列分为为 `[6]`，`[2]`，`[1]`，`[3]`，`[7]`，`[5]`，`[4]`，`[8]`。
5. 将序列看做是 `8` 个长度为 `1` 的子序列，即 `[6]`，`[2]`，`[1]`，`[3]`，`[7]`，`[5]`，`[4]`，`[8]`。
6. 第 `1` 趟排序：将子序列中的有序子序列两两归并，归并后的子序列为：`[2, 6]`，`[1, 3]`，`[5, 7]`，`[4, 8]`。
7. 第 `2` 趟排序：将子序列中的有序子序列两两归并，归并后的子序列为：`[1, 2, 3, 6]`，`[4, 5, 7, 8]`。
8. 第 `3` 趟排序：将子序列中的有序子序列两两归并，归并后的子序列为：`[1, 2, 3, 4, 5, 6, 7, 8]`。得到长度为 `n` 的有序序列，排序结束。

**4. 算法分析**

+ 时间复杂度：O(n×log(2)⁡n)
  + 归并排序算法的时间复杂度等于归并趟数与每一趟归并的时间复杂度乘积。递归分解的次数为O（log(2)⁡n)，而子算法 `merge(int[] array,int start,int mid, int end)`的时间复杂度是 O(n)，因此，归并排序算法总的时间复杂度为 O(n×log2⁡n)

+ 空间复杂度：O(n)
+ 稳定性：稳定
  + 因为在两个有序子序列的归并过程中，如果两个有序序列中出现相同元素，归并排序能够使前一个序列中那个相同元素先被复制，从而确保这两个元素的相对次序不发生改变。

**5. 代码实现**

```java
class Solution {
    public int[] sortArray(int[] nums) {
        sortArray(nums,0,nums.length-1);
        return nums;
    }
    public void merge(int[] array,int start,int mid, int end) {
        //创建一个临时数组储存排序后的数组
        int[] temp = new int[array.length];
        //用于遍历临时数组的指针
        int k = 0;
        //指向数组开头的指针
        int i = start;
        //指向另一半数组的指针
        int j = mid + 1;
        while(i <= mid && j <= end) {
            //较小的元素存在数组的前面，较大的放在后面对应的位置
            if(array[i] <= array[j]) {
                temp[k++] = array[i++];
            } else {
                temp[k++] = array[j++];
            }
        }
        //将不整除时多余的元素放置于数组后面
        while(i <= mid) {
            temp[k++] = array[i++];
        }
        while(j <= end) {
            temp[k++] = array[j++];
        }
        //临时数组赋值回原数组中
        for (int l = 0; l < k; l++) {
            array[l + start] = temp[l];
        }
    }

    public void sortArray(int[] array,int start,int end) {
        //运用递归的方式进行归并排序
        if(start >= end) return;
        int mid = (start + end) / 2;
        sortArray(array,start,mid);
        sortArray(array,mid + 1,end);
        merge(array,start,mid,end);
    }
}
```






## 参考

[完整的排序算法分类](https://sort.hust.cc/)

[Collection.sort()源码分析](https://www.imooc.com/article/257268)

[JAVA内置排序Arrays.sort实现简述](https://cherish-ls.github.io/2020/10/14/JAVA%E5%86%85%E7%BD%AE%E6%8E%92%E5%BA%8FArrays-sort%E5%AE%9E%E7%8E%B0%E7%AE%80%E8%BF%B0/)

[数组排序分析](https://algo.itcharge.cn/01.Array/02.Array-Sort)

[排序算法题目](https://www.yuque.com/dreamin-c68j9/hwyqcg/gydluo?#)
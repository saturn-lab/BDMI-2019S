# BDMI学习日志

作者: 洪昊昀

日期：2019年7月15日

## Abstract

之前对这门课程的期望就是希望能得到丰富的资源，可以在小学期的课下自己探索一些，毕竟实践证明，找真正有用的资源还是非常费时间的，如果有前辈引路绝对是事半功倍，而且自己亲手尝试过的知识或技巧才会记忆最深刻。今天虽然只是第一次节课，但已经得到了很多非常棒的资源了，比如教程还有各种工具，~~这样就不用自己找到昏天黑地了嘻嘻~~。然后看到课程`wiki`上需要同学写学习日志更到`GitLab`上,那么就写一写记录自己的学习过程吧.

## 1

首先需要搭建`GIT`环境，下载`Git GUI`，之前和同学们一起写大作业时用`GitHub`托管代码时下载过，但是因为有小白专用`GitHub Desktop`所以没有管过`Git GUI`的用法，但是今天一用确实真的很好用哇 >.<，短短一行代码解决下载、解压缩等工序，直接在给定目录下创建`master`单层文件夹，便于pull、push等操作（感觉可以不用`GitHub Desktop`了（小声））~

## 2

然后就是安装超好用的`markdown`的editor`Typora`啦~它真的是非常轻量级，一会儿就安装好啦，而且界面简介美观，并且比我常用的`VSCode`的`markdown`功能要更用户友好（毕竟`Typora`是专业做`markdown`的嘛），感觉已经结合了`markdown`的“所码及所得”和`word`“所见即所得的”的优点了，这篇就是用`Typora`写的~

## 3

因为之前做SRT的时候用过一点python，所以环境的配置已经有了，但是这个暑期小学期后面的程序训练课程才会有用python做的项目，所以目前python的语法什么的不是很熟，总之就是比较菜，也希望通过这门课程提升一些为后续做准备啦。python+Jupiter notebook的用法十分有趣，是第一次使用，感觉用起来十分便捷（挺想以后找个时间搞懂Jupiter到底是怎么办到的）~AI云还有pizza之前就注册过了，有GPU cluster给我们用，而且还不用再去装ubuntu双系统也不用总去小虚拟机或者wsl里倒腾了，十分愉快~

## 4

环境配置完成了，然后就进入知识点学习了。今天陈老师讲解的数据结构初步我还算熟悉，不过关于各种树的具体内容就需要在下学期的数据结构课里学了，现在能先学一些也是极好的。这个学期OOP大作业中，我们组写了一个数据库，然而。。。在隐藏测试点中就出现了RE还有TLE，我一直对真正的数据库中数据的存储方式和检索方式感到好奇，从基础开始讲可以更好地拨开我心中的迷雾，感觉体验还是很不错滴。关于排序算法，虽然用C/C++写是完全没有问题，但是python就不太一样了，所以就顺便把今天上课提到的各种排序算法的python实现放在下面了，小白课后自己又码了一遍，~~亲测能跑~~。

### insert sort

```python
def insert_sort(array):
    length = len(array)
    for i in range(1, length):
        a = array[i]
        for j in range(i, -1, -1):
            if a < array[j - 1]:
                array[j] = array[j - 1]
            else:
                break
        array[j] = a

array = [100, 1, 3, 95, 7, 10001]
insert_sort(array)
print(array)
```

### quick sort

```python
def quick_sort(lst, low, high):
    i = low
    j = high
    if i >= j:
        return lst
    pivot = lst[i]
    while i < j:
        while i < j and lst[j] >= pivot:
            j = j-1
        lst[i] = lst[j]
        while i < j and lst[i] <= pivot:
            i = i+1
        lst[j] = lst[i]
    lst[i] = pivot
    quick_sort(lst, low, i-1)
    quick_sort(lst, j+1, high)
    return lst

lst = [100, 10, 3, 95, 70000, 10001]
quick_sort(lst,0,len(lst)-1)
print(lst)
```

### merge sort

```python
def merge(array, left, mid, right):
    len1 = mid - left + 1
    len2 = right - mid
    left_list = [0] * (len1)
    right_list = [0] * (len2)
    for i in range(0, len1):
        left_list[i] = array[left + i]
    for i in range(0, len2):
        right_list[i] = array[mid + 1 + i]
    k = left
    i = 0
    j = 0
    while i < len1 and j < len2:
        if left_list[i] <= right_list[j]:
            array[k] = left_list[i]
            i += 1
        else:
            array[k] = right_list[j]
            j += 1
        k += 1

    while i < len1:
        array[k] = left_list[i]
        i += 1
        k += 1

    while j < len2:
        array[k] = right_list[j]
        j += 1
        k += 1

def merge_sort(array, left, right):
    if left < right:
        mid = (left + (right - 1)) // 2

        merge_sort(array, left, mid)
        merge_sort(array, mid + 1, right)
        merge(array, left, mid, right)

lst = [100, 101, 300, 95, 70000, 10001]
merge_sort(lst,0,len(lst)-1)
print(lst)
```


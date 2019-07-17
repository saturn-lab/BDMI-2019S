# BDMI学习日志

作者: 洪昊昀

日期：2019年7月17日

## Abstract

今天介绍了SQL数据库以及之前的语法，因为上学期用C++面向对象的方法写过一个模拟MySQL数据库的大作业，所以对比较类似的SQL的语法也很熟悉，只是…因为之前安装过`MySQL`来玩，所以和`jupyter notebook`的`ipython-sql extension`起了冲突，之前怎么install都不行，后来uninstall了`MySQL`就搞定了~

## 关系型数据库SQL

因为之前有玩过和模拟过`MySQL`，所以我也有些好奇它和`SQL`的关系，事实证明，它们的性质都不一样，`MySQL`是一种软件，是一种RDBMS，一种关系型数据库软件；而`SQL`是一种语言，结构化查询语言，它对应于功能更强大的`SQL Server`和`SQLite`。其实如何操作数据库都是简单的，毕竟它都是结构化的，不怎么需要费脑子，但是它内部的存储、检索、插入、删除就大有学问了，因为数据库的需要高效地处理，而且需要妥善处理并发的情况，现在也都只知道一个大概，希望接下来能拨开迷雾逐渐清晰吧~

不过语法什么的总是要查也是很麻烦，所以还是做一些整理吧~ ps.SQL对关键字的不分大小写，对自定义变量名大小写敏感。

```sql
/*创建数据库*/
CREATE DATABASE --后面加上数据库的名字
/*修改数据库*/
ALTER DATABASE --后面加上数据库的名字
/*创建表*/
CREATE Table --后面加上表的一系列特征
/*修改表*/
ALTER TABLE --后面加上表的名字，可能还有where的定位语句
/*从数据库中提取数据*/
SELECT --这是万能的select，绝对是万能的，好多高级操作都靠它引出
/*更新表中数据*/
UPDATE --后面可能还有where的定位语句
/*删除数据*/
DELETE --后面可能还有where的定位语句
/*向表中插入新数据*/
INSERT INTO --后面加上表名等
/*创建索引*/
CREATE INDEX --即搜索键
/*删除索引*/
DROP INDEX
--还有一堆更神奇的操作直接看教程就行了（之前写大作业的时候也实现过）
```

## 数据库底层结构

### 1. 索引

在数据库里索引是很重要的，因为它可以让数据库更高效地进行各种操作。

数据库的底层，建立关系，映射成索引，用数据结构存储，然后进行io等硬件方面的操作。

一种索引是hash，另外一种是B+树。

#### Hash 

With hash table： hash(key) -> value

#### B+树

将叶子节点全都用链表接起来，通过每一层的key去寻找目标信息。

#### clustered

clustered index将每一条内容按照索引排序，顺序io比杂乱无章的random io要快很多。

#### Sorting

对文件的排序多用merge sort，有一种external merge algorithm，可以将多个都大于内存buffer的sorted后的文件进行合并，当文件实在是太大时，可以将文件切成好多小份，再进行sort和merge。

#### Counting

With hash table and counter计数器 ：hash(key) -> count（没错，在sql中，count语句和where结合也会很便捷地得到结果）。

### 2. Storage and Memory Model

#### disk: 

所有的信息最终都会存到磁盘，断电复电后存储内容依然存在，数据库的存储内容最终都会放到disk里。

#### main memory: 

速度快，一般是程序运行的时候使用，但是断电后储存内容消失。

#### SSD:

也就是传说中的固态硬盘，io快，断电后也能保留原存储内容。

#### buffer：

 缓冲区，开在main memory里面，等电脑比较空闲的时候，才从buffer批量导到disk里，这样io速度就快得多。






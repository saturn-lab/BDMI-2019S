# BDMI学习日志

作者: 洪昊昀

日期：2019年7月23日

## Abstract

今天首先学了`Haskell`语言，虽然它现在其实一点都不火了，但是它好像在一些领域比如金融有着应用，现在的版本竟然还是98版的，可见它又多么不受重视，但是经过查阅资料，发现并不是因为这个语言不好，而是因为它的思维和大多数编程语言不太一样，即使编程大牛都可能觉得学习这份语言完全是重新学习编程，但是很多基础科学的学者们会更喜欢用这种语言。然后介绍了数据管理系统和machine learning结合的领域，主要是用机器学习提升数据库的查找、处理询问等性能。

## Haskell

`Haskell` 是一种Pure(纯粹)的函数式程序设计语言。

`Haskell`语言的最重要的两个应用是GHC(Glasgow*Haskell*Compiler)和Hugs，然后我们今天使用的就是GHC，直接在命令行中操作即可。如果是仅仅写一些小函数，这个语言并没有和其它语言有什么太大的不同，但是它在其它方面有着得天独厚的优势。

它曾被一位写perl6的业界大佬这么评价： *faster than C++, more concise than Perl, more regular than Python, more flexible than Ruby, more typeful than C#, more robust than Java, and has absolutely nothing in common with PHP.*

*Haskell*本身就是一个数值计算工具，它用来正向求解，反向求解，求偏导之类的。

*Haskell*具有引用透明性，所以只能定义不能赋值。

## SysML

数据管理与机器学习的结合。

The rise of full stack bottlenecks in ML，从底层到代码到应用都是要一站式生产。

 ### 学习索引 learned index

如果关系型数据库没有索引，用列式存储，是连续存储，那就最快是$log_2N$的二分查找。

更加高级的是用树做索引，B+树，所有得数据都放在叶子上哦，其他中间节点都是用来查找得index，输入key，找到位置；或者用hash索引，是用hash func来查找；还有Bloom filter索引。

神经网络索引是用B-树model， min error 0，max error pf the page size(数据库是以页为单位的)，最大、最小的误差只需要训练，不需要验证了。

B- tree that indexes 100M records with a page-size of 100。

Range index models are CDF models，a model which predicts the position 可以通过key来逼近CDF。

RM-index(recursive -model indexes)

Algo1: Hybrid end-to-end training

有的时候神经网络不收敛，然后就会导致训练结果的误差比B树还大，那么就用B树来替换它，让每个网络的最坏结果也就是B树的结果。

神经网络的误差一般都比B树大一点，神经网络的误差是没有办法确定的，是类似黑盒的。

### SageDB: a learned database system

sagedb optimize access methods and query plans, workload,

强化学习的方法可以做很多面向应用过程的优化

cardinality estimation 势估计

multidimensional indices 多维模型分成两个步骤

learned sorting algorithm

调度scheduling：FIFO，SJF，JCT各种方法。

## 在数据处理中的挑战

在实际的生产中，数据量甚至达到几PB。

understanding，validation，clean，enrichment，deviation between serving and training都需要被优化。

Hidden technology debt：在软件开发当前任务量与未来工作量的trade-off。


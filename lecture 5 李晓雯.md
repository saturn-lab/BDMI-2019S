[TOC]

lecture 5 

今天学习了CNN和RNN。其实两个都没有听得太明白，回去后浏览了dl的那本教材以及看了一些视频，稍微比原来多明白了一点点，不过也还不是很懂。



**深度学习框架**

深度学习框架包括编程语言、解释器、编译器

Tensorflow称为"可求导编程语言"

Tensorflow求导采用负号微分法



TensoreFlow数据流图

前向计算损失函数，反向计算梯度



**TensorFlow应用**



### CNN&RNN

#### 卷积运算

$Def: s(t) = \int x(a)w(t-a) da = (x*w)(t)$

离散版本$s(t) = \sum x(a)w(t-a)$

<u>为什么要使用卷积运算？</u>

卷积运算通过三个重要思想来帮助改进机器学习系统：**稀疏交互(sparse interactions), 参数共享(parameter sharing), 等变表示(equivariant representations)**

传统神经网络：每一个输出单元与每一个输入单元都产生交互。而卷积网络的**稀疏交互**的特征是通过使核的大小远小于输入的大小来达到的。

假如有m个输入和n个输出，传统方法需要$m\times n$个参数并且相应算法的时间复杂度为$O(m\times n)$，然而如果限制每一个输出拥有的连接数为$k$，那么稀疏的连接方法只需要$k\times n$个参数以及$O(k\times n )$的运算时间。

![1563526503819](C:\Users\rikka\AppData\Roaming\Typora\typora-user-images\1563526503819.png)

**参数共享**指一个模型的多个函数中使用相同的参数。

参数共享的特殊形式使得神经网络层具有**平移等变性**。也就是说先平移再卷积等于先卷积再平移。

#### 池化

卷积网络中一个典型层包含三级。

第一级中，该层并行地计算多个卷积产生一组线性激活响应。

第二级中(探测级)，每一个线性激活响应将会通过一个非线性的激活函数。

第三级中，用池化函数来进一步调整该层输出。

![1563529050142](C:\Users\rikka\AppData\Roaming\Typora\typora-user-images\1563529050142.png)

池化函数使用某一位置的相邻输出的总体统计特征来代替网络在该位置的输出。常用的有$max\ pooling $函数，给出相邻矩形区域内的最大值。

#### Dense & CNN

Dense网络

多层前馈网络就是一种dense网络



输出层的softmax处理，计算输入层对于的概率分布



**CNN组成**

卷积网络是一种前馈网络

- convolutional layers 卷积层

  意义在于处理图像

- pooling layers 采样层

  采样，缩小模型大小

- dropout层

  减少CNN过拟合问题

- normalization layers 正则层

- MLP分类器

  

  

  用MLP处理图像 

  图像单个像素点的颜色RGB值表示

  对于一张$200\times 200 \times3$的图片，单个神经元有120000参数

**CNN特点**

特点：局部区域的权重W共用(weight sharing)空间维度

卷积：比起dense网络，大大降低参数的个数



**CNN的三个重要思想架构**

局部区域感知

权重共享

空间或时间上的采样



### RNN & LSTM 

#### Recurrent network

用于序列建模预测问题



#### 双向RNN

双向RNN，结合时间上从序列起点开始移动的RNN和另一个时间上从序列末尾开始移动的RNN。双向RNN，其中h(t)代表通过时间向前移动的子

#### LSTM

LSTM(Long Short-Term Memory) 长短期记忆

普通RNN在参数传递的过程中可能会有梯度弥散或者梯度爆炸的问题存在，LSTM就是为了解决这个问题而出现的。

它比普通RNN多了三个控制器：输入、输出、忘记。

![1563536794077](C:\Users\rikka\AppData\Roaming\Typora\typora-user-images\1563536794077.png)



### 参考资料

文字资料：dlbook

视频资料：

1.[LSTM, RNN](https://www.bilibili.com/video/av15998549?from=search&seid=1366063279403778590)




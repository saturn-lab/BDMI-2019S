lecture 4

今天回顾了计算机系统的部分内容，并且学习了数据管理中的bitmap index。之后又学习了与机器学习有关的内容，最近刚好也在看吴恩达的mooc，但也还只是初步了解。最后还了解了TensorFlow的有关内容。

### 计算机系统

计算系统：硬件+软件(系统软件：操作系统，应用软件：数据库、办公软件等)

并行分布式系统：超级计算机、云计算系统、大数据系统



计算机存储器等级：Cache>RAM>SSD>DISK

计算机硬件-处理器

- 指令集：x86与ARM



### Bitmap Indexing for Big Data Management

#### Index for search

- 查找
- 创建索引
- 通过索引查找匹配某个数值的所有数据

#### Data Structure for Index

Tree\Hash\Bitmap

多条件查询(the curse of dimensionality)使用bitmap

**Inverted Index**

bitmap：把条件转化为位图串，把交并补运算转化为位运算



### 人工智能

主要有两个部分：机器认知(思考)和机器感知(语音、视觉、运动控制)

**机器学习**通俗来讲，就是给定一个计算机任务T和一个对任务T的性能度量P，在给出经验集E的前提下，提升任务T的性能P的方法就是机器学习。

机器学习 = 数据+模型+算法

机器学习的任务：预测(通过数据集，预测新的数值)、分类(通过数据集，对新数值进行集合分类)



**神经元**的模型包括：接受的线性部分和触发的非线性部分

建模过程：

- 神经元被建模为一个函数$F(w,x)$，其中$w$是权重，$x$是输入。
- 输入是线性加权叠加的
- 一个非线性函数$F$作用，进行输出，$F$称为激活函数
- 激活函数模拟神经元的出发激活特性

![1563416408825](C:\Users\rikka\AppData\Roaming\Typora\typora-user-images\1563416408825.png)

**激活函数(activation function)**

- $Sigmoid$

  $sigmoid(x) = \frac{1}{1+e^{-x}}$

- $tanh$

  $tan(x) = \frac{e^x-e^{-x}}{e^x+e^{-x}}$

- $ReLU(rectified linear units)$

  $ReLU(x) = max(x,0)$



**人工神经元1 - ReLU单元**

![1563417324742](C:\Users\rikka\AppData\Roaming\Typora\typora-user-images\1563417324742.png)



**人工神经元2 - Logistic Regression Unit**

​		Logistic Regression Unit的激活函数采用sigmoid函数或者logistic 函数



**人工神经网络**

按照连接主义观点，人工神经网络由大量的神经元以及它们之间的有向连接构成。

网络之间的拓扑结构

- feedforward(前馈网络)

- feedback(反馈网络)

- memory network(记忆网络)

![1563417838643](C:\Users\rikka\AppData\Roaming\Typora\typora-user-images\1563417838643.png)

- 多层前馈网络



### 深度学习

**神经网络训练 - 原理**

采用带标签的训练样本对神经网络进行学习，确定网络的权重参数。

$(x,y) $表示一个单独的样本。

神经网络输出的改变体现在$y$上。那么会有一个预期输出与实际输出的差异。**神经网络训练的本质就是找到相应的内部权重$w$，使得在样本输入到网络后，网络的实际输出与预期输出的差异最小**

**神经网络训练 - 损失函数**

用**损失函数(Loss)或成本函数(Cost)**来表示神经网络的预期输出结果与所对应的实际标签之间的差异。

对于回归(预测)任务而言，Loss主要通过均方误差的公式，而对于分类任务，通过交叉熵的公式来计算。

交叉熵：$H_{y'}(y) = - \sum_{i} y'_i log(y_i)$



### TensorFlow

TensorFlow分为Graph和Session两部分

Graph描述计算图，Session开始计算



**Tensor只有三个子类**

​	Constant(计算中不变的常量)

​	Variables(神经网络中的参数)

​	Placeholder(输入数据)


lecture 7 

计算机视觉识别指标

**精确率**

**召回率**

针对原来的样本而已，表示的是样本中的正例有多少被预测正确了。

**准确率**

#### 对象检测的识别精确率指标

常用的识别精确率指标：

**平均精确率均值mAP**

定义

![1563757189797](C:\Users\rikka\AppData\Roaming\Typora\typora-user-images\1563757189797.png)

**PR曲线的AUC(area under curve)指标**

横坐标为recall，纵坐标为precision



#### 视觉对象检测的算法visual object detection algorithm

**IOU重叠联合比**

def：集合的交比上集合的并的值

IOU定义了两个bounding box(抢好框住对象的矩形框)

**视觉对象检测的错误类型**

定位错误(Localization)：类别正确，0.1<IOU<0.5

相似性错误(Similar)：类别相似，IOU>0.1

其他错误(Other)：类别错误，IOU>0.1

背景误认(Background)：IOU<0.1



##### 视觉对象检测的方法

R-CNN

- 输入图像，提取区域

用选择性搜索的算法去搜索一个'fast mode'，对每一个提出的可能有对象的图像区域提取一个4096维的特征向量

对于不是标准正方形的区域，使其标准化。最简单的方法是膨胀(形态学算法)其最小外边框，使整幅图像大小合适。

- 计算CNN特征

5个卷积层，2个全连接层

- 区域分类

对每一个类预先训练好一个支持向量机(SVM)，然后对之前提炼出来的特征向量用对应类的SVM去打分。

贪心思想的“非极大值抑制”：舍弃掉IOU值小的区域



Fast R-CNN



YOLO(You Only Look Once)

- YOLO算法将对目标检测任务的认识由分类问题化简为回归问题。
- 基本流程

1. 将整张图像输入到神经网络中，对图像进行预处理，分割为S X S个网络(Grid)，如果一个Object的中心落在某个grid中，则其负责后续检测该目标对象的class和location

2. 通过预先训练好的神经网络模型，每个网格负责预测 B 个Bounding Box ，每个边界框对应 5 个预测参数边界框的中心点坐标（x ，y），边界框的 宽度与高度 （w ，h）以及置信度（Confidence）

- 损失函数

1. 分类
2. 有无对象
3. Bounding box 的参数的回归


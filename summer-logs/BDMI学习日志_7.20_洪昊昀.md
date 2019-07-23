# BDMI学习日志

作者: 洪昊昀

日期：2019年7月20日

## Abstract

今天主要进行的是语音识别模型训练：先用audioPlot项目中的内容进行数据预处理，即将各种格式的音频后缀全部换成wav格式便于后续处理；然后就是用audioNet进行模型训练，不过发现在自己电脑上用CPU版本的TensorFlow训练实在是太慢了:cry:，因为发现自己的电脑有一个算力为5.0的GPUhiahiahia:happy:，所以就直接卸载了CPU版本的TensorFlow，安装了GPU的版本，然后打算把代码看懂了再跑个模型；最后就是把自己训练后得到的精度最高的模型进行转换，然后生成Andriod手机上的app进行针对开关蓝牙的语音识别啦。今天也正式创建了云AI平台的TF环境，然而，大概因为学生的是免费版本所以只能用icenter的网才能连接到服务器再用命令行进行操作。

不过，因为我们拿到的是大约两年前完成的代码，我们使用的软件版本与python版本与当时已经十分不同了，所以会出现各种各样的问题，但是这些代码都没有什么注释:weary:，所以。。。只能尽量看懂和debug了。

## audioPlot项目及其代码分析

该项目就是将各种不同后缀名即格式的音频文件转换成.wav文件，其中遇到的问题就是代码进行dir_in和dir_out的路径要是没有弄好会转换不成功，看懂代码后，我想提出一个优化方案，这样以后的同学就会更容易地进行转换啦。

```python
#convert.py中的该函数指定了转换后的wav文件存储在wavfile文件夹里
def ConvertAudioToWav(dir_in, dir_out=os.path.join('.', 'wavfile'))
```

于是，如果在audioPlot里面新建一个wavfile的文件夹，就可以自动将wav文件放在wavfile里面了。

然后该函数的后半段：

```python
if __name__ == '__main__':
    ConvertAudioToWav(sys.argv[1])
    #这个最后一句指，sys.argv[1]是系统得到的第二段输入，然后是赋值给dir_in
```

所以，Readme里面的那段代码`python ./convert_file.py  ./rawfile/`就是在暗示我们在audioPlot新建一个rawfile文件夹，然后把不同人的已经有a，b，bb等音频文件的文件夹放在里面就行啦（注意，此处一定要有两层文件夹，一是如果把不同人的好几份音频全都混在同一个目录下，会有重名的问题，二是因为这份代码是会去rawfile的下一个目录再去找有规定名称的音频文件然后再转换完放到wavefile里面）完全按照readme里面的几句代码来就行啦。

关于那个大家都有的报错

`ValueError: buffer size must be a multiple of element size`

并且该错误会导致image文件夹中waveform文件部分缺失，我看见上一行是

```python
data = numpy.frombuffer(buf[itr + 8: itr + 8 + size], dtype=numpy.float32)
```



我觉得应该是这行代码可能和新版的numpy包不兼容了，导致有一些图片的格式与缓存的大小不匹配而输不出来，然后经过深入分析，发现把这行的size微量地改成4的倍数就行了，于是就把上面那行替换成：

```python
#先取个模
more = size % 4
#再减掉，直接变成4的整数倍
data = numpy.frombuffer(buf[itr + 8: itr + 8 + size - more], dtype=numpy.float32)
```

然后，反正在我的win10电脑上是可以输出全部的波形图了:happy:



## audioNet项目及其代码分析

因为一开始下载的是CPU版本，真的特别慢，回去以后我又安装了GPU版本并且配置了CUDA环境，15分钟以内就几乎跑完了`samples_per_epoch=3000`，`nb_epoch=1`，`nb_val_samples=50`的训练，然而，和众多同学跑的CPU版本一样，最后还是卡在了2999/3000处，感觉十分诡异，这大概是代码在存储模型的部分有些不对劲导致程序直接跑飞了:weary:，更加可怕的是，程序没有对异常的情况输出可能的错误并且自动kill掉，就一直在电脑里随便跑:weary:

```python
#对原版train.py的程序解释
from model import KerasModel
from dataGenerator import DataGenerator
import os

def train(sp=-1):
    model = KerasModel()
    
    train = DataGenerator('train')
    test = DataGenerator('test')
    
    #当已经有一些保存的checkpoints的时候，
    if sp != -1:
        chkp = '.' + os.sep + 'models' + os.sep + 'save_' + str(sp) + '.h5'
        model.load_weights(chkp)
    print('start point: %d'%sp)

    for i in range(sp + 1, 100):
        model.fit_generator(
            generator=train,
            #指的是每个epoch里面跑3000个样本，样本数越多，同等条件下跑完一个epoch的时间越长
            samples_per_epoch=3000,
            #指的是一共有多少个epoch
            nb_epoch=1,
            validation_data=test,
            #指的是每次喂几个样本，但是一般情况下可能会因为喂太多数据而卡住，可以把值减小
            nb_val_samples=100
        )
        model.save_weights('.' + os.sep + 'models' + os.sep + 'save_' + str(i) + '.h5' )

if __name__ == '__main__':
    #这份代码的最后一行指，从最初始的点（即当没有任何点时）开始训练
    train(-1) 
    
```

其它的代码大概看懂是什么意思了，但是还是不知道是什么问题，所以我打算直接下载tensorflow的一些可以用的源码（比如speech command），去学习一下具体的语音识别的代码意义。



## audioAndroidRecg项目及其代码分析

这部分是将之前freeze后的模型进行模型压缩，并且转换成Android程序，但是。。。现在甚至根本无法进入这个网站，https://ci.tensorflow.org/view/Nightly/job/nightly-android/ ，就算翻墙了也不行。不过很高兴地发现这个文件夹里就是有`libandroid_tensorflow_inference_java.jar`和`libtensorflow_inference.so` 这两个文件的，那么就可以很快乐地使用了。但是，并没有看懂Step 4，这确实写得过于简略了`Step 4. Run Tensorflow inference interface`，ummm反正还是不会把pd转换成apk然后放到android手机上去跑呜呜。




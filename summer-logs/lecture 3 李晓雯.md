lecture 3

今天主要学习了关系数据模型、SQL语言，以及介绍了数据系统底层的操作和一些计算机硬件上的基础知识。

由于课前对数据库几乎一无所知，所以在总结今天的学习日志之前也先学习了一下与数据库有关的内容，写得不一定对。



**数据库**

数据库的主要用途就是存储和查找数据。

数据库依据特定的数据结构来组织数据，根据所组织的数据结构的特性来查找数据。

**关系型数据库**

关系型数据库是依据关系模型来创建的数据库。

**关系模型**是基于谓词逻辑和集合论的一种数据模型，它的基本假定是所有数据都表示为数学上的关系，数据通过关系演算和关系代数的一种方式来操作。

**关系模型**的基本的数据结构是线性表(二维表)，因而一个关系型数据库就是由二维表及其之间的联系所组成的一个数据组织。

关系模型包括数据结构、操作指令集合(也就是后面要提到的SQL语句)、完整性约束(表内数据约束、表与表之间的约束)

关系型数据库将数据存储在磁盘中，相对比较安全。



**SQL**是一种用于访问和处理数据库的标准的计算机语言。

SQL可以分为两个部分：数据操作语言(DML)和数据定义语言(DDL)

SQL语句的执行一般是先翻译为关系代数再执行的，**关系代数**有五个基础运算符：selection\projection\cross-product\set-difference\union

**Tables In SQL**

**relation\table**: a multiset of tuples having the attributes specified by the schema

列可以称为属性(attribute)

行可以称为tuple/record

**Data Type in SQL**

Atomic types:

​	Characters: CHAR(20), VARCHAR(50)

​    Numbers: INT, BIGINT, SMALLINT, FLOAT

​    Others: MONEY, DATETIME…

every attribute must have an atomic type

**Table Schemas**

schema是元数据的一个抽象集合，包含表名、属性和元素类型。

Product(Pname: string, Price: float, Category: string, Manufacturer: string)

如果要表明一些值是唯一的，可以用下划线表示

Product(<u>Pname</u>: string, Price: float, Category: string, Manufacturer: string)



**Key Constraints**

key可以作为relation中tuples的标识符



SQL的基本语法写在另一个md中，网上也很多，这里不再赘述了。



**Index**

在关系数据库中，索引是一种单独的、物理的对数据库表中一列或多列的值进行排序的一种存储结构，可以理解为目录。

因为数据库的文件是存储在磁盘中的，那么IO操作就是评价一个索引结构好坏的标准。

在读取数据的时候会有访问磁盘的操作，磁盘中有两个机械运动的部分，分别是盘片旋转和磁臂移动。在进行数据读写的时候存在一个定位到磁盘的块的过程，显然，机械运动比起电子运动是一个非常花费时间的过程。

索引结构主要有B+tree和hash表两种，虽然hash结构检索效率非常高，不需要像B+tree从根节点开始从上至下检索，但是hash索引不能用于范围查询，也无法被用来避免数据的排序操作，IO复杂度高，而B+tree所需要的IO操作少一些，提高了磁盘读取时定位的效率，所以现在数据库中常用的结构还是B+tree结构。

B+tree是一种多路搜索树。B+树将数据都存在了叶子节点上，非叶子节点只存储键值信息。且增加了顺序访问指针，每个叶子节点都指向相邻的叶子节点的地址，所以B+树只需要取遍历叶子节点就可以实现整棵树的遍历，在数据库基于范围的查询中是非常高效的。
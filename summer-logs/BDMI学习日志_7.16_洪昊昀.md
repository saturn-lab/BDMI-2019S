# BDMI学习日志

作者: 洪昊昀

日期：2019年7月16日

## Abstract

今天主要就是数据结构部分了，老师讲解了很多的树，Binary Search Tree -> Red Black Tree -> 2-3-4 Tree，left leaning red black tree -> B+ Tree，还有Hashing查找。其中BST的构建与Quick Sort寻找pivot的思想有异曲同工之妙；RB树的染色规则有些绕，但其实已经非常美妙了（毕竟那么几个规则就能让树perfectly balanced了）；2-3-4树是RB树的拓展，就是让每个node的key能够多余1个，然后就可以连接不止1条edge，但是限制就是每个node只能有2/3/4个孩子（边树同）；LLRB树其实是从2-3树转换过来的，毕竟如果拆了一个度为3的节点并且让节点中bigger key作为根就会让根的左子树比较大了，LLRB与RB的区别是前者对边按规则红黑染色，后者对节点按规则红黑染色，两者的规则也比较类似。关于为什么2-3-4树和LLRB会出现呢，因为RB树的实现过于繁琐，但是234和LLRB都是更像BST的，所以实现起来会容易一些，但是也是有trade-off的，就是234和LLRB的balance性能没有RBtree好，所以当n很大时从总体上来讲效率应当没有RB树高，~~但是对程序员来说，~~在可以的情况下，~~真的是the easier the better~~。还有B+树，是一种广泛用于数据库中的数据结构，十分适用于文件索引系统，它的全集信息都在叶子节点，而非叶子节点都是索引。最后就是hash啦，和bucket & radix sort有异曲同工之妙，确实哪里都有hash呢，之前选了一门姚班的课里面就有提到用hash表来检索文件，然后在block chain的mining操作里也用到了hash算法。

## BST in python

关于其它更高级的搜索树我需要再消化一下再po出来 > < 。感觉下个学期应当是各种树的轰炸hiahiahia，不过还没有实现过很多树，还记得上上学期程设课写了一棵二叉树，然后因为太菜了，没有发现二叉树父节点与左右孩子之间的index关系，导致自己开开心心又接了一条按层级连接链表，直接把二叉树接成了圣诞树 > <。不得不说，二叉树确实是一个绝妙的发明，有很多优秀的性质，下面我来用python实现一下吧~各种基本操作都写了，但是示例测试的是删除、插入、升序排列部分

```python
# 节点类
class Node:
    # 用类成员函数进行节点初始化
    def __init__(self, value):
        self.value = value
        self.lchild = None
        self.rchild = None

# 二叉树类
class BST:
    # 用类成员函数进行二叉树初始化
    def __init__(self, node_list):
        self.root = Node(node_list[0])
        for value in node_list[1:]:
            self.insert(value)
    # 搜索拥有某值的节点操作
    def search(self, node, parent, value):
        if node is None:
            return False, node, parent
        if node.value == value:
            return True, node, parent
        # 小的在左孩子，大于等于的在右孩子
        if node.value > value:
            return self.search(node.lchild, node, value)
        else:
            return self.search(node.rchild, node, value)

    # 插入某值的节点操作
    def insert(self, value):
        flag, n, p = self.search(self.root, self.root, value)
        if not flag:
            new_node = Node(value)
            if value > p.value:
                p.rchild = new_node
            else:
                p.lchild = new_node

    # 删除某值的节点
    def delete(self, root, value):
        flag, n, p = self.search(root, root, value)
        if flag is False:
            print("Can't find the key! Delete failed!")
        else:
            if n.lchild is None:
                if n == p.lchild:
                    p.lchild = n.rchild
                else:
                    p.rchild = n.rchild
                del p
            elif n.rchild is None:
                if n == p.lchild:
                    p.lchild = n.lchild
                else:
                    p.rchild = n.lchild
                del p
            else:
                pre = n.rchild
                # 当左右孩子都为空时
                if pre.lchild is None:
                    n.value = pre.value
                    n.rchild = pre.rchild
                    del pre
                else:
                    next = pre.lchild
                    while next.lchild is not None:
                        pre = next
                        next = next.lchild
                    n.value = next.value
                    pre.lchild = next.rchild
                    del p

    # 先序遍历
    def pre_order_traverse(self, node):
        if node is not None:
            print(node.value)
            self.pre_order_traverse(node.lchild)
            self.pre_order_traverse(node.rchild)

    # 中序遍历
    def in_order_traverse(self, node):
        if node is not None:
            self.in_order_traverse(node.lchild)
            print(node.value)
            self.in_order_traverse(node.rchild)

    # 后序遍历
    def post_order_traverse(self, node):
        if node is not None:
            self.post_order_traverse(node.lchild)
            self.post_order_traverse(node.rchild)
            print(node.value)


array = [1024, 233, 666, 500, 60, 100, 1000, 7, 5, 1]
bst = BST(array)
# 创建二叉查找树
print("***********")
bst.in_order_traverse(bst.root)
print("***********")
# 能够降序排序的就是中序遍历
bst.delete(bst.root, 50)
bst.delete(bst.root, 666)
print("***********")
bst.in_order_traverse(bst.root)
print("***********")
bst.insert(23333)
print("***********")
bst.in_order_traverse(bst.root)
print("***********")
```


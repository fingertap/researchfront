# Non-delusional Q-learning and Value-iteration

作者：Tyler Lu, Dale Schuurmans, and Craig Boutilier，三个作者均来自Google。文章发表于NIPS-2018，获得了2018年NIPS的Best Paper Award。

## 思路脉络

### Motivation

当策略（policy）的选取**有限制**时，Q-learning和Value-iteration的效用更新步骤中的$\max$操作会带来“Delusional Bias”，原因是策略的限制可能使得**不是所有**的行动（Action）都合法，此时取最大**不能在所有的行动集合中遍历**。

一个策略选取的限制来自于**近似函数**。Q-learning方法在处理非表格形式的Q值时需要用一个近似函数（Approximator Function）$Q_\theta(s, a)$来近似任意State-Action对的Q值。基于$Q_\theta(s, a)$的策略因此也是一个近似：
$$
\pi_\theta(s) = \text{argmax}_{a\in A}Q_\theta(s, a), \theta\in\Theta
$$
若近似函数不能保证完美近似，那么$\pi_\theta$就有可能有限制。

用线性近似函数作为例子：因为线性函数不能近似异或操作，当我们的最优策略刚好是异或操作的时候（例如两个状态$\times$两种行动分别是$(0, 0), (0, 1), (1, 0), (1, 1)$，再令其效用分别为$0, 1, 1, 0$），算法是无法收敛到最优策略的。

### Method

为了解决Delution问题，作者提出了用`Information Set`来使求$\max$合法化。其方法是把所有可能的转化过程都记录下来，然后删掉在策略限制下不可能实现的状态转移，最后在记录下来的所有可能的状态转移中选择最优的。

## 工作亮点和不足

### 亮点

这个工作的最大亮点在于发现了一个RL里普遍存在的一种现象`Delusion`，并且提供了大量的例子（Delusion的例子和后果，以及使用了information set的Value-iteration方法PCVI的例子等）辅助说明。

### 不足

因为整个工作中作者都是用线性近似函数作为例子，因此我对这个工作最大的concern是当近似函数足够灵活的时候，Delution的严重程度到底是否需要我们花费这么大的计算代价（记住过去的所有状态转移）来处理。

## 写法特色

文章的结构是**Introduction**$\rightarrow$**Preliminaries**$\rightarrow$**A Concrete Example of Delusional Bias and Its Consequeces**$\rightarrow$**PCVI and PCQL**$\rightarrow$**Suggestions for Practical Use**。补充材料里讲了4个Example、和double Q-learning的区别、PCVI和PCQL的定理证明和一个PCQL的例子。

我只看了前三节。因为对RL的文献不熟悉，看了很久才明白文章的目的。我暂时只能感受到这个工作举了很多例子，放大这个Delusion问题，并且提供了Convergence之类的证明。里面的数学我准备在学了VC learning theory等数学能力提升计划之后再回来看看。

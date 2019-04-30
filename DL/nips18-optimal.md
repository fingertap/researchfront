# Optimal Algorithms for Non-Smooth Distributed Optimization in Networks

作者Kevin Scaman，Francis Bach，Sébastien Bubeck，Yin Tat Lee，Laurent Massoulié。文章发表在2018年NIPS上，获得Best Paper Award。他们在2017年的ICML中也发表了一篇工作，讲述在分布式优化中光滑、强凸情形下的最优方法。

## 思路脉络

这篇文章关注**非光滑凸函数**的分布式优化收敛速度。处理非光滑的方式是用[随机扰动](../Extend/siam12-randomized.md)。文章考虑了两种情形：a) master/slave中心化模式，优化的目标$L_g$-Lipschitz连续；b)基于gossip的去中心化模式，每个节点优化的目标$L_i$-Lipschitz连续。后者的假设较前者更强。在这两种情形下，文章给出了期望误差控制到$\epsilon$以内需要的收敛时间的下界，并分别给出了一个接近optimal的中心化算法和一个optimal的去中心化算法。

### 中心化情形

中心化情形假设网络连接已知且可靠，master把参数分发给slave，slave计算梯度后传输给master，master再更新参数。

作者在**Theorem 2**中给出了中心化情形的误差下界，从而推出达到$\epsilon$所需的时间为

$$
\Omega\left(\frac{RL_g}{\epsilon}\Delta\tau+\left(\frac{RL_g}{\epsilon}\right)^2\right)
$$

（这里的下界成立有比较多的假设，例如迭代步数有上界，因此是迭代早期的下界）。而单机上的SGD的收敛所需时间为$O\left(\left(\frac{RL_g}{\epsilon}\right)^2\right)$，因此在中心化情形的分布式优化中，我们能优化的只有Communication Cost，也即**尽量少地交流**。思路是减少收敛所需要的步数，代价是需要控制每次随机梯度的方差。准确地来说，若总迭代次数为$T=\left\lceil\frac{20RL_gd^{1/4}}{\epsilon}\right\rceil$，每个节点在计算随机梯度时采样数为$K=\left\lceil\frac{5RL_gd^{-1/4}}{\epsilon}\right\rceil$，则通过**加速梯度方法**可以达到以下的收敛时间：

$$
O\left(\frac{RL_g}{\epsilon}(\Delta\tau+1)d^{1/4}+\left(\frac{RL_g}{\epsilon}\right)^2\right)
$$

在$d$较小时比较接近下界。总的来说，**中心化的分布式随机优化可以通过提高每个计算节点的采样率来减少收敛所需的步数，从而减少网络传输的时间开销**。

一个trick是在做分布式随机优化时不用每次同步抽样的索引集，只用在初始时同步一下种子就好了。

### 去中心化情形

网络结构未知或在变化时，往往更倾向选择去中心化的方式。去中心化情形假设每个节点广播自己计算得到的梯度，接受到邻居计算得到的梯度并对其做一个加权平均。在linear graph中若令Gossip矩阵为Laplacian矩阵$L$，网络直径$\Delta$可以由$L$的谱近似$\gamma=\lambda_\max/\lambda_1$（$L$的最大特征值比上非零的最小特征值）$\Delta\propto 1/\sqrt{\gamma}$，因此类似的证明可以得到去中心化的时间下界：

$$
\Omega\left(\frac{RL_l}{\epsilon}\frac{\tau}{\sqrt{\gamma}}+\left(\frac{RL_l}{\epsilon}\right)^2\right),
$$

其中$L_l=\sqrt{\frac{1}{n}\sum_{i=1}^nL_i^2}$是局部的Lipschitz常数的$l_2$平均。作者提出通过使用Accelerated Gossip算法来得到每轮的subgradient估计，然后用Primal-Dual算法解。Accelerated Gossip是用Chebyshev多项式加速了Gossip的随机传播过程，使得收敛的速度够快，平均的时间耗费更短。

如果只用最初的primal-dual方法来解的话，上界为

$$
O\left(\frac{RL_l}{\epsilon}\frac{\tau}{\sqrt{\gamma}}+\left(\frac{RL_l}{\epsilon\sqrt{\gamma}}\right)^2\right)
$$

加上了Accelerated Gossip做分布式化，这个去中心化算法的代价上界为

$$
O\left(\frac{RL_l}{\epsilon}\frac{\tau}{\sqrt{\gamma}}+\left(\frac{RL_l}{\epsilon}\right)^2\right)
$$

达到了最优。总的来说就是**中**
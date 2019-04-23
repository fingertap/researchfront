# Optimal Algorithms for Non-Smooth Distributed Optimization in Networks

作者Kevin Scaman，Francis Bach，Sébastien Bubeck，Yin Tat Lee，Laurent Massoulié。文章发表在2018年NIPS上，获得Best Paper Award。

## 思路脉络

假设$$f(x):\mathbb{R}\rightarrow\mathbb{R}$$为凸且为$$L_0$$-Lipschitz，考虑实数$$\gamma>0$$，随机变量$$Z\sim\mathcal{N}(0, I)$$，定义$$f(x)$$的随机平滑函数
$$
f_\gamma(x) = \mathbb{E}_Z[f(x+\gamma Z)]
$$
关于这个函数我在证明一些性质的时候发现一个问题，也就是在对期望中的项分别进行一、二阶展开的时候得到的结果不一致。一阶展开（拉格朗日余项）：
$$
\begin{align}
f_\gamma(x) 
&= \mathbb{E}_Z[f(x+\gamma Z)]\\
&= \mathbb{E}_Z[f(x)+\gamma Z\cdot\nabla f(c_1)]\\
&= \mathbb{E}_Z[f(x)]+\gamma\nabla f(c_1)\cdot\mathbb{E}_Z[Z]\\
& = f(x)
\end{align}
$$
其中$$c_1 = (1-\lambda_1)x + \lambda_1(x+\gamma Z)=x + \lambda_1\gamma Z, for\ some\ \lambda_1\in(0,1)$$，是$$x$$和$$x+\gamma Z$$线段上某点。利用了$$Z$$的零均值。这说明在任一点随机平滑后期望还是原函数值。但是考虑二阶展开：
$$
\begin{align}
f_\gamma(x) 
&= \mathbb{E}_Z[f(x+\gamma Z)]\\
&= \mathbb{E}_Z[f(x)+\gamma Z\cdot\nabla f(x)+\frac{(Z\gamma)^2}{2}\nabla^2f(c_2)]\\
&= \mathbb{E}_Z[f(x)]+\gamma\nabla f(x)\cdot\mathbb{E}_Z[Z]+\frac{\gamma^2}{2}\nabla^2f(c_2)\cdot\mathbb{E}_Z[Z^2]\\
& = f(x)+\frac{\gamma^2}{2}\nabla^2f(c_2)
\end{align}
$$，
其中$$c_2$$和$$c_1$$类似。这里利用了Z的方差为1。但是因为f是凸的，这里$$\nabla^2f(c_2)\geq 0$$，因此这里有$$f_\gamma(x)\geq f(x)$$，和一阶的不一样。
## 工作亮点/不足

## 写法特色

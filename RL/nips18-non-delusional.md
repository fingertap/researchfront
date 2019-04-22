# Non-delusional Q-learning and Value-iteration

作者：Tyler Lu, Dale Schuurmans, and Craig Boutilier，发表于NIPS-2018。

## 思路脉络

### Motivation

当策略（policy）的选取有限制时，Q-learning和Value-iteration的效用更新步骤中的max operator是一个

Q-learning方法在处理非表格形式的Q值时需要用一个近似函数（Approximator Function）$$Q_\theta(s, a)$$来近似任意State-Action对的Q值。基于$$Q_\theta(s, a)$$的策略因此也是一个近似：


$$
\pi_\theta(s) = \text{argmax}_{a\in A}Q_\theta(s, a), \theta\in\Theta
$$


若近似函数不能保证完美近似，那么$$\pi_\theta$$就有可能有限制。


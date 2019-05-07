# R-CNN

这篇文章标题为Rich feature hierarchies for accurate object detection and semantic segmentation，作者是Ross Girshick，Jeff Donahue，Trevor Darrell和Jitendra Malik，来自UC Berkeley，发表在CVPR 2014上，是目标检测目前效果最好的R-CNN系列的开山之作。

## 思想脉络

我只看了算法部分。R-CNN首次提出了多阶段的目标检测方案，结合了**Region Proposal**和**CNN**抽取的视觉特征，并在目标检测的基准数据集`PASCAL VOC`和`ILSVRC2013`上取得了当时最好的成绩，打败了一阶段的目标检测方案*OverFeat*。

第一阶段为Region Proposal，即提前选出可能存在目标的局部图片区域。R-CNN使用的是Selective Search。Selective Search做了一个图片像素的层次聚类，每次形成的更大的类都被加入到提案中。用这样的方式生成大概2000张Proposal。

第二阶段是特征抽取和分类。首先用Krizhevsky等人提出的CNN在Image-Net上训练，然后再在VOC等数据上finetune最后一层。Finetune的数据输入是在Region proposal上训练的（Proposal选择了正负例的比例为32:96=1:3，Proposal经过了Warping操作使得输入的图片大小一致）。

经过了Finetune以后，再用这些Proposal训练最后的SVM分类器。对于IoU小于阈值（这个阈值用grid search搜索后设为0.3）的Proposal判定为负类。训练完分类器后对测试数据中的proposal进行分类，所有检测出包含目标的区域还要做一次过滤，即如果有多个区域框住同一个目标（多个区域的IoU超过一个学出来的阈值），则只保留最confident的那个（在SVM里即margin最大的那个）。

第三阶段还需要对学习到的Proposal的边框进行微调，使得其尽量接近Ground truth。这里的方法是学习坐标的平移和伸缩的变换。引入的是Bounding Box Regression Error的损失。

## 写作特色

本文最大的写作特色是**尽情地展示吊打同期所有算法的测试结果**。在回顾过去的工作之前先点出最近的工作在Benchmark数据集上的准确率已经停滞。回顾了相关工作后说他们的工作点出了ImageNet对Object detection的意义，并进一步展示吊打同期工作的准确率。再总结他们工作中每步设计的初衷（Proposal是为了CNN做的牺牲，因为CNN的stride和接收野会影响探测的位置准确性）。基本上说到所有的Challenge时都cue了一下自己的好效果吊打其他人。

果然实验结果理想，想怎么写就怎么写。
找一个issue对应的commit(s)的add和del行数，遵循的步骤是：

1. 如果issue是pull_request，则使用对应的pull_request的add和del行数（例如：https://github.com/BVLC/caffe/pull/2958 右边已经显示了+7 -2）；

2. 若1.不成立，判断issue的所有events里面是否存在commit_id（例如：https://github.com/electron/electron/issues/623 里面有个event关联了commit fd806f8），统计这些commits的add和del行数总和；

3. 若1.2.不成立，分析issue中的所有comments是否包含commit_id （例如：https://github.com/bilibili/ijkplayer/issues/21 里面有个comment的内容是fixed: 5f00a1b），统计这些commits的add和del行数总和；

4. 否则无法知道相关的commit。

1-3 可信度从高到低
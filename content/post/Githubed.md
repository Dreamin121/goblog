---
title: 基于Github的Typora图床
date: 2022-10-07 23:11:10
tags:
- Typora    
- code
categories: 
- code
---

**考虑到有部分人没有服务器，所以这里用免费的github作为图床**

## 准备

+ 安装好 *Typora* ： [提取码：h9bb](https://pan.xunlei.com/s/VNB_VLRHiLk6wUoyXr4mCWM6A1)    *PicGo*  ：[提取码：k77e](https://pan.xunlei.com/s/VNB_WALBOdxS0Hkp49VZlZT_A1)
+ *Gitee* 账户：https://github.com/

## 开搞

### 使用Github作为图床

**1.新建一个仓库**

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/image-20221007215042471.png" alt="image-20221007215042471" style="zoom:50%;" />

**2.设置好仓库名 仓库为开放状态 并且添加README文件**

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/image-20221007215229045.png" alt="image-20221007215229045" style="zoom:50%;" />

**3.获取Token（记得备份）**

创建一个token，依次选择`Settings —> Developer settings—> Personal access tokens`，点击`Generate new token`创建token。



<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/image-20221007215855658.png" alt="image-20221007215855658" style="zoom:67%;" />

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/image-20221007220120150.png" alt="image-20221007220120150" style="zoom:67%;" />

### 配置PicGo

**1.自定义安装PicGo，首先选择“PicGo设置”，点击“设置Server”，开启Server，设置监听地址为主机127.0.0.1，端口号为36677**

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/PicGo%E9%85%8D%E7%BD%AE-1.png" alt="image-20221007220311253" style="zoom:50%;" />

**2.建议将“时间戳重命名”开启（也可以将上传前重命名开启，自己命名图片名称。这里重命名优先权大于时间命名），避免上传图片重名**

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202210072205359.png" alt="image-20221007220545297" style="zoom:50%;" />

**3. 选择“图床设置”—>“GitHub图床”，进行设置**

仓库名： 使用 用户名 + 仓库名

分支名： 默认为master或main（看仓库具体分支是什么）

token： 使用上述创建的token

存储路径：这里使用上述创建仓库的img目录

自定义域名：不必填，默认格式：

```bash
https://raw.githubusercontent.com/[用户名]/[仓库名]/master
```

但是自己平常访问Github经常404的话建议改为

```ruby
https://cdn.jsdelivr.net/gh/用户名/仓库名/文件路径
```

对于使用存储在GitHub上面的**静态文件**，可使用jsDelivr CDN快速访问

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202210072207463.png" alt="image-20221007220730401" style="zoom:50%;" />

**测试文件保存成功**

![image-20221007221015835](https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202210072210888.png)

### Typora配置

+ 点击 `文件`->  `偏好设置` -> `图像`

![image-20220910163202939](https://dreamin-1312842512.cos.ap-guangzhou.myqcloud.com/image-20220910163202939.png)

+ 如上图配置即可使用

## 参考

+ https://blog.csdn.net/haojie_duan/article/details/120400386

+ https://cloud.tencent.com/developer/article/1834573

+ https://juejin.cn/post/7099811254864674823
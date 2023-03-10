---
title: Linux toy合集
date: 2022-09-15 11:41:10
tags:
- Linux      
- toy
categories: 
- Linux
---

# Linux命令神器 `The Fuck`

![example](https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/example.gif)

**`The Fuck`是一款能够自动修复你的错误命令行的终端应用。**

相信大家每个人都有敲错过命令的时候,把`python`
输入成 `puthon`
.手速过快把`ls -alh`
输入成 `ls a-lh`
等等等,这时候是不是想拍一下键盘说一声`fuck`

## 术前要求

```
Python (2.7+ or 3.3+)
pip
Python-dev
```

## 安装过程

**Mac 下使用 [Homebrew](https://brew.sh/) 安装：**

```
brew install thefuck
```

**Ubuntu 下安装：**

```
sudo apt update
sudo apt install python3-dev python3-pip
sudo pip3 install thefuck
```

**其他操作系统你可以使用 Python 的 pip 安装：**

```
pip install thefuck
```

### 配置

**最后，不要忘记为 The Fuck 设置 alias**

暂时命令

```
eval $(thefuck --alias)
```

在文件中永久配置

```
#编辑bashrc配置文件
vim ~/.bashrc
#在文件尾加入一行给thefuck取别名fuck
eval "$(thefuck --alias fuck)"
#使生效
source ~/.bashrc
```

最后就可以痛快的使用啦！附上[`TheFuck`官方链接](https://github.com/nvbn/thefuck)

### 原理

> 其实`TheFuck`的原理就是规则匹配（正则表达式），如果找到匹配规则的命令，则创建一个命令给用户选择或直接运行。

```
cat_dir - 当你尝试cat目录的时候，用ls替换cat;
cd_correction – 拼写检查和纠正失败的cd命令；
cd_mkdir – 在进入目录之前创建目录；
cd_parent – 更改 cd.. 为cd ..；
dry – 修复类似的重复问题：git git push；
fix_alt_space – 用空格字符代替Alt + Space；
# 还有很多可以参考https://github.com/nvbn/thefuck#how-it-works
```

## ls的翻篇小火车`sl`

**敲下以下命令**

**Ubantu**

```
sudo apt-get install sl
```

**CentOs**

```yum
sudo yum install sl 
```

![image-20221005205546460](https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/image-20221005205546460.png)

嘟嘟嘟嘟~~就会看到一个小火车，从你屏幕缓缓驰过....

还可以配合fuck使用就是

```
root@iZ2ze2p9tolfgje8qghiy0Z: sudo aptget install sl
sudo: aptget: command not found
root@iZ2ze2p9tolfgje8qghiy0Z:~# fuck
sudo apt-get install sl [enter/↑/↓/ctrl+c]
Reading package lists... Done
Building dependency tree       
Reading state information... Done
```

## 反向装逼 `tac` 

 **Ubantu**

```
sudo apt-get install tac
```

**CentOs**

```yum
sudo yum install tac
```

*用cat看代码时*

![image-20221005205556042](https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/image-20221005205556042.png)

*tac呢*

![image-20221005205604369](https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/image-20221005205604369.png)

## 自己是黑客.jpg

 **Ubantu**

```
sudo apt-get install cmatrix
```

**CentOs**

```yum
sudo yum install cmatrix
```

安装好后只要在命令行输入

```
cmatrix
```

![image-20221005205611298](https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/image-20221005205611298.png)

Wow~

只要按Ctrl+C就可以退出，适合当息屏显示

## 谨慎使用`fork`

根据你的shell，选择如下2个命令中的1个，一条命令弄死Linux：

```
:() { :|:& };:
```

或者

```
.() { .|.& };.
```

接着就可以重启啦
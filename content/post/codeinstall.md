---
title: 在线code安装教程
date: 2022-09-12 11:11:10
tags:
- toy 
- Linux
categories: 
- toy
---



##前置条件：


1. 云服务器
2. ssh的连接工具 如[putty](https://www.putty.org/)，[Termius](https://termius.com/)，mac用户可以直接用终端连接.

安装教程
----

首先使用你的ssh工具连接服务器

```
//输入命令下载codeserver
wget https://github.com/coder/code-server/releases/download/v4.6.1/code-server-4.6.1-linux-amd64.tar.gz
//解压
tar -zxvf code-server-4.6.1-linux-amd64.tar.gz
//进入codeserver目录
cd code-server-4.6.1-linux-amd64
//设置密码(密码在双引号内)
export PASSWORD=123456
//启动codeserver
./code-server --port 8081 --host 0.0.0.0 --auth password
```

在浏览器上方输入`你的服务器IP:8081` 即可进入登录界面

这个时候输入之前设置的密码就可以进入codeserver了

配置Screen进程守护
------------

之前的步骤有一个问题,就是当你退出ssh进程的时候,你会发现网站进不去了。

因为当ssh进程关闭的时候，会自动清除当前进程。

我们得下载Screen来给codeserver进行进程守护，防止进程自动退出。

安装Screen
--------
```
//复制适合自己系统的命令安装
//Centos系统
yum install screen
//Debian/Ubuntu系统
apt-get install screen
```
保护进程实现后台运行
--------
```
//以code_server为名字建立进程
screen -S code_server
//再次输入以下命令
cd code-server-4.6.1-linux-amd64
export PASSWORD=123456
./code-server --port 8081 --host 0.0.0.0 --auth password
```



此时关闭ssh终端,也可以照常进入网页啦！

![](https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE-2022-09-06-215111.jpg)

微软官方[请输入链接描述][2]


[1]: https://dreamin.space/usr/uploads/2022/09/3918272090.png
[2]: https://vscode.dev/
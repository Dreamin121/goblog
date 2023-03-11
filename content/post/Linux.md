---
title: Study Notes for Linux
date: 2022-10-02 11:41:10
tags:     
- Linux
categories: 
- 学习笔记
---

# Linux

## 计算机基础

**1.软件程序的运行**

硬件如同人的身体，软件如同人的灵魂。没有了灵魂的躯体也不过就是行尸走肉

**1.1 **机器程序与编译程序

电脑只认识0与1而已，而且电脑最重要的运算与逻辑判断是在CPU内部， 而 CPU其实是具有微指令集的。因此，我们需要CPU帮忙工作时，就得要参考微指令集的内容， 然后撰写让CPU读的懂的指令码给CPU执行，这样就能够让CPU运行了。

流程：

+ 需要了解机器语言：机器只认识0与1，因此你必须要学习直接写给机器看的语言。
+ 需要了解所有硬件的相关功能函数：因为你的程序必须要写给机器看， 当然你就得要参考机器本身的功能，然后针对该功能去撰写程序码。
+ 程序不具有可携性：每个CPU都有独特的微指令集，同样的，每个硬件都有其功能函数。
+ 程序具有专一性：因为这样的程序必须要针对硬件功能函数来撰写， 如果已经开发了一支浏览器程序，想要再开发文件管理程序时，还是得从头再参考硬件的功能函数来继续撰写。

所以，需要开发让人类能看得懂得程序语言。然后创造一种“编译器”让人类的写的程序语言转换为机器能看懂的机器码。常见的编译器有C,C++,Java,Fortran等等。

![image-20220922203728264](https://dreamin-1312842512.cos.ap-guangzhou.myqcloud.com/image-20220922203728264.png)

## 关于学习Linux

两个重要的因素是造成我们学习的原动力： 

+ 创建兴趣： Linux上面可以玩的东西真的太多了，你可以选择一个有趣的课题来深入的玩 一玩！不论是Shell还是图形接口等等， 只要能够玩出兴趣，那么再怎么苦你都会不觉得喔！

+ 成就感： 成就感是怎么来的？说实在话，就是“被认同”来的！怎么被认同呢？写心得分享啊！当你写了心得分享，并且公告在 BBS 上面，自然有朋友会到你的网页去瞧一瞧， 当大家觉得你的网页内容很棒的时候， 哈哈！你肯定会加油继续的分享下去而无法自拔。

## 主机规划与磁盘分区

**Linux各硬件设备在系统中为文件名**

![image-20221001164035525](https://dreamin-1312842512.cos.ap-guangzhou.myqcloud.com/image-20221001164035525.png)

**磁盘分区**

**MBR 主要分区、延伸分区与逻辑分区的特性：**

+ 主要分区与延伸分区最多可以有四笔（硬盘的限制） ；
+ 延伸分区最多只能有一个（操作系统的限制）；
+ 逻辑分区是由延伸分区持续切割出来的分区；
+ 能够被格式化后，作为数据存取的分区为主要分区与逻辑分区。延伸分区无法格式化； 
+ 逻辑分区的数量依操作系统而不同，在Linux系统中SATA硬盘已经可以突破63个以上的分区限制；

**MBR分区限制：**

+ 操作系统无法抓取到 2.2T 以上的磁盘容量
+ MBR 仅有一个区块，若被破坏后，经常无法或很难救援
+ MBR 内的存放开机管理程序的区块仅 446Bytes，无法容纳较多的程序码

**GUID partition table, GPT 磁盘分区表：**

+ 与 MBR 仅使用第一个 512Bytes 区块来纪录不同， GPT 使用了 34 个 LBA 区块来纪录分区信息
+ GPT 除了前面 34 个 LBA 之外，整个磁盘的最后 33 个 LBA 也拿来作为另一个备份

**计算机开机流程：**

1. BIOS：开机主动执行的固件，会认识第一个可开机的设备；
2. MBR：第一个可开机设备的第一个扇区内的主要开机记录区块，内含开机管理程序；
3. 开机管理程序（boot loader）：一支可读取核心文件来执行的软件；
4. 核心文件：开始操作系统的功能

**BIOS与UEFI BIOS区别**

![image-20221001200526805](https://dreamin-1312842512.cos.ap-guangzhou.myqcloud.com/image-20221001200526805.png)



**主机硬盘的规划**

频繁读写的目录

+ boot
+  / 
+ /home 
+ /var 
+ Swap

1):/bin   [***]   (/usr/bin 、 /usr/local/bin) • 是Binary的缩写, 这个目录存放着最经常使用的命令。

2): /sbin (/usr/sbin 、 /usr/local/sbin) • s就是Super User的意思，这里存放的是系统管理员使用的系统管理程序。

3):/home [***] • 存放普通用户的主目录，在Linux中每个用户都有一个自己的目录，一般 该目录名是以用户的账号命名的。

4):/root [***] • 该目录为系统管理员，也称作超级权限者的用户主目录。

5): /lib • 系统开机所需要最基本的动态连接共享库，其作用类似于Windows里的DLL文件。几 乎所有的应用程序都需要用到这些共享库。

6):/lost+found • 这个目录一般情况下是空的，当系统非法关机后，这里就存放了一些文件。

7):/etc [***] • 所有的系统管理所需要的配置文件和子目录 my.conf 

8):/usr  [***] • 这是一个非常重要的目录，用户的很多应用程序和文件都放在这个目录下，类似与 windows下的program files目录

9):/boot [***] • 存放的是启动Linux时使用的一些核心文件，包括一些连接文件以及镜像文件

10):/srv • service缩写，该目录存放一些服务启动之后需要提取的数据。

11):/sys • 这是linux2.6内核的一个很大的变化。该目录下安装了2.6内核中新出现的一个文件系统 sysfs

12):tmp • 这个目录是用来存放一些临时文件的

13):/dev • 类似于windows的设备管理器，把所有的硬件用文件的形式存储。

14):/media [***] • linux系统会自动识别一些设备，例如U盘、光驱等等，当识别后，linux 会把识别的设备挂载到这个目录下。

15):/mnt [***] • 系统提供该目录是为了让用户临时挂载别的文件系统的，我们可以将外部的存储挂 载在/mnt/上，然后进入该目录就可以查看里的内容了。

16):/opt     • 这是给主机额外安装软件所摆放的目录。如安装ORACLE数据库就可放到该目录下，默认为空。

17):/usr/local [***] • 这是另一个给主机额外安装软件所安装的目录。一般是通过编译源码方式安装的程序。

18):/var [***] • 这个目录中存放着在不断扩充着的东西，习惯将经常被修改的目录放在这个目录下。包括各种日志文件。

### 重点

+ 如果磁盘容量大于 2TB 以上时，系统会自动使用 GPT 分区方式来处理磁盘分区。
+ GPT 分区已经没有延伸与逻辑分区的概念，可以想像成所有的分区都是主分区，某些操作系统要使用 GPT 分区时，必须要搭配 UEFI 的新型 BIOS 格式才可安装使用。

+ Linux操作系统的文件使用目录树系统，与磁盘的对应需要有“挂载”的动作才行；
+ 开机的流程由：BIOS-->MBR-->-->boot loader-->核心文件

## Vim程序编辑器

**三种模式**

+ 一般指令模式 （command mode）
+ 编辑模式 （insert mode）
+ 命令行命令模式 （command-line mode）

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202210211616324.png" alt="image-20221021161616258" style="zoom:50%;" />

**常见命令**

*1.输入模式 (i):*
按 i 进入insert输入模式
HJKL代替上下左右
H向左 L向右 J向下 K向上
Ctrl + B 向上翻页
Ctrl + F 想下翻页
Ctrl + E/Y 滚动
Shift + G 末尾
双击gg 首字符

*2.命令模式(esc):*
i 光标位置前面输入 
a 光标位置后面输入
o enter到下一行输入
x 删除光标所在字符
dd 删除整个一行
u 撤销
dw 删除整个单词
b 跳跃单词首字母
e 跳跃单词尾字母
w 跳跃到下一个单词首字母

shift 省略多个单词直接跳
Shift + 6 ^ 跳跃到本行的首字母
Shift + 4 $ 跳跃到本行的dd尾字母
按 0 跳跃到本行首个字符（ 包括空格）
{}移动整段大括号
yw 表示复制一个单词
y$ 表示从当前开始，往后复制到行末尾
p 粘贴剪贴板的内容
*3.可视化模式*
v + hjkl 进行字符选择
V + hjkl 进行行选择
v + G 全选
快捷选择
vaw 快速选择单词
vab 包含括号
vaB 包含大括号
shift + <> 前后缩进
v shift + · ~ 字母大小写切换
v + u/U 全部转换为小写/大写
行号+g
g 跳跃到指定的行号
快速查找
/查找字符 按n 进入下一个
快速替换
按行:s/查找单词/替换单词/g
全局:%s/查找单词/替换单词/g
指定:首，尾s/查找/替换/g
+c 询问

## Bashshell

**硬件、核心与 Shell**

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202210221653386.png" alt="image-20221022165342252" style="zoom:50%;" />

例子：用电脑播放音乐

1. 硬件：当然就是需要你的硬件有“声卡芯片”这个配备，否则怎么会有声音；
2. 核心管理：操作系统的核心可以支持这个芯片组，当然还需要提供芯片的驱动程序；
3. 应用程序：需要使用者输入发生声音的指令。

**为何要学命令行的 shell？**

+ 命令行的 shell：大家都一样

+ 远端管理：命令行就是比较快

+ Linux 的任督二脉： shell 是也

**系统的合法 shell 与 /etc/shells 功能**

历史：由于早年的 Unix 年代，发展者众，所以由于 shell 依据发展者的不同就有许多的版本，例如常听到的 Bourne SHell （sh） 、在 Sun 里头默认的 C SHell、 商业上常用的 K SHell、, 还有 TCSH 等等，每一种 Shell 都各有其特点，Linux 使用的这一种版本就称为“ Bourne Again SHell （简称 bash） ”，这个 Shell 是 Bourne Shell 的增强版本，也是基准于 GNU 的架构下发展出来的。

*Linux可用的shells*
+ /bin/sh （已经被 /bin/bash 所取代）
+ /bin/bash （就是 Linux 默认的 shell）
+ /bin/tcsh （整合 C Shell ，提供更多的功能）
+ /bin/csh （已经被 /bin/tcsh 所取代）

> 系统某些服务在运行过程中，会去检查使用者能够使用的 shells ，而这些 shell 的查询就是借由 /etc/shells 这个文件

**Bash Shell 的功能**

+ 命令编修能力 （history）：

只要在命令行按“上下键”就可以找到前/后一个输入的指令，而在很多distribution 里头，默认的指令记忆功能可以到达 1000 个！也就是说，曾经下达过的指令几乎都被记录下来了。
这么多的指令记录在哪里呢？在你的主文件夹内的 .bash_history 不过，需要留意的是，
~/.bash_history 记录的是前一次登陆以前所执行过的指令， 而至于这一次登陆所执行的指令都被暂存在内存中，当你成功的登出系统后，该指令记忆才会记录到 .bash_history 当中

+ 命令与文件补全功能： （[tab] 按键的好处）

+ 命令别名设置功能： （alias）

可以将`ls -al` 的命令通过`alias lm='ls -al'`就可以将`lm`直接用来调命令了

+ 工作控制、前景背景控制： （job control, foreground, background）

+ 程序化脚本： （shell scripts）

+ 万用字符： （Wildcard）

**查询指令是否为 Bash shell 的内置命令： type**

知道这个指令是来自于外部指令（指的是其他非 bash 所提供的指令） 或是内置在 bash 当中只要利用type 这个指令来观察即可。

```bash
[dmtsai@study ~]$ type [-tpa] name
选项与参数：
：不加任何选项与参数时，type 会显示出 name 是外部指令还是 bash 内置指令
-t ：当加入 -t 参数时，type 会将 name 以下面这些字眼显示出他的意义：
file ：表示为外部指令；
alias ：表示该指令为命令别名所设置的名称；
builtin ：表示该指令为 bash 内置的指令功能；
-p ：如果后面接的 name 为外部指令时，才会显示完整文件名；
-a ：会由 PATH 变量定义的路径中，将所有含 name 的指令都列出来，包含 alias
范例一：查询一下 ls 这个指令是否为 bash 内置？
[dmtsai@study ~]$ type ls
ls is aliased to `ls --color=auto' &lt;==未加任何参数，列出 ls 的最主要使用情况
[dmtsai@study ~]$ type -t ls
alias &lt;==仅列出 ls 执行时的依据
[dmtsai@study ~]$ type -a ls
ls is aliased to `ls --color=auto' &lt;==最先使用 aliase
ls is /usr/bin/ls &lt;==还有找到外部指令在 /bin/ls
范例二：那么 cd 呢？
[dmtsai@study ~]$ type cd
cd is a shell builtin &lt;==看到了吗？ cd 是 shell 内置指令
```

**指令的下达与快速编辑按钮**

```bash
范例：如果指令串太长的话，如何使用两行来输出？
[dmtsai@study ~]$ cp /var/spool/mail/root /etc/crontab \
&gt; /etc/fstab /root
```

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202210221744722.png" alt="image-20221022174441674" style="zoom: 80%;" />

### **Shell 的变量功能**

+ 变量的可变性与方便性

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202210221748828.png" alt="image-20221022174833790" style="zoom: 67%;" />

由于系统已经帮我们规划好 MAIL 这个变量，所以使用者只要知道 mail 这个指 令如何使用即可， mail 会主动的取用 MAIL 这个变量，就能够如上图所示的取得自己的邮件信箱了

+ 影响 bash 环境操作的变量

例如下达 ls 这个指令时，系统就是通过 PATH 这个变量里面的内容所记录的路径顺序来搜寻指令。如果在搜寻完 PATH 变量内的路径还找不到 ls 这个指令时， 就会在屏幕上显示“ command not found ”的错误讯息了。

+ 脚本程序设计 （shell script） 的好帮手

例如你要写一个大 型的 script 时，有些数据因为可能由于使用者习惯的不同而有差异，比如说路径好了，由于该路径在 script 被使用在相当多的地方，如果下次换了一部主机，都要修改 script 里面的所有路径， 这个时候如果使用变量，而将该变量的定义写在最前面，后面相关的路径名称都以变量来取代， 那么你只要修改一行就等于修改整篇 script 了。

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202210221753121.png" alt="image-20221022175328075" style="zoom:67%;" />

**变量的取用与设置：echo, 变量设置规则, unset**

可以利用 echo 这个指令来取用变量， 但是，变量在被取用时， 前面必须要加上钱字号“ $ ”才行

```bash
[mua@localhost ~]$ echo $variable

[mua@localhost ~]$ echo $PATH
/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/home/mua/.local/bin:/home/mua/bin
[mua@localhost ~]$ echo ${PATH} # 比较规范的形式
/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/home/mua/.local/bin:/home/mua/bin
# 设置变量名
[mua@localhost 桌面]$ fuck=myname
[mua@localhost 桌面]$ echo $fuck
myname
[mua@localhost 桌面]$ fuck=VBird
[mua@localhost 桌面]$ echo $fuck
VBird
```

**注意事项**

+ 变量与变量内容以一个等号“=”来链接，如下所示： “myname=VBird”
+ 等号两边不能直接接空白字符，如下所示为错误： “myname = VBird”或“myname=VBird Tsai”
+ 变量名称只能是英文字母与数字，但是开头字符不能是数字，如下为错误：“2myname=VBird”
+ 变量内容若有空白字符可使用双引号“"”或单引号“'”将变量内容结合起来，但
  + 双引号内的特殊字符如 $ 等，可以保有原本的特性，如下所示： “var="lang is$LANG"”则“echo $var”可得“lang is zh_TW.UTF-8”
  + 单引号内的特殊字符则仅为一般字符 （纯文本），如下所示： “var='lang is $LANG'”则“echo $var”可得“lang is $LANG”
+ 可用跳脱字符“ \ ”将特殊符号（如 [Enter], $, \, 空白字符, '等）变成一般字符，如：“myname=VBird\ Tsai”
+ 在一串指令的执行中，还需要借由其他额外的指令所提供的信息时，可以使用反单引号“ 指令 ”或 “$（指令）”。特别注意，那个 ` 是键盘上方的数字键 1 左边那个按键，而不是单引号！ 例如想要取得核心版本的设置： “version=$（uname -r）”再“echo$version”可得“3.10.0-229.el7.x86_64”
+ 若该变量为扩增变量内容时，则可用 "$变量名称" 或 ${变量} 累加内容，如下所示：“PATH="$PATH":/home/bin”或“PATH=${PATH}:/home/bin”
+ 若该变量需要在其他子程序执行，则需要以 export 来使变量变成环境变量： “exportPATH”
+ 通常大写字符为系统默认变量，自行设置变量可以使用小写字符，方便判断 （纯粹依照使用者兴趣与嗜好） 
+ 取消变量的方法为使用 unset ：“unset 变量名称”例如取消 myname 的设置： “unsetmyname”

**测试**

```bash
# 范例一：设置变量hr 内容为fuck
[mua@localhost ~]$ 16hr=fuck
bash: 16hr=fuck: 未找到命令...  ## 变量开头为数字
[mua@localhost ~]$ 16hr = fuck
bash: 16hr: 未找到命令...  ## 变量等于号两侧存在空格
# 范例二：当变量内容为fuck's name
[mua@localhost ~]$ hr=fuck's name
> ^C ## 单引号与双引号必须要成对，当你按下 enter 后，提示继续输入变量内容
[mua@localhost ~]$ hr="fuck's name" ## 成功创建
[mua@localhost ~]$ hr='fuck's name'
> ^C ## 因为前两个单引号已成对，后面就多了一个不成对的单引号，提示继续输入
[mua@localhost ~]$ hr=fuck\'s\ name ## 用跳脱字符成功创建
# 范例三：要在 PATH 这个变量当中“累加”:/home/dmtsai/bin 这个目录
[mua@localhost ~]$ PATH=$PATH:/home/mua/bin
[mua@localhost ~]$ PATH="$PATH":/home/mua/bin
[mua@localhost ~]$ PATH=${PATH}:/home/mua/bin
# 范例四：将 hr 的内容多出 "yes" 
[mua@localhost ~]$ echo $hryes
## 没有双引号，变量name 的内容就是 $nameyes 这个变量
[mua@localhost ~]$ echo "$hr"yes
yes ## 成功添加
[mua@localhost ~]$ echo ${hr}yes
yes ## 成功添加，以此例子为标准
# 范例五：让刚刚设置的 name=VBird 可以用在下个 shell 的程序
[mua@localhost ~]$ hr=fuck ## 赋值变量
[mua@localhost ~]$ bash ## 进入子进程
[mua@localhost ~]$ echo $hr 
## 调用失败
[mua@localhost ~]$ exit
exit
[mua@localhost ~]$ export hr ## 设置系统环境变量
[mua@localhost ~]$ bash 
[mua@localhost ~]$ echo $hr
fuck ## 调用成功
[mua@localhost ~]$ exit
exit
# 范例六：进入到目前核心的模块目录
```

### 数据流重导向

> 数据流:分三种，标准输入流（由键盘输入产生），标准输出流（执行命令的输出日志），标准错误输出流(同理）

**什么是数据流重导向**

将本应由键盘输入或输出到屏幕上的数据流重定向到文件或设备上（保存到文件或设备中），称之为数据流重定向

**数据流重定向的作用**

- 屏幕输出信息需要保存
- 后台执行程序，不想将日志打在桌面上
- 区分输出标准输出与标准错误输出处理时
- 丢弃已知错误信息，`2> /dev/null`

**代号与表现方式**

1. 标准输入 （stdin） ：代码为 `0` ，使用 `< `或 `<<` ；
2. 标准输出 （stdout）：代码为 `1` ，使用 `>` 或 `>>` ；
3. 标准错误输出（stderr）：代码为 `2` ，使用 `2>` 或 `2>>` ；

区别

- `>` ：以【覆盖】的方式，将【正确的数据】输出到文件或设备上
- `>>`：以【追加】的方式，将【正确的数据】输出到文件或设备上
- `2>`：以【覆盖】的方式，将【错误的数据】输出到文件或设备上
- `2>>`：以【追加】的方式，将【错误的数据】输出到文件或设备上

**黑洞 /dev/null**

当需要将某些日志不重要的数据流重定向走，但又不想保存文件占用空间时，重定向数据流 `/dev/null` 设备上，相当于将数据丢入黑洞

Eg:

将标准输出丢入黑洞

```bash
[root@localhost mua]# cat /etc/profile > /dev/null
```

将标准错误输出丢入黑洞

```bash
[root@localhost mua]# find / -name .bashrc 2> /dev/null
```

**将stdout与stderr输出到同一文件或设备**

分别设置stdout与stderr到同一文件

```bash
[mua@localhost ~]$ find / -name .bashrc > /tmp/stdtestlogs1 2> /tmp/stdtestlogs1
```

输出两者带同一文件中，语法`command >[file]>&1`

```bash
[mua@localhost ~]$ find / -name .bashrc & /tmp/stdtustlogs2 2>&1
```

&语法`[command]&>[file] `

```bash
[mua@localhost ~]$ find / -name .bashrc &> /tmp/stdtestlogs3
```

将所有日志输入黑洞

```bash
[mua@localhost ~]$ find / -name .bashrc > /dev/null 2>&1
```

将错误日志输入黑洞

```bash
[mua@localhost ~]$ find / -name .bashrc 2> /dev/null
```

**标准输入流重定向 < 与 <<**

将原本由键盘输入的数据，改由文件内容提供（`<` 表示使用文件提供数据，`<<` 用来【设置输入结束的字符】）

例如：

将`~/.bashrc`输出重定向到`/tmp/stdintest`中

```bash
[mua@localhost ~]$ cat > /tmp/stdintest < ~/.bashrc
```

设置【输入结束字符】，将一段文字输入到`/tmp/stdintest2`中

```bash
[mua@localhost ~]$ cat > /tmp/stdintest <<EOF
> 这是一条测试
> 这是一条测
> 这是一条
> 这是一
> 这是
> 这
> EOF
```

**命令执行的判断依据： ; , &&, ||**

+ `cmd` ; `cmd`(不考虑前者是否执行成功)

eg.进行sync同步化再进行关机命令

```bash
sync; sync; shutdown -h now
```

+ `$?` （指令回传值） 与 `&&` 或 `||`

| 执行下达情况 | 说明                                                         |
| ------------ | ------------------------------------------------------------ |
| cmd1&&cmd2   | 1. 若 cmd1 执行完毕且正确执行（$?=0），则开始执行 cmd2。 2. 若 cmd1 执行完毕且为错误 （$?≠0），则 cmd2 不执行。 |
| cmd1\|\|cmd2 | 1. 若 cmd1 执行完毕且正确执行（$?=0），则 cmd2 不执行。 2. 若 cmd1 执 行完毕且为错误 （$?≠0），则开始执行 cmd2。 |

*练习*

```bash
## 先查询有无此目录再创建xixi这个文件
[mua@localhost ~]$ ls /tmp/abc && touch /tmp/abc/xixi
ls: cannot access /tmp/abc: No such file or directory #查询无
[mua@localhost home]$ mkdir /tmp/abc # 创建文件夹
[mua@localhost home]$ ls /tmp/abc && touch /tmp/abc/xixi #执行成功
#总结 如果查询不到，就不会执行下一个语句
##总是尝试执行语句
[mua@localhost ~]$ ls /tmp/abc &#124;&#124; mkdir /tmp/abc && /tmp/abc/hehe
```

上条执行判断流程图

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211251704834.png" alt="image-20221125170424765" style="zoom: 67%;" />

参考[linux shell数据重定向](https://www.cnblogs.com/chengmo/archive/2010/10/20/1855805.html)

### 管线命令pipe

管道命令的操作符时“|”，它仅能处理经由前面一个指令传出的正确输出信息，也就是 standard output 的信息，对于 stdandard
error 信息没有直接处理能力。然后，传递给下一个命令，作为标准的输入 standard input.









## Linux正则表达式

**概念：**正则表达式 （Regular Expression, RE, 或称为常规表达式）是通过一些特殊字符的排列，用以“搜寻/取代/删除”一列或多列文字字串， 简单的说，正则表达式就是用在字串的处理上面的 一项“表示式”。正则表达式并不是一个工具程序， 而是一个字串处理的标准依据，如果想要以正则表达式的方式处理字串，就得要使用支持正则表达式的工具程序才行， 这类的工具程序很多，例如 vi, sed, awk 等等

+ 例如

```
mua@fuck:~$ grep 'ls' /lib/systemd/system/*
/lib/systemd/system/accounts-daemon.service:ProtectHome=false
/lib/systemd/system/accounts-daemon.service:PrivateTmp=false
/lib/systemd/system/accounts-daemon.service:PrivateUsers=false
/lib/systemd/system/alsa-restore.service:# can be switched using a file exist check - /etc/alsa/state-daemon.conf .
```

+ 正则表达式对于系统管理员的用途

由于系统如果在繁忙的情况之下，每天产生的讯息信息会多到你无法想像的地步，运用正则表达式极度简化操作人员从千百行的数据里面找出一行有问题的讯息的效率。

### 基础正则表达式

***语系对正则表达式的影响***

文件其实记录的仅有 0 与 1，我们看到的字符文字与数字都是通过编码表转换来的。由于不同语系的编码数据并不相同，所以就会造成数据撷取结果的差异了。所以使用正则表达式时，需要特别留意当时环境的语系为何， 否则可能会发现与别人不相同的撷取结果。

+ “ LANG=C ”语系数据“ 						<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211061012414.png" alt="image-20221106101250300" style="zoom: 67%;" />

***grep 的一些进阶选项***

```bash
mua@fuck:~$ grep [-A] [-B] [--color=auto] '搜寻字串' filename
选项与参数：
-A ：后面可加数字，为 after 的意思，除了列出该行外，后续的 n 行也列出来；
-B ：后面可加数字，为 befer 的意思，除了列出该行外，前面的 n 行也列出来；
--color=auto 可将正确的那个撷取数据列出颜色
```

***基础正则表达式练习***

+ 搜寻特定字符

```bash
mua@fuck:~$  grep -n 'the' regular_express.txt
8:I can't finish the test.^M
12:the symbol '*' is represented as start.
15:You are the best is mean you are the no. 1.
16:The world &lt;Happy&gt; is the same with "glad".
18:google is the best tools for search keyword.
// 反向
mua@fuck:~$ grep -vn 'the' regular_express.txt
//不论大小写
mua@fuck:~$ grep -in 'the' regular_express.txt 
8:I can't finish the test.^M
9:Oh! The soup taste good.^M
12:the symbol '*' is represented as start.
14:The gd software is a library for drafting programs.^M
15:You are the best is mean you are the no. 1.
16:The world &lt;Happy&gt; is the same with "glad".
18:google is the best tools for search keyword.
```

+ 利用中括号[]来搜寻集合字符

```bash
# 利用字符共通点
root@fuck:/test# grep -n 't[ae]st' regular_express.txt
8:I can't finish the test.
9:Oh! The soup taste good.
# 搜寻字符带有**
root@fuck:/test# grep -n '[^g]oo' regular_express.txt
2:apple is my favorite food.
3:Football game is not use feet only.
18:google is the best tools for search keyword.
19:goooooogle yes!
#  搜寻带数字
root@fuck:/test# grep -n '[0-9]' regular_express.txt 
5:However, this dress is about $ 3183 dollars.
15:You are the best is mean you are the no. 1.
//其他写法
root@fuck:/test# grep -n '[[:digit:]]' regular_express.txt 
# 带小写字母
root@fuck:/test# grep -n '[^a-z]oo' regular_express.txt 
3:Football game is not use feet only.
//其他写法
root@fuck:/test# grep -n '[^[:lower:]]oo' regular_express.txt 
```

+ 行首与行尾字符 ^ $

```bash
# 句首
root@fuck:/test# grep -n '^the' regular_express.txt 
12:the symbol '*' is represented as start.
# 句首为小写
root@fuck:/test# grep -n '^[a-z]' regular_express.txt 
2:apple is my favorite food.
4:this dress doesn't fit me.
10:motorcycle is cheap than car.
12:the symbol '*' is represented as start.
//其他写法
root@fuck:/test# grep -n '^[[:lower:]]' regular_express.txt 
# 开头不是字母
root@fuck:/test# grep -n '^[^a-zA-Z]' regular_express.txt 
1:"Open Source" is a good mechanism to develop programs.
21:# I am VBird
//其他写法
root@fuck:/test# grep -n '^[^[:alpha:]]' regular_express.txt 
# 以句号作为结尾（用到跳脱字符'\'）
root@fuck:/test# grep -n '\.$' regular_express.txt 
# 找出空白行
root@fuck:/test# grep -n '^$' regular_express.txt 
```

+ 任意一个字符.与重复字符 *

```bash
#  .（小数点）：代表“一定有一个任意字符”的意思；
root@fuck:/test# grep -n 'g..d' regular_express.txt 
1:"Open Source" is a good mechanism to develop programs.
9:Oh! The soup taste good.
16:The world &lt;Happy&gt; is the same with "glad".
#  *（星星号）：代表“重复前一个字符， 0 到无穷多次”的意思，为组合形态 
root@fuck:/test# grep -n 'ooo*' regular_express.txt 
1:"Open Source" is a good mechanism to develop programs.
2:apple is my favorite food.
3:Football game is not use feet only.
9:Oh! The soup taste good.
18:google is the best tools for search keyword.
// 中间间隔
root@fuck:/test# grep -n 'g*g' regular_express.txt 
1:"Open Source" is a good mechanism to develop programs.
3:Football game is not use feet only.
9:Oh! The soup taste good.
# 单个字符 g....g
root@fuck:/test# grep -n 'g.*g' regular_express.txt 
1:"Open Source" is a good mechanism to develop programs.
14:The gd software is a library for drafting programs.
16:The world &lt;Happy&gt; is the same with "glad".
18:google is the best tools for search keyword.
# 任意数字
root@fuck:/test# grep -n '[0-9][0-9]*' regular_express.txt 
5:However, this dress is about $ 3183 dollars.
15:You are the best is mean you are the no. 1.
```
+ 限定连续 RE 字符范围 {}(记得添加跳脱字符`\{`）

```bash
# 查找特定范围
root@fuck:/test# grep -n 'o\{2\}' regular_express.txt 
1:"Open Source" is a good mechanism to develop programs.
2:apple is my favorite food.
3:Football game is not use feet only.
9:Oh! The soup taste good.
18:google is the best tools for search keyword.
19:goooooogle yes!
# 双端界定范围
root@fuck:/test# grep -n 'go\{2,5\}g' regular_express.txt 
18:google is the best tools for search keyword.
```

**基础正则表达式字符汇整**

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211092156739.png" alt="image-20221109215623614" style="zoom: 50%;" />

**sed工具**

**延伸正则表达式**

```bash
root@fuck:/test# grep -v '^$' regular_express.txt | grep -v '^#'
可以替换为
root@fuck:/test# egrep -v '^$|^#' regular_express.txt 
```

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211092218361.png" alt="image-20221109221826302" style="zoom: 80%;" />

### **文件的格式化与相关处理**

**格式化打印： printf**

```bash
[dmtsai@study ~]$ printf '打印格式' 实际内容
选项与参数：
关于格式方面的几个特殊样式：
\a 警告声音输出
\b 倒退键（backspace）
\f 清除屏幕 （form feed）
\n 输出新的一行
\r 亦即 Enter 按键
\t 水平的 [tab] 按键
\v 垂直的 [tab] 按键
\xNN NN 为两位数的数字，可以转换数字成为字符。
关于 C 程序语言内，常见的变量格式
%ns 那个 n 是数字， s 代表 string ，亦即多少个字符；
%ni 那个 n 是数字， i 代表 integer ，亦即多少整数码数；
%N.nf 那个 n 与 N 都是数字， f 代表 floating （浮点），如果有小数码数，
假设我共要十个位数，但小数点有两位，即为 %10.2f
# 例如
root@fuck:/test# printf '%s\t s\t %s\t %s\t %s\t \n' $ (cat printf.txt)
```

**awk：好用的数据处理工具**

数据操作：`awk '条件类型1{动作1} 条件类型2{动作2} ...' filename`

awk 后面接两个单引号并加上大括号 {} 来设置想要对数据进行的处理动作。 awk 可以处理后续接的文件，也可以读取来自前个指令的 standard output。

```bash
# 列出前五行登陆者命令
root@fuck:/test# last -n 5
mua      tty2         tty2             Thu Nov 10 03:37   still logged in
reboot   system boot  5.15.0-52-generi Thu Nov 10 03:37   still running
mua      tty2         tty2             Wed Nov  2 05:56 - crash (7+21:41)
reboot   system boot  5.15.0-52-generi Wed Nov  2 05:56   still running
mua      tty2         tty2             Sun Oct 23 01:14 - crash (10+04:41)
#想要取出帐号与登陆者的 IP ，且帐号与 IP 之间以 [tab] 隔开
[dmtsai@study ~]$ last -n 5 &#124; awk '{print $1 "\t" $3}'
dmtsai 192.168.1.100
dmtsai 192.168.1.100
dmtsai 192.168.1.100
dmtsai 192.168.1.100
dmtsai Fri
```

**`awk`内置变量**

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211131017749.png" alt="image-20221113101742717" style="zoom:67%;" />

```bash
#列出每一行的帐号（就是 $1）；
#列出目前处理的行数（就是 awk 内的 NR 变量）
#并且说明，该行有多少字段（就是 awk 内的 NF 变量）
[dmtsai@study ~]$ last -n 5&#124; awk '{print $1 "\t lines: " NR "\t columns: " NF}'
dmtsai lines: 1 columns: 10
dmtsai lines: 2 columns: 10
dmtsai lines: 3 columns: 10
dmtsai lines: 4 columns: 10
dmtsai lines: 5 columns: 9
```

**逻辑运算字符**

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202211131019209.png" alt="image-20221113101958177" style="zoom:67%;" />

```bash
#逻辑运算上面亦即所谓的大于、小于、等于等判断式上面，习惯上是以“ == ”来表示；
#如果是直接给予一个值，例如变量设置时，就直接使用 = 而已
#假设我要查阅，第三栏小于10 以下的数据，并且仅列出帐号与第三栏
[dmtsai@study ~]$ cat /etc/passwd &#124; awk '{FS=":"} $3 &lt; 10 {print $1 "\t " $3}'
root:x:0:0:root:/root:/bin/bash
bin 1
daemon 2
#第一行未正确显示，利用BEGIN设置第二行
[dmtsai@study ~]$ cat /etc/passwd &#124; awk 'BEGIN {FS=":"} $3 &lt; 10 {print $1 "\t " $3}'
root 0
bin 1
daemon 2
```

### 文件比对工具

**diff**

同一个套装软件的不同版本之间，比较配置文件与原始文件的差异就可以使用`diff`命令

第一步将文件设置为一个新版本

```bash
mua@fuck:~$ mkdir -p /tmp/testpw &lt;
mua@fuck:~$ cd /tmp/testpw/
mua@fuck:/tmp/testpw$ cp /etc/passwd passwd.old
mua@fuck:/tmp/testpw$ cat /etc/passwd &#124;sed -e '4d' -e '6c no six line' &gt;passwd
# 将 /etc/passwd 处理成为一个新的版本，将第四行删除，第六行则取代成为“no six line”，新的文件放置到 /tmp/test 里面，
```

`diff`的用法

```bash
[dmtsai@study ~]$ diff [-bBi] from-file to-file
选项与参数：
from-file ：一个文件名，作为原始比对文件的文件名；
to-file ：一个文件名，作为目的比对文件的文件名；
注意，from-file 或 to-file 可以 - 取代，那个 - 代表“Standard input”之意。
-b ：忽略一行当中，仅有多个空白的差异（例如 "about me" 与 "about me" 视为相同
-B ：忽略空白行的差异。
-i ：忽略大小写的不同。

范例一：比对 passwd.old 与 passwd.new 的差异：
[dmtsai@study testpw]$ diff passwd.old passwd.new
4d3 &lt;==左边第四行被删除 （d） 掉了，基准是右边的第三行
&lt; adm:x:3:4:adm:/var/adm:/sbin/nologin &lt;==这边列出左边（&lt;）文件被删除的那一行内容
6c5 &lt;==左边文件的第六行被取代 （c） 成右边文件的第五行
&lt; sync:x:5:0:sync:/sbin:/bin/sync &lt;==左边（&lt;）文件第六行内容
---
&gt; no six line &lt;==右边（&gt;）文件第五行内容

范例二：比较文件
[mua@localhost testpw]$ diff /etc/rc0.d/ /etc/rc5.d/
只在 /etc/rc0.d/ 存在：K90network
只在 /etc/rc5.d/ 存在：S10network
```

`cmp`命令

`cmp` 主要也是在比对两个文件，他 主要利用“字节”单位去比对， 因此，当然也可以比对 binary file,diff 主要是以“行”为单位比对， `cmp `则是以“字节”为单位去比对。

```bash
[dmtsai@study ~]$ cmp [-l] file1 file2
选项与参数：
-l ：将所有的不同点的字节处都列出来。因为 cmp 默认仅会输出第一个发现的不同点。

范例一：用 cmp 比较一下 passwd.old 及 passwd.new
[dmtsai@study testpw]$ cmp passwd.old passwd.new
passwd.old passwd.new differ: char 106, line 4
```

`patch`命令

patch 这个指令与 diff 可是有密不可分的关系，前面提到，diff 可以用来分辨两个版本之间的差异， 举例来说，刚刚我们所创建的 passwd.old 及 passwd.new 之间就是两个不同版本的文件。 那么，如果要“升级”，就是“先比较先旧版本的差异，并将差异档制作成为补丁文件，再由补丁文件更新旧文件”即可。

```bash
范例一：以 /tmp/testpw 内的 passwd.old 与 passwd.new 制作补丁文件
[dmtsai@study testpw]$ diff -Naur passwd.old passwd.new &gt; passwd.patch
[dmtsai@study testpw]$ cat passwd.patch
--- passwd.old 2015-07-14 22:37:43.322535054 +0800 &lt;==新旧文件的信息
+++ passwd.new 2015-07-14 22:38:03.010535054 +0800
@@ -1,9 +1,8 @@ &lt;==新旧文件要修改数据的界定范围，旧文件在 1-9 行，新文件在 1-8 行
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
-adm:x:3:4:adm:/var/adm:/sbin/nologin &lt;==左侧文件删除
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
-sync:x:5:0:sync:/sbin:/bin/sync &lt;==左侧文件删除
+no six line &lt;==右侧新文件加入
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
```

文件打印工具`pr`

- 用于多打印“文件时间”、“文件文件名”及“页码”三大项目。

```bash
[root@localhost testpw]# pr passwd.new 


2022-11-17 20:04                    passwd.new                    Page 1


root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/黄蓉
```

### 情景运用

+ 通过 grep 搜寻特殊字串，并配合数据流重导向来处理大量的文件搜寻问题。
  + 目标：正确的使用正则表达式；
  + 前提：需要了解数据流重导向，以及通过子指令 $（command） 来处理文件名的搜寻； 我们简单的以搜寻星号 （*） 来处理下面的任务：
    + 利用正则表达式找出系统中含有某些特殊关键字的文件，举例来说，找出在 /etc 下面含有星号 （*） 的文件与内容：解决的方法必须要搭配万用字符，但是星号本身就是正则表达式的字符，因此需要这样进行：

```bash
[root@localhost testpw]# grep '\*' /etc/* 2&gt; /dev/null
[1] 10332
grep: /etc/abrt: Is a directory
Binary file /etc/aliases.db matches
grep: /etc/alsa: Is a directory
grep: /etc/alternatives: Is a directory
······
```

如果是想要连同完整的此目录数据，则

```bash
[dmtsai@study ~]$ grep '\*' $（find /etc -type f ） 2&gt; /dev/null
# 如果只想列出文件名而不要列出内容的话，使用下面的方式来处理即可喔！
[dmtsai@study ~]$ grep -l '\*' $（find /etc -type f ） 2&gt; /dev/null
```

如果文件数量太多，如同上述的案例，如果要找的是全系统（/）呢？可以这样做:

```bash
[dmtsai@study ~]$ grep '\*' $（find / -type f 2&gt; /dev/null ）
-bash: /usr/bin/grep: Argument list too long
```

由于命令行的内容长度是有限制的，因此当搜寻的对象是整个系统时，上述的指令会发生错误。此时我们可以通过管线命令以及 xargs 来处理。举例来说，让 grep 每次仅能处理 10 个文件名，此时可以这样想:

1. 先用 find 去找出文件；
2. 用 xargs 将这些文件每次丢 10 个给 grep 来作为参数处理；
3. grep 实际开始搜寻文件内容。 所以整个作法就会变成这样：

`[dmtsai@study ~]$ find / -type f 2> /dev/null | xargs -n 10 grep '\*'`

ps.**获取IP**

```bash
[root@localhost testpw]# ifconfig ens33 &#124; grep 'inet' &#124;sed 's/^.*inet //g' &#
[1] 11088
[root@localhost testpw]# ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.226.141  netmask 255.255.255.0  broadcast 192.168.226.255
        inet6 fe80::d50b:4c8c:5213:8ae2  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:a6:32:c5  txqueuelen 1000  (Ethernet)
        RX packets 2357  bytes 1990618 (1.8 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1396  bytes 150431 (146.9 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
#将命令指定为myip
[root@localhost testpw]# alias myip="ifconfig ens33 &#124; grep 'inet' &#124;sed 's/^.*inet //g' "
[root@localhost testpw]# myip
[1] 11117
[root@localhost testpw]# ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500

```

## Shell  script


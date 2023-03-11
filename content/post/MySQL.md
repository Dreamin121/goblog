---
title: Mysql Basics
date: 2022-09-09 11:11:10
tags:
- Mysql       
- code
categories: 
- Mysql
---

1.数据库：为了增删改查数据。（文件保存数据很蠢很蠢）
2.C R U D：增删改查的专业术语。  
3.层次、网状、关系型模型数据库

## **数据库开始**

show databases;

imformation_schema：信息数据库，其中保存着关于 MySQL 服务器所维护的所有其他数据库的信息，如数据库名，数据库的表，表栏的数据类型与访问权限等

mysql：保存了用户信息。

performance_schema：监控 MySQL 运行过程的资源消耗情况。

sys： 通过过视图的形式把 information_schema 和 performance_schema 结合起来，查询出更加令人容易理解的数据。

## **数据库基本操作**

创建数据库

```
语句：

create database student;

判断创建语句：

create database if not exists student;

关键字变量名语句：

create database `database`;
```

删除数据库
```
语句：

drop database student;

判断删除语句：

drop database if exists student;

关键字变量名语句：

drop database `database`;
```

查看创建数据库的 SQL：
```
show create database student;
```

回退的语句：

Ctrl + C（^C）

创建数据库设置指定的字符编码
```
create database if not exists teacher charset=gbk;
```

修改数据库字符编码
```
alter database student charset=gbk;
```

### **表操作**

进入库:
```
use fuck_school;
```
展示表：
```
show tables;
```
制作表：
```
create table student(

Id int,

name varchar(30),

age int);
```
有 B 格的写法：
```
create table if not exists teacher(

Id int auto_increment primary key comment '主键 Id', 

name varchar(30) not null comment '名字',

phone varchar(20) default '暂时未知' comment '电话', 

adress varchar(100) default '暂时未知' comment '家庭住址'

)engine = innodb;
```
auto_increment 自动增长 用于类似于 ID 的数据（有规律性）

primary key 主键 最主要的 靠它来区分表 

comment 注释

not null 不能为空

default 默认值

engine = innodb 数据库引擎类型

展示表结构
```
desc teacher;
```
删除表
```
drop table if exists frank,fuck;
```
修改表：

添加元素
```
alter table student add address varchar(20);
```
按位元素

之后
```
alter table student add address varchar(20) after Id；
```
位数
```
alter table student add address varchar(30) first; 
```
删除元素
```
alter table student drop address;
```
修改元素
```
alter table student change address `Add` varchar(20);
```
修改类型
```
alter table student modify Id varchar(11);
```
修改表名
```
alter table student rename to students;
```
清空表
```
truncate table teacher;
```


### **数据操作**

插入数据
```
insert teacher (Id, name, phone, adress) values (1, 'Fuck', '128989', 'GuangZhou');
```
查看数据
```
select * from teacher;
```
一次插入多条数据
```
insert into teacher values (Null, 'Tom', Null, default), (Null, 'Jack', Null, default);
```
删除数据( 注意 where 后面记得带上数据，否则可能误删多条数据！)
```
delete from teacher where name = 'Tom';
```
清空表
```
truncate table teacher;
```
小细节

delete 与 truncate 清表时，delete 会继续接下来的的顺序编号。

更新数据( 同删除数据一样必须带上 where 不然可能带来灾难性的后果）
```
update teacher set name = 'Frank' where name = 'Fuck'(Id = 1);
```
查询部分数据
```
select Id, name from teacher;
```
理论部分

DDL data definition language 数据库定义语言 create alter drop show

DML data manipution language 数据库操纵语言 insert update delete select

DCL data control language 数据库控制语言 

 

### **数据类型**
```
create table emp(

  -> id smallint unsigned auto_increment primary key comment 'id', 

  -> age tinyint unsigned comment '年龄', 

  -> fuck int(6)

  -> );
```
`unsigned `

表示正值数据

`double` 类型精度丢失问题

浮点型数据类型会有精度丢失的问题，比如小数位设置 6 位，存入 0.45，0.45 转换成二进制是个无限循环小数 0.01110011100...，无法准确表示，存储的时候会发生精度丢失。

`Decimal`（定点数）

四舍五入后用字符串类型数据进行存储

VarChar 与 Char

`VarChar` 为可变长字符串 节省空间 但是性能较低

`Char` 为定长字符串 空间占用可能较多 但性能高

性能不同原因：VarChar 存储的不仅仅是数据内容，还有字节长度以及节点位置。

Boolean

insert into test values(true/false/1/0);

enum 

create table Dmeo(

gender enum('women','man','?')

);

枚举类型只能用枚举列表里面的元素来赋值（也可以通过整数进行存储）

好处：存储实际上使用整数，速度比字符串快，限制数据节省空间。

set 集合
```
create table Demo(

hobby_novel set ('secience','love','model')

);

insert into Demo ('seciece','model');
```
与 enum 相比可以一次选择多个元素

时间

create table Demo(

createdTime date

);

insert into Demo values('2022-04-09 11:23:56');

### **列属性完整性**

### 主键

设置主键
```
alter table demo add primary key(id,name);
```
删除主键
```
alter table demo drop primary key;
```
主键的唯一性

一个表里只能存在一个主键（复合主键也为一个主键） 并且主键每行数据都不能为空

### 唯一键

设置唯一键
```
alter table demo add unique (phone);
```
删除唯一键
```
alter table demo drop index (phone);
```
主键和唯一键的区别

1.主键不能为空，唯一键可以为空

2.主键只有一个，唯一键可以存在多个

3.主键可以在别的表里用，唯一键只在自己的表里瞎折腾

数据库完整性

1.保证字段完整 eg.保证存在主键、是设置自动增长，有唯一数据

2.保证数据类型正确

3.考虑表里的字段可能会被其他的表所用

4.自己定义约束

### 外键

添加外键
```
create table eatery(

  -> price int,

  -> stuId int(4),

  -> foreign key (stuId) references stuId(stuId) 

  -> );
```
后期加入外键
```
alter table eatery_2 add foreign key (stuId) references stuId(stuId);
```
删除外键

先查询 ```show create table eatery_2;```

再删除 ```alter table eatery_2 drop foreign key eatery_2_ ibfk_1;```

设计时最好在定义表时就设置好外键

置空：用于删除数据

级联：用于更新数据

操作 
```
alter table eatery add foreign key (stuId) references stuId(stuId) on delete set null on update cascade;
```
## **关系型数据库**

关系：两张表的共有字段去确定数据的完整性

行：一条数据 一条数据记录 实体

列：一个字段 属性

数据冗余：虽然会占用空间，但是提高了性能。

实体和实体的关系：一对一，一对多，多对多。

Code 范式

1.确保字段的原子性

2.非键字段必须依赖于键字段 说白了就是别他妈没事找事

3.消除传递依赖

### **数据查询语句**

**单表查询**

**select**
```
select 'go fuck yourself' as qnmd;

select 2*7 as result;
```
**from**

**dual**

伪表：该表主要目的是为了保证在使用 SELECT 语句中的语句的完整性而提供的。
```
select 2*7 as result from dual;
```
**where** 

< > = != dddd
```
select * from t3 where age >= 18;

select * from t4 where adress = 'Beijing';

select * from t4 where adress != 'Shanghai'; 
```
/or

**in**
```
select * from t4 where adress not in('Shanghai');

select * from t4 where adress in('Shanghai','Beijing');
```
**between and**
```
select * from t3 where age between 15 and 20;
```
### **聚合函数**

总和``` select sum(english) from score;```

平均 ```select avg(english) from score;```

最大``` select max(english) from score;```

最小```select min(english) from score;```

次数``` select count(id) from score; / select count(*) from score;```

**like**

查询'张'后面带多个字符
```
select * from student where name like '张%';
```
'_'个数表示元素多少个字符
```
select * from student where name like '张__'; 
```
**order by** 

升序查询
```
select * from score order by chinese asc;
```
降序查询
```
select * from score order by english desc;
```
**group by**
```
select avg(age) as '年龄' , address as '地区' from info group by address desc;
```
**group_concat()**
```
select group_concat(name) , gender as '性别' from student group by gender;
```
<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202210141915708.png" alt="image-20221014191523641" style="zoom:33%;" />

**having**

表示对生成的表进行查询，相当于 where
```
select avg(age) as 'age' , address from info group by address having age > 20;
```
**limit**

limit 开始位置，结束长度；
```
select * from info order by age desc limit 2,3;
```
**distinct all**

去重
```
select count(distinct address) from info; 
```
### **多表查询**

**inner join on**
```
select name,chinese from student inner join score on student.id = score.id order by english desc;
```
注意事项：超过两张表时直接在后面继续续写一次语句。

**left/right join on**
```
select name,english from student left/right join score on student.id = score.id order by english asc;
```
**cross join** 

```
select * from t1 cross join t3; 
```
有笛卡尔积内味了（数学组合）

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/image-20221005205759542.png" alt="image-20221005205759542" style="zoom: 33%;" />

**natural join**
```
select * from t1 natural (left/right) left join t3;
```
ps.若两表之间无公共字段，则返回的依旧是笛卡尔积。

**using**
```
select * from t1 inner t3 using (name);
```
ps.当两张表为相同字段时，要采用加上using的结构，否则可能empty set输出。

### **子查询**

**基本语法**
```
select * from student where id in(select id from score where english <= 85);
```
**not in**
```
select * from student where id not in(select id from score where chinese >= 85);
```
ps.用in或者not in主要是不止一个结果。

**exists / not exists**
```
select * from student where exists (select id from score where english >= 85); 
```
ps.只要有存在就输出。

## 高级部分

### 视图

 **视图的创建与查询**

```
create view stu_all as select name,phone,score from student 
select * from vw_stu_all
```

**修改视图**

```
alter view stu_all as select name,phone from student
```

**删除视图**

```
drop view vw_stu_all
```

**视图算法**

```
create algorithm=merge view stu_all as select name,phone,score from student 
```

> Merge算法

合并算法，每当执行的时候,先将视图的sql语句与外部查询视图的sql语句,合并在一起,最终执行；这样操作对效率基本上没有什么影响

> Temptable

临时表算法，创建一个临时表用于数据的填充以及查询，当数据量越大时，效率越低，且该视图无法进行update的操作。

### 事务

**开启事务**
```
start transaction;
```
**回滚事务**
```
rollback;
```
**提交事务**
```
commit;
```

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202210191611437.png" alt="image-20221019161158358" style="zoom:50%;" />

**保存回滚点**

```
savapoint *；
```

**回到回滚点**

```
rollback to *;
```

![image-20221019163142908](https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202210191631958.png)

**特性：ACID（InnoDB引擎下）**

原子性（atomicity，或称不可分割性）、一致性（consistency）、隔离性（isolation，又称独立性）、持久性（durability）。

### 索引

增删改很慢，查很快

**创建索引**

```
create index money_index on wallet(id);
```

**添加索引**

```
alter table wallet add index money_index (money);
```

**删除索引**

```
drop index money_index on wallet;
```

### 扩展

**delimiter更改结束符号**

```sql
delimiter //
```

**procedure存储过程**

```]
create procedure proc()
    -> begin
    -> update wallet set money=money+50;
    -> insert into wallet values(5,3737);
    -> end //
```

**执行存储**

```
call proc();
```

<img src="https://cdn.staticaly.com/gh/Dreamin121/picgohub@master/imgs/202210200006857.png" alt="image-20221020000510172" style="zoom:50%;" />

**函数**

*数字*

rand()随机数

ceil()向上取整

round()向下取整

floor()向下取整

truncate(112,2)截取数字

*字符串*

ucase()大写

lcase()小写

left/right('fuck',2)截取

substring('fuck',1,3)截取中间

concat('fu','ck')拼接字符串

*时间*

unix_timestamp()时间毫秒值

year/month/day(now())获取当前年/月/日

*加密*

sha('fuck');


create database game_db;
use game_db;

-- 作用1: 验证用户身份
-- 作用2: 用来保存用户的基本信息

create table users(
id int(11) unsigned unique primary key auto_increment comment '主键',
username varchar(64) not null unique comment'用户名',
password varchar(32) not null comment'密码',
nickname varchar(64)  default null comment'昵称',
mobile char(11) default null comment'手机号码',
age tinyint(3) unsigned default	18 comment '年龄',
idno char(18) default null comment '身份证号'
);

show create table users;

-- 分为两个表,用户信息表和用户验证表
-- 作用1: 用户信息和用户验证是两种"对象"
-- 作用2: 登陆验证的时候列较少,查询速度快.
-- 作用3: 防止查询用户时,直接把密码也查询出来,会被攻击和恶意操作
create database game_db;
use game_db;

create table users(
id int(11) unsigned unique primary key auto_increment comment '主键',
username varchar(64) not null unique comment'用户名',
nickname varchar(64)  default null comment'昵称',
mobile char(11) default null comment'手机号码',
age tinyint(3) unsigned default	18 comment '年龄',
idno char(18) default null comment '身份证号'
);



create table user_auths(
userid int(11) unsigned not null comment'外键,对应users中的id',
username varchar(64) not null unique comment'用户名',
password varchar(32) not null comment '密码',
foreign key user_auths(userid) references users(id)
);

insert into users (username, nickname, mobile, age, idno) 
values('vincent', '丁真', '17321105728', 25, '310429199907048675');
 
 -- 加密
insert into user_auths values(1, 'vincent', md5('qwerty12345'));
select * from  user_auths;





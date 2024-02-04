

SHOW DATABASES;

CREATE DATABASE BOX_MAN;

use BOX_MAN;
create table users(
    id int(11) not null 
    AUTO_INCREMENT PRIMARY KEY COMMENT '用户id',
    username varchar(64) not null comment '用户名',
    password VARCHAR(32) not null COMMENT '密码',
    level_id int DEFAULT 1 COMMENT '当前关卡'
);

select * from users;

CREATE Table levels(
    id int not null PRIMARY KEY COMMENT'游戏关卡序号',
    name varchar(64) not null   COMMENT'地图名称',
    map_row int NOT NULL    COMMENT'地图二维的总行数',
    map_col int NOT NULL    COMMENT'地图二维的总列数',
    map_data     varchar(4096) NOT NULL, 
    next_level_id int DEFAULT 0
);

select * from levels;

INSERT INTO users VALUES(1000, 'vincent', md5('8956333asdf'), 1);
INSERT INTO levels VALUES(1, '小试牛刀', 9, 12,'0,0,0,0,0,0,0,0,0,0,0,0|0,1,0,1,1,1,1,1,1,1,0,0|0,1,4,1,0,2,1,0,2,1,0,0|0,1,0,1,0,1,0,0,1,1,1,0|0,1,0,2,0,1,1,4,1,1,1,0|0,1,1,1,0,3,1,1,1,4,1,0|0,1,2,1,1,4,1,1,1,1,1,0|0,1,0,0,1,0,1,1,0,0,1,0|0,0,0,0,0,0,0,0,0,0,0,0',0);

DELETE FROM levels where id = 1;

use box_man;
select * from levels where id =1;
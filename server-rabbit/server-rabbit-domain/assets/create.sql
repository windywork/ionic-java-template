SET FOREIGN_KEY_CHECKS=0;
drop database if exists speed_rabbit_dev;

create database speed_rabbit_dev;
use speed_rabbit_dev;

/*用户表*/
create table t_users(
	id int primary key auto_increment comment '编号',
	login_name varchar(50) unique not null comment '登录名',
    password varchar(50) default 'e10adc3949ba59abbe56e057f20f883e' comment '密码',
    full_name varchar(50) not null comment '姓名',
    picture varchar(50) comment '照片',
    sex char(1) comment '性别',
    email varchar(50) comment '邮箱',
    last_login_time datetime  default null comment '最后登录时间',
    last_login_ip varchar(50) default null comment '最后登录IP',
    remarks text comment '备注'
)default charset=utf8,comment '用户表';

insert into t_users values(null,'T0001',default,'赵小赵','/face/face01.jpg','男','hdxsyxxxhj@126.com',null,null,'校长');
insert into t_users values(null,'T0002',default,'白小白','/face/face02.jpg','女','xxx@qq.com',null,null,'主任');
insert into t_users values(null,'T0003',default,'苗小苗','/face/face03.jpg','女','2318865823@qq.com',null,null,'班主任');
insert into t_users values(null,'T0004',default,'周小周','/face/face04.jpg','男','xianwu1980@126.com',null,null,'教员');
insert into t_users values(null,'T0005',default,'王小王','/face/face05.jpg','女','xx@126.com',null,null,'教员');
insert into t_users values(null,'T0006',default,'毛小毛','/face/face06.jpg','男','aa@126.com',null,null,'教员');
insert into t_users values(null,'T0007',default,'董小董','/face/face07.jpg','男','ee@126.com',null,null,'教员');
insert into t_users values(null,'T0008',default,'黄小黄','/face/face08.jpg','女','tt@126.com',null,null,'教员');
insert into t_users values(null,'T0009',default,'陈小陈','/face/face09.jpg','男','uu@126.com',null,null,'教员');
insert into t_users values(null,'T0010',default,'赵小赵','/face/face10.jpg','女','ii@126.com',null,null,'教员');

   

  
SET FOREIGN_KEY_CHECKS=1;

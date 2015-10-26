SET FOREIGN_KEY_CHECKS=0;
drop database if exists speed_rabbit;

create database speed_rabbit;
use speed_rabbit;

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

insert into t_users values(null,'S0001',default,'吴小吴','/face/face11.jpg','男','',null,null,'学生1');
insert into t_users values(null,'S0002',default,'梁小梁','/face/face12.jpg','女','',null,null,'学生2');
insert into t_users values(null,'S0003',default,'张小张','/face/face13.jpg','女','',null,null,'学生3');
insert into t_users values(null,'S0004',default,'冯小冯','/face/face14.jpg','女','',null,null,'学生4');
insert into t_users values(null,'S0005',default,'马小马','/face/face15.jpg','男','',null,null,'学生5');
insert into t_users values(null,'S0006',default,'钱小钱','/face/face16.jpg','男','',null,null,'学生6');
insert into t_users values(null,'S0007',default,'孙小孙','/face/face17.jpg','男','',null,null,'学生7');
insert into t_users values(null,'S0008',default,'李小李','/face/face18.jpg','女','',null,null,'学生8');
insert into t_users values(null,'S0009',default,'蒋小蒋','/face/face19.jpg','女','',null,null,'学生9');
insert into t_users values(null,'S0010',default,'单小单','/face/face20.jpg','女','',null,null,'学生10');

/**********************学校**************************************************/
/*学校表*/
create table t_school(
	id int primary key auto_increment comment '编号',
	mark varchar(50) unique not null comment '学校英文表示',
	title varchar(50) not null comment '学校名称',
	icon varchar(50) comment '图标',
	welcome_img varchar(50) comment '欢迎图片',
	panorama  varchar(50) comment '全景图片',
	address varchar(50) comment '地址',
	introduction text comment '公司简介',
	longitude  float(10,10) comment '经度',
	latitude float(10,10) comment '纬度',
	phone varchar(50) comment '电话',
	site varchar(50) comment '网址',
	email varchar(50) comment '邮箱'
)default charset=utf8,comment '学校表';

insert into t_school values
(null,'hdxsyxx','邯郸县实验小学','img/school_icon.png','img/school_screen.png','img/school_panorama.png','河北省邯郸县实验小学','邯郸县实验小学始建于1991年，原为邯郸县师范附属小学，1995年改为邯郸县第一小学,1999年更名为邯郸县实验小学。学校位于城市主干道滏东南大街78号，占地11694平方米..',0.0,0.0,'2050777','http://www.hdxsyxx.com','admin@hdxsyxx.com');
insert into t_school values
(null,'zzxx','贾村小学','img/school_icon.png','img/school_screen.png','img/school_panorama.png','河北省邯郸县贾村小学','贾村小学...，占地11694平方米..',0.0,0.0,'2050776','http://www.hdxjcxx.com','admin@hdxjcxx.com');


/*学校新闻*/
create table t_school_news( 
	id int primary key auto_increment comment '编号',
	school_id int not null comment '学校编号',
	title varchar(50) not null comment '名称',
	content text comment '新闻内容',
	picture varchar(50) comment '新闻图片',
	recommend  tinyint(1) default 0 comment '是否推荐',
	create_time datetime default null comment '创建时间',
	foreign key(school_id) REFERENCES t_school(id) ON DELETE CASCADE 
)default charset=utf8,comment '学校新闻';

insert into t_school_news values(null,1,'图片广告1','图片广告...1','news/pic1.jpg',1,now());
insert into t_school_news values(null,1,'图片广告2','图片广告...2','news/pic2.jpg',1,now());
insert into t_school_news values(null,1,'图片广告3','图片广告...3','news/pic3.jpg',1,now());
insert into t_school_news values(null,1,'图片广告4','图片广告...4','news/pic4.jpg',1,now());
insert into t_school_news values(null,1,'全校植树节活动','3月15日全校到公园参加植树节活动','news/zsj.jpg',0,now());
insert into t_school_news values(null,1,'学雷锋做好事','4月5日全校到进行学雷锋做好事活动','news/xlf.jpg',0,now());
insert into t_school_news values(null,1,'我是国旗手-张婷','今天我是小小国旗手,感到无比的自豪','news/gqs.jpg',0,now());
insert into t_school_news values(null,1,'速叠杯活动开始','马上开始一年一度的速叠杯比赛了，赶快练习啊同学们','news/sdb.jpg',0,now());


/*学校荣誉*/
create table t_school_honor(
	id int primary key auto_increment comment '编号',
	school_id int not null comment '学校编号',
	title varchar(50) not null comment '荣誉名称',
	recommend text comment '荣誉介绍',
	picture varchar(50) comment '荣誉图片',
	winning_date date default null comment '获奖时间',
	create_time datetime default null comment '创建时间',
	foreign key(school_id) REFERENCES t_school(id) ON DELETE CASCADE 
)default charset=utf8,comment '学校荣誉';

insert into t_school_honor values(null,1,'第十七届艺术节活动一等奖','邯郸县实验小学获得第十七届艺术节活动一等奖','honor/honor001.jpg','2010-10-01',now());
insert into t_school_honor values(null,1,'邯郸县思政体委工作先进单位','邯郸县思政体委工作先进单位','honor/honor002.jpg','2010-10-01',now());
insert into t_school_honor values(null,1,'第十七届艺术节活动十佳节目','第十七届艺术节活动十佳节目','honor/wsgqs001.jpg','2010-10-01',now());


/*学校特色*/
create table t_characteristics(
	id int primary key auto_increment comment '编号',
	school_id int not null comment '学校编号',
	title varchar(50) not null comment '名称',
	recommend text comment '介绍',
	picture varchar(50) comment '图片',
	create_time datetime default null comment '创建时间',
	foreign key(school_id) REFERENCES t_school(id) ON DELETE CASCADE 
)default charset=utf8,comment '学校特色';

insert into t_characteristics values(null,1,'课间广播操','课间广播操,火热举办中..','istics/img1.jpg',now());
insert into t_characteristics values(null,1,'真人象棋','真人象棋,火热举办中','istics/img2.jpg',now());
insert into t_characteristics values(null,1,'太极拳比赛','太极拳比赛,火热举办中','istics/img3.jpg',now());
insert into t_characteristics values(null,1,'音乐社团','音乐社团,火热举办中','istics/img4.jpg',now());
insert into t_characteristics values(null,1,'速叠杯活动','速叠杯活动,火热举办中','istics/img5.jpg',now());
insert into t_characteristics values(null,1,'手风琴学习','手风琴学习,火热举办中','istics/img6.jpg',now());
insert into t_characteristics values(null,1,'大合唱比赛','大合唱比赛,火热举办中','istics/img7.jpg',now());


/*学校职位表*/
create table t_inschool_position( 
	id int unique auto_increment  comment '编号',
	school_id int  not null  comment '学校编号',
	title varchar(50)  not null  comment '职位名称',
	remarks text comment '备注',
	level int default 1 comment '级别,值越小职位越高',
	primary key(title,school_id),
	foreign key(school_id) REFERENCES t_school(id) ON DELETE CASCADE 
)default charset=utf8,comment '学校职位';

insert into t_inschool_position values(null,1,'校长','校领导..',1);
insert into t_inschool_position values(null,1,'副校长','校领导..',2);
insert into t_inschool_position values(null,1,'主任','校领导..',3);
insert into t_inschool_position values(null,1,'书记','书记..',4);
insert into t_inschool_position values(null,1,'信息','信息维护',5);



/*学校留言表*/
create table t_leave_word(
	id int primary key auto_increment comment '编号',
	title varchar(50)  not null  comment '留言标题',
	content text comment '留言内容',
	school_id int  not null   comment '学校编号',
	user_id int null comment '留言人',
	foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE ,
	foreign key(school_id) REFERENCES t_school(id) ON DELETE CASCADE 
)default charset=utf8,comment '学校留言';

insert into t_leave_word values(null,'主抓学生德智体各项发展','主抓学生德智体各项项发展,跟进社会发展',1,1);



/**********************课程**************************************************/
/*课程级别*/
create table t_course_level(
	id int unique auto_increment comment '编号',
	school_id int  not null  comment '学校编号',
	title varchar(50)  not null  comment '级别名字',
	rank int not null default 1 comment '等级',
	part varchar(50) null comment '部分,上、下',
	remarks text comment '备注',
	primary key(school_id,title,part),
	foreign key(school_id) REFERENCES t_school(id) ON DELETE CASCADE 
)default charset=utf8,comment '课程级别';

insert into t_course_level values
(null,1,'一年级',1,'',''),
(null,1,'二年级',2,'',''),
(null,1,'三年级',3,'',''),
(null,1,'四年级',4,'',''),
(null,1,'五年级',5,'',''),
(null,1,'六年级',6,'','');

/*科目*/
create table t_subject(
	id int unique auto_increment comment '编号',
	level_id int  not null  comment '级别编号',
	title varchar(50)  not null  comment '科目名称',
	remarks text comment '备注',
	foreign key(level_id) REFERENCES t_course_level(id) ON DELETE CASCADE 
)default charset=utf8,comment '科目表';

insert into t_subject values
(null,1,'语文',''),
(null,1,'数学',''),
(null,1,'自然',''),
(null,1,'生物',''),
(null,2,'语文',''),
(null,2,'数学',''),
(null,2,'地理',''),
(null,2,'英语','');

/*单元表*/
create table t_unit(
  id int unique auto_increment comment '编号',
  subject_id int  not null  comment '科目编号',
  title varchar(50)  not null  comment '单元名称',
  remarks text comment '备注',
  foreign key(subject_id) REFERENCES t_subject(id) ON DELETE CASCADE 
)default charset=utf8,comment '单元表';

insert into t_unit values
(null,1,'第一单元',''),
(null,1,'第二单元',''),
(null,1,'第三单元',''),
(null,1,'第四单元','');

/*单元课表*/
create table t_lesson(
  id int unique auto_increment comment '编号',
  unit_id int  not null  comment '单元编号',
  title varchar(50)  not null  comment '课程名称',
  remarks text comment '备注',
  foreign key(unit_id) REFERENCES t_unit(id) ON DELETE CASCADE 
)default charset=utf8,comment '单元课表';

insert into t_unit values
(null,1,'小蝌蚪找妈妈',''),
(null,1,'我们为什么要旅行',''),
(null,1,'放风筝','');


/*知识点表*/
create table t_knowledge(
  id int unique auto_increment comment '编号',
  subject_id int  not null comment '科目编号',
  title varchar(50)  not null comment '知识点名称',
  degree int default 1 comment '难易程度,值越大越难',
  remarks text comment '备注',
  foreign key(subject_id) REFERENCES t_subject(id) ON DELETE CASCADE 
)default charset=utf8,comment '单元表';

insert into t_knowledge values
(null,1,'生词的理解',1,''),
(null,1,'感情的理解',3,''),
(null,4,'人类的进化',3,'');


/**********************班级、社团、教师、学生**************************************************/
/*老师表*/
create table t_teacher(
   	id int primary key auto_increment comment '编号',
  	user_id int unique not null comment '用户编号',
  	identity_card varchar(50) comment '身份证号',
    phone varchar(50) comment '电话',
    birthday date default null comment '出生日期',
    affiliation varchar(50) comment '政治面貌',
    address varchar(50) comment '地址',
    positional varchar(50) comment '职称',
    recommend text comment '介绍',
    education varchar(50) comment '学历',
    arrival_time datetime default null comment '到校时间',
    remarks  text comment '备注',
	foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8,comment '教师表';

insert into t_teacher(user_id,identity_card,phone,birthday,affiliation,address)  values
(1,'2121212111','15631061111','1972/06/02','党员','邯郸县褀府苑12号楼2-1'),
(2,'2121212112','15232009111','1967/01/02','党员','邯郸市邯山区明珠花园B区13-2-8'),
(3,'2121212113','13303306111','1981/10/19','群众','邯郸县德馨园小区2-2-20'),
(4,'2121212114','15431061111','1972/06/02','党员','邯郸县褀府苑12号楼2-1'),
(5,'2121212115','15532009111','1967/01/02','党员','邯郸市邯山区明珠花园B区13-2-8'),
(6,'2121212116','13603306111','1981/10/19','群众','邯郸县德馨园小区2-2-20'),
(7,'2121212117','13703306111','1981/10/19','群众','邯郸县德馨园小区2-2-20'),
(8,'2121212118','13803306111','1981/10/19','群众','邯郸县德馨园小区2-2-20'),
(9,'2121212119','13903306111','1981/10/19','群众','邯郸县德馨园小区2-2-20'),
(10,'2121212110','16784220111','1980/09/23','群众','邯郸县实验小学');

/*学生表*/
create table t_student(
   id int primary key auto_increment comment '编号',
   user_id int unique not null comment '用户编号',
   birthdate date default null comment '出生日期',
   address varchar(50) comment '家庭住址',
   hobbies varchar(50) comment '爱好',
   qq varchar(50) comment 'QQ号',
   remarks  text comment '备注',
   foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8,comment '用户表';

insert into t_student(user_id,birthdate,address,hobbies) values
(11,'2001-01-09','河北邯郸','足球'),
(12,'2002-06-03','河北保定','游泳'),
(13,'1998-02-05','河北邢台','画画'),
(14,'2003-03-02','河北廊坊','书法'),
(15,'2001-05-12','河北沧州','睡觉'),
(16,'2002-07-23','河北衡水','篮球'),
(17,'2001-08-02','河北邯郸','乒乓球'),
(18,'2003-04-02','河北邯郸','桌球'),
(19,'2001-02-07','河北邯郸','台球'),
(20,'2002-01-04','河北邯郸','足球');

/*班级表*/
create table t_classes( 
	id int unique auto_increment comment '编号',
	course_level_id int not null comment '课程级别(年级)',
	class_name varchar(50) not null comment '班级名称',
    headmaster int not null comment '班主任',
    year_th varchar(50) comment '年届',
	remarks text comment '备注',
	finish tinyint(1) default 0 comment '是否结课',
	primary key(course_level_id,class_name,year_th),
	foreign key(course_level_id) REFERENCES t_course_level(id) ON DELETE CASCADE,
	foreign key(headmaster) REFERENCES t_teacher(id) ON DELETE CASCADE 
)default charset=utf8,comment '班级表';

insert into t_classes values(null,1,'一班',8,'201303','',1);
insert into t_classes values(null,1,'二班',7,'201303','',1);
insert into t_classes values(null,2,'一班',9,'201303','',0);
insert into t_classes values(null,2,'二班',10,'201403','',0);



/*教师任职*/
create table t_teacher_position(
    id int unique auto_increment comment '编号',
    teacher_id int not null comment '教师编号',
    position_id int not null comment '职位编号',
    entry_date date not null comment '入职时间',
    higher_up int null comment '上级',
    primary key(teacher_id,position_id),
    foreign key(higher_up) REFERENCES t_teacher_position(id) ON DELETE CASCADE,
	foreign key(teacher_id) REFERENCES t_teacher(id) ON DELETE CASCADE,
	foreign key(position_id) REFERENCES t_inschool_position(id) ON DELETE CASCADE
)default charset=utf8,comment '教师任职';

insert into t_teacher_position values(null,1,1,current_date(),null);
insert into t_teacher_position values(null,2,2,current_date(),1);
insert into t_teacher_position values(null,3,3,current_date(),2);
insert into t_teacher_position values(null,4,4,current_date(),3);
insert into t_teacher_position values(null,3,5,current_date(),2);


/*任课表*/
create table t_teacher_teach(
    id int unique auto_increment comment '编号',
    class_id int not null comment '班级编号',
    teacher_id int not null comment '教师编号',
    subject_id int not null comment '课程编号',
    entry_date date not null comment '任课时间',
    primary key(class_id,teacher_id,subject_id),
	foreign key(teacher_id) REFERENCES t_teacher(id) ON DELETE CASCADE,
	foreign key(class_id) REFERENCES t_classes(id) ON DELETE CASCADE ,
	foreign key(subject_id) REFERENCES t_subject(id) ON DELETE CASCADE 
)default charset=utf8,comment '教师任课';
   

insert into t_teacher_teach values (null,1,4,3,current_date());
insert into t_teacher_teach values (null,1,5,2,current_date());
insert into t_teacher_teach values (null,2,4,3,current_date());
insert into t_teacher_teach values (null,2,8,2,current_date());
insert into t_teacher_teach values (null,3,5,7,current_date());
insert into t_teacher_teach values (null,4,6,6,current_date());
insert into t_teacher_teach values (null,4,7,8,current_date());


/**
 * 学生所在班级表
 */
create table t_stu_inclass(
	id int unique auto_increment comment '编号',
	student_id int not null comment '学生编号',
	class_id int not null comment '班编号',
	remarks  text comment '备注',
	enter_date date comment '进班时间',
	primary key(student_id,class_id),
    foreign key(student_id) REFERENCES t_student(id) ON DELETE CASCADE,
	foreign key(class_id) REFERENCES t_classes(id) ON DELETE CASCADE
)default charset=utf8,comment '学生所在班级';

insert into t_stu_inclass(student_id,class_id,enter_date) values
(1,1,current_date()),
(2,1,current_date()),
(3,1,current_date()),
(4,1,current_date()),
(5,1,current_date()),
(6,2,current_date()),
(7,2,current_date()),
(8,2,current_date()),
(9,2,current_date()),
(2,2,current_date()),
(10,2,current_date()),
(1,3,current_date()),
(2,3,current_date()),
(3,3,current_date()),
(4,3,current_date()),
(5,3,current_date()),
(6,4,current_date()),
(7,4,current_date()),
(8,4,current_date()),
(9,4,current_date()),
(2,4,current_date()),
(10,4,current_date());



/*学校社团*/
create table t_community(
	id int unique auto_increment comment '编号',
	school_id int not null comment '学校编号',
	title varchar(50) not null comment '社团名称',
	recommend text comment '社团介绍',
	icon varchar(50) comment '社团图标',
	picture varchar(50) comment '社团图片',
	remarks  text comment '备注',
	director int comment '负责人',
	primary key(school_id,title),
	foreign key(director) REFERENCES t_users(id) ON DELETE CASCADE ,
	foreign key(school_id) REFERENCES t_school(id) ON DELETE CASCADE 
)default charset=utf8,comment '学校社团';

insert into t_community values(null,1,'象棋社团','象棋社团..','community/icon-xiangqi.jpg','community/pic1.jpg','',3);
insert into t_community values(null,1,'音乐社团','音乐社团..','community/icon-yinyue.jpg','community/pic3.jpg','',4);
insert into t_community values(null,1,'武术社团','武术社团..','community/icon-wushu.jpg','community/pic5.jpg','',11);
insert into t_community values(null,1,'其他社团','其他社团..','community/icon-more.jpg','community/pic4.jpg','',12);

/*社团活动*/
create table t_community_activity(
  id int primary key auto_increment comment '编号',
  title varchar(50) not null comment '标题',
  content text comment '内容',
  takes_place date default null comment '举办日期',
  community_id int not null comment '社团编号',
  picture varchar(50) comment '图片',
  is_public  tinyint(1) default 1 comment '是否公开 -公开显示在校首页',
  foreign key(community_id) REFERENCES t_community(id) ON DELETE CASCADE
)default charset=utf8,comment '社团活动';

insert into t_community_activity values
(null,'徒步十公里','明天一起去徒步吧','2015-06-01',1,'community/stu1.jpg',1),
(null,'公园散步','明天一起去散步吧','2015-06-12',2,'community/stu2.jpg',1),
(null,'心算比赛','全校举行心算比赛','2015-06-15',3,'community/stu3.jpg',1),
(null,'大合唱','明天一起去大合唱排练吧','2015-06-18',4,'community/stu4.jpg',1);

/*教师赞美*/
create table t_teacher_praise(
	id int primary key auto_increment comment '编号',
	teacher_id int not null comment '教师编号',
	user_id int not null comment '用户编号',
	genre int default 1 comment '类别1:点赞;-1:失望',
	create_time datetime default null comment '创建时间',
	foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE,
	foreign key(teacher_id) REFERENCES t_teacher(id) ON DELETE CASCADE 
)default charset=utf8,comment '教师赞美';

insert into t_teacher_praise values
(null,1,5,1,now()),
(null,2,6,1,now()),
(null,3,5,1,now()),
(null,1,7,1,now());


/*教师荣誉*/
create table t_teacher_honor(
	id int primary key auto_increment comment '编号',
	teacher_id int not null comment '教师编号',
	title varchar(50) not null comment '荣誉名称',
	recommend text comment '荣誉介绍',
	picture varchar(50) comment '荣誉图片',
	create_time datetime default null comment '创建时间',
	foreign key(teacher_id) REFERENCES t_teacher(id) ON DELETE CASCADE 
)default charset=utf8,comment '教师荣誉';

insert into t_teacher_honor values
(null,3,'最美教师','老师获得最美教师奖励','tea_honor/pic1.jpg',now()),
(null,4,'创新教师','老师获得创新教师奖励','tea_honor/pic2.jpg',now()),
(null,5,'个性教师','老师获得个性教师奖励','tea_honor/pic3.jpg',now()),
(null,6,'最强教师','老师获得最强教师奖励','tea_honor/pic4.jpg',now());


/*紧急联系人*/
create table t_em_contact(
  id int primary key auto_increment comment '编号',
  student_id int not null comment '学生编号',
  fill_name varchar(50) not null comment '姓名',
  appellation varchar(50) comment '称谓',
  phone varchar(50) comment '联系电话',
  company varchar(50) comment '单位',
  is_default  tinyint(1) default 1 comment '是否默认',
	foreign key(student_id) REFERENCES t_student(id) ON DELETE CASCADE 
)default charset=utf8,comment '紧急联系人';

insert into t_em_contact(student_id,fill_name,appellation,phone,company) values
(1,'张妈妈','妈妈','151111111','国企'),
(2,'刘妈妈','妈妈','151111112','国企'),
(3,'赵妈妈','妈妈','151111113','国企'),
(4,'郝妈妈','妈妈','151111114','国企');

/*学生荣誉*/
create table t_student_honor(
	id int primary key auto_increment comment '编号',
	student_id int not null comment '学生编号',
	title varchar(50) not null comment '荣誉名称',
	recommend text comment '荣誉介绍',
	picture varchar(50) comment '荣誉图片',
	create_time datetime default null comment '创建时间',
	foreign key(student_id) REFERENCES t_student(id) ON DELETE CASCADE 
)default charset=utf8,comment '学生荣誉';

insert into t_student_honor values
(null,1,'我是国旗手','今天我是一名国旗手,我很骄傲','stu_honor/wsgqs.jpg',now()),
(null,1,'拾金不昧好学生','拾金不昧好学生就是他','stu_honor/sjbm.jpg',now());

/*学生评价*/
create table t_student_evaluation(
	id int primary key auto_increment comment '编号',
	student_id int not null comment '学生编号',
	teacher_id int not null comment '教师编号',
	title varchar(50) not null comment '名称',
	recommend text comment '介绍',  
	score varchar(50) comment '分数,json格式:{礼貌:9,积极:8}',
	create_time datetime default null comment '创建时间',
	foreign key(teacher_id) REFERENCES t_teacher(id) ON DELETE CASCADE,
	foreign key(student_id) REFERENCES t_student(id) ON DELETE CASCADE 
)default charset=utf8,comment '学生评价';

insert into t_student_evaluation values
(null,1,1,'期末评测','','{"礼貌":9,"积极":10,"学习":4}',now()),
(null,2,1,'期末评测','','{"礼貌":2,"积极":3,"学习":10}',now()),
(null,3,1,'期末评测','','{"礼貌":5,"积极":5,"学习":8}',now()),
(null,4,1,'期末评测','','{"礼貌":7,"积极":6,"学习":9}',now());

/*学生参加社团*/
create table t_attend_community(
	id int unique auto_increment comment '编号',
	community_id int not null comment '社团编号',
	user_id int not null comment '学生编号',
	primary key(community_id,user_id),
	foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE, 
	foreign key(community_id) REFERENCES t_community(id) ON DELETE CASCADE 
)default charset=utf8,comment '学生参加社团';

insert into t_attend_community values
(null,1,13),
(null,1,14),
(null,1,16),
(null,2,14),
(null,2,15),
(null,3,15),
(null,3,17);





/*********************软件更新*****************************/
create table t_app_channel(
  id int primary key auto_increment comment '编号',
  title varchar(50) not null comment '名称',
  url varchar(100) null comment '渠道地址',
  remark text null comment '备注'
)default charset=utf8;

create table t_app_version(
  id int primary key auto_increment comment '编号',
  version varchar(50) not null comment '版本',
  channel varchar(200) null comment '更新的渠道,逗号隔开id',
  download_url varchar(200) comment '下载地址',
  remark text null comment '备注'
)default charset=utf8;





/*********************#####通知信息####*****************************/

/*学校通知*/
create table t_school_notice(
   id int primary key auto_increment comment '编号',
   title varchar(50) not null comment '标题',
   school_id int not null comment '学校编号',
   content text comment '内容',
   major_level int default 1 comment '重要级别',
   reply tinyint(1) default 0 comment '是否回复',
   promoter int not null comment '发起人',
   visibled  tinyint(1) default 1 comment '可见性',
   create_time  timestamp default CURRENT_TIMESTAMP comment '创建时间',
   foreign key(school_id) REFERENCES t_school(id) ON DELETE CASCADE,
   foreign key(promoter) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8,comment '学校通知';

/*通知回复表*/
create table t_school_notice_reply( 
   id int primary key auto_increment comment '编号',
   pater_id int null comment '父编号',
   notice_id int not null comment '通知编号',
   user_id int not null comment '回复人',
   content varchar(200) comment '内容',
   create_time datetime default null comment '创建时间',
   foreign key(notice_id) REFERENCES t_school_notice(id) ON DELETE CASCADE,
   foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE,
   foreign key(pater_id) REFERENCES t_school_notice_reply(id) ON DELETE CASCADE
)default charset=utf8,comment '通知回复';


/*通知读者*/
create table t_school_notice_reader(
 id int unique auto_increment comment '编号',
 notice_id int not null comment '通知编号',
 reader int null comment '阅读人',
 read_time datetime default null comment '阅读时间',
 primary key(notice_id,reader,read_time),
 foreign key(notice_id) REFERENCES t_school_notice(id) ON DELETE CASCADE,
 foreign key(reader) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8;

/*班级通知*/
create table t_classes_notice(
   id int primary key auto_increment comment '编号',
   title varchar(50) not null comment '标题',
   class_id int not null comment '班级编号',
   content text comment '内容',
   major_level int  default 1 comment '重要级别',
   reply tinyint(1) default 0 comment '是否回复',
   promoter int not null comment '发起人',
   create_time  timestamp default CURRENT_TIMESTAMP comment '创建时间',
   foreign key(class_id) REFERENCES t_classes(id) ON DELETE CASCADE,
   foreign key(promoter) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8,comment '班级通知';


/*通知回复表*/
create table t_classes_notice_reply( 
   id int primary key auto_increment comment '编号',
   pater_id int null comment '父编号',
   notice_id int not null comment '通知编号',
   user_id int not null comment '回复人',
   content varchar(200) comment '内容',
   create_time datetime default null comment '创建时间',
   foreign key(notice_id) REFERENCES t_classes_notice(id) ON DELETE CASCADE,
   foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE,
   foreign key(pater_id) REFERENCES t_classes_notice_reply(id) ON DELETE CASCADE
)default charset=utf8,comment '通知回复';


/*通知读者*/
create table t_classes_notice_reader(
 id int unique auto_increment comment '编号',
 notice_id int not null comment '通知编号',
 reader int null comment '阅读人',
 read_time datetime default null comment '阅读时间',
 primary key(notice_id,reader,read_time),
 foreign key(notice_id) REFERENCES t_classes_notice(id) ON DELETE CASCADE,
 foreign key(reader) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8;

/*社团通知*/
create table t_community_notice(
 id int unique auto_increment comment '编号',
   title varchar(50) comment '标题',
   community_id int comment '社团编号',
   content text comment '内容',
   major_level int default 1 comment '重要级别',
   reply tinyint(1) default 0 comment '是否回复',
   promoter int not null comment '发起人',
   is_public  tinyint(1) default 1 comment '是否公开 -公开显示在校首页',
   create_time  timestamp default CURRENT_TIMESTAMP comment '创建时间',
   foreign key(community_id) REFERENCES t_community(id) ON DELETE CASCADE,
   foreign key(promoter) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8,comment '社团通知';

/*通知回复表*/
create table t_community_notice_reply( 
   id int primary key auto_increment comment '编号',
   pater_id int null comment '父编号',
   notice_id int not null comment '通知编号',
   user_id int not null comment '回复人',
   content varchar(200) comment '内容',
   create_time datetime default null comment '创建时间',
   foreign key(notice_id) REFERENCES t_community_notice(id) ON DELETE CASCADE,
   foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE,
   foreign key(pater_id) REFERENCES t_community_notice_reply(id) ON DELETE CASCADE
)default charset=utf8,comment '通知回复';


/*通知读者*/
create table t_community_notice_reader(
 id int unique auto_increment comment '编号',
 notice_id int not null comment 'p通知编号',
 reader int null comment '阅读人',
 read_time datetime default null comment '阅读时间',
 primary key(notice_id,reader,read_time),
 foreign key(notice_id) REFERENCES t_community_notice(id) ON DELETE CASCADE,
 foreign key(reader) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8;

/**********************消息**************************************************/
/*消息记录表*/
create table t_msg_record(
  id int primary key auto_increment comment '编号',
  from_user int not null comment '来自用户',
  to_user int not null comment '接受用户',
  session_num varchar(50) default null comment '会话标示',
  notice tinyint(1) default 1 comment '是否显示通知',
  is_read tinyint(1) default 0 comment '是否读取',
  major_level int default 1 comment '重要级别',
  reply tinyint(1) default 0 comment '是否回复',
  timeout int default -1 comment '未读循环提示间隔时间',
  content text comment '内容',
  create_time datetime default null comment '创建时间',
  foreign key(from_user) REFERENCES t_users(id) ON DELETE CASCADE, 
  foreign key(to_user) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8;


/**********************学员分数**************************************************/


/**
 * 试卷表
 */
create table t_stu_score_paper(
  id int primary key auto_increment comment '编号',
  title varchar(50) not null comment '标题',
  teacher_id int not null comment '评论老师',
  create_time datetime default null comment '创建时间',
  foreign key(teacher_id) REFERENCES t_teacher(id) ON DELETE CASCADE
)default charset=utf8;


/**
 * 个人评论
 */
create table t_stu_score_individual(
  id int unique auto_increment comment '编号',
  student_id int not null comment '学员编号',
  pager_id int not null comment '分数页编号',
  remark text null comment '评语',
  primary key(student_id,pager_id),
  foreign key(student_id) REFERENCES t_student(id) ON DELETE CASCADE,
  foreign key(pager_id) REFERENCES t_stu_score_paper(id) ON DELETE CASCADE
)default charset=utf8;

/*评分表*/
create table t_stu_score(
  id int primary key auto_increment comment '编号',
  individual_id int not null comment '个人编号',
  title varchar(50) not null comment '选项名称',
  source int default 60 comment '评分',
  foreign key(individual_id) REFERENCES t_stu_score_individual(id) ON DELETE CASCADE
)default charset=utf8;


/**********************资源共享**************************************************/


/*资源设置表*/
create table t_resource_setting(
  id int primary key auto_increment comment '编号',
  password varchar(20) null comment '密码',
  path varchar(100) null comment '路径',
  is_system tinyint(1) default 0 comment '是否系统文件',
  is_public tinyint(1) default 0 comment '是否公开'
)default charset=utf8;


/*下载者*/
create table t_resource_download(
  id int primary key auto_increment comment '编号',
  res_id int not null comment '资源编号',
  user_id int not null comment '用户编号',
  download_time datetime default null comment '下载时间',
  foreign key(res_id) REFERENCES t_resource(id) ON DELETE CASCADE,
  foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8;




/**********************学习资料**************************************************/

/*学习资料*/
create table t_datum(
 id int primary key auto_increment comment '编号',
 lesson_id int null comment '课程编号', 
 knowledge_id int null comment '知识点编号',
 publisher int not null comment '发布人',
 title varchar(50) not null comment '标题',
 content text comment '内容',
 foreign key(lesson_id) REFERENCES t_lesson(id) ON DELETE CASCADE,
 foreign key(knowledge_id) REFERENCES t_knowledge(id) ON DELETE CASCADE,
 foreign key(publisher) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8;

/*学习资料附件*/
create table t_datum_attachment(
 id int primary key auto_increment comment '编号',
 datum_id int null comment '资料编号', 
 file_path varchar(100) not null comment '文件路径',
 remark text null comment '备注',
 foreign key(datum_id) REFERENCES t_datum(id) ON DELETE CASCADE
)default charset=utf8;

/*学习资料读者*/
create table t_datum_reader(
 id int primary key auto_increment comment '编号',
 datum_id int null comment '资料编号', 
 reader int null comment '阅读人',
 read_time datetime default null comment '阅读时间',
 foreign key(datum_id) REFERENCES t_datum(id) ON DELETE CASCADE,
 foreign key(reader) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8;



/**********************分享圈子**************************************************/
/**
 * 晒心情
 */
create table t_bask(
 id int primary key auto_increment comment '编号',
 user_id int not null comment '用户编号',
 address varchar(50) comment '地点',
 content varchar(200) comment '内容',
 create_time datetime default null comment '创建时间',
 foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8;
/**
 * 晒图片
 */
create table t_bask_img(
	id int primary key auto_increment comment '编号',
	bask_id int not null comment '晒编号',
	img_path varchar(50) null comment '图片路径',
	remark text null comment '备注',
	foreign key(bask_id) REFERENCES t_bask(id) ON DELETE CASCADE
)default charset=utf8;

/**
 * 晒的点赞
 */
create table t_bask_praise(
	id int primary key auto_increment comment '编号',
	bask_id int not null comment '晒编号',
	user_id int not null comment '点赞人',
	create_time datetime default null comment '创建时间',
	foreign key(bask_id) REFERENCES t_bask(id) ON DELETE CASCADE,
	foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8;

/**
 * 晒的浏览
 */
create table t_bask_browse(
   id int primary key auto_increment comment '编号',
   bask_id int not null comment '晒编号',
   user_id int not null comment '点赞人',
   create_time datetime default null comment '创建时间',
	foreign key(bask_id) REFERENCES t_bask(id) ON DELETE CASCADE,
	foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE
)default charset=utf8;

/**
 * 晒的评论
 */
create table t_bask_reply(
   id int primary key auto_increment comment '编号',
   pater_id int null comment '父编号',
   bask_id int not null comment '晒编号',
   user_id int not null comment '点赞人',
   content varchar(200) comment '内容',
   create_time datetime default null comment '创建时间',
   foreign key(bask_id) REFERENCES t_bask(id) ON DELETE CASCADE,
   foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE,
   foreign key(pater_id) REFERENCES t_bask_reply(id) ON DELETE CASCADE
)default charset=utf8;



/**********************任务**************************************************/
/*任务项目表*/
create table t_project( 
 id int primary key auto_increment comment '编号',
 title varchar(50) not null comment '标题',
 is_public tinyint(1) default 0 comment '是否公开',
 is_team tinyint(1) default 0 comment '是否团队项目'
)default charset=utf8;

/*项目成员表*/
create table t_project_member( 
  id int primary key auto_increment comment '编号',
  project_id int not null comment '项目成员',
  user_id int not null comment '用户编号',
  is_admin tinyint(1) default 0 comment '是否管理员',
  foreign key(project_id) REFERENCES t_project(id) ON DELETE CASCADE,
  foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE 
)default charset=utf8;

/*项目任务表*/
create table t_project_task( 
  id int primary key auto_increment comment '编号',
  project_id int not null comment '项目编号',
  title varchar(20) not null comment '任务标题',
  remark text null comment '备注',
  deadline datetime null comment '截止日期',
  grade int default 1 comment '重要等级',
  state int default 1 comment '状态, 1:要做;2:在做;3:待定;4:归档',
  create_time datetime default null comment '创建时间',
  foreign key(project_id) REFERENCES t_project(id) ON DELETE CASCADE
)default charset=utf8;


/*任务附件表*/
create table t_task_attachment( 
  id int primary key auto_increment comment '编号',
  task_id int not null comment '任务编号',
  file_path varchar(100) not null comment '文件路径',
  remark text null comment '备注',
  foreign key(task_id) REFERENCES t_project_task(id) ON DELETE CASCADE
)default charset=utf8;

/*任务分配表*/
create table t_task_allot( 
  id int primary key auto_increment comment '编号',
  task_id int not null comment '任务编号',
  user_id int not null comment '项目成员',
  remark text null comment '备注',
  foreign key(task_id) REFERENCES t_project_task(id) ON DELETE CASCADE,
   foreign key(user_id) REFERENCES t_users(id) ON DELETE CASCADE 
)default charset=utf8;


/**********############创建视图################******************************/

/**
 * 教师欢迎程度
 */
create or replace view v_teacher_heat as 
select a.teacher_id,ifnull(sum(a.genre),0) heat 
from t_teacher_praise a group by a.teacher_id;

/**
 * 教师任职
 */
create or replace view v_teacher_position as  
select e.id user_id,e.full_name,e.picture,e.sex,
ifnull(f.heat,0) heat,c.id teacher_id,b.id school_id,
b.title school_title,a.id position_id,a.title position_title,a.level position_level,
c.higher_up,c.entry_date entry_date 
    from t_inschool_position a 
    left join t_school b on a.school_id=b.id 
    left join t_teacher_position c on c.position_id=a.id 
    left join t_teacher d on c.teacher_id=d.id 
    left join t_users e on d.user_id=e.id
    left join v_teacher_heat f on d.id=f.teacher_id;

/**
 * 教师任课
 */
create or replace view v_teacher_teach as  
select e.id user_id,e.full_name,e.picture,e.sex,
d.id teacher_id,ifnull(g.heat,0) heat,c.school_id,b.id class_id,c.id course_level_id,
c.title course_level,
b.class_name class_name,b.year_th year_th,b.finish,
f.id subject_id,f.title subject_title,a.id teach_id,a.entry_date entry_date
from t_teacher_teach a 
  left join t_classes b on a.class_id=b.id 
  left join t_course_level c on b.course_level_id=c.id 
  left join t_teacher d on a.teacher_id=d.id 
  left join t_users e on d.user_id=e.id 
  left join t_subject f on a.subject_id=f.id
  left join v_teacher_heat g on d.id=g.teacher_id;

/**
 * 担任班主任
 */ 
create or replace view v_class_headmaster as  
select c.id user_id,c.full_name,c.picture,c.sex,
   b.id teacher_id,ifnull(f.heat,0) heat, e.id school_id, e.title school_title,
   d.id course_level_id,d.title course_level,
   a.id class_id,a.class_name class_name,
   a.year_th year_th,a.finish from t_classes a 
   left join t_teacher b on a.headmaster=b.id 
   left join t_users c on  b.user_id=c.id 
   left join t_course_level d on a.course_level_id=d.id 
   left join t_school e on  d.school_id=e.id
   left join v_teacher_heat f on b.id=f.teacher_id;
   
/**
 * 学生就读
 */
create or replace view v_student_attend as  
select c.id user_id,c.full_name,c.picture,c.sex ,b.id student_id,
f.id school_id,f.title school_title ,e.id course_level_id,
e.title course_level,d.id class_id,d.class_name class_name,
d.year_th year_th,d.finish,a.id id,a.enter_date enter_date from t_stu_inclass a 
   left join t_student b on  b.id=a.student_id 
   left join t_users c on c.id=b.user_id  
   left join t_classes d on d.id=a.class_id
   left join t_course_level e on e.id=d.course_level_id
   left join t_school f on  f.id=e.school_id;
   
/**
 * 获得管理社团
 */
create or replace view v_community_manager as 
select b.id user_id,b.full_name,b.picture,b.sex, c.id school_id, c.title school_title,
	a.id community_id,a.title community_title,a.recommend,a.icon community_icon,a.picture community_picture,a.remarks community_remarks  
   from t_community a 
   left join t_users b on  a.director=b.id 
   left join t_school c on  a.school_id=c.id order by b.id;

/**
 * 社团参与
 */
create or replace view v_community_attend as 
select b.id user_id,b.full_name,b.picture,b.sex ,
d.id school_id,d.title school_title,c.id community_id,c.title community_title,
c.recommend,c.icon community_icon,c.picture community_picture,
c.remarks community_remarks,a.id id   from t_attend_community a 
   left join t_users b on b.id=a.user_id  
   left join t_community c on c.id=a.community_id 
   left join t_school d on  d.id=c.school_id order by b.id;
   
   

  
SET FOREIGN_KEY_CHECKS=1;

/*

*/
CREATE TABLE IF NOT EXISTS user(
uid char(20) not null primary key,
upassword char(32) not null,
uname char(20) character set utf8,
uauth enum('0','1') comment '0普通用户，1管理员'
);


/*
set session  
sql_mode='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'; 
*/
CREATE TABLE IF NOT EXISTS matchtype(
matchname char(50) character set utf8 not null,
enrolltime TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
uploadtime TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
issuetime TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
info varchar(500) character set utf8
);

/*

*/

CREATE TABLE IF NOT EXISTS enroll(
uid char(20)  CHARACTER SET UTF8 not null ,
matchname char(50)  CHARACTER SET UTF8 not null ,
uploadtime TIMESTAMP,
projectname char(50)  CHARACTER SET UTF8 not null ,
teamname char(50)  CHARACTER SET UTF8 not null ,
teachername char(20)  CHARACTER SET UTF8 not null ,
name1 char(20)  CHARACTER SET UTF8 not null ,
number1 char(20)  CHARACTER SET UTF8 not null ,
grade1 char(50)  CHARACTER SET UTF8 not null ,
qq1 char(20)  CHARACTER SET UTF8 not null ,
wechat1 char(20)  CHARACTER SET UTF8 not null ,
phone1 char(20)  CHARACTER SET UTF8 not null ,
name2 char(20) CHARACTER SET UTF8,
number2 char(20) CHARACTER SET UTF8,
grade2 char(50) CHARACTER SET UTF8,
qq2 char(20) CHARACTER SET UTF8,
wechat2 char(20) CHARACTER SET UTF8,
phone2 char(20) CHARACTER SET UTF8,
name3 char(20) CHARACTER SET UTF8,
number3 char(20) CHARACTER SET UTF8,
grade3 char(50) CHARACTER SET UTF8,
qq3 char(20) CHARACTER SET UTF8,
wechat3 char(20) CHARACTER SET UTF8,
phone3 char(20) CHARACTER SET UTF8
)CHARACTER SET UTF8;

/**作品上传*/
CREATE TABLE uploadwork(
uid char(20)  CHARACTER SET UTF8 not null ,
matchname char(50)  CHARACTER SET UTF8 not null ,
uploadtime TIMESTAMP,
dropboxurl char(100) not null,
boxpassword char(20)
);



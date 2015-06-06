drop database if exists 3dprint3;
create database 3dprint3;
use 3dprint3;
# 用户表
create table if not exists user (
	user_id int unsigned not null auto_increment,
	name varchar(128) not null,
	password varchar(128) not null,
	email varchar(128),
	telephone varchar(128),
	qq varchar(128),
    
	addtime datetime default now(),
    updatetime datetime default now(),
	status varchar(128) default "normal",
    
	primary key (user_id),
	unique key(name)
);
insert user(name, password) values('admin','123123');
insert user(name, password) values('manager','123123');
insert user(name, password) values('all_roles', '123123');
insert user(name, password) values('123123','123123');
insert user(name, password) values('sxdw','123123');
insert user(name, password) values('sadxa','123123');
insert user(name, password) values('呢呢呢','123123');
insert user(name, password) values('上山打老虎','123123');
insert user(name, password) values('fdxfg','123123');
# 权限表
create table if not exists user_role (
	user_role_id int unsigned not null auto_increment,
    user_role_name varchar(128) not null,
    
    addtime datetime default now(),
    updatetime datetime default now(),
	status varchar(128) default "normal",
    
    primary key (user_role_id),
    unique key(user_role_name)
);
insert into user_role(user_role_name) values('ROLE_ADMIN');
insert into user_role(user_role_name) values('ROLE_MANAGER');
insert into user_role(user_role_name) values('ROLE_USER');
# 用户权限关联表
create table if not exists authentication (
	authentication_id int unsigned not null auto_increment,
	user_id int unsigned not null,
	user_role_id int unsigned not null,
    
    addtime datetime default now(),
    updatetime datetime default now(),
	status varchar(128) default "normal",
    
    primary key (authentication_id),
    foreign key (user_id) references user (user_id),
    foreign key (user_role_id) references user_role(user_role_id),
    unique key(user_id, user_role_id)
);
insert into authentication (user_id, user_role_id) values(1, 1);
insert into authentication (user_id, user_role_id) values(2, 2);
insert into authentication (user_id, user_role_id) values(3, 1);
insert into authentication (user_id, user_role_id) values(3, 2);
insert into authentication (user_id, user_role_id) values(3, 3);
insert into authentication (user_id, user_role_id) values(4, 3);
insert into authentication (user_id, user_role_id) values(5, 3);
insert into authentication (user_id, user_role_id) values(6, 3);
insert into authentication (user_id, user_role_id) values(7, 3);
insert into authentication (user_id, user_role_id) values(8, 3);
insert into authentication (user_id, user_role_id) values(9, 3);


drop database if exists 3dprint3;
create database 3dprint3;
use 3dprint3;
# �û���
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
insert user(name, password) values('������','123123');
insert user(name, password) values('��ɽ���ϻ�','123123');
insert user(name, password) values('fdxfg','123123');
# Ȩ�ޱ�
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
# �û�Ȩ�޹�����
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

use 3dprint3;

alter table  user modify email varchar(128) default '';
alter table  user modify telephone varchar(128) default '';
alter table  user modify qq varchar(128) default '';
alter table  user modify qq varchar(128) default '';

update user set email='', telephone='', qq='' where user_id>0;

use 3dprint3;

create table model(
	model_id int unsigned not null auto_increment,
	model_name varchar(128) not null,
	model_description varchar(128) default '',
	model_length double default 0,
	model_height double default 0,
	model_width double default 0,
	model_style varchar(128) default '',
	model_bought int default 0,
	model_downloaded int default 0,
	user_id int unsigned not null,
	
	addtime datetime default now(),
	updatetime datetime default now(),
	status varchar(128) default 'normal',

	primary key(model_id),
	foreign key(user_id) references user(user_id)
);

insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('ģ��1', 'model\'s description', 1, 1, 9, 'ʱ��', 1);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('ģ��2', 'model\'s description', 2, 2, 8, 'ʱ��', 1);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('ģ��3', 'model\'s description', 1, 3, 7, 'ʱ��', 2);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('ģ��4', 'model\'s description', 2, 4, 6, 'ʵ��', 2);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('ģ��5', 'model\'s description', 1, 5, 5, 'ʱ��', 2);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('ģ��6', 'model\'s description', 2, 6, 4, 'ʵ��', 4);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('ģ��7', 'model\'s description', 1, 7, 3, 'ʱ��', 4);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('ģ��8', 'model\'s description', 2, 8, 2, '��Լ', 4);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('ģ��9', 'model\'s description', 1, 9, 1, 'ʱ��', 4);

use 3dprint3;

alter table model add image_name varchar(128) default '';
alter table model add image_index int default 0;

drop table if exists model_type;
create table model_type(
	model_type_id int unsigned not null auto_increment,
	model_type_name varchar(128) not null,
	addtime datetime default now(),
	updatetime datetime default now(),
	status varchar(128) default 'normal',
	primary key(model_type_id),
	unique key(model_type_name)
);
insert into model_type(model_type_name) values('ʱ��');
insert into model_type(model_type_name) values('ʵ��');
insert into model_type(model_type_name) values('��Լ');
insert into model_type(model_type_name) values('����');

drop table if exists model_comment;
create table model_comment(
	model_comment_id int unsigned not null auto_increment,
	model_comment_content varchar(200) not null,
	model_id int unsigned not null,
	user_id int unsigned not null,
	addtime datetime default now(),
	updatetime datetime default now(),
	status varchar(128) default 'normal',
	primary key(model_comment_id),
	foreign key(model_id) references model(model_id),
	foreign key(user_id) references user(user_id)
);

drop table if exists model_collection;
create table model_collection(
	model_collection_id int unsigned not null auto_increment,
	user_id int unsigned not null,
	model_id int unsigned not null,
	addtime datetime default now(),
	updatetime datetime default now(),
	status varchar(128) default 'normal',
	primary key(model_collection_id),
	foreign key(model_id) references model(model_id),
	foreign key(user_id) references user(user_id),
	unique key(model_id, user_id)
);

use 3dprint3;
alter table model change model_description model_description varchar(20000) not null;

use 3dprint3;

drop table if exists floor_comment;
drop table if exists article_comment;
drop table if exists article;

create table article(
	article_id int unsigned not null auto_increment,
	article_name varchar(128) not null,
	article_content varchar(20000) not null,
	article_type varchar(128) not null,
	user_id int unsigned not null,
	addtime datetime default now(),
	updatetime datetime default now(),
	status varchar(128) default 'normal',
	primary key(article_id),
	foreign key(user_id) references user(user_id)
);


create table article_comment(
	article_comment_id int unsigned not null auto_increment,
	article_comment_floor int unsigned not null,
	article_comment_content varchar(20000) not null,
	article_id int unsigned not null,
	user_id int unsigned not null,
	addtime datetime default now(),
	updatetime datetime default now(),
	status varchar(128) default 'normal',
	primary key(article_comment_id),
	foreign key(article_id) references article(article_id),
	foreign key(user_id) references user(user_id),
	unique key(article_id, article_comment_floor)
);

create table floor_comment(
	floor_comment_id int unsigned not null auto_increment,
	floor_comment_floor int unsigned not null,
	floor_comment_content varchar(200) not null,
	article_comment_id int unsigned not null,
	user_id int unsigned not null,
	addtime datetime default now(),
	updatetime datetime default now(),
	status varchar(128) default 'normal',
	primary key(floor_comment_id),
	foreign key(article_comment_id) references article_comment(article_comment_id),
	foreign key(user_id) references user(user_id),
	unique key(article_comment_id, floor_comment_floor)
);

drop table if exists article_type;
create table article_type(
	article_type_id int unsigned not null auto_increment,
	article_type varchar(128) not null,
	addtime datetime default now(),
	updatetime datetime default now(),
	status varchar(128) default 'normal',
	primary key(article_type_id)
);

insert into article_type(article_type) values('3D��ӡ��');
insert into article_type(article_type) values('3Dģ�����');
insert into article_type(article_type) values('3D��Ʒ����');
insert into article_type(article_type) values('�ۺ�������');

ALTER TABLE `3dprint3`.`model` 
ADD COLUMN `collections` INT(10) NULL DEFAULT '0' COMMENT '' ;

CREATE TABLE `3dprint3`.`cart` (
  `cart_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `model_id` INT(10) UNSIGNED NOT NULL COMMENT '',
  `user_id` INT(10) UNSIGNED NOT NULL COMMENT '',
  `material_id` INT(11) NULL COMMENT '',
  `amount` INT(11) UNSIGNED NOT NULL COMMENT '',
  `selected` INT(11) NULL DEFAULT 0 COMMENT '',
  `addtime` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updatetime` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `status` VARCHAR(128) NULL DEFAULT 'normal' COMMENT '',
  PRIMARY KEY (`cart_id`)  COMMENT '',
  UNIQUE INDEX `cart_id_UNIQUE` (`cart_id` ASC)  COMMENT '',
  INDEX `user_id_idx` (`user_id` ASC)  COMMENT '',
  INDEX `model_id_idx` (`model_id` ASC)  COMMENT '',
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `3dprint3`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `model_id`
    FOREIGN KEY (`model_id`)
    REFERENCES `3dprint3`.`model` (`model_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


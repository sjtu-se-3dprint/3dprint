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
insert into model_type(model_type_name) values('时尚');
insert into model_type(model_type_name) values('实用');
insert into model_type(model_type_name) values('简约');
insert into model_type(model_type_name) values('其他');

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
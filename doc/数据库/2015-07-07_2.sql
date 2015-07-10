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
values ('模型1', 'model\'s description', 1, 1, 9, '时尚', 1);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('模型2', 'model\'s description', 2, 2, 8, '时尚', 1);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('模型3', 'model\'s description', 1, 3, 7, '时尚', 2);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('模型4', 'model\'s description', 2, 4, 6, '实用', 2);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('模型5', 'model\'s description', 1, 5, 5, '时尚', 2);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('模型6', 'model\'s description', 2, 6, 4, '实用', 4);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('模型7', 'model\'s description', 1, 7, 3, '时尚', 4);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('模型8', 'model\'s description', 2, 8, 2, '简约', 4);
insert into model(model_name, model_description, model_length, model_height, model_width, model_style, user_id)
values ('模型9', 'model\'s description', 1, 9, 1, '时尚', 4);
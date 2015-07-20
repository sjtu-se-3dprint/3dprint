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
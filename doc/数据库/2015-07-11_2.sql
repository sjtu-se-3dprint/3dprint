use taskcenter;
drop table if exists record;
create table record(
	record_id int unsigned not null auto_increment,
	record_type varchar(128) not null,
	record_task_name varchar(128) not null,
	record_task_detail varchar(1280) not null,
	record_task_status  varchar(128) not null,
	record_content varchar(128) not null,
	record_process_id int unsigned default 0,
	record_days int unsigned default 0,
	record_delay int unsigned default 0,
	user_id int unsigned not null,
	task_id int unsigned not null,
	addtime datetime default now(),
	primary key(record_id),
	foreign key(user_id) references user(user_id),
	foreign key(task_id) references task(task_id)
);
drop database if exists taskcenter;
create database taskcenter;
use taskcenter;

create table if not exists user(
	user_id int unsigned not null auto_increment,
	user_name varchar(128) not null,
	primary key(user_id)
);

insert into user(user_name) values('刘德霖');
insert into user(user_name) values('王臻');
insert into user(user_name) values('舒映');

create table if not exists task(
	task_id int unsigned not null auto_increment,
	task_name varchar(128) not null,
	task_detail varchar(1280) not null,
	task_status varchar(128) not null default '未处理',
	task_publisher int unsigned not null,
	addtime datetime default now(),
	updatetime datetime default now(),
	primary key(task_id),
	foreign key(task_publisher) references user(user_id)
);

#insert into task(task_name, task_detail, task_publisher)
#	values('任务1', '任务1的详细描述', 1);
#insert into task(task_name, task_detail, task_publisher)
#	values('任务2', '任务2的详细描述', 2);
#insert into task(task_name, task_detail, task_publisher)
#	values('任务3', '任务3的详细描述', 3);
#insert into task(task_name, task_detail, task_publisher)
#	values('任务4', '任务4的详细描述', 1);
#insert into task(task_name, task_detail, task_publisher, task_status)
#	values('任务5', '任务5的详细描述', 1, '正在进行中');
#insert into task(task_name, task_detail, task_publisher, task_status)
#	values('任务6', '任务6的详细描述', 1, '正在进行中');
#insert into task(task_name, task_detail, task_publisher, task_status)
#	values('任务7', '任务7的详细描述', 1, '未处理');

create table if not exists process(
	process_id int unsigned not null auto_increment,
	task_id int unsigned not null,
	user_id int unsigned not null,
	process_duration int unsigned not null default 1,
	addtime datetime default now(),
	updatetime datetime default now(),
	status varchar(128) default 'processing',
	primary key(process_id),
	foreign key(task_id) references task(task_id),
	foreign key(user_id) references user(user_id)
);

#insert into process(task_id, user_id, process_duration)
#	values(5, 1, 1);
#insert into process(task_id, user_id, process_duration)
#	values(6, 1, 2);
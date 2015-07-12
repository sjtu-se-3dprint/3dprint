use taskcenter;
alter table task change task_detail task_detail varchar(20000) not null;
alter table record change record_task_detail record_task_detail varchar(20000) not null;
alter table record change record_content record_content varchar(1280) not null;
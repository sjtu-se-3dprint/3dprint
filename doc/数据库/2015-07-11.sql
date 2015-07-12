use taskcenter;
alter table user add user_account varchar(128) not null default '';
alter table user add user_password varchar(128) not null default '';

update user set user_account = 'liudelin', user_password='1231' where user_id=1;
update user set user_account = 'wangzhen', user_password='123456' where user_id=2;
update user set user_account = 'shuying', user_password='123456' where user_id=3;
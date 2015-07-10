use 3dprint3;

alter table  user modify email varchar(128) default '';
alter table  user modify telephone varchar(128) default '';
alter table  user modify qq varchar(128) default '';
alter table  user modify qq varchar(128) default '';

update user set email='', telephone='', qq='' where user_id>0;
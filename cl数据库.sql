-- cl数据库.sql
create table food(
	fno varchar(20)primary key,
	fname varchar(30)not null,
	price int
);

create table vip(
	vno varchar(20)primary key,
	vname varchar(30)not null,
	addtime date
);

create table consum(
	fno varchar(20)not null,
	vno varchar(20)not null,
	num int not null,
	foreign key(fno)references food(fno),
	foreign key(vno)references vip(vno)
);

create table admin(
	ano varchar(20)primary key,
	aname varchar(30)not null
);

create table log(
	lid int primary key auto_increment,
	fno varchar(20)not null,
	vno varchar(20)not null,
	foreign key(fno)references food(fno),
	foreign key(vno)references vip(vno)
);


delimiter $$
create trigger trigger_log after
	insert on consum
	for each row
	begin
	insert into log(log.fno,log.vno) values(new.fno,new.vno);
	end $$
delimiter;


delimiter $$
create procedure Proc_Delete_food(in no int)
	begin
	delete from food where cno=no;
	end $$
delimiter;


insert into food values('1001','蒜蓉小龙虾',128);
insert into food values('1002','青椒肉丝',18);
insert into food values('1003','红烧茄子',15);
insert into food values('1004','包子',1);

insert into vip values('101','陈柳','2019-7-7');

insert into admin values('1','李刚');

create view consum_list as(
	select vip.vname,food.fname,num from vip,food,consum
	where vip.vno=consum.vno and food.fno=consum.fno
);
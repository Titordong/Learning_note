-- 数据库学习笔记.sql

-- 创建数据库
SHOW DATABASES;

CREATE DATABASE test;

-- 创建表
SHOW TABLES;   -- 显示
DESC S;        -- 查看属性

CREATE TABLE S(
	SNO CHAR(5),
	SNAME CHAR(20),
	STATUS INT,
	CITY CHAR(20)
);
-- 建表后添加与删除
	-- 1.建表时候添加
	-- 2.alter ... add ...
	-- 3.alter ... modify ...
	-- 4.删除 alter ... drop ...

CREATE TABLE P(
	SNO CHAR(5),
	SNAME CHAR(20),
	STATUS INT,
	CITY CHAR(20)
);

ALTER TABLE P /*选中表*/ADD/*操作符*/ primary key(SNO)/*操作内容*/; -- 增加
ALTER TABLE P DROP primary key;									  -- 只能删除主键约束
ALTER TABLE P DROP index SNO;                                     -- 删除指定属性的约束
ALTER TABLE P MODIFY SNO CHAR(5)/*数据类型*/ primary key;		  -- 修改

-- 增删查改

INSERT INTO S VALUES('S1','精益',20,'天津');
INSERT INTO S VALUES('S2','盛锡',10,'北京');
INSERT INTO S VALUES('S3','东方红',30,'北京');
INSERT INTO S VALUES('S4','丰泰盛',20,'天津');
INSERT INTO S VALUES('S5','为民',30,'上海');
INSERT INTO S(SNO) VALUES('S5');               -- 缺省插入
INSERT INTO S(SNO,SNAME) VALUES('S5','国家');   -- 缺省插入
INSERT INTO S VALUES('S6',NULL,NULL,NULL);     -- 置NULL插入

DELETE FROM S WHERE SNO='S5'; -- 选择删除
DELETE FROM S;                -- 全部删除

SELECT *FROM S;						-- 查找全部
SELECT SNO FROM S;					-- 查某列
SELECT SNO,SNAME FROM S;			-- 多列
SELECT *FROM S WHERE SNO='S1';		-- 符合条件的元组

UPDATE S SET STATUS=5;                      -- 全部修改
UPDATE S SET SNAME='可以' WHERE SNO='S1';	-- 条件修改

-- 主键约束  复合主键同时不同才算不同 不可空

CREATE TABLE user(
	SNO CHAR(5) primary key,   --与唯一约束不同，主键约束要么一个，要么联合
	SNAME CHAR(20),
	STATUS INT,
	CITY CHAR(20)
);
CREATE TABLE use2(
	SNO CHAR(5),
	SNAME CHAR(20),
	STATUS INT,
	CITY CHAR(20),
	primary key(SNO,SNAME)	   --联合主键
);

-- 自增约束 与主键约束搭配

CREATE TABLE user3(
	id INT primary key auto_increment,
	name VARCHAR(20)
);

INSERT INTO user3 VALUES(NULL,"zs");   -- 自动补齐id，从上一个有id的开始+1
INSERT INTO	user3(name) VALUES("zf");
INSERT INTO user3 VALUES(3,'gf')       -- 如果没有id为3（删除了）的，则插入，并自动插在递增位置上
INSERT INTO user3 VALUES(3,'gf')       -- 第二次插入失败
INSERT INTO user3 VALUES(8,'gf')       -- 插的数大一点则下一次从这个数开始加1

-- 唯一约束  不能重复，可为空，为空时不算重复

CREATE TABLE user4(
	id INT,
	name VARCHAR(20)
);
ALTER TABLE user4 ADD UNIQUE(id);

mysql> INSERT INTO user4 VALUES(1,"lisi"); -- 类似于主键约束，不能重复id
Query OK, 1 row affected (0.08 sec)
mysql> INSERT INTO user4 VALUES(1,"lisi");
1062 - Duplicate entry '1' for key 'id'

CREATE TABLE user5(
	id INT,
	name VARCHAR(30),
	UNIQUE(id,name)	      --绑定在一起的唯一约束，两个加起来不一样算不一样
);
INSERT INTO user5 VALUES(1,"zhangsan");
INSERT INTO user5 VALUES(2,"zhangsan");

CREATE TABLE user6(
	id INT UNIQUE,		  --分开的唯一约束，每个都要不一样
	name VARCHAR(30)UNIQUE
);
mysql> INSERT INTO user6 VALUES(1,"zhangsan");
INSERT INTO user6 VALUES(2,"zhangsan");
Query OK, 1 row affected (0.09 sec)
1062 - Duplicate entry 'zhangsan' for key 'name'

-- 非空约束 字段不能为空 NULL
CREATE TABLE user7(
	id INT,
	name VARCHAR(20)NOT NULL
);
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | NO   |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
mysql> INSERT INTO user7 VALUES(1,NULL);      -- 不能传空进去
1048 - Column 'name' cannot be null 
 
mysql> INSERT INTO user7 VALUES(NULL,"lisi"); -- id可以为空
Query OK, 1 row affected (0.07 sec) 
 
mysql> INSERT INTO user7(name) VALUES("zs");  -- 不能缺省name
INSERT INTO user7(id) VALUES(2);
Query OK, 1 row affected (0.06 sec)
1364 - Field 'name' doesn''t have a default value

-- 默认约束 某个属性没有赋值就用默认值填充
CREATE TABLE user8(
	id INT,
	name VARCHAR(20),
	age INT Default 10
);
INSERT INTO user8(id,name)VALUES(1,'zs');
mysql> select *from user8;
+----+------+-----+
| id | name | age |
+----+------+-----+
|  1 | zs   |  10 |
+----+------+-----+
INSERT INTO user8 VALUES(1,'ls',5); --传了值就不用默认值了
+----+------+-----+
| id | name | age |
+----+------+-----+
|  1 | zs   |  10 |
|  1 | ls   |   5 |
+----+------+-----+

-- 外键约束 涉及到2个表：父表（主表）和子表（副表），添加和删除约束
CREATE TABLE class(
	id INT primary key,
	name VARCHAR(20)
);
CREATE TABLE student(    --外键约束表明子表的变量必须要在父表里有才能添加
	id INT primary key,
	name VARCHAR(20),
	class_id INT,
	foreign key(class_id)references class(id)
);
INSERT INTO class VALUES(1,'一班');
INSERT INTO class VALUES(2,'二班');
INSERT INTO class VALUES(3,'三班');
INSERT INTO class VALUES(4,'四班');
INSERT INTO class VALUES(5,'五班');

INSERT INTO student VALUES(1001,'zhangsan',1);
INSERT INTO student VALUES(1002,'zhangsan',2);
INSERT INTO student VALUES(1003,'zhangsan',3);
INSERT INTO student VALUES(1004,'zhangsan',4);

INSERT INTO student VALUES(1006,'zhangsan',6); -- 插入失败，class里没有6
mysql> INSERT INTO student VALUES(1006,'zhangsan',6);
1452 - Cannot add or update a child row: a foreign key constraint fails...

mysql> DELETE FROM class where id=4;		   -- 删除失败，子表里用了4班
1451 - Cannot delete or update a parent row: a foreign key constraint fails...

-- 范式 NF
	-- 第一范式：数据表中的所有字段都是不可分割的原子值，即尽量细分
				-- eg:'四川省','成都市','武侯区'，'...街道'
	-- 第二范式：满足第一范式的情况下，除主键外每一列都完全依赖于主键，即属性和
	--          主键有很强的相关性，类似于学号主键对应人的各种属性，不满足则拆表
				-- eg:
					CREATE TABLE myorder(
						product_id INT,
						customer_id INT,
						product_name VARCHAR(20),
						customer_name VARCHAR(20),
						primary key(product_id,customer_id)
					);
					-- 拆表
					CREATE TABLE myorder(
						order INT primary key,
						product_id INT,
						customer_id INT
					);
					CREATE TABLE product(
						id INT primary key,
						name VARCHAR(20)
					);
					CREATE TABLE customer(
						id INT primary key,
						name VARCHAR(20)
					);
	-- 第三范式：满足第二范式的情况下，除开主键列的其他列之间不能有传递依赖





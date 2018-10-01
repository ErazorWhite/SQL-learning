//1
create database new_database;

use new_database

create table cities (id INT, name VARCHAR(255));

show tables;

drop table cities

create tables cities (id INT NOT NULL, name VARCHAR(255) NOT NULL);

insert into cities(id, name) value(1, 'Erazor');
insert into cities(id, name) value(2, 'Sanguis');
insert into cities(id, name) value(3, 'Pagv');

select * from cities;

select * from cities limit 2;

select * from cities where id = 2;

update cities set name = 'Sil' where id = 2;

delete from cities where id = 3;

select * from cities order by name ASC;

//2
PRAGMA FOREIGN_KEYS = ON;

DROP TABLE IF EXISTS regions;
CREATE TABLE IF NOT EXISTS regions (
	id INTEGER PRIMARY KEY AUTO_INCREMENT, // SERIAL в Postgre
	name VARCHAR(255) NOT NULL UNIQUE,
	active BOOLEAN NOT NULL DEFAULT TRUE,
	regions_id INTEGER NOT NULL,
) ENGINE InnoDB;

DROP TABLE IF EXISTS cities;
CREATE TABLE IF NOT EXISTS cities (
	id INTEGER PRIMARY KEY AUTO_INCREMENT, // SERIAL в Postgre
	name VARCHAR(255) NOT NULL UNIQUE,
	active BOOLEAN NOT NULL DEFAULT TRUE,
	FOREIGN KEY (regions_id) REFERENCES regions(id)
) ENGINE InnoDB;

INSERT INTO cities (name, region_id) VALUES ('Erazor', 1); // должна быть ошибка PRAGMA FOREIGN_KEYS
SELECT * FROM cities; // ошибка. добавьте регион

INSERT INTO regions (name, id, regions_id) VALUES ('Sanguis');

select * from regions;

INSERT INTO cities (name, region_id) VALUES ('Erazor', 1);
SELECT * FROM cities; // ошибка. добавьте город // в этот раз ошибка не возниктен

UPDATE cities SET regions_id = 3 where id = 1;

sqlite3 lesson.sqlite .dump > sqlite_dump.sql;		//sqlite3
sqlite3 lesson.sqlite .schema > sqlite_dump.sql;	//sqlite3

mysqldump -u root -folder > myssql_dump.sql			//mysql
mysqldump -u root -folder -d > myssql_dump.sql		//mysql schema

pg_dump -U postgres -d folder > postgresql_dump.sql	//posgresql
pg_dump -U postgres -d folder -s > postgresql_dump.sql	//posgresql schema

//Выборка из нескольких таблиц
SELECT * FROM cities LEFT JOIN regions ON (regions.id = cities.regions_id);
SELECT cities.name, regions.name FROM cities LEFT JOIN regions ON (regions.id = cities.regions_id);
SELECT cities.id as id , cities.name as city, regions.name as region FROM cities LEFT JOIN regions ON (regions.id = cities.regions_id) ORDER BY cities.id desc;

//3
ALTER TABLE cities ADD COLUMN strength INTEGER NOT NULL DEFAULT 0;
SELECT * FROM cities // всем записям добавилось значение 0

ALTER TABLE cities DROP COLUMN strength;

ALTER TABLE cities CHANGE strength count INTEGER NOT NULL DEFAULT 0;//mysql
ALTER TABLE cities RENAME strength to count;//postgresql

ALTER TABLE cities MODIFY count VARCHAR(255) NOT NULL DEFAULT 'nope';//mysql
ALTER TABLE cities ALTER COLUMN vars SET DATA TYPE VARCHAR(255);//posgresql
ALTER TABLE cities ALTER COLUMN vars SET DEFAULT 'nope';//posgresql
ALTER TABLE cities ALTER COLUMN vars SET NOT NULL;//posgresql

SELECT * FROM cities WHERE name like 'Erazor';
SELECT * FROM cities WHERE name like '%s';
SELECT * FROM cities WHERE name like '%a%';
SELECT * FROM cities WHERE regions_id = 2 AND name like '%a%';
SELECT * FROM cities WHERE regions_id = 1 OR name like '%a%';

SELECT DISTINCT regions_id FROM cities;
SELECT * FROM cities GROUP BY regions_id HAVING strength > 40000;

//func
SELECT MIN(id) FROM cities;
SELECT MAX(id) FROM cities;
SELECT ROUND(1.2345);
SELECT RANDOM();

//func string
SELECT LENGTH('132 21AR');//вывести кол-во символов
SELECT TRIM('132 21AR');//вывести только литералы
SELECT LENGTH(TRIM('132 21AR'));//вывести колво литералов
SELECT UPPER('132 21ARad');
SELECT LOWER('132 21ARad');
SELECT SUBSTR('132 21ARad', 2);//вернуть строку со сдвигом на 1 символ
SELECT REPLACE('a1a1a1a1', 1, 2);//заменить 1 на 2
SELECT REVERSE('12345');
SELECT MD5('12345');//вернуть хэш строки
SELECT SHA2('12345', 224);//вернуть хэш строки, разрядностью 224

//func time
SELECT NOW();
SELECT UNIX_TIMESTAMP();

CREATE TABLE table1 (id INTEGER, name VARCHAR(255));
INSERT INTO table1 VALUES (1, '123');
INSERT INTO table1 VALUES (2, '123');
INSERT INTO table1 VALUES (3, '123');
INSERT INTO table1 VALUES (4, '123');
INSERT INTO table1 VALUES (5, '123');

SELECT * FROM table1;

CREATE TABLE table2 (field_1 INTEGER, field_2 VARCHAR(255));
INSERT INTO table2 SELECT id, name FROM table1;
SELECT * FROM table2;
DELETE FROM table2;
INSERT INTO table2 SELECT id, name FROM table1 ORDER BY id desc;









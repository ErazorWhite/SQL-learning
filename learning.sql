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




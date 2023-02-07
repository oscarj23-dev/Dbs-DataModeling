-- (25 pt) (a) Write a series of CREATE and INSERT INTO statements that would
-- allow you to map a subset of the data from the ‘alzheimers’ table into tables
-- with the following schema:

-- create table questions (
-- 	id int,
-- 	question_id varchar(20),
-- 	question text,
-- 	primary key (id, question_id)
-- );

-- insert into questions(id, question_id, question) (
-- 	select id, question_id, question
-- 	from alzheimers 
-- );

-- create table responses (
-- 	id int,
-- 	question_id varchar(20) ,
-- 	data_value varchar(500),
-- 	data_value_unit varchar(20),
-- 	foreign key (id, question_id) references questions(id, question_id),
-- 	primary key (id, question_id)
-- );

-- insert into responses (id, question_id, data_value, data_value_unit) (
-- 	select id, question_id, data_value, data_value_unit 
-- 	from alzheimers
-- );

-- create table results (
-- 	id int,
-- 	loc_abbrev VARCHAR(20),
-- 	source VARCHAR(20),
-- 	class text,
-- 	topic text,
-- 	question_id varchar(20),
-- 	foreign key (id, question_id) references questions(id, question_id),
-- 	primary key(id, question_id)
-- );

-- insert into results(id, loc_abbrev, source, class, topic, question_id) (
-- 	select id, loc_abbrev, source, class, topic, question_id
-- 	from alzheimers
-- );

-- select * from questions 
-- limit 10;
-- (b) For the results table, the primary key can be the id field, as it is guaranteed to be unique for each record. 
-- The question_id is also included as a key as it references the questions table.


-- (c) In the results table, the question_id field is related to the question_id field in the questions table as a foreign key, as each 
-- result is related to a single question. In the responses table, the question_id field is related to the question_id 
-- field in the questions table as a foreign key, as each response is related to a single question. These foreign key 
-- relationships ensure referential integrity between the tables.

-- 2) create temporary table temp (vin varchar(10),
-- county varchar(200), 
-- city varchar(200), 
-- state char(2), 
-- postal_code int, 
-- model_year int, 
-- make varchar(50), 
-- model varchar(50), 
-- ev_type varchar(200), 
-- cafv varchar(200), 
-- electric_range int, 
-- base_msrp money, 
-- legislative_district int,
-- DOL_vehicle_ID int, 
-- location varchar(200), 
-- electric_utility varchar(200), 
-- census_tract bigint);
-- \copy temp from '/Users/oscarmaldonado/Downloads/ev.csv' csv header;
-- 
-- create table ev (id serial primary key,
-- vin varchar(10),
-- county varchar(200),
-- city varchar(200),
-- state char(2),
-- postal_code int,
-- model_year int,
-- make varchar(50),
-- model varchar(50),
-- ev_type varchar(200),
-- electric_range int,
-- base_msrp money,
-- census_tract bigint);
-- 
-- insert into ev (select DOL_vehicle_ID, vin, county, city, state, postal_code, model_year, make, model, ev_type, electric_range, base_msrp, census_tract from temp);
-- oscarj23_db=> select * from ev limit 10;
-- (25 pt) (a) Write a series of CREATE and INSERT INTO statements that would
-- allow you to map a subset of the data from the ‘alzheimers’ table into tables
-- with the following schema:

create table questions (
	id int,
	question_id varchar(20),
	question text,
	primary key (id, question_id)
);

insert into questions(id, question_id, question) (
	select id, question_id, question
	from alzheimers 
);

create table responses (
	id int,
	question_id varchar(20) ,
	data_value varchar(500),
	data_value_unit varchar(20),
	foreign key (id, question_id) references questions(id, question_id),
	primary key (id, question_id)
);

insert into responses (id, question_id, data_value, data_value_unit) (
	select id, question_id, data_value, data_value_unit 
	from alzheimers
);

create table results (
	id int,
	loc_abbrev VARCHAR(20),
	source VARCHAR(20),
	class text,
	topic text,
	question_id varchar(20),
	foreign key (id, question_id) references questions(id, question_id),
	primary key(id, question_id)
);

insert into results(id, loc_abbrev, source, class, topic, question_id) (
	select id, loc_abbrev, source, class, topic, question_id
	from alzheimers
);

select * from questions 
limit 10;
-- (b) For the results table, the primary key can be the id field, as it is guaranteed to be unique for each record. 
-- The question_id is also included as a key as it references the questions table.


-- (c) In the results table, the question_id field is related to the question_id field in the questions table as a foreign key, as each 
-- result is related to a single question. In the responses table, the question_id field is related to the question_id 
-- field in the questions table as a foreign key, as each response is related to a single question. These foreign key 
-- relationships ensure referential integrity between the tables.

create table Books (
	title varchar(200),
	author varchar(50),
	isbn char(10) primary key check (
		isbn like ('[0-9] {3} \- [0-9] {2} \- [0-9] {3}')
	),
	publisher varchar(200),
	printing int,
	constraint valid_publisher check (
		publisher in ('Norton', 'Penguin Classics', 'Macmillan', 'The New Press')
		),
	constraint valid_print check (
		printing >= 1 and printing <= 20
	)

);

create table Customer (
	curstomer int primary key,
	lname varchar(200),
	fname varchar(200),
	constraint valid_customer check (
		curstomer >= 1000 and curstomer <= 9999
	)
);

create table Ordered (
	isbn char(10),
	curstomer int,
	date Date,
	foreign key(isbn) references Books(isbn),
	foreign key(curstomer) references Customer(curstomer),
	primary key(isbn, curstomer, date)
);


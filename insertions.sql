insert into books(title, author, isbn) 
(
	select title, author, isbn
	from GoodReadsBooks
	where rating >= 4.0 and isbn not in (select isbn from Books)
)
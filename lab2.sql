-- 1.Write a SQL query that returns the titles and authors of books that were
-- published in 2010 sorted alphabetically.

select title, author
from books
where year_published = 2010
group by title, author
order by author asc
limit 10;

-- 2. (5 pts) query that returns the number of books that are over 300
-- pages long and highly rated on goodreads (rating greater than or equal to 4).

select count(title)
from books
where pages > 300 and goodreads_rating >= 4;

-- 3.  Write a SQL query that returns the number of books published per year
-- ordered by publication year. Is there anything odd about this data?

select year_published, count(*)
from books
group by year_published
order by year_published desc
limit 10;
-- one odd thing about this data could be that in 2008 the amount of published books 
-- eclispes any other year in the table?

-- 4. (10 pts) Write a SQL query that returns for *each* book in the books table its
-- (rating and number of ratings from the books table), and its (average rating and
-- total number of ratings computed from the ratings table.) Every book from the
-- books table should have a single entry in the output regardless of whether it has
-- been rated.

select title, goodreads_rating, num_ratings, avg(rating), count(rating)
from books
left join ratings on title = book_name
group by title, goodreads_rating, num_ratings
order by title asc
limit 10;


-- 5. (10 pts) We want to know which of the users in our database are cranks (give
-- lower ratings to books on average when compared to the GoodReads ratings)!
-- Let’s define “crankiness” as the average delta (or difference) between a user’s
-- ratings and the GoodReads ratings for the same books. For each individual book
-- a user has rated, you would compute this delta by subtracting the user’s rating
-- from the GoodReads rating. Write a SQL query that returns for each user in
-- users their “crankiness”. Your results should include only the 10 most “cranky”
-- reviewers, ordered by their “crankiness” from most cranky to least cranky.

select distinct username, goodreads_rating - rating  as crank
from users
join ratings on users.id = user_id
join books on book_name = title
order by crank desc
limit 10;

-- 6.(10 pts) One of the users is called ‘austenfan’. Based on the books they’ve rated,
-- are they a Jane Austen fan? Write a query to output a list of the most commonly
-- rated authors by this user, the number of books per author the user has rated,
-- and the list of book titles from books for each author that has been rated by this
-- user. Based on your results, is ‘austenfan’ a Jane Austen fan?

select username, author, count(title) as books_rated, array_agg(title) as title
from users
join ratings on users.id = user_id
join books on book_name = title
where username = 'austenfan'
group by username, author
order by count(title) desc;
-- austenfan is an avid Jane Austen fan, more of a P.G. Wodehouse fan since he seems to have read more books
-- by this author and given them a fairly good rating, something must be attracting the user back to
-- his books.

-- bonus

select username, count(title) as austen_books_rated
from users
join ratings on users.id = user_id
join books on book_name = title
group by username, author
having author = 'Jane Austen'
order by count(title) desc
limit 10;


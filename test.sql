-- Write a query using common table expressions to find companies that 
-- manufacturer both cheap (sold for <$10) and expensive (sold for >$500) 
-- products
-- Product r(product_id, pname, manufacturer)
-- Purchase p(purchase_id, product_id, price, quantity, month, year)
-- Company c(cname, country)


with cheap as (
	select * 
	from product r, purchase p, company c
	where r.product_id = p.product_id
	and r.manufacturer = c.cname 
	and p.price < 10
),
expensive as (
	select * 
	from product r, purchase p, company c
	where r.product_id = p.product_id
	and r.manufacturer = c.cname 
	and p.price > 500
) 
-- select cheap.manufacturer as cheap
-- from cheap
-- limit 10

select expensive.manufacturer as expensive
from expensive
limit 10

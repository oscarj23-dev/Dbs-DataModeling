-- with countryMax as (
--    SELECT x.country, max(y.price) as maxPrice     
--    FROM   Company x, Purchase y, Product z
--    WHERE  y.product_id = z.product_id
--    AND z.manufacturer = x.cname 
--    GROUP BY x.country
-- ) 
-- SELECT c.country, r.pname, p.price
-- FROM Company c, Product r, Purchase p, CountryMax m 
-- WHERE p.product_id = r.product_id
--    AND r.manufacturer = c.cname 
--    AND (c.country = m.country or (c.country is null and m.country is null))
--    AND p.price = m.maxPrice;

-- select c.country, r.pname, max(p.price)
-- from company c, product r, purchase p, purchase x
-- where p.product_id = r.product_id
-- and r.manufacturer = c.cname
-- and p.product_id = x.product_id
-- group by c.country, r.pname
-- having max(p.price) = p.price


-- select product_id 
-- from (
-- 	select*
-- 	from purchase y
-- 	where price > 100
-- ) as x
-- where x.price < 500
-- limit 10;


-- select x.manufacturer, y.product_id
-- from product x, purchase y
-- where x.manufacturer not in (
-- 	select r.manufacturer as man
-- 	from product r, purchase p
-- 	where p.product_id = r.product_id
-- 	and r.pname <> 'hammer' and r.pname <> 'screwdriver'
-- 	);
	
-- find monthyears that have more than $10000 of total sales
-- select p.month, p.year, sum(price*quantity) as totalSales
-- from purchase p
-- group by p.month, p.year
-- having sum(price*quantity) > 10000;

-- find all products sold <10 and >50

-- select r.pname, y.price
-- from product r, purchase y
-- where y.product_id = r.product_id
-- and y.price < 10 or y.price > 50


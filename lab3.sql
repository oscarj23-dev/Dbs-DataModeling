-- 1. (10pt) Write a nested SQL query that returns the top 10 electric vehicles (make,
-- model, year) by average electric range. The average electric range should be
-- computed from the electric range numbers reported in the ‘ev_wa’ table. The
-- reason this is a nested query is because each VIN (vehicle identification number)
-- may be included multiple times in the table, so you will first need to compute the
-- average range per car (per VIN) before aggregating over make-model-year. In
-- your final output table, please include the model_year, make, model, number of
-- cars of that make-model-year, and the average electric range. Hint: you might
-- want to start by writing a query computing the average electric range for each
-- VIN.

select ev.make, ev.model, ev.model_year, models_sold, range
from ( 
	select make, model_year, model, count(model) as models_sold, avg(electric_range) as range
	from ev_wa
	group by make, model, model_year
	order by avg(electric_range) desc
) ev
limit 10;

-- "TESLA"	"MODEL S"	2020	380	331.2342105263157895
-- -- "TESLA"	"MODEL 3"	2020	3683	297.3070866141732283
-- -- "TESLA"	"MODEL X"	2020	646	291.6315789473684211
-- -- "TESLA"	"MODEL Y"	2020	2263	291.0000000000000000
-- -- "TESLA"	"MODEL X"	2019	371	289.0000000000000000
-- -- "TESLA"	"MODEL S"	2019	252	270.0000000000000000
-- -- "TESLA"	"MODEL S"	2012	133	265.0000000000000000
-- -- "CHEVROLET"	"BOLT EV"	2020	1022	259.0000000000000000
-- -- "HYUNDAI"	"KONA"	2020	157	258.0000000000000000
-- -- "HYUNDAI"	"KONA"	2019	41	258.0000000000000000

-- 2. (15pt) We want to know which electric vehicles have made the most year-on-
-- year improvement in electric range. Write a query using common table ex-
-- pressions to return the vehicles (make, model) that made the most single year
-- improvement to their electric range. Output just the top 10 most dramatic year-
-- on-year changes. Hint: This query should build upon your previous query.
-- We want to know whether there is a relationship between median household income
-- and prevalence of electric cars. We will use census tract as a minimum geographic
-- unit. Median household income can be found in the ‘income’ table associated with
-- the census geo ID. This geo ID maps to the census tracts in the ‘ev_wa’ table.







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

-- select ev.make, ev.model, ev.model_year, models_sold, range
-- from ( 
-- 	select make, model_year, model, count(model) as models_sold, avg(electric_range) as range
-- 	from ev_wa
-- 	group by make, model, model_year
-- 	order by avg(electric_range) desc
-- ) ev
-- limit 10;

-- answers:
-- -- "TESLA"	"MODEL S"	2020	380		331.2342105263157895
-- -- "TESLA"	"MODEL 3"	2020	3683	297.3070866141732283
-- -- "TESLA"	"MODEL X"	2020	646		291.6315789473684211
-- -- "TESLA"	"MODEL Y"	2020	2263	291.0000000000000000
-- -- "TESLA"	"MODEL X"	2019	371		289.0000000000000000
-- -- "TESLA"	"MODEL S"	2019	252		270.0000000000000000
-- -- "TESLA"	"MODEL S"	2012	133		265.0000000000000000
-- -- "CHEVR"	"BOLT EV"	2020	1022	259.0000000000000000
-- -- "HYUNDAI"	"KONA"		2020	157		258.0000000000000000
-- -- "HYUNDAI"	"KONA"		2019	41		258.0000000000000000

-- 2. (15pt) We want to know which electric vehicles have made the most year-on-
-- year improvement in electric range. Write a query using common table ex-
-- pressions to return the vehicles (make, model) that made the most single year
-- improvement to their electric range. Output just the top 10 most dramatic year-
-- on-year changes. Hint: This query should build upon your previous query.
-- We want to know whether there is a relationship between median household income
-- and prevalence of electric cars. We will use census tract as a minimum geographic
-- unit. Median household income can be found in the ‘income’ table associated with
-- the census geo ID. This geo ID maps to the census tracts in the ‘ev_wa’ table.

-- with best_evr as( 
-- 	select make, model_year, model, count(model) as models_sold, avg(electric_range) as e_range
-- 	from ev_wa
-- 	where electric_range > 0
-- 	group by make, model, model_year
-- 	order by avg(electric_range) desc
-- ),
-- year_on_year as (
-- 	select r.make, r.model, r.model_year, r.e_range, (r.e_range - ev.e_range) as diff
-- 	from best_evr r, best_evr ev
-- 	where r.model = ev.model
-- 	and r.model_year - ev.model_year = 1
-- 	order by (diff) desc
-- 	 )
-- select r.make, r.model
-- from year_on_year r
-- order by r.diff desc 
-- limit 10;

-- answers:
-- "KIA"	"NIRO"
-- "TESLA"	"MODEL 3"
-- "TESLA"	"MODEL S"
-- "TESLA"	"MODEL X"
-- "NISSAN"	"LEAF"
-- "VOLKSWAGEN"	"E-GOLF"
-- "TESLA"	"MODEL S"
-- "TESLA"	"MODEL X"
-- "HYUNDAI"	"IONIQ"
-- "KIA"	"NIRO"

-- 3. (15pt) Write a query to return the number of unique electric vehicles (by VIN)
-- per census tract in Washington state along with the median household income
-- of that census tract, for only tracts where the median income is available. The
-- query should return only the top 10 tracts by highest median income.

-- final query
-- SELECT e.census_tract, i.census_geo_id, count(distinct e.vin)
-- FROM ev_wa e
-- JOIN income i ON i.census_geo_id LIKE CONCAT('%', e.census_tract)
-- group by e.census_tract, i.census_geo_id
-- order by count(distinct e.vin) desc
-- limit 100;

-- test bench
-- SELECT e.census_tract, i.census_geo_id, i.median_hh_income_2020 as med,
-- 	  i.median_hh_income_2020_1 as med1,
-- 	  i.median_hh_income_2020_2 as med2, 
-- 	  i.median_hh_income_2020_3 as med3,
-- 	  i.median_hh_income_2020_4 as med4,
-- 	  i.median_hh_income_2020_5 as med5,
-- 	  i.median_hh_income_2020_6 as med6,
-- 	  i.median_hh_income_2020_7 as med7,
-- count(distinct e.vin) as unique_evs
-- FROM ev_wa e
-- JOIN income i ON i.census_geo_id LIKE CONCAT('%', e.census_tract)
-- where i.census_geo_id is not null 
-- 	and e.census_tract is not null
-- 	and i.median_hh_income_2020 is not null 
-- 	and i.median_hh_income_2020_1 is not null 
-- 	and i.median_hh_income_2020_2 is not null 
-- 	and i.median_hh_income_2020_3 is not null 
-- 	and i.median_hh_income_2020_4 is not null 
-- 	and i.median_hh_income_2020_5 is not null 
-- 	and i.median_hh_income_2020_6 is not null 
-- 	and i.median_hh_income_2020_7 is not null 
-- group by e.census_tract, i.census_geo_id, i.median_hh_income_2020, i.median_hh_income_2020_1,
-- 		i.median_hh_income_2020_2, 
-- 		i.median_hh_income_2020_3,
-- 		i.median_hh_income_2020_4,
-- 		i.median_hh_income_2020_5,
-- 		i.median_hh_income_2020_6,
-- 		i.median_hh_income_2020_7
-- order by i.median_hh_income_2020 desc
-- limit 10;

with censi as ( 
	SELECT e.census_tract, i.census_geo_id, count(distinct e.vin) as vic
	FROM ev_wa e
	JOIN income i ON i.census_geo_id LIKE CONCAT('%', e.census_tract)	
	where i.census_geo_id is not null 
	and e.census_tract is not null
	group by e.census_tract, i.census_geo_id
)
-- med as (
-- 	select i.median_hh_income_2020 as med
-- 	from income i
-- 	where i.median_hh_income_2020 is not null
-- )
select c.census_tract, c.vic
from censi c
order by c.vic desc
limit 10;





















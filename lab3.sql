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
-- 	where make is not null
-- 		and model_year is not null
-- 		and model is not null
-- 	group by make, model, model_year
-- 	order by avg(electric_range) desc
-- ) ev
-- limit 10;

-- answers:

-- 	  Make		Model		Year	#sold	Average range
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
-- 	where make is not null
-- 		and model_year is not null
-- 		and model is not null
-- 		and electric_range > 0
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

-- make		model
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

SELECT e.census_tract, i.census_geo_id, i.median_hh_income_2020 as median, i.county_name, e.city, count(distinct e.vin) as unique_evs 
FROM ev_wa e
JOIN income i ON i.census_geo_id LIKE CONCAT('%', e.census_tract)
where i.state_code is not null	
	and i.census_geo_id is not null 
	and e.census_tract is not null
	and i.median_hh_income_2020 is not null
	and i.county_name is not null
	and e.city is not null
	and i.state_code = '53'
group by e.census_tract, i.census_geo_id, i.median_hh_income_2020, i.county_name, e.city
order by i.median_hh_income_2020 asc
limit 10;

-- answers:

-- census_tract		census_geo_id			median	county_name		Unique_evs
-- "53033004101"	"14000US53033004101"	250001	"King County"	222
-- "53033024100"	"14000US53033024100"	250001	"King County"	323
-- "53033024602"	"14000US53033024602"	250001	"King County"	252
-- "53033024601"	"14000US53033024601"	245278	"King County"	302
-- "53033032217"	"14000US53033032217"	245099	"King County"	203
-- "53033023902"	"14000US53033023902"	240833	"King County"	186
-- "53033032215"	"14000US53033032215"	235821	"King County"	234
-- "53033024905"	"14000US53033024905"	223686	"King County"	218
-- "53033006200"	"14000US53033006200"	217885	"King County"	215
-- "53033032326"	"14000US53033032326"	213246	"King County"	193
-- I made this data set with the i.median_hh_income_2020 column, it is not really specified in the assignment spec 
-- so I felt I should use this column since it was the first one, also added in county_name in because I was 
-- curious to know which counties were in the top 10

-- 4. (10pt) Retrieve the top 10 and bottom 10 tracts by median household income.
-- Is there a difference in the number of electric vehicles in these sets of tracts?
-- What are the cities associated with these tracts? You can use SQL to do this. Do
-- the results match your expectations?

-- answers:

-- To address the changes in the dataset, I am assuming the city values for some of the answers in Q3
-- were null so they were replaced with the city that had the next highest income.
-- There is quite a big difference in the two sets of tracts, the cities associated with the top tracts
-- tend to be more urban areas, while vice versa for the bottom tracts, they are more agricultural towns
-- with heavy migrant populations. One thing I didnt expect was to see my home town sunnyside, I knew
-- sunnyside wasn't home to the wealthiest residents but it is a little disheatening to see them in 
-- this dataset.
-- (top 10)
-- "53033004101"	"14000US53033004101"	250001	"King County"	"Seattle"		222
-- "53033024100"	"14000US53033024100"	250001	"King County"	"Clyde Hill"	208
-- "53033024100"	"14000US53033024100"	250001	"King County"	"Hunts Point"	44
-- "53033024100"	"14000US53033024100"	250001	"King County"	"Kirkland"		1
-- "53033024100"	"14000US53033024100"	250001	"King County"	"Yarrow Point"	101
-- "53033024602"	"14000US53033024602"	250001	"King County"	"Mercer Island"	252
-- "53033024601"	"14000US53033024601"	245278	"King County"	"Mercer Island"	302
-- "53033032217"	"14000US53033032217"	245099	"King County"	"Sammamish"		203
-- "53033023902"	"14000US53033023902"	240833	"King County"	"Bellevue"		186
-- "53033032215"	"14000US53033032215"	235821	"King County"	"Redmond"		4

-- (bottom 10)
-- "53075000100"	"14000US53075000100"	12473	"Whitman County"	"Pullman"	1
-- "53063003500"	"14000US53063003500"	14280	"Spokane County"	"Spokane"	19
-- "53075000601"	"14000US53075000601"	17294	"Whitman County"	"Pullman"	7
-- "53075000602"	"14000US53075000602"	21024	"Whitman County"	"Pullman"	6
-- "53075000500"	"14000US53075000500"	21696	"Whitman County"	"Pullman"	5
-- "53033005305"	"14000US53033005305"	21781	"King County"		"Seattle"	23
-- "53077002005"	"14000US53077002005"	21783	"Yakima County"		"Sunnyside"	7
-- "53037975404"	"14000US53037975404"	22080	"Kittitas County"	"Ellensburg"12
-- "53077000100"	"14000US53077000100"	23590	"Yakima County"		"Yakima"	7
-- "53021020404"	"14000US53021020404"	24025	"Franklin County"	"Pasco"		3



















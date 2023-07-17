
-- =========================--=================--Segment 2-- =========================--===============================

-- Q1 Determine the total number of movies released each year and analyse the month-wise trend.
-- Asnwer:  Query has been written below for this


select year,month(date_published)as month,
count(id)
as movies_released_count 
from movie group 
by year ,month(date_published)
order by year , month(date_published)  asc;
-- end of query Q1-- 

-- Q2:Calculate the number of movies produced in the USA or India in the year 2019.
-- Answer: 

select country,count(id) as movies_released 
from movie
where country IN ('India', 'USA') and 
year= 2019
group by country;

-- end of query--

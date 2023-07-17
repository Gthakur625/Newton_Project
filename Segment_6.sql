
-- 										----------Segment 6-------------

-- Q1. Classify thriller movies based on average ratings into different categories.
-- Answer

select rg.movie_id,
title,gn.genre,
case
 when rg.avg_rating >=8 then 'Blockbuster_Movie'
 when rg.avg_rating >=7 then 'Hit_Movie'
 when rg.avg_rating>=6 then 'Average_Movie'
 else 'Below_Average_Movie' end as rating_category
from movie as mm
left  join ratings as rg
on mm.id= rg.movie_id
left join genre as gn
on mm.id= gn.movie_id
where gn.genre='Thriller'
order by avg_rating desc;


-- Q2. analyse the genre-wise running total and moving average of the average movie duration.
-- Answer:
SELECT
    g.genre,
    round(AVG(m.duration),2) AS average_duration,
    round(SUM(AVG(m.duration)) OVER (PARTITION BY g.genre ORDER BY g.genre ASC),2) AS running_total,
    round(AVG(AVG(m.duration)) OVER (PARTITION BY g.genre ORDER BY g.genre ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) 
    AS moving_average
FROM genre g JOIN
movie m ON g.movie_id = m.id
GROUP BY g.genre
ORDER BY g.genre ASC;

-- Q3. Identify the five highest-grossing movies of each year that belong to the top three genres.
-- Answer:
Select rr.year,
		rr.genre,
        rr.title,
        rr.worlwide_gross_income
		from (
		Select row_number() over(partition by mm.year order by mm.worlwide_gross_income desc) AS movie_rank,
		mm.year,mm.title,gg.genre,mm.worlwide_gross_income from movie mm
		left join genre gg
		on mm.id= gg.movie_id
		where gg.genre IN (

		Select genre from (
			select genre , count(movie_id)as no_of_movies
			from genre gg
			group by genre
			order by no_of_movies desc
			limit 3
		) as top_genre
	)
)as rr
where rr.movie_rank <=5
order by rr.year asc, rr.genre asc,rr.movie_rank;


-- Q4 Determine the top two production houses that have produced the highest number of hits among multilingual movies.
-- Answer:
SELECT m.production_company, COUNT(*) AS hit_count
FROM movie m
inner JOIN ratings r ON 
m.id = r.movie_id
WHERE m.languages LIKE '%,%' -- Movies with multiple languages
AND r.avg_rating >= 7.0 -- Assuming a rating of 7.0 or above is considered a hit
GROUP BY m.production_company
ORDER BY hit_count DESC
LIMIT 2;

-- Q5-	Identify the top three actresses based on the number of Super Hit movies (average rating > 8) in the drama genre.
-- Answer
Select ns.name, 
count(rg.movie_id) as Superhit_Movies
from names ns left join 
role_mapping rm on ns.id=rm.name_id
left join ratings rg 
on  rm.movie_id= rg.movie_id
left join genre g on 
rg.movie_id= g.movie_id
where rg.avg_rating>8 and g.genre='Drama' and 
rm.category='actress'
group by ns.name
order by Superhit_movies desc limit 3;


-- Q6. Retrieve details for the top nine directors based on the number of movies, including average inter-movie duration, ratings, and more.
-- Answer:
SELECT n.name AS director_name,
       COUNT(DISTINCT dm.movie_id) AS movie_count,
       round(AVG(m.duration),2) AS average_duration,
       round(AVG(r.avg_rating),2) AS average_rating
FROM names n
JOIN director_mapping dm ON n.id = dm.name_id
JOIN movie m ON dm.movie_id = m.id
JOIN ratings r ON m.id = r.movie_id
GROUP BY n.name
ORDER BY movie_count DESC
LIMIT 9;
















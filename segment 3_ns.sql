
								-- ----------------------Segment 3-------------------
                                
-- Q1. Retrieve the unique list of genres present in the dataset.
-- Answer: 
select distinct 
genre from
genre;

-- Q2. Identify the genre with the highest number of movies produced overall.
-- Asnwer-- 
select genre, count(movie_id) as 
movies_count from 
genre 
group by genre
order by count(movie_id) DESC 
limit 1;

-- Q3.-	Determine the count of movies that belong to only one genre.
-- Answer:
select genre, count(movie_id) as 
movies_count from 
genre 
group by genre;

-- Q4.Calculate the average duration of movies in each genre.
-- Answer:

SELECT gn.genre, ROUND(AVG(mv.duration), 2) AS avg_duration
FROM movie AS mv
JOIN genre AS gn ON mv.id = gn.movie_id     -- Joined genre table with Movie to get the genre
GROUP BY gn.genre
order by avg_duration desc;     					

-- Q5 -	Find the rank of the 'thriller' genre among all genres in terms of the number of movies produced.
-- Answer:
select  genre,rank() over (order by count(movie_id))
as genre_rank
from genre
group by genre
order by genre_rank desc
;





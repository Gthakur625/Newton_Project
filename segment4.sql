use imdb;
												-- segment 5--
                                                
 -- Q1. -	Retrieve the minimum and maximum values in each column of the ratings table (except movie_id).
 -- Answer:
 select min(avg_rating)as  min_rating,
 max(avg_rating)as  max_rating,
 min(total_votes)as  min_votes,
 max(total_votes) as max_votes,
 min(median_rating)as  min_median,
 max(median_rating)as  max_median
 from ratings ;
 
 -- Q2.Identify the top 10 movies based on average rating.
 -- Answer

Select mv.title ,
rg.avg_rating
from movie as mv
left join ratings as rg
on mv.id=rg.movie_id
order by avg_rating
desc limit 10;

-- Q3.Summarise the ratings table based on movie counts by median ratings.
-- Answer
Select count(movie_id)as no_of_movies,
median_rating
from ratings
group by median_rating
order by no_of_movies desc;

-- Q4.Identify the production house that has produced the most number of hit movies (average rating > 8).
-- Answer: 
Select mv.production_company ,
count(rg.movie_id)as hit_movies_count
from movie as mv
left join ratings as rg
on mv.id=rg.movie_id
where rg.avg_rating>8
group by production_company
order by hit_movies_count
desc;

-- Q5.-	Determine the number of movies released in each genre during March 2017 in the USA with more than 1,000 votes.
-- Answer:

select gn.genre,
count(rg.movie_id)as released_movies
from genre as gn
left join ratings as rg
on gn.movie_id=rg.movie_id
inner join movie as mv
on mv.id=rg.movie_id
where mv.date_published 
between '2017-03-01' and '2017-03-31' 
and mv.country= 'USA' 
and rg.total_votes >1000
group by genre
order by released_movies desc
;

-- Q6 Retrieve movies of each genre starting with the word 'The' and having an average rating > 8.

select gn.genre,
mv.title,rg.avg_rating
from movie as mv
left join genre as gn
on mv.id=gn.movie_id 
left join ratings as rg
on mv.id=rg.movie_id
where title like 'The%' 
and rg.avg_rating>8;







 
 
 
 
 
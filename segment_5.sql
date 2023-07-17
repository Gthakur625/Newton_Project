
														-- ------Segment 5--------
                                                        
 -- Q1.Identify the columns in the names table that have null values.   
 -- Answer:
 select 
 case WHEN  id IS NULL THEN 'null' ELSE 'not_null' end as id_null_chk,
 case when  name is null  THEN 'null' ELSE 'not_null' end as name_null_chk,
 case when height is null THEN 'null' ELSE 'not_null'end as height_null_chk,
 case when date_of_birth is null THEN 'null' ELSE 'not_null'end as birthDate_null_chk,
 case when known_for_movies is null THEN 'null' ELSE 'not_null' end as Know_fr_movies_null_chk
 from names; 
 
 
 -- Q3.Determine the top three directors in the top three genres with movies having an average rating > 8.
 -- Answer 
 
 select  nm.name ,gn.genre
 from director_mapping as dm
 left join names as nm
 on dm.name_id= nm.id
 left join genre as gn
 on dm.movie_id= gn.movie_id
 left join ratings as rg
 on dm.movie_id= rg.movie_id
 where rg.avg_rating>8
 order by name desc
 ,genre desc 
 limit 3
 ;
  
  
-- Q4: -	Find the top two actors whose movies have a median rating >= 8.
-- Answer:

SELECT n.name, rr.median_rating
FROM (
  SELECT  rm.name_id,rs.median_rating,
	ROW_NUMBER() OVER (ORDER BY rs.median_rating DESC) AS ranking
  FROM ratings as rs left join role_mapping as rm
  on rs.movie_id= rm.movie_id
  WHERE median_rating >= 8
) AS rr
JOIN names n ON rr.name_id = n.id
WHERE rr.ranking <= 2;


-- Q5: Identify the top three production houses based on the number of votes received by their movies.
-- Answers:

SELECT m.production_company, SUM(r.total_votes) AS total_votes
FROM movie m
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.production_company
ORDER BY total_votes DESC
LIMIT 3;

-- Q6: Rank actors based on their average ratings in Indian movies released in India.
-- Answer:


select ns.name,dense_rank() over(order by avg(rg.avg_rating) desc) as final_rank,
round(avg(rg.avg_rating),2)as final_avg_rating ,
count(mm.id) as movies 
from ratings as rg 
inner join role_mapping as rm
on rg.movie_id= rm.movie_id
inner join names as ns
on rm.name_id= ns.id
left join movie as mm
on rg.movie_id= mm.id
where country='India'
group by name
order by final_avg_rating desc ;



-- Q6 -	Identify the top five actresses in Hindi movies released in India based on their average ratings.
-- Answer :
select ns.name,
dense_rank() over(order by avg(rg.avg_rating) desc) as final_rank,
round(avg(rg.avg_rating),2)as final_avg_rating ,
count(mm.id) as movies 
from ratings as rg 
inner join role_mapping as rm
on rg.movie_id= rm.movie_id
inner join names as ns
on rm.name_id= ns.id
left join movie as mm
on rg.movie_id= mm.id
where country='India' and
rm.category='actress' and
mm.languages='Hindi' 
group by name
order by final_rank asc limit 5;


--  ---------------------------------------- End of Segment 5--------------------------------------
 
 

   
   --       							  ------------Segment 7-----------------
   
-- Recommendations : Based on the analysis, provide recommendations for the types of content Bolly movies should focus on producing.
   
/*  Bollywood should focus on Drama, Action Comedy & Thriller as 
    these having highest rating as well very good worldwide collection. 
    Even number of movies released  in worldwide are Drama followed by Comedy.									*/
    
 -- ================================ Other Analysis=======================================   ======================== =============
 
 
-- Determine the average duration of movies released by Bolly Movies compared to the industry average.

SELECT round(AVG(duration),2) AS bolly_movies_average_duration,(SELECT round(AVG(duration),2) AS industry_average_duration
FROM movie)as Industory_Average -- Calculate overall industry average duration
FROM movie
WHERE country = 'India';

-- Analyse the correlation between the number of votes and the average rating for movies produced by Bolly Movies.

SELECT
    round((SUM(r.total_votes * r.avg_rating) - SUM(r.total_votes) * SUM(r.avg_rating) / COUNT(*)) /
    (SQRT((SUM(r.total_votes * r.total_votes) - SUM(r.total_votes) * SUM(r.total_votes) / COUNT(*)) *
        (SUM(r.avg_rating * r.avg_rating) - SUM(r.avg_rating) * SUM(r.avg_rating) / COUNT(*)))),2)
    AS correlation
FROM movie m
JOIN ratings r ON m.id = r.movie_id
WHERE m.country = 'India';

-- Find the production house that has consistently produced movies with high ratings over the past three years.
SELECT
    m.production_company,
    AVG(r.avg_rating) AS average_rating
FROM movie m
JOIN ratings r ON m.id = r.movie_id
WHERE m.year >= YEAR(CURDATE()) - 3
GROUP BY m.production_company
HAVING
    COUNT(DISTINCT m.year) = 3 -- Considering only the production houses with movies in all three years
     
ORDER BY
    AVG(r.avg_rating) DESC; -- Didnt find  any production house...
    
    
    -- Identify the top three directors who have successfully delivered commercially successful movies with high ratings.
    
SELECT
    n.name AS director_name,
    round(AVG(r.avg_rating),2) AS average_rating,
    SUM(m.worlwide_gross_income) AS total_gross_income
FROM names n
JOIN
director_mapping dm ON n.id = dm.name_id
JOIN movie m ON dm.movie_id = m.id
JOIN ratings r ON m.id = r.movie_id
GROUP BY n.name
HAVING
   AVG(r.avg_rating) >= 8.0 -- Considering high ratings
   and sum(worlwide_gross_income)>10000 -- Considering commercially successful movies
ORDER BY
    total_gross_income DESC
LIMIT 3;







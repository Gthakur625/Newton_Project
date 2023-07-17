use imdb;
-- ==========================================segment 1--===================================================================================-----------------



/* 
  Q1. What are the different tables in the database and how are they connected to each other in the database?

  Answer 1: There are 6 tables in database. Table  Movie,genre,director_mapping,role_mapping & ratings have common ID 
       that is movie_id & this movie_id is the primary id of Movie table. And Names table related with role_mapping & 
       director_mapping with name_id as Name_id is the primary key in Names table.
*/


/*

Q2.   Find the total number of rows in each table of the schema.  
  Answer 2: movie Table 7997 rows,
			director_mapping table 3867 rows,
            genre table 14662 rows,
            names table 25735 rows,
            ratings table 7997 rows,
            role_mapping table 15615 rows.   */

-- Answer of Q2:--
select count(*) as row_count_movie,
(select count(*) as row_coun2  from director_mapping )as row_count_director_mapping
,(select count(*) from genre)as row_count_genre,
(select count(*) from names)as row_count_names,
(select count(*) from ratings) as row_count_ratings,
(select count(*) from role_mapping)as row_count_role_mapping
from movie;
-- end of Q2-------------------------------------



/*
  Q3.  Identify which columns in the movie table have null values.
  Answer: Column: Country,worlwide_gross_income,languages & production_company have null values.  */

-- Answer of Q3:--
SELECT
  CASE WHEN id IS NULL THEN '0' ELSE '1' END AS id_null_check,    -- using case statement as to check for null
  CASE WHEN title IS NULL THEN '0' ELSE '1' END AS title_null_check,
  CASE WHEN year IS NULL THEN '0' ELSE '1' END AS year_null_check,
  CASE WHEN date_published IS NULL THEN '0' ELSE '1' END AS date_null_check,
  CASE WHEN duration IS NULL THEN '0' ELSE '1' END AS duration_null_check,
  CASE WHEN country IS NULL THEN '0' ELSE '1' END AS country_null_check,
  CASE WHEN worlwide_gross_income IS NULL THEN '0' ELSE '1' END AS worldwide_null_check,
  CASE WHEN languages IS NULL THEN '0' ELSE '1' END AS languages_null_check,
  CASE WHEN production_company  is null then '0' else '1' end as production_null_check
FROM movie;


-- end of Q3 query  ---------------  
    
    

  
  






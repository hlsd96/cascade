
  
    

        create or replace transient table cascade.dev_prod.location  as
        (

WITH location_a AS (
    SELECT a.city AS city,
        a.country AS country
    FROM cascade.dev.src_africa a 
    UNION 
    SELECT b.city,
        b.country
    FROM cascade.dev.src_america b
    UNION 
    SELECT c.city,
        c.country
    FROM cascade.dev.src_asia c
    UNION 
    SELECT d.city,
        d.country
    FROM cascade.dev.src_atlantic d
    UNION 
    SELECT e.city,
        e.country
    FROM cascade.dev.src_australia e
    UNION 
    SELECT f.city,
        f.country
    FROM cascade.dev.src_europe f
    UNION 
    SELECT g.city,
        g.country
    FROM cascade.dev.src_indian g
    UNION 
    SELECT h.city,
        h.country
    FROM cascade.dev.src_pacific h
),
location_b AS (
    SELECT a.city_agent AS city
    FROM cascade.dev.src_africa a 
    UNION 
    SELECT b.city_agent
    FROM cascade.dev.src_america b
    UNION 
    SELECT c.city_agent
    FROM cascade.dev.src_asia c
    UNION 
    SELECT d.city_agent
    FROM cascade.dev.src_atlantic d
    UNION 
    SELECT e.city_agent
    FROM cascade.dev.src_australia e
    UNION 
    SELECT f.city_agent
    FROM cascade.dev.src_europe f
    UNION 
    SELECT g.city_agent
    FROM cascade.dev.src_indian g
    UNION 
    SELECT h.city_agent
    FROM cascade.dev.src_pacific h
)
SELECT 
    
md5(cast(coalesce(cast(city as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS location_id,
    city AS city_name,
    country AS country_name
FROM location_a
UNION
SELECT 
    
md5(cast(coalesce(cast(city as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)),
    city,
    NULL
FROM location_b
WHERE city NOT IN (
    SELECT city
    FROM location_b
)
        );
      
  
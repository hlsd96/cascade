
  
    

        create or replace transient table cascade.dev_prod.witness  as
        (

WITH witness AS (
    SELECT a.witness AS witness
    FROM cascade.dev.src_africa a 
    UNION 
    SELECT b.witness
    FROM cascade.dev.src_america b
    UNION 
    SELECT c.witness
    FROM cascade.dev.src_asia c
    UNION 
    SELECT d.witness
    FROM cascade.dev.src_atlantic d
    UNION 
    SELECT e.witness
    FROM cascade.dev.src_australia e
    UNION 
    SELECT f.witness
    FROM cascade.dev.src_europe f
    UNION 
    SELECT g.witness
    FROM cascade.dev.src_indian g
    UNION 
    SELECT h.witness
    FROM cascade.dev.src_pacific h
)
SELECT 
    
md5(cast(coalesce(cast(witness as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS Witness_id,
    LEFT(witness,CHARINDEX(' ', witness) - 1) AS Witness_name,
    RIGHT(witness, CHARINDEX(' ', REVERSE(witness)) - 1) AS Witness_surname
FROM witness
        );
      
  
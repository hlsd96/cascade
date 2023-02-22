
  
    

        create or replace transient table cascade.dev_prod.agent  as
        (

WITH agent AS (
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(a.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','') AS agent
    FROM cascade.dev.src_africa a 
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(b.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM cascade.dev.src_america b
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(c.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM cascade.dev.src_asia c
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(d.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM cascade.dev.src_atlantic d
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(e.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM cascade.dev.src_australia e
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(f.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM cascade.dev.src_europe f
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(g.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM cascade.dev.src_indian g
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(h.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM cascade.dev.src_pacific h
)
SELECT 
    
md5(cast(coalesce(cast(agent as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS agent_id,
    LEFT(agent,CHARINDEX(' ', agent) - 1) AS agent_name,
    RIGHT(agent, CHARINDEX(' ', REVERSE(agent)) - 1) AS agent_surname
FROM agent
        );
      
  
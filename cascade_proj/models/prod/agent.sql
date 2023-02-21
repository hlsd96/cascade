{{
    config(
    materialized = 'incremental',
    schema='prod'
    )
}}

WITH agent AS (
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(a.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','') AS agent
    FROM {{ ref('src_africa') }} a 
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(b.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM {{ ref('src_america') }} b
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(c.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM {{ ref('src_asia') }} c
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(d.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM {{ ref('src_atlantic') }} d
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(e.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM {{ ref('src_australia') }} e
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(f.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM {{ ref('src_europe') }} f
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(g.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM {{ ref('src_indian') }} g
    UNION 
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(h.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','')
    FROM {{ ref('src_pacific') }} h
)
SELECT {{ dbt_utils.generate_surrogate_key(['agent']) }} AS agent_id,
    LEFT(agent,CHARINDEX(' ', agent) - 1) AS agent_name,
    RIGHT(agent, CHARINDEX(' ', REVERSE(agent)) - 1) AS agent_surname
FROM agent

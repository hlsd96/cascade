{{
    config(
    materialized = 'incremental',
    schema='prod'
    )
}}

WITH location_a AS (
    SELECT a.city AS city,
        a.country AS country
    FROM {{ ref('src_africa') }} a 
    UNION 
    SELECT b.city,
        b.country
    FROM {{ ref('src_america') }} b
    UNION 
    SELECT c.city,
        c.country
    FROM {{ ref('src_asia') }} c
    UNION 
    SELECT d.city,
        d.country
    FROM {{ ref('src_atlantic') }} d
    UNION 
    SELECT e.city,
        e.country
    FROM {{ ref('src_australia') }} e
    UNION 
    SELECT f.city,
        f.country
    FROM {{ ref('src_europe') }} f
    UNION 
    SELECT g.city,
        g.country
    FROM {{ ref('src_indian') }} g
    UNION 
    SELECT h.city,
        h.country
    FROM {{ ref('src_pacific') }} h
),
location_b AS (
    SELECT a.city_agent AS city
    FROM {{ ref('src_africa') }} a 
    UNION 
    SELECT b.city_agent
    FROM {{ ref('src_america') }} b
    UNION 
    SELECT c.city_agent
    FROM {{ ref('src_asia') }} c
    UNION 
    SELECT d.city_agent
    FROM {{ ref('src_atlantic') }} d
    UNION 
    SELECT e.city_agent
    FROM {{ ref('src_australia') }} e
    UNION 
    SELECT f.city_agent
    FROM {{ ref('src_europe') }} f
    UNION 
    SELECT g.city_agent
    FROM {{ ref('src_indian') }} g
    UNION 
    SELECT h.city_agent
    FROM {{ ref('src_pacific') }} h
)
SELECT {{ dbt_utils.generate_surrogate_key(['city']) }} AS location_id,
    city AS city_name,
    country AS country_name
FROM location_a
UNION
SELECT {{ dbt_utils.generate_surrogate_key(['city']) }},
    city,
    NULL
FROM location_b
WHERE city NOT IN (
    SELECT city
    FROM location_b
)

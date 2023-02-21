{{
    config(
    materialized = 'incremental',
    schema='prod'
    )
}}

WITH witness AS (
    SELECT a.witness AS witness
    FROM {{ ref('src_africa') }} a 
    UNION 
    SELECT b.witness
    FROM {{ ref('src_america') }} b
    UNION 
    SELECT c.witness
    FROM {{ ref('src_asia') }} c
    UNION 
    SELECT d.witness
    FROM {{ ref('src_atlantic') }} d
    UNION 
    SELECT e.witness
    FROM {{ ref('src_australia') }} e
    UNION 
    SELECT f.witness
    FROM {{ ref('src_europe') }} f
    UNION 
    SELECT g.witness
    FROM {{ ref('src_indian') }} g
    UNION 
    SELECT h.witness
    FROM {{ ref('src_pacific') }} h
)
SELECT {{ dbt_utils.generate_surrogate_key(['witness']) }} AS Witness_id,
    LEFT(witness,CHARINDEX(' ', witness) - 1) AS Witness_name,
    RIGHT(witness, CHARINDEX(' ', REVERSE(witness)) - 1) AS Witness_surname
FROM witness

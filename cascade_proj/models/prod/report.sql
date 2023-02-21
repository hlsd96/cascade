{{
    config(
    materialized = 'incremental',
    schema='prod'
    )
}}

WITH report AS (
    SELECT *,
        'africa' AS source
    FROM {{ ref('src_africa') }} a 
    UNION 
    SELECT *,
        'america' AS source
    FROM {{ ref('src_america') }} b
    UNION 
    SELECT *,
        'asia' AS source
    FROM {{ ref('src_asia') }} c
    UNION 
    SELECT *,
        'atlantic' AS source
    FROM {{ ref('src_atlantic') }} d
    UNION 
    SELECT *,
        'australia' AS source
    FROM {{ ref('src_australia') }} e
    UNION 
    SELECT *,
        'europe' AS source
    FROM {{ ref('src_europe') }} f
    UNION 
    SELECT *,
        'indian' AS source
    FROM {{ ref('src_indian') }} g
    UNION 
    SELECT *,
        'pacific' AS source
    FROM {{ ref('src_pacific') }} h
),
location_list AS (
    SELECT *
    FROM {{ ref('location') }}
),
witness_list AS (
    SELECT *
    FROM {{ ref('witness') }}
),
agent_list AS (
    SELECT *
    FROM {{ ref('agent') }}
),
sighting_list AS (
    SELECT *
    FROM {{ ref('sighting') }}
)
SELECT {{ dbt_utils.generate_surrogate_key(['a.date_witness','witness','city','country','a.latitude','a.longitude','a.has_weapon','a.has_jacket','a.has_hat','a.behavior']) }} AS report_id,
    d.sighting_id,
    e.agent_id,
    a.date_agent,
    c.location_id,
    a.source AS region
FROM report a
LEFT JOIN location_list c ON a.city = c.city_name
LEFT JOIN witness_list b ON a.witness = CONCAT(b.witness_name,' ',Witness_surname)
JOIN sighting_list d ON a.date_witness = d.date_witness
    AND d.witness_id = b.witness_id
    AND d.location_id = c.location_id
    AND a.longitude = d.longitude
    AND a.latitude = d.latitude
JOIN agent_list e ON REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(a.agent,'Mr. ',''),'Dr. ',''),' Jr.',''), 'Mrs. ',''),'Ms. ',''),' PhD',''),' MD',''),' DVM','') = CONCAT(e.agent_name, ' ', e.agent_surname)
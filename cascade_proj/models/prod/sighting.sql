{{
    config(
    materialized = 'incremental',
    schema='prod'
    )
}}

WITH sighting AS (
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
)
SELECT {{ dbt_utils.generate_surrogate_key(['date_witness','witness','city','country','latitude','longitude','has_weapon','has_jacket','has_hat','behavior']) }} AS sighting_id,
    a.date_witness,
    b.Witness_id,
    c.location_id,
    a.latitude,
    a.longitude,
    a.has_weapon,
    a.has_hat,
    a.has_jacket,
    a.behavior
FROM sighting a
LEFT JOIN witness_list b ON a.witness = CONCAT(b.witness_name,' ',Witness_surname)
LEFT JOIN location_list c ON a.city = c.city_name

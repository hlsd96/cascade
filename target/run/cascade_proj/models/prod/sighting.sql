
  
    

        create or replace transient table cascade.dev_prod.sighting  as
        (

WITH sighting AS (
    SELECT *,
        'africa' AS source
    FROM cascade.dev.src_africa a 
    UNION 
    SELECT *,
        'america' AS source
    FROM cascade.dev.src_america b
    UNION 
    SELECT *,
        'asia' AS source
    FROM cascade.dev.src_asia c
    UNION 
    SELECT *,
        'atlantic' AS source
    FROM cascade.dev.src_atlantic d
    UNION 
    SELECT *,
        'australia' AS source
    FROM cascade.dev.src_australia e
    UNION 
    SELECT *,
        'europe' AS source
    FROM cascade.dev.src_europe f
    UNION 
    SELECT *,
        'indian' AS source
    FROM cascade.dev.src_indian g
    UNION 
    SELECT *,
        'pacific' AS source
    FROM cascade.dev.src_pacific h
),
location_list AS (
    SELECT *
    FROM cascade.dev_prod.location
),
witness_list AS (
    SELECT *
    FROM cascade.dev_prod.witness
)
SELECT 
    
md5(cast(coalesce(cast(date_witness as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(witness as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(city as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(country as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(latitude as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(longitude as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(has_weapon as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(has_jacket as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(has_hat as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(behavior as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS sighting_id,
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
        );
      
  

  
    

        create or replace transient table cascade.dev_prod.report  as
        (

WITH report AS (
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
),
agent_list AS (
    SELECT *
    FROM cascade.dev_prod.agent
),
sighting_list AS (
    SELECT *
    FROM cascade.dev_prod.sighting
)
SELECT 
    
md5(cast(coalesce(cast(a.date_witness as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(witness as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(city as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(country as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(a.latitude as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(a.longitude as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(a.has_weapon as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(a.has_jacket as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(a.has_hat as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(a.behavior as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS report_id,
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
        );
      
  
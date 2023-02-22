
  create or replace   view cascade.dev.src_indian
  
   as (
    WITH src_indian AS (
    SELECT *
    FROM cascade.dev.seed_indian
)
SELECT
    date_witness,
    witness,
    agent,
    date_agent,
    region_hq AS city_agent,
    country,
    city,
    latitude,
    longitude,
    has_weapon,
    has_hat,
    has_jacket,
    behavior
FROM src_indian
  );


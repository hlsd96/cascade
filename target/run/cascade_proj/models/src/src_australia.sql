
  create or replace   view cascade.dev.src_australia
  
   as (
    WITH src_australia AS (
    SELECT *
    FROM cascade.dev.seed_australia
)
SELECT
    witnessed AS date_witness,
    observer AS witness,
    field_chap AS agent,
    reported AS date_agent,
    interpol_spot AS city_agent,
    nation AS country,
    place AS city,
    lat AS latitude,
    long AS longitude,
    has_weapon,
    has_hat,
    has_jacket,
    state_of_mind AS behavior
FROM src_australia
  );


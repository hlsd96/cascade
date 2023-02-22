
  create or replace   view cascade.dev.src_pacific
  
   as (
    WITH src_pacific AS (
    SELECT *
    FROM cascade.dev.seed_pacific
)
SELECT
    sight_on AS date_witness,
    sighter AS witness,
    filer AS agent,
    file_on AS date_agent,
    report_office AS city_agent,
    nation AS country,
    town AS city,
    lat AS latitude,
    long AS longitude,
    has_weapon,
    has_hat,
    has_jacket,
    behavior
FROM src_pacific
  );

WITH src_america AS (
    SELECT *
    FROM cascade.dev.seed_america
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
FROM src_america
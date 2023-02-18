WITH src_africa AS (
    SELECT *
    FROM {{ source('cascade', 'src_africa') }}
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
FROM src_africa
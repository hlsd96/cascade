WITH src_europe AS (
    SELECT *
    FROM {{ source('cascade', 'src_europe') }}
)
SELECT
    date_witness,
    witness,
    agent,
    date_filed AS date_agent,
    region_hq AS city_agent,
    country,
    city,
    lat_ AS latitude,
    long_ AS longitude,
    armed AS has_weapon,
    chapeau AS has_hat,
    coat AS has_jacket,
    observed_action AS behavior
FROM src_europe
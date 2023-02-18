WITH src_asia AS (
    SELECT *
    FROM {{ source('cascade', 'src_asia') }}
)
SELECT
    sighting AS date_witness,
    citizen AS witness,
    officer AS agent,
    date_agent,
    city_interpol AS city_agent,
    nation AS country,
    city,
    latitude,
    longitude,
    has_weapon,
    has_hat,
    has_jacket,
    behavior
FROM src_asia
{{
    config(
    materialized = 'view'
    )
}}

WITH src_hosts AS (
    SELECT *
    FROM {{ ref('src_hosts') }}
)
SELECT
    host_id,
    CASE WHEN host_name IS NOT NULL THEN host_name
        WHEN host_name IS NULL THEN REPLACE(host_name,'Anonymous')
    END AS host_name,
    is_superhost,
    created_at,
    updated_at
FROM src_hosts
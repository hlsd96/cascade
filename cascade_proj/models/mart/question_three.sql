{{
    config(
    schema='mart'
    )
}}

WITH question_three AS (
    SELECT *
    FROM {{ ref('sighting') }}
)

SELECT behavior,
    COUNT(1) AS frequent_behavior
FROM question_three
WHERE has_hat = True 
    AND has_jacket = True
GROUP BY behavior
ORDER BY 2 DESC


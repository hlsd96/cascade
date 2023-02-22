

WITH question_two AS (
    SELECT *
    FROM cascade.dev_prod.sighting a
    LEFT JOIN cascade.dev_prod.report b ON a.sighting_id = b.sighting_id
)

SELECT MONTH(a.date_witness) AS month,
    COUNT(1) AS total_records,
    COUNT(CASE WHEN a.has_weapon = True AND a.has_hat = False AND a.has_jacket = True THEN 1 END)/COUNT(1) AS Probability
FROM question_two a
GROUP BY MONTH(a.date_witness)
ORDER BY MONTH(a.date_witness) ASC
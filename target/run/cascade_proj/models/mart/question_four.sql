
  create or replace   view cascade.dev_mart.question_four
  
   as (
    

WITH question_four AS (
    SELECT *
    FROM cascade.dev_prod.sighting a
)

SELECT MONTH(a.date_witness) AS month,
    COUNT(1) AS total_records,
    COUNT(CASE WHEN a.has_hat = True AND a.has_jacket = True AND a.behavior IN ('complaining','panicking','insulting') THEN 1 END)/NULLIF(COUNT( CASE WHEN a.has_hat = True AND a.has_jacket = True THEN 1  END),0) AS Probability
FROM question_four a
GROUP BY MONTH(a.date_witness)
ORDER BY MONTH(a.date_witness) ASC
  );


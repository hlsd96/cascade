
  create or replace   view cascade.dev_mart.report_sighting_grouping
  
   as (
    

WITH grouping AS (
    SELECT *
    FROM cascade.dev_prod.sighting a
    LEFT JOIN cascade.dev_prod.report b ON a.sighting_id = b.sighting_id
)

SELECT MONTH(a.date_witness) AS month,
    COUNT(1) AS total_records,
    COUNT(CASE WHEN a.has_hat = True AND a.has_jacket = True AND a.region= 'africa' THEN 1 END)/COUNT(1) AS africa_likelihood,
    COUNT(CASE WHEN a.has_hat = True AND a.has_jacket = True AND a.region= 'america' THEN 1 END)/COUNT(1) AS america_likelihood,
    COUNT(CASE WHEN a.has_hat = True AND a.has_jacket = True AND a.region= 'asia' THEN 1 END)/COUNT(1) AS asia_likelihood,
    COUNT(CASE WHEN a.has_hat = True AND a.has_jacket = True AND a.region= 'atlantic' THEN 1 END)/COUNT(1) AS atlantic_likelihood,
    COUNT(CASE WHEN a.has_hat = True AND a.has_jacket = True AND a.region= 'australia' THEN 1 END)/COUNT(1) AS australia_likelihood,
    COUNT(CASE WHEN a.has_hat = True AND a.has_jacket = True AND a.region= 'europe' THEN 1 END)/COUNT(1) AS europe_likelihood,
    COUNT(CASE WHEN a.has_hat = True AND a.has_jacket = True AND a.region= 'indian' THEN 1 END)/COUNT(1) AS indian_likelihood,
    COUNT(CASE WHEN a.has_hat = True AND a.has_jacket = True AND a.region= 'pacific' THEN 1 END)/COUNT(1) AS pacific_likelihood
FROM grouping a
GROUP BY MONTH(a.date_witness)
ORDER BY MONTH(a.date_witness) ASC
  );


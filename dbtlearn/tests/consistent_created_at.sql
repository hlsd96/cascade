SELECT * 
FROM {{ ref('dim_listings_cleansed')}} a
JOIN {{ ref('fct_reviews')}} b ON a.listing_id = b.listing_id
WHERE b.review_date <= a.created_at
LIMIT 10
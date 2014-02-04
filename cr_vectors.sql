--
-- ~/mlp/cr_vectors.sql
--

-- I use this script to create some vectors to be used with MADlib.

-- Also the vectors are useful for studying heuristic based predictions.

-- Start by calculating the normalized 1 day gain for all rows except the most recent
-- which has no value yet.

DROP   TABLE vec1;
CREATE TABLE vec1 AS
SELECT
ydate
,closing_price cp
,(LEAD(closing_price,1,NULL) OVER (ORDER BY ydate)
   - closing_price ) / closing_price AS n1dg
FROM mydata
ORDER BY ydate
;

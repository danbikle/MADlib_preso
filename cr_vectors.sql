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
,LEAD(closing_price,1,NULL) OVER (ORDER BY ydate) lead_cp
FROM mydata
ORDER BY ydate
;

-- Calculate normalized 1 day gain for each row:
DROP   TABLE vec2;
CREATE TABLE vec2 AS
SELECT
ydate
,(lead_cp - cp) / cp n1dg
FROM vec1
ORDER BY ydate
;

-- Create simple, 2 element vector.
-- Also calculate 'y-value' for each vector:
DROP   TABLE my_vectors;
CREATE TABLE my_vectors AS
SELECT
ydate
,n1dg
,lag(n1dg,1,NULL) OVER (ORDER BY ydate) prev_1st_n1dg
,lag(n1dg,2,NULL) OVER (ORDER BY ydate) prev_2nd_n1dg
,CASE WHEN n1dg <= 0 THEN 0 ELSE 1 END  yvalue
FROM vec2
ORDER BY ydate
;

-- Create training vectors:
DROP   TABLE training_vectors;
CREATE TABLE training_vectors AS
SELECT
ydate
,n1dg
,prev_1st_n1dg
,prev_2nd_n1dg
yvalue
FROM my_vectors
WHERE ydate < '2014-01-01'
ORDER BY ydate
;

-- Create 'Out of Sample' vectors to-be-predicted and then studied:
DROP   TABLE oos_vectors;
CREATE TABLE oos_vectors AS
SELECT
ydate
,n1dg
,prev_1st_n1dg
,prev_2nd_n1dg
yvalue
FROM my_vectors
WHERE ydate > '2014-01-01'
ORDER BY ydate
;

-- Study distributions:

SELECT yvalue, COUNT(yvalue) FROM my_vectors GROUP BY yvalue;

SELECT 
ROUND(MIN(n1dg),5)  min_n1dg
,ROUND(AVG(n1dg),5) avg_n1dg
,ROUND(MAX(n1dg),5) max_n1dg
,ROUND(STDDEV(n1dg),5) stddev_n1dg
FROM my_vectors
;

-- Are the tails interesting?

-- English:
-- Count the yvalues,
-- Where yesterday was down by more than 1-std-deviation,
-- And day before yesterday was down by more than 1-std-deviation

SELECT 
yvalue
,COUNT(yvalue)
FROM my_vectors
WHERE prev_1st_n1dg < -0.012
AND   prev_2nd_n1dg < -0.012
GROUP BY yvalue
;


-- English:
-- Count the yvalues,
-- Where yesterday was up by more than 1-std-deviation,
-- And day before yesterday was up by more than 1-std-deviation

SELECT 
yvalue
,COUNT(yvalue)
FROM my_vectors
WHERE prev_1st_n1dg > 0.012
AND   prev_2nd_n1dg > 0.012
GROUP BY yvalue
;



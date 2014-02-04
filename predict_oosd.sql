--
-- ~/mlp/predict_oosd.sql
--

-- I use this script to predict outcomes of
-- Out of sample observations with known outcomes.

-- Then I report on the accuracy of the predictions.

DROP TABLE oosd_predictions;
CREATE TABLE oosd_predictions AS
SELECT
ydate
,madlib.logistic(madlib.array_dot(my_out_table.coef,
  array[1,prev_1st_n1dg, prev_2nd_n1dg]::float8[])) AS probability
,ROUND(n1dg,7) n1dg
FROM oos_vectors, my_out_table
ORDER BY ydate
;

SELECT * FROM oosd_predictions;

SELECT * FROM oosd_predictions
WHERE probability > 0.55
;

SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions;

SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability > 0.51;

SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability > 0.52;

SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability > 0.53;

SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability > 0.54;

SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability > 0.55;

SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability > 0.56;

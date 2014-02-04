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
  array[1,n1dg_today, n1dg_yesterday]::float8[])) AS probability
,ROUND(n1dg,7) tomorrows_n1dg
FROM oos_vectors, my_out_table
ORDER BY ydate
;

SELECT * FROM oosd_predictions;

SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions;

SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability < 0.46;
SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability < 0.47;
SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability < 0.48;
SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability < 0.49;
SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability < 0.50;

SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability > 0.50;
SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability > 0.51;
SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability > 0.52;
SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability > 0.53;
SELECT COUNT(n1dg),ROUND(AVG(n1dg),5) avg_n1dg FROM oosd_predictions WHERE probability > 0.54;


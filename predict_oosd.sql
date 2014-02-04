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
,yvalue
FROM oos_vectors, my_out_table
ORDER BY ydate
;

SELECT * FROM oosd_predictions;

SELECT COUNT(tomorrows_n1dg),ROUND(AVG(tomorrows_n1dg),5) avg_tomorrows_n1dg FROM oosd_predictions;

SELECT COUNT(tomorrows_n1dg),ROUND(AVG(tomorrows_n1dg),5) avg_tomorrows_n1dg FROM oosd_predictions WHERE probability < 0.46;
SELECT COUNT(tomorrows_n1dg),ROUND(AVG(tomorrows_n1dg),5) avg_tomorrows_n1dg FROM oosd_predictions WHERE probability < 0.47;
SELECT COUNT(tomorrows_n1dg),ROUND(AVG(tomorrows_n1dg),5) avg_tomorrows_n1dg FROM oosd_predictions WHERE probability < 0.48;
SELECT COUNT(tomorrows_n1dg),ROUND(AVG(tomorrows_n1dg),5) avg_tomorrows_n1dg FROM oosd_predictions WHERE probability < 0.49;
SELECT COUNT(tomorrows_n1dg),ROUND(AVG(tomorrows_n1dg),5) avg_tomorrows_n1dg FROM oosd_predictions WHERE probability < 0.50;

SELECT COUNT(tomorrows_n1dg),ROUND(AVG(tomorrows_n1dg),5) avg_tomorrows_n1dg FROM oosd_predictions WHERE probability > 0.50;
SELECT COUNT(tomorrows_n1dg),ROUND(AVG(tomorrows_n1dg),5) avg_tomorrows_n1dg FROM oosd_predictions WHERE probability > 0.51;
SELECT COUNT(tomorrows_n1dg),ROUND(AVG(tomorrows_n1dg),5) avg_tomorrows_n1dg FROM oosd_predictions WHERE probability > 0.52;
SELECT COUNT(tomorrows_n1dg),ROUND(AVG(tomorrows_n1dg),5) avg_tomorrows_n1dg FROM oosd_predictions WHERE probability > 0.53;
SELECT COUNT(tomorrows_n1dg),ROUND(AVG(tomorrows_n1dg),5) avg_tomorrows_n1dg FROM oosd_predictions WHERE probability > 0.54;

-- Confusion Matrix Calculations:

-- True Positives:
SELECT COUNT(tomorrows_n1dg) FROM oosd_predictions WHERE probability >= 0.5 AND yvalue = true;

-- True Negatives:
SELECT COUNT(tomorrows_n1dg) FROM oosd_predictions WHERE probability < 0.5 AND yvalue = false;

-- False Positives:
SELECT COUNT(tomorrows_n1dg) FROM oosd_predictions WHERE probability >= 0.5 AND yvalue = false;

-- False Negatives:
SELECT COUNT(tomorrows_n1dg) FROM oosd_predictions WHERE probability < 0.5 AND yvalue = true;

-- Finally, Accuracy.
-- We calculate accuracy by hand using:
-- (True Positives + True Negatives) / SELECT COUNT(tomorrows_n1dg) FROM oosd_predictions;

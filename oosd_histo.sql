--
-- ~/mlp/oosd_histo.sql
--

-- I use this script to aggregate prediction results for a histogram.

SELECT ROUND(AVG(tomorrows_n1dg),5) aggregate_avg FROM oosd_predictions;

SELECT
'Under 0.5' probability
,ROUND(AVG(tomorrows_n1dg),5)          myavg
,ROUND(AVG(tomorrows_n1dg)/0.00069,5) myavg_over_agg_avg 
,COUNT(probability)                   observation_count
FROM oosd_predictions
WHERE probability < 0.50
;

SELECT
'Over 0.5' probability
,ROUND(AVG(tomorrows_n1dg),5)          myavg
,ROUND(AVG(tomorrows_n1dg)/0.00069,5) myavg_over_agg_avg 
,COUNT(probability)                   observation_count
FROM oosd_predictions
WHERE probability >= 0.50
;

SELECT
ROUND(probability::NUMERIC,2)         probability
,ROUND(AVG(tomorrows_n1dg),5)         myavg
,ROUND(AVG(tomorrows_n1dg)/0.00069,5) myavg_over_agg_avg 
,COUNT(probability)                   observation_count
FROM oosd_predictions
GROUP BY ROUND(probability::NUMERIC,2)
ORDER BY ROUND(probability::NUMERIC,2)
;



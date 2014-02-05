--
-- ~/mlp/annual_gain_dist.sql
--

SELECT
MIN(annual_gain) min_annual_gain
,AVG(annual_gain) avg_annual_gain
,MAX(annual_gain) max_annual_gain
,STDDEV(annual_gain) stddev_annual_gain
FROM 
(
SELECT
100 * (LEAD(closing_price,251,NULL) OVER (ORDER BY ydate)
       - closing_price)
       / closing_price AS annual_gain
FROM mydata
) sq
;

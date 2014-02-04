--
-- ~/mlp/predict_oosd.sql
--

-- I use this script to predict outcomes of
-- Out of sample observations with known outcomes.

-- Then I report on the accuracy of the predictions.

SELECT
ydate
,madlib.logistic(madlib.array_dot(my_out_table.coef,
  array[1,prev_1st_n1dg, prev_2nd_n1dg]::float8[])) AS probability
FROM oos_vectors, my_out_table
ORDER BY ydate
;

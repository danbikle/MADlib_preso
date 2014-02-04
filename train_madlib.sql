--
-- ~/mlp/train_madlib.sql
--

--
-- ref:
-- http://doc.madlib.net/latest/group__grp__logreg.html

-- The logistic regression training function has the following format:
-- 
-- logregr_train( source_table,
--                out_table,
--                dependent_varname,
--                independent_varname,
--                grouping_cols,
--                max_iter,
--                optimizer,
--                tolerance,
--                verbose
--              )

-- In this script:
-- source_table is training_vectors
-- out_table    is my_out_table
-- dependent_varname is yvalue
-- independent_varname is ARRAY[1, prev_1st_n1dg, prev_2nd_n1dg]
-- grouping_cols is ... NULL 
-- max_iter  is 999
-- optimizer defaults to irls (Iteratively reweighted least squares )
-- tolerance defaults to 0.0001

SELECT logregr_train( 'training_vectors',
'my_out_table',
'yvalue',
'ARRAY[1,prev_1st_n1dg, prev_2nd_n1dg]',
NULL,
999             
);

--
-- rpt, Look at the regression created by MADlib:
--
\x on
SELECT * FROM my_out_table;
\x off


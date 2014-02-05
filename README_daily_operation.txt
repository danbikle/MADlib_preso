~/mlp/README_daily_operation.txt

Now that I am convinced that the scripts in this repository are effective,
I follow these steps to generate a prediction for tomorrow.

  - I wait until the market is near close.
    In California this would be about 12:55 pm.
    It is lunch hour, which is convenient.

  - I note the current price of SPY at this URL:
    - http://finance.yahoo.com/q?s=SPY

  - I add a row to table: 'my_data' using SQL syntax like this:
    
madlib=#
madlib=#
madlib=# select * from mydata where ydate > '2014-02-01';
   ydate    |  opn   |   mx   |   mn   | closing_price |    vol    | adjclse 
------------+--------+--------+--------+---------------+-----------+---------
 2014-02-03 | 177.97 | 178.37 | 173.83 |        174.17 | 253847600 |  174.17
(1 row)

madlib=# insert into mydata (ydate,closing_price) values ('2014-02-04',175.38);
INSERT 0 1
madlib=#
madlib=#

  - I create vectors:
    ./psqlmad.bash -f cr_vectors.sql 
  - I generate predictions:
    ./psqlmad.bash -f predict_oosd.sql

  - I find the prediction for tomorrow inside a table named oosd_predictions:

    SELECT * FROM oosd_predictions WHERE ydate > '2014-01-20' ORDER BY ydate;

  - Demo:

madlib=#  SELECT * FROM oosd_predictions WHERE ydate > '2014-01-20' ORDER BY ydate;
   ydate    |    probability    | tomorrows_n1dg | yvalue 
------------+-------------------+----------------+--------
 2014-01-21 | 0.492009699310662 |      0.0006515 | f
 2014-01-22 | 0.488631380083487 |     -0.0081932 | f
 2014-01-23 | 0.510260006568897 |     -0.0213360 | f
 2014-01-24 | 0.548547912017748 |     -0.0049192 | f
 2014-01-27 | 0.528633378774523 |      0.0059547 | t
 2014-01-28 |  0.48634041893089 |     -0.0096052 | f
 2014-01-29 | 0.507158136950145 |      0.0106005 | t
 2014-01-30 | 0.481792938908986 |     -0.0058584 | f
 2014-01-31 | 0.493743424666264 |     -0.0225053 | f
 2014-02-03 | 0.548359304455023 |      0.0069472 | t
 2014-02-04 | 0.504546505191495 |                | t
(11 rows)

madlib=# 
madlib=# 

  - The predictions are listed in the probability column.

  - I notice that in the above list,
    8/10 of the predictions are correct.

  - The most recent prediction is this:
    0.504546505191495

  - I see that it is above 0.50 and I consider it a signal
    to buy SPY.

  - If it were below 0.50, I would sell SPY.

  - Back to the scenario, 
    I look at the clock and see it at 12:56.
    I have 4 minutes to enter my order before the market closes.




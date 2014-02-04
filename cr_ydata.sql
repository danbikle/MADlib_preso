--
-- ~/mlp/cr_mydata.sql
--

-- I use this script to create table mydata which holds price data from Yahoo.

DROP   TABLE mydata;
CREATE TABLE mydata
(
tkr VARCHAR(9)
,ydate   DATE
,opn     DECIMAL
,mx      DECIMAL
,mn      DECIMAL
,closing_price DECIMAL
,vol     DECIMAL
,adjclse DECIMAL
)
;

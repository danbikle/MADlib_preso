#!/bin/bash

# ~/mlp/wgetit.bash

# I use this script to download data from Yahoo.

mkdir -p ~/mlp/
mkdir -p ~/tmp/

cd ~/tmp/
rm -f SPY.csv
wget --output-document=SPY.csv  http://ichart.finance.yahoo.com/table.csv?s=SPY 
ls -la SPY.csv

exit


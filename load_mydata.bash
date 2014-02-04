#!/bin/bash

# ~/mlp/load_mydata.bash

# I use this script to load data into a table.

cd ~/mlp/
./psqlmad.bash -f cr_mydata.sql
./psqlmad.bash -f load_mydata.sql

exit

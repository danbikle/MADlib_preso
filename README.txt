~/mlp/README.txt

The files in this repository are intended to enhance a presentation I gave at the Meetup listed below:

http://www.meetup.com/Palo-Alto-Data-Science-Association/events/153556462/

The title of the presentation is:

  Stock Market Predictions via MADlib Logistic Regression

The basic steps are listed below:

  - mkdir ~/mlp/
  - copy https://github.com/danbikle/MADlib_preso into ~/mlp/
    using git or unzip 
  - mkdir ~/tmp/
  - cd    ~/mlp/

  - Download data from Yahoo:
    - ~/mlp/wgetit.bash

  - Create a table to hold the data
  - Load the data into the table
    - ~/mlp/load_mydata.bash

  - Build some vectors for MADlib
    - ~/mlp/cr_vectors.sql

  - Train MADlib 
    - ~/mlp/train_madlib.sql

  - Let MADlib predict
    - ~/mlp/predict_oosd.sql

  - Report on predictions
    - ~/mlp/oosd_histo.sql

If you have questions, e-me: dan.bikle@gmail.com

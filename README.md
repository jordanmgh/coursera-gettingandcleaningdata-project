Summary of Human Activity Recognition Using Smartphones Dataset
===============================================================

Version: 1.0  
Author: Jordan Hyam  
Date: August 10, 2020

#### Overview

This dataset is a summary of all mean and standard deviation features
from the "Human Activity Recognition Using Smartphones" dataset, using
the mean of each summarized feature.

That source dataset was comprised of a test file, a training file- each
with 561 features and subject and activity identifiers, an activity
ID-label file and a file containing feature descriptions.

(see following section for more detailed information on the source
dataset)

#### The analysis script "run\_analysis.R" creates the output "dataset\_summary.csv" file via the following steps:

1.  Loading and then cleaning up the feature names (special characters
    replaced with underscores and duplicates removed, all letters set to
    lowercase, repeating words removed, and single letter abbreviations
    t and f replaced with time/freq).
2.  Load test and train files into data frames and name variables in
    each (using cleaned up feature names, with names manually added for
    subjectID, activityID )
3.  Vertically merging the test and training datasets into one data
    frame.
4.  Adding activity names via merge between activity label data frame
    and combined test/train dataframe.
5.  Removing features other than mean/std from the merged data frame.
6.  Converting the data frame into a dplyr data table, then summarizing
    it by activity ID, activity label, and subject ID, with the mean of
    each remaining feature.
7.  Writing the final summarized table to the output file.

#### For each record is provided:

-   Its activity label (both label and the corresponding identifier are
    included).
-   An identifier of the subject who carried out the experiment.
-   The mean for each activity and subject of each source feature that
    was itself a mean or standard deviation.

#### The dataset includes the following files:

-   'README.md' this file.
-   'dataset\_summary.txt: The summarized output.
-   'CodeBook.md': Description of variables.

Notes regarding the source dataset used to create the merged and summarized output
----------------------------------------------------------------------------------

-   Background and description:
    <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
-   Source data files:
    <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
-   For more information about this dataset contact:
    <activityrecognition@smartlab.ws>

#### Source data usage license:

This dataset is distributed AS-IS and no responsibility implied or
explicit can be addressed to the authors or their institutions for its
use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita.
November 2012.

Use of this dataset in publications must be acknowledged by referencing
the following publication 1.

1.  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and
    Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones
    using a Multiclass Hardware-Friendly Support Vector Machine.
    International Workshop of Ambient Assisted Living (IWAAL 2012).
    Vitoria-Gasteiz, Spain. Dec 2012

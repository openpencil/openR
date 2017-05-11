#######################################################
# Objective: A demonstration of how to read in data
# and summarize in R - with commented parallels to SAS.
#
# NB: # comments out a line.
#######################################################
#
#### Set work directory ####
## This is ideally a path which you don't want to specify over and over in code.
## It is also the directory where any output files would end up by default.
##
## SAS
## LIBNAME libref "~/Documents/dtn/";
##
## setwd(): A function that sets the working directory.
## dir is named argument whose value you need to supply
## below, the value is the directory path.
setwd(dir = "~/Documents/dtn/")

#### Loading in a CSV ####
## SAS: The DATA step
## DATA somedata;
##  INFILE 'trials_meta.csv' delimiter=",";
## RUN;
##
## Simple invocation of the function read.csv()
## "<-" is an assignment operator. To its left is an object you want to
## create in the R environment. This object could hold a string, a dataframe
## a list etc..
## the file argument is for denoting the name of the file on disk
## the header argument tells R whether or not the first row is a header
## as.is = TRUE tells R to keep values exactly as they are - i.e. make no
## assumed conversions.
somedata <- read.csv(file = "trials_meta.csv", header = TRUE, as.is = TRUE)

## Below is the same invocation with some more useful arguments specified
## strip.white = TRUE strips trailing whitespaces, if present
## blank.lines.skip = TRUE skips blank lines. Yes, exactly what it says. :-)
## R does not like whitespaces in names, so usually it converts all blank spaces
## in columns into dots. For example "A column name" will be "corrected" to:
## "A.column.name"
## check.names = FALSE prevents this aggressive check-and-"correct" behaviour.
somedata <- read.csv(file = "trials_meta.csv", header = TRUE, as.is = TRUE,
                     strip.white = TRUE, blank.lines.skip = TRUE, check.names = FALSE)

#### Displaying and exploring data ####
## PROC PRINT data=somedata;
##  VAR LATITUDE LONGITUDE CROP;
## RUN;
##
## somedata is stored as a dataframe in R.
## dataframes have 2 dimensions, rows and columns
## they are indexed by rows and columns within square brackets:
## dataframe[row number, column number]
## c() is for concatenating strings. Here column-names of interest
## are being concatenated.
## This will display the columns of interest in the console
somedata[, c("LATITUDE", "LONGITUDE", "CROP")]
## The View() function opens up a prettier view of the data:
View(somedata[, c("LATITUDE", "LONGITUDE", "CROP")])
## You can also explore other attributes of the data:
dim(somedata)
## [1] 140  12
## Indicates the dimensions (i.e. number of rows and columns) in the data.
## Show first 5 rows
head(somedata)
## Show last 5 rows
tail(somedata)
## List the column names (headers)
colnames(somedata)
## You can also list rownames, if there are any. If there aren't any, this
## will just display the rownumbers
rownames(somedata)

#### Adding new variables to the data ####
##
## DATA somedata;
## SET somedata;
##  newvar = min(LATITUDE, LONGITUDE);
## RUN;
## NB: In SAS min() is a row-by-row operation.
##
## In R min() will take the min of all numbers in the two columns specified and output
## one minimum value. In other words, min() is not a row-by-row operation by default.
## To make it a row-by-row operation, you can apply the min() function row-by-row with
## lapply() which will iterate till reaches the end of the 1:nrow(somedata)
somedata$newvar <- unlist(lapply(1:nrow(somedata), function(rownum){
  minvalue <- min(somedata[rownum, c("LATITUDE", "LONGITUDE")])
  return(minvalue)
}))

#### Generating and displaying summaries ####
## http://stats.idre.ucla.edu/sas/modules/collapsing-across-observations-in-sas/

#######################################################
# Objective: A demonstration of how to read in data
# and summarize in R - with commented parallels to SAS.
#
# NB: # comments out a line.
#######################################################
#
#### Set work directory ####
## Ideally a path which you don't want to specify over and over in code.
## Also the directory where any output files would end up by default.
##
## LIBNAME LIBREF "~/Documents/dtn/";
##
## setwd(): A function that sets the working directory.
## dir is named argument whose value you need to supply
## below, the value is the directory path.
setwd(dir = "~/Documents/dtn/")

#### Loading in a CSV ####
##
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
                     strip.white = TRUE, blank.lines.skip = TRUE,
                     check.names = FALSE)

#### Displaying and exploring data ####
## PROC PRINT DATA=somedata;
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
  # rownum <- 1
  minvalue <- min(somedata[rownum, c("LATITUDE", "LONGITUDE")])
  return(minvalue)
}))

somedata$devlat <- unlist(lapply(1:nrow(somedata), function(rownum){
  # rownum <- 1
  meanlat <- mean(somedata[, "LATITUDE"])
  devlat <- somedata[rownum, "LATITUDE"] - meanlat
  return(devlat)
}))

#### Generating and displaying summaries ####
##
## Calculate mean latitude by crop, and output this in a file.
## PROC MEANS DATA=somedata NWAY;
##  CLASS CROP;
##  VAR LATITUDE;
##  OUTPUT OUT=by_crop_summary MEAN= ;
## RUN;
##
by_crop_summary <- sapply(unique(somedata$CROP), function(cropname){
  # get the values
  # cropname <- "Sorghum"
  values <- somedata[somedata$CROP == cropname, "LATITUDE"]
  summary_values <- data.frame(N = length(values), Mean = mean(values),
                               SD = sd(values),
                               Minimum = min(values), Maximum = max(values))
  return(summary_values)
})

by_crop_summary_list <- lapply(unique(somedata$CROP), function(cropname){
  # get the values
  # cropname <- "Sorghum"
  values <- somedata[somedata$CROP == cropname, "LATITUDE"]
  summary_values <- data.frame(N = length(values), Mean = mean(values),
                               SD = sd(values),
                               Minimum = min(values), Maximum = max(values))
  return(summary_values)
})
names(by_crop_summary_list) <- unique(somedata$CROP)
library(plyr)
by_crop_summary_list <- ldply(by_crop_summary_list, .id = "Crops")


## Save output in a CSV
write.csv(x = by_crop_summary_list,
          file = "by_crop_summary_NEW.csv",
          row.names = FALSE)
# NB: To get to exactly the way SAS would present this, you could potentially use
# the ldply() function on the output of an lapply. In this case, you would need
# the plyr library.
# install.packages("plyr", repos = "https://cloud.r-project.org/", dependencies=TRUE)
# library(plyr)

## Getting means of more than one variable
## PROC MEANS DATA=somedata NWAY;
##  CLASS CROP;
##  VAR LATITUDE, LONGITUDE;
##  OUTPUT OUT=by_crop_summary MEAN= ;
## RUN;
##
## If you need an operation more than once, generalize and make a function with input arguments!
## Converting the one-off code above to a function.
##
## Here we will feed a string with names of the variables of interest to the function and get back all their summaries
## e.g.
variable_names <- c("LATITUDE", "LONGITUDE")


get_by_crop_summary <- function(var_name){
  list_of_summaries <- lapply(unique(somedata$CROP), function(cropname){
    # get the values
    values <- somedata[somedata$CROP == cropname, var_name]
    summary_values <- data.frame(N = length(values), Mean = mean(values), SD = sd(values),
                                 Minimum = min(values), Maximum = max(values))
    return(summary_values)
  })
  names(list_of_summaries) <- unique(somedata$CROP)
  output <- ldply(list_of_summaries, .id = "Crop")
  return(output)
}

summaries_for_two_vars <- lapply(variable_names, function(vname){
  get_by_crop_summary(var_name = vname)
})
names(summaries_for_two_vars) <- variable_names
final_summary <- ldply(summaries_for_two_vars, .id = "Variable")

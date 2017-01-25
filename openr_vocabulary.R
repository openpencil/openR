#### Objective: Learn some new functions! ####

##### Concept I. Flatten a contingency table ####
#'
#' When would you want to do this: You have more than 2
#' variables that you want to summarize in a single table.
#' table() gives you a 2X2 table stratified by the 3rd variable.
#' However ftable() of the table() output will flatten
#' all the strata and result in a flat contingency table.
#'
#' first create some data with more than 3 variables
breakfast <- rbinom(n = 10, size = 1, prob = 0.3)
lunch <- rbinom(n = 10, size = 1, prob = 0.9)
dinner <- rbinom(n = 10, size = 1, prob = 0.6)
foodpattern <- data.frame(breakfast, lunch, dinner, stringsAsFactors = F)
foodpattern[foodpattern == 1] <- "Yes"
foodpattern[foodpattern == 0] <- "No"
#' retains labels
xtabs_output <- xtabs(formula = "~ breakfast + lunch + dinner",
                      data = foodpattern)
#' does not retain labels
table_output <- table(foodpattern$breakfast,foodpattern$lunch, foodpattern$dinner)
#' flatten!
ftable(xtabs_output)
ftable(table_output)

#### Concept II: Read in fixed-width data, or parse data by specifying widths ####
#'
#' When would you want to do this: useful for unit testing
#' because you can create content that you know about,
#' and later use this as a canonical truth for testing.
#'
#' create some data first by creating a virtual file.
somefile <- tempfile()
cat(file = somefile, "123456", "789101112", sep = "\n")
#' check the contents of the file
readLines(con = somefile)
#' read in the virtual file with fixed width annotations
out1 <- read.fwf(somefile, widths = c(1,2,3))
#' the file is stored in the form of a dataframe
str(out1)
#' some other ways of reading in the same file
read.fwf(somefile, widths = c(1,-2,3))
read.fwf(somefile, widths = c(1, 0, 2, 3))
read.fwf(somefile, widths = list(c(1,0,2,3,2,2,2)))
read.fwf(somefile, widths = list(c(1,0, 2,3),
                                 c(2,2,2)))
#' close the virtual file once the job is done
unlink(x = somefile)

#### Concept III: Capture and save R console output  ####
#'
#' Method (1)
#' When would you want this: Demonstrations! StackExchange questions!
#' Saves on tedious and error-prone cutting and pasting.
#' Captures the console output as line separated character strings
#' so you can access it with indexing
#'
#' generate some model data
glmout <- capture.output(summary(glm(case ~ spontaneous + induced,
                                     data = infert, family = binomial())))
glmout[1:10]
#' simple addition example
str(capture.output(1+1, 2+2))

#' Method (2)
#' Create a local file and save all output of the following commands to the file
sink("file_that_will_store_stuff.txt")
summary(glm(case ~ spontaneous + induced,data = infert, family = binomial()))
#' Close the sink
sink()

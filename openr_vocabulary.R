#### Objective: Learn some new functions! ####
##
## All functions in this script
##
## (subset(getParseData(parse('~/repos/openR/openr_vocabulary.R')),
## token == "SYMBOL_FUNCTION_CALL")["text"] %>% unique)$text %>% sort
##
## c("binomial", "c", "capture.output", "cat", "data.frame", "ftable",
## "glm", "list", "rbinom", "read.fwf", "readLines", "sink", "str",
## "summary", "table", "tempfile", "unlink", "xtabs")
##
##
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

#***************************************************************#
# All other functions in the vocabulary chapter that I explored
# a bit more
# **************************************************************#

# Files and directories
# dir() is just list.dirs() with full.names and recursive
# arguments set to false
# basename, dirname, tools::file_ext
# file.path
# path.expand, normalizePath
# file.choose
# file.copy, file.create, file.remove, file.rename, dir.create
# file.exists, file.info
# tempdir, tempfile
# download.file, library(downloader)

### How to use replicate to generate bootstrap confidence intervals of difference between 2 groups
# generate some data
group1 <- log2(round(rnorm(n = 100, mean = 500, sd = 50), 0))
group2 <- log2(round(rnorm(n = 900, mean = 525, sd = 40), 0))

# visualize the distribution of datasets
# make a dataframe
ggdata <- data.frame(Counts = c(group1, group2), stringsAsFactors = F)
# Add a column with the group label
ggdata$group <- c(rep(x = "group1", times = length(group1)),
                  rep(x = "group2", times = length(group2)))
library(ggplot2)
# Call ggplot, define the dataframe for plotting, define the x and y axis
p <- ggplot(data = ggdata, mapping = aes(x = group, y = Counts))
p <- p + geom_violin()
p <- p + xlab("")
p
# Visualized another way
p <- ggplot(data = ggdata, mapping = aes_string(x = "Counts", y = "..density.."))
p <- p + geom_density(aes(fill = group), alpha = 0.4)
# Draw the means
p <- p + geom_vline(xintercept = c(mean(group1), mean(group2)), linetype = "dashed",colour = "grey30")
p <- p + xlab("Value") + ylab("Density")
p

# Calculate the bootstrap confidence interval of differences in means
#
bootfunction <- function(){
  # set.seed(round(runif(n = 1, min = 9, max = 788), 0))
  # sample by the size of the group
  group1data <- ggdata[which(ggdata$group == "group1"),]
  group2data <- ggdata[which(ggdata$group == "group2"),]
  samplerows1 <- sample(x=(1:nrow(group1data)), size=nrow(group1data), replace = TRUE)
  samplerows2 <- sample(x=(1:nrow(group2data)), size=nrow(group2data), replace = TRUE)
  group1vals <- group1data[samplerows1, "Counts"]
  group2vals <- group2data[samplerows2, "Counts"]
  # welch statistic
  if (length(group1vals) == 0  | length(group2vals) == 0){
    return(NA)
  } else {
    wnum <- mean(group1vals) - mean(group2vals)
    wdenom <- sqrt((sd(group1vals))^2/length(group1vals) +
                     (sd(group2vals))^2/length(group2vals))
    wtest <- wnum/wdenom
    return(wtest)
  }
}
# repeat the function 5000 times
bootdo <- na.exclude(replicate(100, bootfunction()))
#  bootdo <- bootdo[-which(is.infinite(bootdo))]
bootci <- quantile(bootdo, prob=c(0.025, 0.975))
bootdf <- data.frame(lowerci=bootci["2.5%"], upperci=bootci["97.5%"])




#### Objective: Learn some new functions! ####

#### Read in fixed-width data, or parse data by specifying widths ####
#' Function I. read.fwf
#' Create some data first by creating a virtual file.
#' Why would you want to do this: useful for unit testing
#' because you can create content that you know about,
#' and later use this as a canonical truth for testing.
somefile <- tempfile()
cat(file = somefile, "123456", "789101112", sep = "\n")
#' check the contents of the file
readLines(con = somefile)
#' read in with fixed width annotations
out1 <- read.fwf(somefile, widths = c(1,2,3))
#' the file is stored in the form of a dataframe
str(out1)
read.fwf(somefile, widths = c(1,-2,3))
read.fwf(somefile, widths = c(1, 0, 2, 3))
read.fwf(somefile, widths = list(c(1,0,2,3,2,2,2)))
read.fwf(somefile, widths = list(c(1,0, 2,3),
                                 c(2,2,2)))
unlink(x = somefile)

#### Capture and save R output exactly as they appear on the console ####
#' When would you want this: Demonstrations! StackExchange questions!
#' Saves on tedious cutting and pasting.
#' Function II. capture.output()
#' capture the output exactly as it appears in the console.
glmout <- capture.output(summary(glm(case ~ spontaneous + induced,
                                     data = infert, family = binomial())))
glmout[1:5]
str(capture.output(1+1, 2+2))
capture.output({1+1; 2+2})

#' Function III. sink()
#' Create a local file and save all output of the following commands in it
sink("sink-examp.txt")
i <- 1:10
outer(i, i, "*")
#' Close the sink
sink()

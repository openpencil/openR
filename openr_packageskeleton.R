#### Objective: Walkthrough Hillary Parker's R package from scratch blogpost ####
## https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
## Sub-text: Not sure I care about cats this much...

####  Step 0: Packages you will need
##  The packages you will need to create a package are devtools and roxygen2.
##  Download the development version of the roxygen2 package.

#' install.packages("devtools")
library("devtools")
#' devtools::install_github("klutometis/roxygen")
library(roxygen2)

#### Step 1: Create your package directory ####
setwd("./repos/openR/")
#' Create a directory with the bare minimum folders of R packages.
#' Create package Omisc: A package for common handy functions.
create("Omisc")
#' Creating package 'Omisc' in './repos/openR'
#' No DESCRIPTION found. Creating with values:
#' Package: Omisc
#' Title: What the Package Does (one line, title case)
#' Version: 0.0.0.9000
#' Authors@R: person("First", "Last", email = "first.last@example.com", role = c("aut", "cre"))
#' Description: What the package does (one paragraph).
#' Depends: R (>= 3.3.1)
#' License: What license is it under?
#' Encoding: UTF-8
#' LazyData: true
#' * Creating `Omisc.Rproj` from template.
#' * Adding `.Rproj.user`, `.Rhistory`, `.RData` to ./.gitignore

#### Step 2: Add functions ####
#' omisc_annotateggplot.R

#### Step 3: Add documentation ####
#' Add special comments to the beginning of each function, that will later be compiled into the correct format for
#' package documentation by roxygen2
#'
#'

#### Step 4: Process your documentation ####
setwd("./Omisc/")
document()

#### Step 5: Install! ####
setwd("..")
install("./Omisc")
# Installing Omisc
# '/Library/Frameworks/R.framework/Resources/bin/R' --no-site-file --no-environ --no-save --no-restore --quiet CMD INSTALL  \
# './repos/openR/Omisc' --library='/Library/Frameworks/R.framework/Versions/3.3/Resources/library' --install-tests
#
# * installing *source* package ‘Omisc’ ...
# ** R
# ** preparing package for lazy loading
# ** help
# *** installing help indices
# ** building package indices
# ** testing if installed package can be loaded
# * DONE (Omisc)
# Reloading installed Omisc
#
# Attaching package: ‘Omisc’
#
# The following objects are masked _by_ ‘.GlobalEnv’:
#
#   calculate_median, calculate_n

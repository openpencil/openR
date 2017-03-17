#### Things I did not know from the "Functions" chapter ####
library(magrittr)
library(dplyr)

#### THREE MAIN PARTS!!!
# Three parts of a function can be extracted with
formals()
# argument
body()
environment()

### namespace!
# These functions allow you to tell if an object is a function
is.function()
is.primitive() # Don't have a BODY! oooooooh!

# This code makes a list of all functions in the base package
objs <- mget(ls("package:base"), inherits = TRUE)
funs <- Filter(is.function, objs)

objects_in_dplyr <- mget(ls("package:dplyr"), inherits = TRUE)
funs_in_dplyr <- Filter(is.function, objects_in_dplyr)

# Find all primitive functions
primitive.funs <- Filter(is.primitive, objs)

# tangential discoveries
# Reduce uses a binary function to successively combine the elements of a given vector and a possibly given initial value.
# Filter extracts the elements of a vector for which a predicate (logical) function gives true.
# Find and Position give the first or last such element and its position in the vector, respectively.
# Map applies a function to the corresponding elements of given vectors.
# Negate creates the negation of a given function.

# Reduce(f, x, init, right = FALSE, accumulate = FALSE)
# f is the predicate which gives a logical answer of true or false
# x is the vector from which elements which are "true" are extracted
# Filter(f, x)
# gets first or last element that meets the condition in f
# Find(f, x, right = FALSE, nomatch = NULL)
# applies f to the corresponding elements of the given vectors
# Map(f, ...)
# creates the negative of a given function.
# Negate(f)
# Position(f, x, right = FALSE, nomatch = NA_integer_)

# This code makes a list of all functions in any R script
out <- (subset(getParseData(parse('~/repos/openR/openr_vocabulary.R')), token == "SYMBOL_FUNCTION_CALL")["text"] %>% unique)$text %>% sort


# Which base function has the most arguments:
which.max(lapply(funs, function(x) length(formals(x))))

# How many functions have no arguments?
length(which(unlist(lapply(funs, function(x) length(formals(x)))) < 1))
# 225 Functions


#### Lexical Scoping ####
# R has two types of scoping: lexical scoping, implemented automatically at the language level,
# and dynamic scoping, used in select functions to save typing during interactive analysis.
#
# Principles behind lexical scoping
# name masking
# I thought this was cool!
j <- function(x) {
  y <- 2
  function() {
    # even though y is not defined in the function or the function call, it is in the environment.
    c(x, y)
  }
}
k <- j(1)
k()
# Environments contain variable definitions!
#
# functions vs. variables
# a fresh start
# dynamic lookup
#
# What is this doing?
f <- function() x + 1
# Ideally this should be:
l <- function(){x + 1}
codetools::findGlobals(l)

#
# this is very handy! Empty the environment
environment(f) <- emptyenv()

### What are the four principles that govern how R looks for values?
# 1. Name masking.  Variables are evaluated according to the highest-precedence environment in which they are defined, starting from the local environment and working upwards through each parent environment.
# 2. Functions vs. variables.  For all intents and purposes, function names are evaluated by the same rules as for variables.  If it is implicit that a function is being used, R will ignore objects with the same name that are not functions.
# 3. Fresh starts.  Functions do not have state (unless the environment of the function is changed).
# 4. Dynamic lookup.  Variables are evaluated when needed, and so variables may be defined outside
# of the function's environment.

#### Every operation in R is a function call ####
# including
# ( and )
# infix operators +
# control flow operators for if while
# subsetting operators [ ] and $
# curly brace {}
# backtick lets you refer to functions or variables that have otherwise reserved or illegal names


# Note the difference between `+` and "+".
# The first one is the value of the object called +, and the second is a string containing the character +.

## Nifty useful stuff ##
x <- list(1:3, 4:9, 10:12)
# Use the fact that `[` is a function to subset and get the second element from every set above
sapply(x, "[", 2)

## The ... argument
## If a function uses ... , you can only specify arguments listed after ... with their full name.

## A list of function arguments can be supplied to a function using do.call()
list_of_args <- list(1:10, na.rm = TRUE)
# supply to the function, mean()
do.call(mean, list_of_args)

## The default value of an argument can be defined in terms of other arguments.

## You can determine if an argument was supplied or not with the missing() function.

## How to add a non-trivial default value as an argument to a function
# non-trivial default values might take several lines of code to compute.
# Instead of inserting that code in the function definition, you could use
# missing() to conditionally compute it if needed. However, this makes it
# hard to know which arguments are required and which are optional without
# carefully reading the documentation.
#
# An alternative is to set the default value to NULL and use is.null()
# to check if the argument was supplied and then make the computations
# to generate the default value conditional on the is.null() call.
#
#

## If you want to ensure that an argument is evaluated you can use force():
f <- function(x) {
  10
}
f()
f <- function(x) {
  force(x)
  10
}
f()
# Error in force(x) : argument "x" is missing, with no default

add <- function(x) {
  function(y) x + y
}
adders <- lapply(1:10, add)
adders[[1]](10)
adders[[10]](10)

#### Objective: Understand R Data Structures ####
## Chapter 2: Advanced R

#### Most useful takeaways for practice ####
#' Coercion: If you have two or more types of objects concatenated together in a homogeneous data structure,
#' such as an "atomic" vector, matrix or an array, then the final type of this structure will be the following
#' if at least one of this type exists in the collection: character, double (or numeric), integer, logical.
#'
#' Testing arguments to or outputs from a function: is.atomic() and is.list() are good ways to check if the
#' arguments/inputs that you (or someone else) has supplied to a function are the ones that are expected.
#' For example: assert_that(is.list(defaults)). You can also check that the results of an operation are
#' in the expected form. For example: expect_true(is.list(result))
#'
#' Convert a list to an atomic vector (with coerced types) with unlist() (Important because the outputs of
#' several functions such as sapply() and lapply() return lists). unlist() uses the same coercion rules as c().
#'
#' Assigning a dimension (dim() attribute) to an atomic vector turns it into a matrix, which is a two dimensional array
#' matrix(), array() creates matrices and arrays
#' as.matrix() and as.array() turn existing vectors into matrix or array.
#'
#' Extract the character values of the levels of a factor variable: as.character(x)
#' Extract the underlying integer levels of the factor variable: as.numeric(x)
#'
#' stringsAsFactors = FALSE is a useful argument that many functions take (include data.frame) to prevent
#' character vectors being converted to factors. as.is=T also plays the same role. Changing global options
#' is not a good idea.

#### Atomic vectors ####
#' Atomic vectors are usually created with c(), short for combine:
#' Double: includes decimals | real numbers
dbl_var <- c(1, 2.5, 4.5)
#' With the L suffix, you get an integer rather than a double | integers don't include decimals
int_var <- c(1L, 6L, 10L)
#' Use TRUE and FALSE (or T and F) to create logical vectors
log_var <- c(TRUE, FALSE, T, F)
chr_var <- c("these are", "some strings")

#' Atomic vectors are always flat, even if you nest c()’s:
c(1, c(2, c(3, 4)))
#> [1] 1 2 3 4
#' the same as
c(1, 2, 3, 4)
#> [1] 1 2 3 4

#### Types and tests ####
#' Shows type: typeof()
#' Shows a boolean answer: is.character(), is.double(), is.integer(), is.logical(), is.atomic(), is.list()
#' non-specific: is.numeric(), is.vector()
#'

#### Coercion ####
#' Combining a character and an integer yields a character:
str(c("a", 1))
#>  chr [1:2] "a" "1"

#### Lists ####
list_x <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
str(list_x)
is.vector(list_x)
is.list(list_x)
is.atomic(list_x) #FALSE
is.numeric(list_x) #FALSE
is.recursive(list_x)

x <- list(list(1, 2), c(3, 4))
y <- c(list(1, 2), c(3, 4))
str(x)
#> List of 2
#>  $ :List of 2
#>   ..$ : num 1
#>   ..$ : num 2
#>  $ : num [1:2] 3 4
str(y)
#> List of 4
#>  $ : num 1
#>  $ : num 2
#>  $ : num 3
#>  $ : num 4

#### Exercises ####
#' Size types of atomic vector: character, double, integer, logical, raw, complex
#' is.vector() is true for both atomic and list vectors.
#' is.numeric() is true for both double and integer vectors
#' Predicting coercion:
#' c(1, FALSE) # double
#' c("a", 1) # character
#' c(list(1), "a") #list
#' c(TRUE, 1L) # integer
#' unlist converts a list vector to an atomic vector. list is already a vector so as.vector doesn't do anything.
#' 1 == "1" is coerced to character
#' FALSE = 0 which is > -1
#' "one" < 2 (FALSE because 2 is a character and alphabetically come before "o")
#' NA is logical because it can be coerced to any type before it (integer, double or character)

#### Attributes ####
y <- 1:10
#' access attributes individually with attr()
attr(y, "my_attribute") <- "This is a vector"
attr(y, "my_attribute")
#> [1] "This is a vector"
#' access attributes all at once - as a list
attributes(x = y)
#' the names of formal arguments of a function are given by names(formals(f))
#' names(formals(attributes)) | but this doesn't work for primitive functions
#' http://stackoverflow.com/questions/33636347/why-does-rs-attributes-function-fail-when-using-explicit-arguments
str(attributes(y))
#> List of 1
#>  $ my_attribute: chr "This is a vector"

#' The structure() function returns a new object with modified attributes:
y_new <-structure(1:10, my_attribute = "This is a vector")
#>  [1]  1  2  3  4  5  6  7  8  9 10
#> attr(,"my_attribute")
#> [1] "This is a vector"
#'
#' Attributes that are not lost include
#' Names, a character vector giving each element a name, described in names.
#' Dimensions, used to turn vectors into matrices and arrays, described in matrices and arrays.
#' Class, used to implement the S3 object system, described in S3.
#'
#### The name attribute ####
#' You can name a vector in three ways:
#' When creating it: x <- c(a = 1, b = 2, c = 3).
#' By modifying an existing vector in place: x <- 1:3; names(x) <- c("a", "b", "c").
#' By creating a modified copy of a vector: x <- setNames(1:3, c("a", "b", "c")).
#' unname(x), or remove names in place with names(x) <- NULL.

#### Factors ####
# A factor is a vector that can contain only predefined values, and is used to store categorical data.
# Factors are built on top of integer vectors using two attributes: the class(), “factor”, which
# makes them behave differently from regular integer vectors, and the levels(), which defines the
# set of allowed values.
x <- factor(c("a", "b", "b", "a"))
x
#> [1] a b b a
#> Levels: a b
class(x)
#> [1] "factor"
levels(x)
#> [1] "a" "b"

#' You can't use values that are not in the levels
x[2] <- "c"
#> Warning in `[<-.factor`(`*tmp*`, 2, value = "c"): invalid factor level, NA generated
x
#> [1] a    <NA> b    a
#> Levels: a b

#' NB: you can't combine factors
c(factor("a"), factor("b"))
#> [1] 1 1

#' Extract the values of the levels
as.character(x)
#' Extract the ordering of values - according to the levels
as.numeric(x)

## Make missing data obvious with factors
sex_char <- c("m", "m", "m")
sex_factor <- factor(sex_char, levels = c("m", "f"))
table(sex_char)
#> sex_char
#> m
#> 3
table(sex_factor)
#> sex_factor
#> m f
#> 3 0
#
#### Exercises ####
out <- structure(1:5, comment = "my attribute")
#> [1] 1 2 3 4 5
#' Attributes are suppressed till you explicitly extract the attributes with the str(), attr() or attributes() functions
#' Changing the levels of a factor changes the dictionary so the values also change along with the levels.
f1 <- factor(letters)
as.numeric(f1)
levels(f1) <- rev(levels(f1))

#' factor() builds a dictionary of values of the variable.
#' rev() reverses the order of values in the factor
f2 <- rev(factor(x = letters))
as.numeric(f2)

#' explicitly set the values of the factor as well as the levels)
f3 <- factor(x = letters, levels = rev(letters))
as.numeric(f3)
#'
#'
#### Matrices and arrays ####
# Two scalar arguments to specify rows and columns
a <- matrix(1:6, ncol = 3, nrow = 2)
# One vector argument to describe all dimensions
b <- array(1:12, c(2, 3, 2))

# You can also modify an object in place by setting dim()
# Filling occurs column by column
c <- 1:6
dim(c) <- c(3, 2)
c
#>      [,1] [,2]
#> [1,]    1    4
#> [2,]    2    5
#> [3,]    3    6

dim(c) <- c(2, 3)
c
#>      [,1] [,2] [,3]
#> [1,]    1    3    5
#> [2,]    2    4    6
#' length for 2d matrices is nrow() * ncol()
length(a)
#> [1] 6
nrow(a)
#> [1] 2
ncol(a)
#> [1] 3
rownames(a) <- c("A", "B")
colnames(a) <- c("a", "b", "c")
a
#>   a b c
#> A 1 3 5
#> B 2 4 6

length(b)
#> [1] 12
dim(b)
#> [1] 2 3 2
#' dimnames for a 3d array is in the format: rows, columns and third dimension
dimnames(b) <- list(c("one", "two"), c("a", "b", "c"), c("A", "B"))
b
#> , , A
#>
#>     a b c
#> one 1 3 5
#> two 2 4 6
#>
#> , , B
#>
#>     a  b  c
#> one 7  9 11
#> two 8 10 12
## Matrix operations ##
# c() generalises to cbind() and rbind() for matrices, and to abind() (provided by the abind package) for arrays.
# You can transpose a matrix with t(); the generalised equivalent for arrays is aperm().
str(object = 1:3)                   # 1d vector
#>  int [1:3] 1 2 3
str(matrix(data = 1:3, ncol = 1)) # column vector
#>  int [1:3, 1] 1 2 3
str(matrix(data = 1:3, nrow = 1)) # row vector
#>  int [1, 1:3] 1 2 3
str(array(data = 1:3, dim = 3))         # "array" vector
#>  int [1:3(1d)] 1 2 3

#### Exercises ####
#' dim() returns a null when applied to a vector
#' matrices are 2d arrays, so when is.matrix() is true, is.array() will be true as well
#' 3 dimensional arrays with same number of values but different number of rows, columns and 3rd dimension
x1 <- array(1:5, c(1, 1, 5))
x2 <- array(1:5, c(1, 5, 1))
x3 <- array(1:5, c(5, 1, 1))

#### Data Frames ####
# a data frame is a list of equal-length vectors.
# The length() of a data frame is the length of the underlying list and so is the same as ncol().
df <- data.frame(x = 1:3, y = c("a", "b", "c"), stringsAsFactors = FALSE)
str(df)
#> 'data.frame':    3 obs. of  2 variables:
#>  $ x: int  1 2 3
#>  $ y: Factor w/ 3 levels "a","b","c": 1 2 3
#
## Testing and coercion
typeof(df)
#> [1] "list"
class(df)
#> [1] "data.frame"
is.data.frame(df)
#> [1] TRUE
# Combining dataframes
cbind(df, data.frame(z = 3:1))
#>   x y z
#> 1 1 a 3
#> 2 2 b 2
#> 3 3 c 1
rbind(df, data.frame(x = 10, y = "z"))
#>    x y
#> 1  1 a
#> 2  2 b
#> 3  3 c
#> 4 10 z
# When combining column-wise, the number of rows must match, but row names are ignored.
# When combining row-wise, both the number and names of columns must match.
# Use plyr::rbind.fill() to combine data frames that don’t have the same columns.
# Having a function to combine data.frames which don't have the same number of rows doesn't make sense
# since R doesn't take into account rownames and so there is no concept of assigning data to sensible
# or appropriate rows.
# cbind() will create a matrix unless one of the arguments is already a data frame.
## Lists as part of dataframe
# when a list is given to data.frame(), it tries to put each item of the list into its own column, so this fails:
data.frame(x = 1:3, y = list(1:2, 1:3, 1:4))
#> Error in data.frame(1:2, 1:3, 1:4, check.names = FALSE, stringsAsFactors = TRUE): arguments imply differing number of rows: 2, 3, 4
# A workaround is to use I(), which causes data.frame() to treat the list as one unit:
# I() adds the AsIs class to its input,
dfl <- data.frame(x = 1:3, y = I(list(1:2, 1:3, 1:4)))
#' have a column of a data frame that’s a matrix or array, as long as the number of rows matches the data frame:
dfm <- data.frame(x = 1:3, y = I(matrix(1:9, nrow = 3)))
str(dfm)
#> 'data.frame':    3 obs. of  2 variables:
#>  $ x: int  1 2 3
#>  $ y: 'AsIs' int [1:3, 1:3] 1 2 3 4 5 6 7 8 9
dfm[2, "y"]
#>      [,1] [,2] [,3]
#> [1,]    2    5    8
#### Exercises ####
# Attributes of a dataframe: rownames(), colnames(), names(), class()
# as.matrix() coerces to the same data type as the first column
# yes - empty dataframe

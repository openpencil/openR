#### Objective: Understand subsetting within R ####
## Chapter 3: Advanced R

#### Most useful takeaways for practice ####
#' drop = FALSE if you are subsetting a matrix, array, or data frame
#' and you want to preserve the original dimensions. You should almost
#' always use it when subsetting inside a function.
#'
#'
#'
## Ah!
x <- c(2.1, 4.2, 3.3, 5.4)
#' Real numbers are silently truncated to integers | not rounded.
x[c(2.1, 2.9)]

#' If the logical vector is shorter than the vector being subsetted, it will be recycled to be the same length.
x[c(TRUE, FALSE)]
#> [1] 2.1 3.3
# Equivalent to
x[c(TRUE, FALSE, TRUE, FALSE)]
#> [1] 2.1 3.3

#' A missing value in the index always yields a missing value in the output:
x[c(TRUE, TRUE, NA, FALSE)]
#> [1] 2.1 4.2  NA
#' Can use this to omit values etc.
#'
#' DETAIL
#' The outer product of the arrays X and Y is the array A with dimension c(dim(X), dim(Y))
#' where element A[c(arrayindex.x, arrayindex.y)] = FUN(X[arrayindex.x], Y[arrayindex.y], ...).
vals <- outer(1:5, 1:5, FUN = "paste", sep = ",")
#' %o% is binary operator providing a wrapper for outer(x, y, "*").
#'
select <- matrix(ncol = 2, byrow = TRUE, c(
  1, 1,
  3, 1,
  2, 4
))
vals[select]
#> [1] "1,1" "3,1" "2,4"

df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
#' There's an important difference if you select a single
#' column: matrix subsetting simplifies by default, list
#' subsetting does not.
str(df["x"])
#> 'data.frame':    3 obs. of  1 variable:
#>  $ x: int  1 2 3
str(df[, "x"])
#>  int [1:3] 1 2 3

# S4 objects
#' There are also two additional subsetting operators that are needed for S4 objects:
#' @ (equivalent to $), and slot() (equivalent to [[).
#' @ is more restrictive than $ in that it will return an error if the slot does not exist.


#' Returns a matrix of logicals the same size of a given matrix with entries TRUE in the lower or upper triangle.
lower.tri(x, diag = FALSE)
upper.tri(x, diag = FALSE)
#' @param x a matrix.
#' @param diag logical. Should the diagonal be included?

#### Objective: A demonstration of how to invert a matrix ####
## Why is inverting a matrix important in statistics?
## Consider a simple regression equation:
## y = X*beta
## beta = X^-1*y
## X^-1 (pronounced as X-inverse) is the inverse of the X matrix,
## where X is a matrix of variables.
## Think of X-inverse as similar to a reciprocal term for a matrix.
###################################################################
## Let's look at how matrix inversion is done.
## First make a matrix
matrix_a <- matrix(data = c(2, 3, 4, 5), nrow = 2, ncol = 2)

## You can simply find the inverse using R
inverted_a_r <- solve(a = matrix_a)

## BUT what's the fun making R do all the dirty work?
## Let's do it by hand!
##
## First, get determinant of the matrix:
## Determinant of a matrix is absolute_value(Difference of the product of 1st diagonal - 2nd diagonal)
## Remember the 1st diagonal (or the leading or main) always goes down from left-to-right. The
## anti-diagonal is the one that goes down from right-to-left.
##
## As with any calculation you can find the determinant using R.
determinant_a_r <- determinant(x = matrix_a, logarithm = FALSE)
## But to build character, we will also do it by hand and verify if out answer is accurate:
determinant_a <- (matrix_a[1,1] * matrix_a[2, 2]) - (matrix_a[2, 1] * matrix_a[1, 2])

## Second, take the adjoint of a matrix: If you swap the rows and columns
## of a matrix and additionally swap the entries of the leading diagonal,
## you get the adjoint of the matrix. The adjoint of a matrix has swapped
## rows and columns and also swapped entries in the leading diag.
adjoint_a <- matrix_a
diag(adjoint_a) <- rev(diag(matrix_a))
# swap the sign of the entries in the anti-diagonal
adjoint_a[1,2] <- -1 * matrix_a[1,2]
adjoint_a[2,1] <- -1 * matrix_a[2,1]

## Third, divide the adjoint by the determinant
## (Scalar division: every element of matrix is divided by determinant)
inverse_a <- adjoint_a/determinant_a

## So the main property of an inverted matrix is:
identity_matrix <- matrix_a %*% inverse_a

#### Some more matrix operations
outer(X = c(1:4), Y = c(2:4))
crossprod(x = matrix_a, y = inverse_a)

#### Objective: A demonstration of how to invert a matrix ####
## Why is inverting a matrix important?
## Ax = b
## x = A^-1*b
## A^-1 is the inverse of A
##
## Make a matrix
matrix_a <- matrix(data = c(2, 3, 4, 5), nrow = 2, ncol = 2)
## Using R
inverted_a_r <- solve(a = matrix_a)
## By hand
## First, get determinant of the matrix: absolute_value(Difference of the product of 1st diagonal - 2nd diagonal)
determinant_a_r <- determinant(x = matrix_a, logarithm = FALSE)
determinant_a <- (matrix_a[1,1] * matrix_a[2, 2]) - (matrix_a[2, 1] * matrix_a[1, 2])
## Second, take the adjoint of a matrix (rows and columns are swapped)
# swap the entries of the leading diagonal
adjoint_a <- matrix_a
diag(adjoint_a) <- rev(diag(matrix_a))
# swap the sign of the entries in the anti-diagonal
adjoint_a[1,2] <- -1 * matrix_a[1,2]
adjoint_a[2,1] <- -1 * matrix_a[2,1]
## Third, divide the adjoint by the determinant (Scalar division: every element of matrix is divided by determinant)
inverse_a <- adjoint_a/determinant_a
## Property of an inverted matrix
identity_matrix <- matrix_a %*% inverse_a

#### Some more matrix operations
outer(X = c(1:4), Y = c(2:4))
crossprod(x = matrix_a, y = inverse_a)

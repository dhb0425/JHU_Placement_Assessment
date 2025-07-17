# This function uses gradient descent to find the scalar b that minimizes the
# squared‐error loss between y and b * x.
#
#' @param x Numeric vector. Predictor values.
#' @param y Numeric vector. Response values with the same length of x.
#' @param lr Numeric scalar. Learning rate for gradient descent.
#' @param n_iter Integer. Number of gradient descent iterations.
#' @param b_init Numeric scalar. Initial guess for b.
#' @return Numeric scalar. Estimated value of b after gradient descent in n_iter interations.
gradient_descent_b <- function(x, y, lr, n_iter, b_init) {
  b <- as.numeric(b_init)
  for (i in seq_len(n_iter)) {
    # derivative of ||y - b x||^2 w.r.t. b is -2 * sum(x * (y - b x))
    grad <- -2 * sum(x * (y - b * x))
    b    <- b - lr * grad
  }
  return(b)

}


set.seed(2025)
n      <- 1000
x      <- rnorm(n)
b_true <- 2.5
y      <- b_true * x + rnorm(n, sd = 0.5)

# Try a range of learning rates
learning_rates <- c(1e-6, 5e-6, 1e-5, 5e-5, 1e-4, 5e-4, 1e-3, 5e-3, 1e-2, 5e-2)
results <- data.frame(lr = learning_rates,
                      b_est = NA,
                      error = NA)

for (i in seq_along(learning_rates)) {
  lr    <- learning_rates[i]
  b_hat <- gradient_descent_b(x, y, lr = lr, n_iter = 1000, b_init = 0)
  results$b_est[i] <- b_hat
  results$error[i] <- abs(b_hat - b_true)
}

print(results)




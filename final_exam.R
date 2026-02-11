# ---------------------------------------------
# Parallel computing with R using the futureverse
# Final Exam
# Author: Nudo Luca
# Date: 22/10/2025
# ---------------------------------------------

# Instructions:
# For the first five questions, provide concise answers.
# Coding questions: R code in blocks with explanations as comments.

# 1. Explain the concept of futures in R
# A future represents a value that may be available later.
# The {future} framework abstracts parallel/distributed computations.
# 'Future' is a placeholder for a value.
# 'Plan' defines where/how futures are evaluated (sequential, multisession, etc.)

# 2. Use the {future} package to defer computations to another R session
library(future)

# Set multisession with 2 workers
plan(multisession, workers = 2)

# Example: compute median in parallel
f <- future({
  Sys.sleep(2)            # Simulate long computation
  median(rnorm(10000))
})

# Retrieve the result
value(f)  # Main session remains responsive until this call

# 3. Package supporting progress bars in parallel computations
library(progressr)  # Provides progress bars for future computations

# 4. User vs developer functions in {future}
# User-level functions: future(), value(), plan()
# Developer-level: Future class, ResolvedFuture
# Users get a clean interface; developers extend the framework safely

# 5. Difference between {future.apply} and {furrr}
# {future.apply}: parallelized versions of base apply() functions
# {furrr}: parallelized versions of purrr functions like future_map
# Use future.apply for base loops, furrr for pipelines or list-columns

# 6. Function to compute T1 statistic
T_1 <- function(X) {
  # Column means
  x_bar <- as.matrix(colMeans(X), ncol = 1)
  
  # Sample covariance
  S <- cov(X)
  
  # Eigen decomposition
  eig <- eigen(S, symmetric = TRUE)
  
  # Keep non-zero eigenvalues
  non_zero <- eig$values > 1e-10
  lambda_inv <- 1 / eig$values[non_zero]
  U <- eig$vectors[, non_zero, drop = FALSE]
  
  # Moore-Penrose pseudoinverse
  S_plus <- U %*% (diag(lambda_inv, nrow = length(lambda_inv))) %*% t(U)
  
  # Compute T1
  as.numeric(t(x_bar) %*% S_plus %*% x_bar)
}

# 7. Function to compute T2 statistic
T_2 <- function(X, alpha = 0.1) {
  x_bar <- as.matrix(colMeans(X), ncol = 1)
  S <- cov(X)
  p <- ncol(S)
  
  # Shrinkage covariance estimator
  S_alpha <- (1 - alpha) * S + alpha * diag(p)
  
  # Inverse of shrinkage estimator
  S_alpha_inv <- solve(S_alpha)
  
  # Compute T2
  as.numeric(t(x_bar) %*% S_alpha_inv %*% x_bar)
}

# 8. Benchmark functions with a random matrix
library(microbenchmark)

set.seed(123)
n <- 500
p <- 1000
X <- matrix(rnorm(n * p), n, p)

# Benchmark T1 and T2
microbenchmark(
  T1 = T_1(X),
  T2 = T_2(X),
  times = 5
)

# 9. Generate B = 1000 matrices and compute statistics in parallel using furrr
library(furrr)
library(ggplot2)
library(tidyverse)

set.seed(123)
mat_list <- replicate(1000, matrix(rnorm(500 * 1000), 500, 1000), simplify = FALSE)

# Set up parallel plan
plan(multisession, workers = 4)

# Compute T1 and T2 in parallel
set.seed(123)
risultato1 <- future_map_dbl(mat_list, T_1)
risultato2 <- future_map_dbl(mat_list, T_2)

# Combine results into a tibble for plotting
results <- tibble(
  T1 = risultato1,
  T2 = risultato2
) %>%
  pivot_longer(cols = everything(), names_to = "stat", values_to = "value")

# Plot histogram of T1 and T2 distributions
ggplot(results, aes(x = value, fill = stat)) +
  geom_histogram(alpha = 0.6, bins = 30, position = "identity") +
  theme_minimal() +
  labs(
    title = "Distribution of T1 and T2 Statistics",
    x = "Value",
    y = "Frequency"
  )

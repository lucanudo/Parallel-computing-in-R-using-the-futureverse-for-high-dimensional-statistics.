# Parallel Computing with R: Futureverse & High-Dimensional Statistics

This repository contains my final exam project for the course *Parallel Computing with R using the Futureverse*, completed during my academic experience at ENSAI – École Nationale de la Statistique et de l’Analyse de l’Information (Rennes, France).

## Project Overview

The project combines theoretical explanations and practical implementation of parallel computing techniques in R using the future ecosystem.

It covers:

- The concept of futures and asynchronous evaluation in R  
- The distinction between user-level and developer-level functions in {future}  
- Parallelization strategies using {future.apply} and {furrr}  
- Progress handling with {progressr}  

In addition, the project implements and analyzes two high-dimensional statistics:

### T₁ Statistic

\[
T_1 = \overline{X}^\top S^{+} \overline{X}
\]

where:
- \(\overline{X}\) is the vector of column means  
- \(S^{+}\) is the Moore–Penrose pseudoinverse of the sample covariance matrix  

The implementation includes eigen decomposition and construction of the pseudoinverse using non-zero eigenvalues.

### T₂ Statistic

\[
T_2 = \overline{X}^\top S_\alpha^{-1} \overline{X}
\]

where:
- \(S_\alpha = (1 - \alpha)S + \alpha I\)  
- \(\alpha\) is a shrinkage parameter  

This version uses a shrinkage estimator to ensure invertibility and improve numerical stability.

## Computational Experiments

The project includes:

- Benchmarking performance using the {microbenchmark} package  
- Large-scale Monte Carlo simulations (B = 1000)  
- Parallel computation with {furrr}  
- Visualization of the resulting distributions  

The simulations involve high-dimensional matrices (n = 500, p = 1000), highlighting both computational and statistical challenges.

## Technologies Used

- R  
- future  
- future.apply  
- furrr  
- progressr  
- microbenchmark  
- ggplot2  
- tidyverse  

## How to Run

1. Install the required packages:

```r
install.packages(c(
  "future",
  "future.apply",
  "furrr",
  "progressr",
  "microbenchmark",
  "ggplot2",
  "tidyverse"
))

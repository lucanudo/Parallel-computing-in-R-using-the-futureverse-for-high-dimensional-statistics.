# Parallel Computing with R using the Futureverse

This repository contains my final exam project for the course *Parallel Computing with R using the Futureverse*, completed during my academic experience at ENSAI – École Nationale de la Statistique et de l’Analyse de l’Information (Rennes, France).

## Project Overview

The project combines theoretical explanations and practical implementation of parallel computing techniques in R using the future ecosystem.

It covers:

- The concept of futures and asynchronous evaluation in R  
- The distinction between user-level and developer-level functions in {future}  
- Parallelization strategies using {future.apply} and {furrr}  
- Progress handling with {progressr}  

The project implements and analyzes two high-dimensional statistics:

- **T1 Statistic**: based on the Moore–Penrose pseudoinverse of the sample covariance matrix.  
  Includes eigen decomposition and construction of the pseudoinverse using non-zero eigenvalues.

- **T2 Statistic**: based on a shrinkage estimator of the covariance matrix.  
  The shrinkage parameter ensures numerical stability and invertibility.

## Computational Experiments

The project includes:

- Benchmarking performance using the {microbenchmark} package  
- Large-scale Monte Carlo simulations (B = 1000)  
- Parallel computation with {furrr}  
- Visualization of the resulting distributions  

Simulations involve high-dimensional matrices with hundreds of rows and columns, highlighting computational and statistical challenges.

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

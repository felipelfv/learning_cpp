# learning_cpp

A collection of functions implementing well-known statistical estimators in C++,
written as a way of learning C++ (with RcppArmadillo, called from R).

## OLS

An ordinary least squares estimator. `ols_full()` returns the coefficients and
their standard errors from `(X'X)^-1 X'y`.

### Usage

```r
library(Rcpp)
sourceCpp("ols.cpp")

set.seed(42)
x <- runif(100, 0, 10)
y <- 2 + 1.5 * x + rnorm(100, sd = 2)

fit <- ols_full(cbind(1, x), y)
fit$coefficients   # intercept, slope
fit$stderr         # standard errors
```

Run the full example (fits the model and writes `plot.png`):

```sh
Rscript example.R
```

### Plot

![OLS fit](plot.png)

# learning_cpp

A collection of functions implementing well-known statistical estimators in C++,
written as a way of learning C++ (with RcppArmadillo, called from R).

## Layout

```
estimators/   C++ estimator functions (ols.cpp, ridge.cpp)
examples/     R scripts demonstrating them
```

## OLS

An ordinary least squares estimator. `ols_full()` returns the coefficients and
their standard errors from `(X'X)^-1 X'y`.

```r
library(Rcpp)
sourceCpp("estimators/ols.cpp")

fit <- ols_full(cbind(1, x), y)
fit$coefficients   # intercept, slope
fit$stderr         # standard errors
```

## Ridge

A ridge regression estimator (L2-penalised OLS). `ridge_full()` returns the
coefficients from `(X'X + lambda*I)^-1 X'y` for a given penalty `lambda`. The
intercept (first column) is left unpenalised.

```r
library(Rcpp)
sourceCpp("estimators/ridge.cpp")

fit <- ridge_full(cbind(1, x), y, lambda = 10)
fit$coefficients   # intercept, slope
fit$lambda         # penalty used
```

## Example

Run from the repository root; it fits both estimators and writes `plot.png`:

```sh
Rscript examples/example.R
```

![OLS vs Ridge fit](plot.png)

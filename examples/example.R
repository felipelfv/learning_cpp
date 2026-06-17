# Run from the repository root: Rscript examples/example.R
library(Rcpp)
sourceCpp("estimators/ols.cpp")
sourceCpp("estimators/ridge.cpp")

set.seed(42)
x <- runif(100, 0, 10)
y <- 2 + 1.5 * x + rnorm(100, sd = 2)
X <- cbind(1, x)

ols <- as.numeric(ols_full(X, y)$coefficients)

png("examples/plot.png", width = 800, height = 600)
plot(x, y, pch = 19, col = "steelblue",
     main = "OLS vs ridge: larger lambda shrinks the slope")
abline(ols[1], ols[2], col = "red", lwd = 2)

# Ridge fits at increasing penalties — the line flattens as lambda grows
lambdas <- c(500, 2000, 5000)
greens  <- c("#74c476", "#31a354", "#006d2c")
for (i in seq_along(lambdas)) {
  b <- as.numeric(ridge_full(X, y, lambdas[i])$coefficients)
  abline(b[1], b[2], col = greens[i], lwd = 2, lty = 2)
}

legend("topleft",
       c("OLS", sprintf("Ridge (lambda = %d)", lambdas)),
       col = c("red", greens), lwd = 2, lty = c(1, 2, 2, 2), bty = "n")
dev.off()

# Run from the repository root: Rscript examples/example.R
library(Rcpp)
sourceCpp("estimators/ols.cpp")
sourceCpp("estimators/ridge.cpp")

set.seed(42)
x <- runif(100, 0, 10)
y <- 2 + 1.5 * x + rnorm(100, sd = 2)
X <- cbind(1, x)

ols   <- as.numeric(ols_full(X, y)$coefficients)
ridge <- as.numeric(ridge_full(X, y, lambda = 10)$coefficients)

png("plot.png", width = 800, height = 600)
plot(x, y, pch = 19, col = "steelblue")
abline(ols[1],   ols[2],   col = "red",  lwd = 2)
abline(ridge[1], ridge[2], col = "darkgreen", lwd = 2, lty = 2)
legend("topleft", c("OLS", "Ridge (lambda = 10)"),
       col = c("red", "darkgreen"), lwd = 2, lty = c(1, 2), bty = "n")
dev.off()

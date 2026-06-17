library(Rcpp)
sourceCpp("ols.cpp")

set.seed(42)
x <- runif(100, 0, 10)
y <- 2 + 1.5 * x + rnorm(100, sd = 2)

fit <- ols_full(cbind(1, x), y)
b <- as.numeric(fit$coefficients)

png("plot.png", width = 800, height = 600)
plot(x, y, pch = 19, col = "steelblue")
abline(b[1], b[2], col = "red", lwd = 2)
dev.off()

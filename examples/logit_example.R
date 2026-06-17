# run from the repository root: Rscript examples/logit_example.R
library(Rcpp)
sourceCpp("estimators/logit.cpp")

set.seed(1)
n <- 500
x <- rnorm(n)
prob <- 1 / (1 + exp(-(-0.5 + 1.2 * x)))
y <- rbinom(n, 1, prob)

b <- as.numeric(logit_full(cbind(1, x), y)$coefficients)

# fitted probability curve over the range of x
grid <- seq(min(x), max(x), length.out = 200)
phat <- 1 / (1 + exp(-(b[1] + b[2] * grid)))

png("examples/logit_plot.png", width = 800, height = 600)
plot(x, y, pch = 19, col = "#3b7dd855",
     xlab = "x", ylab = "y / P(y = 1)")
lines(grid, phat, col = "red", lwd = 2)
dev.off()

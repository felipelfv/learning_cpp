# run from the repository root: Rscript examples/poisson_example.R
library(Rcpp)
sourceCpp("estimators/poisson.cpp")

set.seed(7)
n <- 400
x <- runif(n, -1, 2)
y <- rpois(n, exp(0.3 + 0.8 * x))

b <- as.numeric(poisson_full(cbind(1, x), y)$coefficients)

# fitted mean curve mu = exp(b0 + b1 x) over the range of x
grid <- seq(min(x), max(x), length.out = 200)
mu <- exp(b[1] + b[2] * grid)

png("examples/poisson_plot.png", width = 800, height = 600)
plot(x, y, pch = 19, col = "#3b7dd855", xlab = "x", ylab = "count")
lines(grid, mu, col = "red", lwd = 2)
dev.off()

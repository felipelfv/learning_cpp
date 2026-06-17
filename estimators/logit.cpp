#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export]]
Rcpp::List logit_full(const arma::mat& X, const arma::colvec& y,
                      int max_iter = 100, double tol = 1e-8) {
  int k = X.n_cols;
  arma::colvec coef = arma::zeros(k);   // start at zero
  arma::mat XtWX_inv;

  // iteratively reweighted least squares (newton-raphson)
  for (int it = 0; it < max_iter; ++it) {
    arma::colvec eta = X * coef;
    arma::colvec p   = 1.0 / (1.0 + arma::exp(-eta));   // fitted probabilities
    arma::colvec w   = p % (1.0 - p);                   // irls weights

    arma::mat XtWX = X.t() * (X.each_col() % w);        // x'wx
    XtWX_inv = arma::inv(XtWX);
    arma::colvec step = XtWX_inv * (X.t() * (y - p));   // (x'wx)^-1 x'(y - p)
    coef += step;

    if (arma::norm(step, 2) < tol) break;               // converged
  }

  arma::colvec se = arma::sqrt(arma::diagvec(XtWX_inv));

  return Rcpp::List::create(
    Rcpp::Named("coefficients") = coef,
    Rcpp::Named("stderr")       = se
  );
}

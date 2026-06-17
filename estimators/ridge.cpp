#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export]]
Rcpp::List ridge_full(const arma::mat& X, const arma::colvec& y, double lambda) {
  int k = X.n_cols;

  arma::mat XtX = X.t() * X;
  arma::mat pen = lambda * arma::eye(k, k);   // L2 penalty, one per column
  pen(0, 0) = 0;                              // leave the intercept (first column) unpenalised
  arma::colvec coef = arma::solve(XtX + pen, X.t() * y);   // (X'X + lambda I)^-1 X'y

  return Rcpp::List::create(
    Rcpp::Named("coefficients") = coef,
    Rcpp::Named("lambda")       = lambda
  );
}

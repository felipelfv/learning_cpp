#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export]]
Rcpp::List ols_full(const arma::mat& X, const arma::colvec& y) {
  int n = X.n_rows, k = X.n_cols;
  
  arma::mat XtX_inv = arma::inv(X.t() * X);   // (X'X)^-1, computed once
  arma::colvec coef = XtX_inv * X.t() * y;    // textbook: (X'X)^-1 X'y
  
  arma::colvec resid = y - X * coef;
  double sig2 = arma::as_scalar(resid.t() * resid) / (n - k);
  arma::colvec se = arma::sqrt(sig2 * arma::diagvec(XtX_inv));   // reuse it
  
  return Rcpp::List::create(
    Rcpp::Named("coefficients") = coef,
    Rcpp::Named("stderr")       = se
  );
}
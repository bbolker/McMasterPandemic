% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ageify.R
\name{expand_state_age}
\alias{expand_state_age}
\alias{ageify}
\title{expand state vector by age classes and population distribution}
\usage{
expand_state_age(x, age_cat = mk_agecats(), Nvec = NULL)

ageify(ratemat, params, age_cat = mk_agecats())
}
\arguments{
\item{x}{state vector}

\item{age_cat}{vector of age categories}

\item{Nvec}{population distribution (as counts)}

\item{ratemat}{rate matrix}

\item{params}{parameter vector}
}
\description{
epidemiological state varies fast, age category varies slowly
}
\examples{
params <- read_params("PHAC_testify.csv")
ss <- make_state(params=params)
# ss2 <- expand_state_age(ss)
params <- read_params("PHAC_testify.csv")
state <- make_state(params=params)
M <- make_ratemat(state,params, sparse=TRUE)
Ma <- ageify(M, params)
library(Matrix)
Matrix::image(Ma)
Mta <- ageify(testify(M,params),params)
Matrix::image(Mta)
}

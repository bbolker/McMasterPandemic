% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ageify.R
\name{expand_params_mistry}
\alias{expand_params_mistry}
\title{Expand parameter list to include age structure using Mistry et al. data}
\usage{
expand_params_mistry(
  params,
  transmissibility = 1,
  province = "ON",
  contact_rate_setting = mk_contact_rate_setting(),
  age_cat = NULL
)
}
\arguments{
\item{params}{baseline parameters loaded from one of the parameter files (??)}

\item{transmissibility}{probability of transmission upon contact with an infected (beta0 = transmissibility * contact_rate)}

\item{province}{province for which to construct the matrix (if NULL, make a Canada-wide contact matrix)}

\item{contact_rate_setting}{named list containing setting-specific contact rates (in units of average contacts in the given setting per individual of age i with individuals of age j per day)}

\item{age_cat}{(optional) list of age groups to aggregate ages in; use `mk_agecats()` to generate (must start with 0 and end with 84); default is single ages starting with 0 and up to 83, then a single 84+ category}
}
\value{
an object of class `params_pansim`
}
\description{
Expand parameter list to include age structure using Mistry et al. data
}
\examples{
params <- read_params("PHAC_testify.csv")
age_cat <- mk_agecats(min = 0, max = 80, da = 10)
expand_params_mistry(params = params, province = "ON", age_cat = age_cat)
}

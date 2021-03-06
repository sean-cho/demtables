% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make_dem_table.R
\name{make_dem_table}
\alias{make_dem_table}
\title{Make pretty demographics table}
\usage{
make_dem_table(dat, expr, tblname = NA, type = "html", ...)
}
\arguments{
\item{dat}{Data.frame containing classification and demographic variables.}

\item{expr}{Expression of how to populate table. \code{cls ~ .} or
\code{cls ~ var1 + var2}}

\item{tblname}{Name of the table.}

\item{type}{Type of table to make. Currently only \code{html} is supported.}

\item{...}{Passed onto htmlTable}
}
\value{
HTML ready table.
}
\description{
Generates display ready demographics table.
}
\details{
\code{make_dem_table} Generate display ready demographics table.

Generates display ready demographic table from given expression.
}
\examples{

data(iris)
iristbl <- make_dem_table(iris, Species ~ ., 'Iris')
view_dem_table(iristbl)

}
\seealso{
\code{\link[demtables]{dem_table}} \code{\link[demtables]{view_dem_table}}
}

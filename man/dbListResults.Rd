% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DBConnection.R
\name{dbListResults}
\alias{dbListResults}
\title{A list of all pending results}
\usage{
dbListResults(conn, ...)
}
\arguments{
\item{conn}{A \code{\linkS4class{DBIConnection}} object, as produced by
\code{\link[=dbConnect]{dbConnect()}}.}

\item{...}{Other parameters passed on to methods.}
}
\value{
a list. If no results are active, an empty list. If only
a single result is active, a list with one element.
}
\description{
List of \linkS4class{DBIResult} objects currently active on the connection.
}
\seealso{
Other DBIConnection generics: \code{\link{DBIConnection-class}},
  \code{\link{dbDataType}}, \code{\link{dbDisconnect}},
  \code{\link{dbExecute}}, \code{\link{dbExistsTable}},
  \code{\link{dbGetException}}, \code{\link{dbGetInfo}},
  \code{\link{dbGetQuery}}, \code{\link{dbIsValid}},
  \code{\link{dbListFields}}, \code{\link{dbListTables}},
  \code{\link{dbReadTable}}, \code{\link{dbRemoveTable}},
  \code{\link{dbSendQuery}}, \code{\link{dbSendStatement}}
}


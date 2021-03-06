% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\name{sqlData}
\alias{sqlData}
\title{Convert a data frame into form suitable for upload to a SQL database}
\usage{
sqlData(con, value, row.names = NA, ...)
}
\arguments{
\item{con}{A database connection.}

\item{value}{A data frame}

\item{row.names}{Either \code{TRUE}, \code{FALSE}, \code{NA} or a string.

If \code{TRUE}, always translate row names to a column called "row_names".
If \code{FALSE}, never translate row names. If \code{NA}, translate
rownames only if they're a character vector.

A string is equivalent to \code{TRUE}, but allows you to override the
default name.

For backward compatibility, \code{NULL} is equivalent to \code{FALSE}.}

\item{...}{Other arguments used by individual methods.}
}
\description{
This is a generic method that coerces R objects into vectors suitable for
upload to the database. The output will vary a little from method to
method depending on whether the main upload device is through a single
SQL string or multiple parameterised queries.
This method is mostly useful for backend implementers.
}
\details{
The default method:
\itemize{
\item Converts factors to characters
\item Quotes all strings
\item Converts all columns to strings
\item Replaces NA with NULL
}
}
\examples{
con <- dbConnect(RSQLite::SQLite(), ":memory:")

sqlData(con, head(iris))
sqlData(con, head(mtcars))

dbDisconnect(con)
}


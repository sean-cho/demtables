#' View demographics table
#'
#' \code{view_dem_table} View demographics table from make_dem_table.
#'
#' @description Views demographics table from \code{make_dem_table} in RStudio.
#'
#' @param tbl Result from \code{make_dem_table}.
#' @return Displays table in viewer.
#'
#' @details Displays table from \code{make_dem_table}
#'
#' @examples
#'
#' data(iris)
#' iristbl <- make_dem_table(iris, Species ~ ., 'Iris')
#' view_dem_table(iristbl)
#'
#' @export view_dem_table
#'
#' @seealso \code{\link[demtables]{make_dem_table}}
#'

view_dem_table <- function(tbl){
  tf <- tempfile(fileext = '.html')
  writeLines(tbl, tf)
  rstudioapi::viewer(tf)
}

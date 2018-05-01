#' Make pretty demographics table
#'
#' \code{make_dem_table} Generate display ready demographics table.
#'
#' @description Generates display ready demographics table.
#'
#' @param dat Data.frame containing classification and demographic variables.
#' @param expr Expression of how to populate table. \code{cls ~ .} or
#'    \code{cls ~ var1 + var2}
#' @param tblname Name of the table.
#' @param ... Passed onto htmlTable
#' @param type Type of table to make. Currently only \code{html} is supported.
#' @return HTML ready table.
#'
#' @details Generates display ready demographic table from given expression.
#'
#' @examples
#'
#' data(iris)
#' iristbl <- make_dem_table(iris, Species ~ ., 'Iris')
#' view_dem_table(iristbl)
#'
#' @import dplyr tidyr formula.tools htmlTable
#' @export make_dem_table
#'
#' @seealso \code{\link[demtables]{dem_table}} \code{\link[demtables]{view_dem_table}}
#'

make_dem_table <- function(dat, expr, tblname = NA, type = 'html', ...){
  if(type == 'html'){
    require(htmlTable)
    tbl <- dem_table(dat, expr)
    if(is.na(tblname)){
      tblname = ''
    }
    htmlTable(tbl, cgroup = tblname, n.cgroup = ncol(tbl),
              css.cell = "padding-left: .5em; padding-right: .5em;",
              col.rgroup = c("none", "#F7F7F7"),
              ...)
  }
}

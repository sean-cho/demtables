#' Make base demographics table
#'
#' \code{dem_table} Generate demographics table.
#'
#' @description Generates demographics table from given data.frame.
#'
#' @param dat Data.frame containing classification and demographic variables.
#' @param expr Expression of how to populate table. \code{cls ~ .} or
#'    \code{cls ~ var1 + var2}
#' @param make_pretty Prettify the LHS and RHS names?
#' @return Data.frame of demographic table.
#'
#' @details Generates demographic table from given expression.
#'
#' @examples
#'
#' data(iris)
#' dem_table(iris, Species ~ .)
#' dem_table(iris, Species ~ Sepal.Width + Sepal.Length)
#'
#' @import dplyr tidyr formula.tools
#' @export dem_table
#'
#' @seealso \code{\link[demtables]{make_dem_table}}
#'

dem_table <- function(dat, expr, make_pretty = FALSE){
  if(!inherits(dat, 'data.frame')) stop('x is not data.frame.')
  if(!inherits(expr, 'formula')) stop('Not a valid expression.')
  if(op(expr) != '~') stop('Not a valid expression.')

  .cond <- lhs.vars(expr, data = dat)
  if(length(.cond) > 1) stop('More than one condition found.')
  .vars <- rhs.vars(expr, data = dat)

  .vars <- setdiff(.vars, .cond)
  if(!all(.vars %in% colnames(dat))) stop('Not all provided variables are in data.frame.')

  condition <- dat[,.cond]

  ## Analysis
  demvars <- list()
  ## Make pretty variable (row) names for table?
  if(make_pretty){
    .vname <- prettify(.v)
  } else {
    .vname <- .v
  }
  for(.v in .vars){
    demvars[[.v]] <- .dem_stats(dat[,.v], condition, .vname)
  }
  demvars <- as.matrix(do.call(rbind, demvars))

  ## Header
  if(inherits(condition, 'factor')){
    hc <- levels(condition)
  } else {
    hc <- as.character(unique(condition))
  }
  ## Make pretty condition (column) names?
  if(make_pretty){
    .header <- sort(sapply(hc, prettify))
  } else {
    .header <- sort(hc)
  }
  header <- c('', '', .header, 'pvalue')
  N <- c('N', '', table(dat[.cond]),'')
  demvars <- rbind(header, N, demvars)
  rownames(demvars) <- NULL
  colnames(demvars) <- NULL
  return(demvars)
}

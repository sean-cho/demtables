#' Miscellaneous or core functions not directly accessed by user
#' @import dplyr tidyr formula.tools

.prettify <- function(x){
  ## Skip if all uppercase
  if(grepl("^[[:upper:]]+$", x)) return(x)
  ## Skip if one
  if(nchar(x) == 1) return(x)
  ## Process
  foo <- strsplit(x,'')[[1]]
  foo[1] <- toupper(foo[1])
  foo[2:length(foo)] <- tolower(foo[2:length(foo)])
  return(paste0(foo, collapse = ''))
}

prettify <- function(x){
  foo <- strsplit(x, ' ')
  foo <- sapply(foo, .prettify)
  paste0(foo, collapse = ' ')
}

.dem_stats <- function(v, cond, vname = NULL){
  require(dplyr)
  require(tidyr)
  require(formula.tools)
  if(inherits(v,c('numeric','integer','double'))){
    m <- tapply(v, cond, mean, na.rm = TRUE)
    s <- tapply(v, cond, sd, na.rm = TRUE)
    p <- try({
      if(length(cond) > 2){
        summary(aov(v ~ cond))[[1]][,5][1]
      } else {
        t.test(v ~ cond)$p.value
      }
    })
    if(inherits(p,'try-error')) p <- NA
    cellval <- sprintf('%0.2f (%0.1f)', m, s)
    if(is.na(p)) {
      tb <- as.matrix(rbind(c('', '', cellval, 'NA')))
    } else if(p < 0.01){
      tb <- as.matrix(rbind(c('', '', cellval, '< 0.01')))
    } else {
      tb <- as.matrix(rbind(c('', '', cellval, sprintf('%0.2f', p))))
    }
    tb <- rbind(c(vname, rep('', ncol(tb) - 1)), tb)
  } else {
    counttb <- table(v, cond)
    p <- try(fisher.test(counttb)$p.value)
    if(inherits(p, 'try-error')) p <- NA
    proptb <- sprintf('%0.1f', prop.table(counttb, margin = 2)*100)
    prtb <- paste0(counttb, ' (', proptb, ')')
    dim(prtb) <- dim(counttb)
    colnames(prtb) <- colnames(counttb)
    rownames(prtb) <- rownames(counttb)
    prtb <- as.table(prtb)
    tb <- cbind('', spread(as.data.frame(prtb), Var2, Freq)) %>%
      mutate(Var1 = as.character(Var1))
    colnames(tb) <- rep('', ncol(tb))
    tb <- as.matrix(tb)
    tb <- rbind(c(vname, rep('',ncol(tb)-1)), tb)
    if(is.na(p)) {
      tb <- cbind(tb, c('', 'NA', rep('', nrow(tb) - 2)))
    } else if(p < 0.01){
      tb <- cbind(tb, c('', '< 0.01', rep('', nrow(tb) - 2)))
    } else {
      tb <- cbind(tb, c('', sprintf('%0.2f', p), rep('', nrow(tb) - 2)))
    }
  }
  colnames(tb) <- paste('V',1:ncol(tb))
  return(tb)
}

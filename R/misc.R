#' Miscellaneous or core functions not directly accessed by user
#' @import dplyr tidyr formula.tools

.prettify <- function(x){
  ## Skip if all uppercase
  if(grepl("^[[:upper:]]+$", x)) return(x)
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
    m <- tapply(v, cond, mean)
    s <- tapply(v, cond, sd)
    if(length(cond) > 2){
      p <- summary(aov(v ~ cond))[[1]][,5][1]
    } else {
      p <- t.test(v ~ cond)$p.value
    }
    cellval <- sprintf('%0.2f (%0.1f)', m, s)
    if(p < 0.01){
      tb <- as.matrix(rbind(c('', '', cellval, '< 0.01')))
    } else {
      tb <- as.matrix(rbind(c('', '', cellval, sprintf('%0.2f', p))))
    }
    tb <- rbind(c(vname, rep('', ncol(tb) - 1)), tb)
  } else {
    tb <- table(v, cond)
    p <- fisher.test(tb)$p.value
    tb <- cbind('', spread(as.data.frame(tb), cond, Freq)) %>%
      mutate(v = as.character(v))
    colnames(tb) <- rep('', ncol(tb))
    tb <- as.matrix(tb)
    tb <- rbind(c(vname, rep('',ncol(tb)-1)), tb)
    if(p < 0.01){
      tb <- cbind(tb, c('', '< 0.01', ''))
    } else {
      tb <- cbind(tb, c('', sprintf('%0.2f', p), ''))
    }
  }
  colnames(tb) <- paste('V',1:ncol(tb))
  return(tb)
}

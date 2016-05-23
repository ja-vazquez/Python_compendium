# From package jagstools https://github.com/johnbaums/jagstools
jagsresults <- function(x, params, regex=FALSE, invert=FALSE, 
                        probs=c(0.025, 0.25, 0.5, 0.75, 0.975), signif, ...) {
  if(!regex) {
    params <- paste0(gsub('(?=\\.|\\[|\\])', '\\1\\\\', params, perl=TRUE),
                     '(\\[.*\\])?', collapse='|')
    params <- paste("^", gsub("\\|", "$|^", params), '$', sep = "")
  } else if(length(params) > 1) {
    stop("If 'regex' is TRUE, 'params' must be a single regex string.",
         call.=FALSE)
  }
  if(any(is(x) %in% c('rjags.parallel', 'rjags'))) {
    nm <- dimnames(x$BUGSoutput$sims.array)[[3]]
    i <- grep(params, nm, invert=invert, ...)
    if(length(i) == 0) stop("No parameters match 'params'", call.=FALSE)
    samp <- x$BUGSoutput$sims.array[, , i, drop=FALSE] 
    rhat_neff <- x$BUGSoutput$summary[i, c('Rhat', 'n.eff'), drop=FALSE]
    out <- cbind(t(apply(
      samp, 3, function(x) 
        c(mean=mean(x), sd=sd(x), quantile(x, probs=probs)))), rhat_neff)
  } else if(any(is(x)=='mcmc.list')) {
    nm <- colnames(x[[1]])
    i <- grep(params, nm, invert=invert, ...)
    if(length(i) == 0) stop("No parameters match 'params'", call.=FALSE)
    out <- t(apply(do.call(rbind, x), 2, function(z) {
      c(mean=mean(z), sd=sd(z), quantile(z, probs))
    }))[i, , drop=FALSE]
  } else {
    stop("x must be an 'mcmc.list' or 'rjags'  object.")
  }
  if(!missing(signif)) {
    out[, colnames(out) != 'n.eff'] <- 
      signif(out[, colnames(out) != 'n.eff'], signif)  
    out
  } else out
}
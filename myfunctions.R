mydata <- function(file) paste0("http://repos.dii.unitn.it:8080/data/", file)

`%contains%` <- function(vector, x) {
  v <- unlist(vector)
  x >= min(v) & x <= max(v)
}

tukey.plot <- function(t) {
  name <- paste("Differences in mean levels of", names(t)[1])
  t[[1]] %>% 
    data.frame %>%
    rownames_to_column("pair") %>%
      ggplot(aes(x=pair))+ 
      geom_point(aes(y=diff)) + 
      geom_linerange(aes(ymin=lwr, ymax=upr)) + 
      geom_hline(yintercept=0) + 
      labs(title=paste0((attr(t, "conf.level")*100), "% family-wise confidence level")) +
      ylab(name) + 
      xlab("") +
      coord_flip()
}

file_head <- function(filename, n=6) {
  f <- file(filename, "r")
  for (i in 1:n) {
    line <- readLines(f, n=1)
    cat(line)
    cat("\n")
  }
  close(f)
}

# hack for setting LaTeX fontsize for code chuncks
# see https://stackoverflow.com/questions/25646333/code-chunk-font-size-in-rmarkdown-with-knitr-and-latex
def.chunk.hook  <- knitr::knit_hooks$get("chunk")
knitr::knit_hooks$set(chunk = function(x, options) {
  x <- def.chunk.hook(x, options)
  ifelse(options$size != "normalsize", paste0("\n \\", options$size,"\n\n", x, "\n\n \\normalsize"), x)
})

knitr::opts_chunk$set(
  fig.align="center", 
  fig.dim=c(5, 4), 
  out.height="2in",
  message=FALSE, 
  warning=FALSE,
  echo=TRUE, 
  tidy=TRUE, 
  tidy.opts=list(width.cutoff=I(60)),
  size="small",
  # size="footnotesize",
  # size="scriptsize",
  # size="tiny",
  cache.extra = packageVersion('tufte') # invalidate cache when the tufte version changes
)
options(htmltools.dir.version = FALSE)
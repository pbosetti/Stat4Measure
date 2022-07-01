#!/usr/local/bin/Rscript
#Sys.setenv(RSTUDIO_PANDOC="/Applications/RStudio.app/Contents/MacOS/pandoc")
library(stringr)

files <- c(
  "0-Introduzione_R.Rmd",
  "1-StatisticaDescrittiva.Rmd",
  "2-Tidyverse.Rmd",
  "3-StatisticaInferenziale.Rmd",
  "4-Regressione.Rmd",
  "5-Bootstrapping.Rmd",
  "6-MisuraIncertezzaTaratura.Rmd",
  "7-DesignOfExperiments.Rmd",
  "8-SerieTemporali.Rmd"
)
out_files <- c()

for (f in files) {
  cat(paste("********* Building source", f, "**********\n"))
  out_files <- c(out_files, str_replace(f, "\\.Rmd$", ".pdf"))
  rmarkdown::render(
    input = f,
    quiet = T,
    clean = T
  )
}

# merge all files
gs_args <- c("-q", "-dNOPAUSE", "-dBATCH", "-sDEVICE=pdfwrite", "-sOutputFile=merged.pdf", out_files)
system2("gs", gs_args)

# cleanup
system2("rm", c("*.log"))

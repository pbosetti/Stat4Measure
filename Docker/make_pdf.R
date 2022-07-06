#!/usr/local/bin/Rscript
library(glue)
library(stringr)


dir <- Sys.getenv("GITHUB_WORKSPACE")
if (length(dir) > 0) {
  setwd(dir)
}

args = commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  stop("ERROR: need one or more Rmd files as input")
}

for (in_file in args) {
  out_file <- str_replace(in_file, "\\.Rmd$", ".pdf")
  cat(str_pad(
    glue(" Building source {in_file}->{out_file} "),
    width=80, side="both", pad = "*"
    ),
    sep="\n"
  )
  rmarkdown::render(
    input = in_file,
    quiet = T,
    clean = T
  )
}
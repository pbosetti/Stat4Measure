# Rmarkdown docker container

This directory contains what is needed to build a Docker container able to compile the Rmd files in the project root.

This is designed to be used within a GitHub Workflow for automatic compilation of Rmd files on pushing a new tag.

**Note**: the `make_pdf.R`script accepts a glob of files to be compiled, and changes directory to the content of the environment variable `GITHUB_WORKSPACE` before compiling via `rmarkdown`.

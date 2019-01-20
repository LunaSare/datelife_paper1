# Domingo 14 de enero 2018
library(citer)
library(rmarkdown)
setwd("~/Library/Mobile Documents/com~apple~CloudDocs/Desktop/datelife_paper1")
pandoc_convert("Datelife_paper1.md", to="pdf", citeproc = TRUE, output = "Datelife_paper1.pdf")
# pandoc: Unknown writer: pdf
# To create a pdf with pandoc, use the latex or beamer writer and specify
# an output file with .pdf extension (pandoc -t latex -o filename.pdf).
# Error: pandoc document conversion failed with error 9
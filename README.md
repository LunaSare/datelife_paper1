# datelife_paper1
First paper for DateLife
File structure:
  

To reproduce any version of this paper:
To render, use the knit button in RStudio for Datelife_paper1.Rmd.

Alternatively:
```
setwd("~/Desktop/datelife_paper1/")
rmarkdown::render(input = "~/Desktop/datelife_paper1/Datelife_paper1.Rmd", output_format = "pdf_document")
```

file `svm-latex-ms.tex` was downloaded with the following code on Sept 27 2019:
```
download.file(url = "https://raw.githubusercontent.com/svmiller/svm-r-markdown-templates/master/svm-latex-ms.tex",
              destfile = "svm-latex-ms.tex", mode="wb")
```

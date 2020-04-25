# datelife paper 1

First paper for DateLife

To reproduce any version of this manuscript, you will need the R packages `datelife`, `drake`, `knitr` and `rmarkdown` installed.

From the root directory, choose the version of the paper that you want to reproduce, for example `biorxiv_2019.09.28.Rmd`.
You can open this in RStudio and hit the `knit` button. Or you can go to the R terminal and use rmarkdown::render("biorxiv_2019.09.28.Rmd", "all")

Project file structure:

- paper_1-header.Rmd: Information of title and author's names and  affiliations.
- paper_2-abstract.Rmd: The abstract and keywords.
- paper_3-main.Rmd: Go here if you want to modify the main parts of the manuscript: intro, methods, results, discussion, conclusion, disclaimers, thanks.
- paper_references.tex: Contans the bibtex of references. Any new reference should be added here in bibtex format.
- figures_download.R: Code to download figures from the repos they were created in.
- data directory: contains R files to generate data used to generate the figures in the ms.

- journal_date.Rmd: Contains the yaml code to format paper.Rmd for the specific journal
- journal_date.tex: latex file from the .Rmd to be rendered to pdf. Generated with `rmarkdown::render()` from the R terminal or RStudio knit button.
- journal_date.pdf: pdf file final render.
- journal_datefigcaps.tex: contains the latex for the main figures and their captions. It is included in the journal_date.tex file

- *.csl files are the reference formats for different journals

file `svm-latex-ms.tex` was downloaded with the following code on Sept 27 2019:
```
download.file(url = "https://raw.githubusercontent.com/svmiller/svm-r-markdown-templates/master/svm-latex-ms.tex",
              destfile = "svm-latex-ms.tex", mode="wb")
```

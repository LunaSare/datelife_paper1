# Welcome to DateLife's first reproducible manuscript GitHub repository!

To reproduce any version of this manuscript, you will need the R packages `datelife`, `drake`, `knitr` and `rmarkdown` installed.

From the root directory, choose the version of the paper that you want to reproduce, for example `biorxiv_2019.09.28.Rmd`.
You can open this in RStudio and hit the `knit` button. Or you can go to the R terminal and use rmarkdown::render("biorxiv_2019.09.28.Rmd", "all")

### Project file structure:

- _**paper_1-header.Rmd**_: Information of title and author's names and  affiliations.
- **_paper_2-abstract.Rmd_**: The abstract and keywords.
- **_paper_3-main.Rmd_**: Go here if you want to modify the main parts of the manuscript: intro, methods, results, discussion, conclusion, disclaimers, thanks.
- **_paper_references.tex_**: Contans the bibtex of references. Any new reference should be added here in bibtex format.
- **_figures_download.R_**: Code to download figures from the repos they were created in.
- **_data/_**: directory that contains R files to generate data used for the figures in the ms.

- **_journal_date.Rmd_**: Contains the yaml code to format paper.Rmd for the specific journal
- _**journal_date.tex**_: latex file from the .Rmd to be rendered to pdf. Generated with `rmarkdown::render()` from the R terminal or RStudio knit button.
- **_journal_date.pdf_**: pdf file final render.
- **_journal_datefigcaps.tex_**: contains the latex for the main figures and their captions. It is included in the journal_date.tex file

- **_*.csl files_**: the reference formats for different journals

The file svm-latex-ms.tex was downloaded with the following code on Sept 27 2019:

```
download.file(url = "https://raw.githubusercontent.com/svmiller/svm-r-markdown-templates/master/svm-latex-ms.tex",
              destfile = "svm-latex-ms.tex", mode="wb")
```

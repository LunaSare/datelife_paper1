library(datelife)
library(drake)
class(opentree_chronograms$trees) <- "multiPhylo"
make_report <- function(rmdname, mdname, placeholder){
  knitr::knit(knitr_in(rmdname), file_out(mdname), quiet = TRUE)
}
render_pdf <- function(reportname, dir, placeholder) {
    original.dir <- getwd()
    setwd(dir)
    system(paste0('pandoc ', paste0(reportname, '.md'), ' -o ', paste0(reportname, '.pdf --pdf-engine=xelatex -V mainfonts="DejaVu Sans"')))
    setwd(original.dir)
    # pandoc -o emoji.pdf --pdf-engine=lualatex -V mainfonts="DejaVu Sans"
    # pandoc -o emoji.pdf --pdf-engine=xelatex  -V mainfonts="DejaVu Sans"
}
# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @

tol_query <- drake_plan(
  strings_in_dots = "literals",
  biggest = which.max(unname(ape::Ntip(opentree_chronograms$trees))),
  # names(opentree_chronograms$trees[[biggest]])
  # names(opentree_chronograms$trees[biggest])
  # tol_dq = make_datelife_query(input = opentree_chronograms$trees[[biggest]], get_spp_from_taxon = FALSE),
  # tol_dr = get_datelife_result(input = tol_dq), # erroring, so tryCatch and divide it because it is too large:
  # all_dr_1 = lapply(opentree_chronograms$trees[1:100], function(x) tryCatch(datelife:::phylo_to_patristic_matrix(x),
  #     error = function(e) NULL)) # biggest is the only one that error when going from phylo to patristic matrix.
  # all_dr_2 = lapply(opentree_chronograms$trees[101:200], function(x) tryCatch(datelife:::phylo_to_patristic_matrix(x),
  #     error = function(e) NULL)), # biggest is the only one that error when going from phylo to patristic matrix.
  # tol_summ = get_taxon_summary(datelife_query = tol_dq, datelife_result = all_dr),
  tol_dq = make_datelife_query(input = opentree_chronograms$trees[[biggest]], get_spp_from_taxon = FALSE),
  tol_dr = get_datelife_result(input = tol_dq), # erroring, so tryCatch:
  tol_summ = get_taxon_summary(datelife_query = tol_dq, datelife_result = all_dr),
)
make(tol_query)

loadd(biggest)
loadd(tol_biggest)
# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
tol_calibs <- drake_plan(
  all_calibs_minus93 = get_all_calibrations(opentree_chronograms$trees[-93], each = TRUE),
  all_calibs_93 = get_all_calibrations(opentree_chronograms$trees[[93]], each = TRUE),
  all_calibs_93_matched = match_all_calibrations(phy = tol_biggest, calibrations = all_calibs_93[[1]])
)
make(tol_calibs)
save(all_calibs_minus93, file = "data/all_calibs_minus93.RData")
loadd(all_calibs_93_matched)
# names(all_calibs_93_matched)
tb <- list(tol_biggest)
names(tb) <- names(opentree_chronograms$trees)[biggest]
save(all_calibs_93_matched, file = "data/all_calibs_93_matched.RData")
# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
tol_biggest_chronograms <- drake_plan{
  # tol_otol = get_otol_synthetic_tree(input = tol_dq)
  # tol_otol = get_otol_synthetic_tree(ott_ids = opentree_chronograms$trees[[biggest]]$ott_ids),
  tol_biggest_bladj_calibs93_mean = use_calibrations_bladj(phy = tol_biggest,
    calibrations = all_calibs_93_matched, type = "mean", match_calibrations = FALSE),
    # tol_biggest_bladj_calibs93_mean <- new.phy
    # this takes about 30 in to run
  plot2 = plot_ltt_phyloall(taxon = "Biggest calibs93", phy = tol_biggest_bladj_calibs93_mean, ltt_colors = "#ff00ff", tax_datedotol = NULL,
    file_name = "_lttplot.pdf", file_dir = getwd(), height = 3.5, width = 7, add_legend = FALSE,
    add_title = TRUE, title_text = " BLADJ chronogram ")
  # plot1y = plot_ltt_phyloall(taxon = "Biggest", phy = tb, ltt_colors = "#ff0000", tax_datedotol = NULL,
  #   file_name = "_lttplot_logy.pdf", file_dir = getwd(), height = 3.5, width = 7, add_legend = FALSE,
  #   add_title = TRUE, title_text = " chronogram in datelife database", log = "y") # Error in plot.window(...) : Logarithmic axis must have positive limits
  tol_biggest_bladj_calibsminus93_mean = use_calibrations(phy = tol_biggest, calibrations = all_calibs_minus93,
    dating_method = "bladj", type = "mean")
}
# usethis::use_data(tol_biggest_bladj_calibs93_mean)
save(tol_biggest_bladj_calibs93_mean, file = "data/tol_biggest_bladj_calibs93_mean.RData")

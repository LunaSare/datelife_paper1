# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
tol_topologies <- drake_plan(
  biggest = which.max(unname(ape::Ntip(opentree_chronograms$trees))),
  tol_biggest = opentree_chronograms$trees[[biggest]], #tol_biggest$node.label
  plot_biggest = plot_ltt_phyloall(taxon = "Biggest", phy = tol_biggest, ltt_colors = "#ff0000", tax_datedotol = NULL,
    file_name = "_lttplot.pdf", file_dir = getwd(), height = 3.5, width = 7, add_legend = FALSE,
    add_title = TRUE, title_text = " chronogram in datelife database"),
  # tol_otol_biggest = get_otol_synthetic_tree(input = tol_dq)
  # tol_otol_biggest = get_otol_synthetic_tree(ott_ids = opentree_chronograms$trees[[biggest]]$ott_ids),
  # tol_otol_fam =
  tol_jetz1 = opentree_chronograms$trees[grepl("jetz", tolower(names(opentree_chronograms$trees)))][1],
  tol_jetz2 = opentree_chronograms$trees[grepl("jetz", tolower(names(opentree_chronograms$trees)))][2],
  plot_jetz1 = plot_ltt_phyloall(taxon = "Jetz chronogram 1", phy = tol_jetz1,
    ltt_colors = "#ff0000", tax_datedotol = NULL, file_name = "_lttplot.pdf",
    file_dir = getwd(), height = 3.5, width = 7, add_legend = FALSE,
    add_title = TRUE, title_text = " chronogram in datelife database"),
  plot_jetz2 = plot_ltt_phyloall(taxon = "Jetz chronogram 2", phy = tol_jetz2,
    ltt_colors = "#ff0000", tax_datedotol = NULL, file_name = "_lttplot.pdf",
    file_dir = getwd(), height = 3.5, width = 7, add_legend = FALSE,
    add_title = TRUE, title_text = " chronogram in datelife database")
)
make(tol_topologies)

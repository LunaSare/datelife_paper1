library(datelife)
library(drake)
frin_plan <- drake_plan(
  strings_in_dots = "literals",
  dq = make_datelife_query(input = "fringillidae", get_spp_from_taxon = TRUE),
  dr = get_datelife_result(input = dq),
  summ = get_taxon_summary(datelife_query = dq, datelife_result = dr),
  phyloall = summarize_datelife_result(datelife_query = dq,
    datelife_result = dr, summary_format = "phylo_all",
    taxon_summary = "none"),
  cb_cols1 = c("#0072B2", "#D55E00", "#440154FF", "#CC79A7", "#440154FF", "#009E73",
    "#9ad0f3", "#95D840FF", "#F0E442"),
  cb_cols2 = c("#440154FF", "#009E73", "#e79f00", "#9ad0f3", "#0072B2", "#D55E00",
    "#CC79A7", "#F0E442", "#95D840FF"),
  ltt_plot = plot_ltt_phyloall(taxon = "Fringillidae", phy = phyloall, ltt_colors = cb_cols1, tax_datedotol = NULL,
      file_name = "ltt_plot_poster.pdf", file_dir = getwd(), height = 3, width = 7.9, add_legend = FALSE, add_title = FALSE),
  datedotol = get_dated_otol_induced_subtree(input = dq, ott_ids = dq$ott_ids),
  bestgrove = get_best_grove(datelife_result = dr),
  sdm_matrix = get_sdm_matrix(datelife_result = bestgrove$best_grove),
  median_matrix = datelife_result_median_matrix(datelife_result = bestgrove$best_grove),
  otol = get_otol_synthetic_tree(input = dq),
  phy_sdm = summary_matrix_to_phylo_all(summ_matrix = sdm_matrix, target_tree = otol),
  phy_median = summary_matrix_to_phylo_all(summ_matrix = median_matrix, target_tree = otol),
  ltt_summ = plot_ltt_summary(taxon = "Fringillidae", phy = phyloall, phy_sdm, phy_median,
        file_name = "ltt_summ_poster.pdf", file_dir = "~//Desktop//datelife_paper1//", height = 3, width = 7.9,
        add_legend = TRUE),
  each_calibrations = get_all_calibrations(phyloall, each = TRUE)
  # , # inactivating the following because having trouble with getting otol for some reason
  # it was only used for the poster figures anyways
  # sim_otol = use_each_calibration(phy = otol, calibrations = each_calibrations)$phy,
  # ltt_simotol = plot_ltt_phyloall(taxon = "Fringillidae", sim_otol, summ,
  #       add_title = FALSE, file_dir = getwd(), file_name = "_lttplot_simotol_poster.pdf",
  #       ltt_colors = cb_cols1, height = 3, width = 7.9)
)
make(frin_plan)

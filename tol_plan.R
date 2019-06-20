library(datelife)
library(drake)
tol_plan <- drake_plan(
  # class(opentree_chronograms$trees) <- "multiPhylo"
  strings_in_dots = "literals",
  biggest = which.max(unname(ape::Ntip(opentree_chronograms$trees))),
  # names(opentree_chronograms$trees[[biggest]])
  # names(opentree_chronograms$trees[biggest])  
  tol_dq = make_datelife_query(input = opentree_chronograms$trees[[biggest]]$tip.label, get_spp_from_taxon = FALSE),
  # tol_dr = get_datelife_result(input = tol_dq), # erroring, so tryCatch:
  all_dr = lapply(opentree_chronograms$trees, function(x) tryCatch(datelife:::phylo_to_patristic_matrix(x),
      error = function(e) NULL)), # biggest is the only one that error when going from phylo to patristic matrix.
  tol_summ = get_taxon_summary(datelife_query = tol_dq, datelife_result = all_dr),
  tol_otol = get_otol_synthetic_tree(ott_ids = opentree_chronograms$trees[[biggest]]$ott_ids),
  all_calibs = get_all_calibrations(opentree_chronograms$trees[-93], each = FALSE),
  tol_otol_sim = use_calibrations(phy = tol_otol, calibrations = all_calibs)
)
make(tol_plan)

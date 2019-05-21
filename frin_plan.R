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
  datedotol = get_dated_otol_induced_subtree(input = dq,
    ott_ids = dq$ott_ids),
  otol = get_otol_synthetic_tree(input = dq),
  bestgrove = get_best_grove(datelife_result = dr)
)
make(frin_plan)
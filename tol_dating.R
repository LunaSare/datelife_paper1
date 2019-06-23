# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
# @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
loadd(tol_jetz1)
tol_jetz_query <- drake_plan(
  tol_jetz_dq = make_datelife_query(input = tol_jetz1, get_spp_from_taxon = FALSE),
  tol_jetz_dr = get_datelife_result(input = tol_dq),
  tol_summ = get_taxon_summary(datelife_query = tol_dq, datelife_result = tol_dr),
  # for report table only:
  tol_dq = tol_jetz_dq,
  tol_dr = tol_jetz_dr,
  tol_summ = tol_jetz_summ,
  reportname = "Jetz_dr_table0",
  report = make_report("table0_pdf_template.Rmd", paste0("inst/docs/", reportname, ".md"), "try5"),
  table0_caption = "Jetz et al. 2012 source chronogram original studies information.",
  taxon = "Birds",
  table0_pdf = render_pdf(reportname, "inst/docs", "try5")
)
make(tol_jetz_query)

load("data/tol_jetz1.RData")
loadd(tol_dr)
loadd(tol_jetz2)
jetz_phylo_all <- vector(mode = "list", length = length(tol_dr))
is_jetz <- grepl("Jetz", names(tol_dr))
is_biggest <- which(grepl("Hedges", names(tol_dr)))
jetz_phylo_all[[which(is_jetz)[1]]] <- tol_jetz1[[1]]
jetz_phylo_all[[which(is_jetz)[2]]] <- tol_jetz2[[1]]

for(i in seq(jetz_phylo_all)[-is_biggest]){
  if(!is_jetz[i]){
    print(i)
    jetz_phylo_all[[i]] <- datelife::patristic_matrix_to_phylo(tol_dr[[i]])
  }
}
save(jetz_phylo_all, file = "data/jetz_phylo_all.RData")

# the step that takes a lot of time is going from patristic matrix to phylo
# then get all calibrations for each tree, in a loop, so we save the information
jetz_all_calibrations <- vector(mode = "list", length = length(tol_dr))
for(i in seq(jetz_all_calibrations)[-is_biggest]){
  if(!is_jetz[i]){
    print(i)
    jetz_all_calibrations[[i]] <- datelife::get_all_calibrations(jetz_phylo_all[[i]], each = TRUE)[[1]]
  }
}
jetz_all_calibrations[[which(is_jetz)[1]]] <- datelife::get_all_calibrations(tol_jetz1[[1]], each = TRUE)[[1]]
jetz_all_calibrations[[which(is_jetz)[2]]] <- datelife::get_all_calibrations(tol_jetz2[[1]], each = TRUE)[[1]]
# still need to get_all_calibrations from biggest but takes too much time, but later this week
# xx <- datelife::get_all_calibrations(tol_biggest, each = TRUE)
# we really need to find a way to go from patristic matrix to all_calibrations object
# loadd(all_calibs_93)
save(jetz_all_calibrations, file = "data/jetz_all_calibrations.RData")


# create one table of all Calibrations
# take out the empty lists that belong to jetz et al. and biggest:
jetz_all_calibs <- jetz_all_calibrations[sapply(jetz_all_calibrations, inherits, "data.frame")]
sum(sapply(jetz_all_calibs, nrow)) # 6267
jetz_all_calibs_one <- data.table::rbindlist(jetz_all_calibs)
nrow(jetz_all_calibs_one) # 6267
# finally match calibrations for each tree, also in a loop to save information
jetz_all_calibs_matched <- vector(mode = "list", length(jetz_all_calibs))
for (i in seq(jetz_all_calibs)){
  print(i)
  jetz_all_calibs_matched <- datelife::match_all_calibrations(phy = tol_jetz1[[1]],
    calibrations = jetz_all_calibs[[i]])$matched_calibrations
}
# It was super fast (without biggest, but actually have not tried it, but should be fast too)
# so we will put all matched calibrations together in another object:
jetz_all_calibs_one_matched <- datelife::match_all_calibrations(phy = tol_jetz1[[1]],
  calibrations = jetz_all_calibs_one)
save(jetz_all_calibs_one_matched, file = "data/jetz_all_calibs_one_matched.RData")
# then, use calibrations bladj with min and max to generate two chronograms
names(jetz_all_calibs_one_matched)
nrow(jetz_all_calibs_one_matched$matched_calibrations) # all nodes are calibrated
tol_jetz1_bladj_min = datelife::use_calibrations_bladj(phy = NULL, calibrations = jetz_all_calibs_one_matched,
  type = "min", match_calibrations = FALSE)
tol_jetz1_bladj_mean = datelife::use_calibrations_bladj(phy = NULL, calibrations = jetz_all_calibs_one_matched,
  type = "mean", match_calibrations = FALSE)
tol_jetz1_bladj_max = datelife::use_calibrations_bladj(phy = NULL, calibrations = jetz_all_calibs_one_matched,
  type = "max", match_calibrations = FALSE)

tol_jetz_chronograms <- drake_plan(
  tol_jetz1_bladj_calibs93_mean = use_calibrations_bladj(phy = NULL, calibrations = tol_matched_calibs93_jetz1,
    type = "mean", match_calibrations = FALSE),
  plot_jetz1 = plot_ltt_phyloall(taxon = "Jetz1 calibs93", phy = tol_jetz1_bladj_calibs93_mean, ltt_colors = "#ff0000", tax_datedotol = NULL,
    file_name = "_lttplot.pdf", file_dir = getwd(), height = 3.5, width = 7, add_legend = FALSE,
    add_title = TRUE, title_text = " BLADJ chronogram")
)
make(tol_jetz_chronograms)

# run rates analysis and plot
tip_fams <- tol_jetz1[[1]]$jetz2012_family
tip_rich <- tol_jetz1[[1]]$jetz2012_richness
jetz_jetz2012_min_fam_age_and_rich <- get_clade_age_and_rich(phy = tol_jetz1_bladj_min,
  tip_clade = tip_fams, richness = tip_rich)
jetz2012_min_ms0 <- get_all_ms(phy = tol_jetz1_bladj_min, age_and_richness = jetz_jetz2012_min_fam_age_and_rich, epsilon = 0)

jetz_jetz2012_mean_fam_age_and_rich <- get_clade_age_and_rich(phy = tol_jetz1_bladj_mean,
  tip_clade = tip_fams, richness = tip_rich)
jetz2012_mean_ms0 <- get_all_ms(phy = tol_jetz1_bladj_mean, age_and_richness = jetz_jetz2012_mean_fam_age_and_rich, epsilon = 0)

jetz_jetz2012_max_fam_age_and_rich <- get_clade_age_and_rich(phy = tol_jetz1_bladj_max,
  tip_clade = tip_fams, richness = tip_rich)
jetz2012_max_ms0 <- get_all_ms(phy = tol_jetz1_bladj_max, age_and_richness = jetz_jetz2012_max_fam_age_and_rich, epsilon = 0)

# fig_workflow_cap <- paste("Stylized DateLife workflow. This shows the general worflows
#                           and analyses that can be performed with DateLife, via the R
#                           package or through the website. Details on the functions involved
#                           on each workflow are shown in datelife's R package vignette.")
download.file(url = "https://github.com/phylotastic/datelife/raw/b3532e70b679272093658731d249534e84e15e28/data-raw/benchmark/runtime_tests/2_tests/2_random_spp_names/mdq_plus_gdr_2018.05.29_fill.pdf",
              destfile = "./figures/fig_runtime1.pdf", mode="wb")
# fig_runtime1_cap <- "Computation time of input processing and search across `DateLife`s
#   chronogram database"
download.file(url = "https://github.com/LunaSare/datelife_examples/raw/master/docs/plots/Fringillidae_LTTplot_phyloall.pdf",
              destfile = "./figures/fig_schronograms1.pdf", mode="wb")
# fig_schronograms_cap <- "Lineage through time (LTT) plots of source chronograms containing
#   all or a subset of species from the bird family Fringillidae of true finches. Arrows indicate maximum age of each chronogram. Numbers
#   indicate chrinograms' original publication: 1) [@barker2012going], 2) [@barker2015new], 3) [@burns2014phylogenetics],
#   4) [@claramunt2015new], 5) [@gibb2015new], 6) [@Hedges2015], 7) [@hooper2017chromosomal],
#   8) [@Jetz2012], 9) [@price2014niche]"

download.file(url = "https://github.com/LunaSare/datelife_examples/raw/master/docs/plots/Fringillidae_LTTplot_summary_chronograms2.pdf",
              destfile = "./figures/fig_summaries.pdf", mode="wb")
download.file(url = "https://github.com/LunaSare/datelife_examples/raw/master/docs/plots/Fringillidae_LTTplot_crossval_bladj.pdf",
              destfile = "./figures/fig_crossval_bladj.pdf", mode="wb")
download.file(url = "https://github.com/LunaSare/datelife_examples/raw/master/docs/plots/Fringillidae_lttplot_crossval_pathd8_summ1.pdf",
              destfile = "./figures/fig_crossval_boldsumm.pdf", mode="wb")
download.file(url = "https://github.com/LunaSare/datelife_examples/raw/master/docs/plots/Fringillidae_LTTplot_clusters_both.pdf",
              destfile = "./figures/fig_lttplot_clusters.pdf", mode="wb")

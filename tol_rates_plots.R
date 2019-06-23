ms <- jetz_ms0
ms <- jetz2012_ms0
ms <- jetz2012_min_ms0
ms <- jetz2012_mean_ms0
ms <- jetz2012_max_ms0
plot_ms <- function(ms, file_name = NULL, height = 3.5, width = 5){
  ii <- !is.na(ms$crown$crown.p)
  cc <- ms$crown$richness[ii] < ms$crown$lb_global[ii] | ms$crown$richness[ii] > ms$crown$ub_global[ii]

  plot(x = ms$crown$crown_age[ii], y = ms$crown$richness[ii], xlab = "Crown age (MYA)",
  ylab = "log(species number)", col = ifelse(cc, "orchid", "gray") )
  lines(x = sort(ms$crown$crown_age[ii]), y = ms$crown$lb_global[ii][order(ms$crown$crown_age[ii])], type = "l", col = "grey")
  lines(x = sort(ms$crown$crown_age[ii]), y = ms$crown$ub_global[ii][order(ms$crown$crown_age[ii])], type = "l", col = "grey")

  hist(ms$crown$crown.p)
}

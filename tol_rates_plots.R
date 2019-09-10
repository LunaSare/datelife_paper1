ms <- jetz_ms0
ms <- jetz2012_ms0
ms <- jetz2012_min_ms0
ms <- jetz2012_mean_ms0
ms <- jetz2012_max_ms0
rm(ms)
plot_ms <- function(ms, file_dir = NULL, file_name = NULL, height = 3.5, width = 5,
  write_pdf = TRUE, ylab = "Species N", pch = 19, col_significant = NULL, ...){
  if(!inherits(file_dir, "character")){
    file_dir <- getwd()
  }
  if(!inherits(file_name, "character")){
    file_name <- "_ms_plot"
  }
  file_out <- paste0(file_dir, "//", file_name)
  message(file_out)
  if(write_pdf){
    grDevices::pdf(file = paste0(file_out, "_crown.pdf"), height = height, width = width)
    graphics::par(mai = c(1.02, 0.82, 0.2, 0.2))
  }
  ii <- !is.na(ms$crown$crown.p)
  cc <- ms$crown$richness[ii] < ms$crown$lb_global[ii] | ms$crown$richness[ii] > ms$crown$ub_global[ii]
  plot(x = ms$crown$crown_age[ii], y = ms$crown$richness[ii], xlab = "Crown age (MYA)",
    ylab = ylab, col = ifelse(cc, paste0(col_significant, "80"), "#80808080"), pch = pch)
  lines(x = sort(ms$crown$crown_age[ii]), y = ms$crown$lb_global[ii][order(ms$crown$crown_age[ii])],
    type = "l", col = "grey", ...)
  lines(x = sort(ms$crown$crown_age[ii]), y = ms$crown$ub_global[ii][order(ms$crown$crown_age[ii])],
    type = "l", col = "grey", ...)
  text(labels = paste("n =", sum(ms$crown$richness[ii] > ms$crown$ub_global[ii])), cex = 0.8,
    x = 0.07*max(ms$crown$crown_age, na.rm = TRUE), y = 0.9*max(ms$stem$richness, na.rm = TRUE), adj = 0)
  text(labels = paste("n =", sum(ms$crown$richness[ii] < ms$crown$lb_global[ii])), cex = 0.8,
    x = 0.99*max(ms$crown$crown_age, na.rm = TRUE), y = 0.1*max(ms$stem$richness, na.rm = TRUE), adj = 1)
  if(write_pdf){
    dev.off()
  }
  if(write_pdf){
    grDevices::pdf(file = paste0(file_out, "_stem.pdf"), height = height, width = width)
    graphics::par(mai = c(1.02, 0.82, 0.2, 0.2))
  }
  ii <- !is.na(ms$stem$stem.p)
  cc <- ms$stem$richness[ii] < ms$stem$lb_global[ii] | ms$stem$richness[ii] > ms$stem$ub_global[ii]
  plot(x = ms$stem$stem_age[ii], y = ms$stem$richness[ii], xlab = "Stem age (MYA)",
    ylab = ylab, col = ifelse(cc, paste0(col_significant, "80"), "#80808080"), pch = pch)
  lines(x = sort(ms$stem$stem_age[ii]), y = ms$stem$lb_global[ii][order(ms$stem$stem_age[ii])],
    type = "l", col = "grey", ...)
  lines(x = sort(ms$stem$stem_age[ii]), y = ms$stem$ub_global[ii][order(ms$stem$stem_age[ii])],
    type = "l", col = "grey", ...)
    text(labels = paste("n =", sum(ms$stem$richness[ii] > ms$stem$ub_global[ii])), cex = 0.8,
      x = 0.07*max(ms$stem$stem_age, na.rm = TRUE), y = 0.9*max(ms$stem$richness, na.rm = TRUE), adj = 0)
    text(labels = paste("n =", sum(ms$stem$richness[ii] < ms$stem$lb_global[ii])), cex = 0.8,
    x = 0.99*max(ms$stem$stem_age, na.rm = TRUE), y = 0.1*max(ms$stem$richness, na.rm = TRUE), adj = 1)
  if(write_pdf){
    dev.off()
  }
  # hist(ms$crown$crown.p)
}
plot_ms(ms = jetz2012_min_ms0, file_name = "jetz2012_fams_ms0_min", col_significant = "#DA70D6")
plot_ms(ms = jetz2012_mean_ms0, file_name = "jetz2012_fams_ms0_mean", col_significant = "#DA70D6")
plot_ms(ms = jetz2012_max_ms0, file_name = "jetz2012_fams_ms0_max", col_significant = "#DA70D6")
plot_ms(ms = jetz2012_ms0, file_name = "jetz2012_fams_ms0_original", col_significant = "#00BFFF", pch = 17)
significantly_rich_crown <- function(ms){
  ii <- !is.na(ms$crown$crown.p)
  row.names(ms$crown)[ms$crown$richness[ii] > ms$crown$ub_global[ii]]
}
significantly_poor_crown <- function(ms){
  ii <- !is.na(ms$crown$crown.p)
  row.names(ms$crown)[ms$crown$richness[ii] < ms$crown$lb_global[ii]]
}
significantly_rich_stem <- function(ms){
  ii <- !is.na(ms$stem$stem.p)
  row.names(ms$crown)[ms$stem$richness[ii] > ms$stem$ub_global[ii]]
}
significantly_poor_stem <- function(ms){
  ii <- !is.na(ms$stem$stem.p)
  row.names(ms$stem)[ms$stem$richness[ii] < ms$stem$lb_global[ii]]
}
in_mean <- significantly_rich_crown(ms = jetz2012_min_ms0) %in% significantly_rich_crown(ms = jetz2012_mean_ms0)
significantly_rich_crown(ms = jetz2012_min_ms0)[!in_mean]

in_mean <- significantly_rich_crown(ms = jetz2012_max_ms0) %in% significantly_rich_crown(ms = jetz2012_mean_ms0)
significantly_rich_crown(ms = jetz2012_min_ms0)[!in_mean]

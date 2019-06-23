# hypothetical example
# phy <- tol_jetz1[[1]]
# age_and_richness <- jetz_fam_ages_and_richness
get_all_ms <- function(phy, age_and_richness, epsilon = 0){
  globalr = geiger::bd.ms(phy= NULL, time = max(ape::branching.times(phy)), n = sum(age_and_richness$richness), missing = 0, crown=TRUE, epsilon = epsilon)
# c is for crown, global is for global rate, clade is for clade rate, ll is for limits
    cp <-  geiger::crown.p(phy=NULL, time = age_and_richness$crown_age, n = age_and_richness$richness,
      r = globalr, epsilon = epsilon)
    cbd <- geiger::bd.ms(phy=NULL, time = age_and_richness$crown_age, n = age_and_richness$richness,
      missing = 0, crown = TRUE, epsilon = epsilon)

    cglobalr_ll <- lapply(age_and_richness$crown_age, function(x) tryCatch(
      as.data.frame(geiger::crown.limits(time = x, r = globalr, epsilon, CI=0.95)),
      error = function(e) data.frame(lb = NA, ub = NA)))
    cglobalr_ll <- data.table::rbindlist(cglobalr_ll)

    cclader_ll <- lapply(seq(age_and_richness$crown_age), function(i) tryCatch(
      as.data.frame(geiger::crown.limits(time = age_and_richness$crown_age[i], r = cbd[i], epsilon, CI=0.95)),
      error = function(e) data.frame(lb = NA, ub = NA)))
    cclader_ll <- data.table::rbindlist(cclader_ll)

    all_crown <- data.frame(crown.p = cp, bd.ms = cbd, cglobalr_ll, cclader_ll, age_and_richness$crown_age, age_and_richness$richness)
    names(all_crown) <- c("crown.p", "bd.ms", "lb_global", "ub_global", "lb_clade", "ub_clade", "crown_age", "richness")
    row.names(all_crown) <- row.names(age_and_richness)

    sp <-  geiger::stem.p(phy=NULL, time = age_and_richness$stem_age, n = age_and_richness$richness,
      r = globalr, epsilon = epsilon)
    sbd <- geiger::bd.ms(phy=NULL, time = age_and_richness$stem_age, n = age_and_richness$richness,
      missing = 0, crown = TRUE, epsilon = epsilon)

    sglobalr_ll <- lapply(age_and_richness$stem_age, function(x) tryCatch(
      as.data.frame(geiger::stem.limits(time = x, r = globalr, epsilon, CI=0.95)),
      error = function(e) data.frame(lb = NA, ub = NA)))
    sglobalr_ll <- data.table::rbindlist(sglobalr_ll)

    sclader_ll <- lapply(seq(age_and_richness$stem_age), function(i) tryCatch(
      as.data.frame(geiger::stem.limits(time = age_and_richness$stem_age[i], r = cbd[i], epsilon, CI=0.95)),
      error = function(e) data.frame(lb = NA, ub = NA)))
    sclader_ll <- data.table::rbindlist(sclader_ll)

    all_stem <- data.frame(stem.p = sp, bd.ms = sbd, sglobalr_ll, sclader_ll, age_and_richness$stem_age, age_and_richness$richness)
    names(all_stem) <- c("stem.p", "bd.ms", "lb_global", "ub_global", "lb_clade", "ub_clade", "stem_age", "richness")
    row.names(all_stem) <- row.names(age_and_richness)

    return(list(crown = all_crown, stem = all_stem))
}


jetz_ms0 <- get_all_ms(phy = tol_jetz1[[1]], age_and_richness = jetz_fam_ages_and_richness, epsilon = 0)
jetz2012_ms0 <- get_all_ms(phy = tol_jetz1[[1]], age_and_richness = jetz_jetz2012fam_age_and_rich, epsilon = 0)

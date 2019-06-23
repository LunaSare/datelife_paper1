# GET OTT IDS FOR JETZ ET AL TREE
load("data/new.tree_tnrs.RData")
names(new.tree_tnrs)
nrow(new.tree_tnrs)
loadd(tol_jetz1)
head(new.tree_tnrs)
head(tol_jetz1[[1]]$tip.label)
mm_unique <- match(tol_jetz1[[1]]$tip.label, new.tree_tnrs$unique) # position of tip labels in unique
mm_search <- match(tolower(gsub(" ", "_", tol_jetz1[[1]]$tip.label)), new.tree_tnrs$search)
sum(is.na(mm_unique)) # 387
sum(is.na(mm_search))# 436, mm_unique and mm_search match different bird tip labels
# make a vector of indices of matching tip labels with tnrs table:
jetz_ott_ids_ii <- rep(0, length(tol_jetz1[[1]]$tip.label))
jetz_ott_ids_ii[!is.na(mm_unique)] <- mm_unique[!is.na(mm_unique)]
sum(jetz_ott_ids_ii == 0) # 387, ok
# those that are not in unique but are on search
# are the ones that have a different name in ott taxonomy
ii <- jetz_ott_ids_ii ==0 & !is.na(mm_search)
sum(ii) # 114
jetz_ott_ids_ii[ii] <- mm_search[ii]
sum(jetz_ott_ids_ii == 0) # 273, these are the ones that are not in search nor unique, so search!
ss <- data.frame(jetz = tol_jetz1[[1]]$tip.label[ii],
  search = new.tree_tnrs$search[mm_search[ii]])
  new.tree_tnrs[mm_search[ii],]
dd <- data.frame(jetz = tol_jetz1[[1]]$tip.label[jetz_ott_ids_ii != 0], search = new.tree_tnrs$search[jetz_ott_ids_ii], unique = new.tree_tnrs$unique[jetz_ott_ids_ii])

jetz_ott_ids <- rep(NA, length(tol_jetz1[[1]]$tip.label))
jetz_ott_ids[jetz_ott_ids_ii != 0] <- new.tree_tnrs$ott_id[jetz_ott_ids_ii]
tol_jetz1[[1]]$ott_ids <- as.numeric(jetz_ott_ids)
new_search <- tol_jetz1[[1]]$tip.label[is.na(tol_jetz1[[1]]$ott_ids)]
jetz_new_search_tnrs <- tnrs_match(input = new_search) # tnrs of species in jetz that are not in biggest
jetz_new_search_tnrs$search[is.na(jetz_new_search_tnrs$ott_id)] <- new_search[is.na(jetz_new_search_tnrs$ott_id)]
save(jetz_new_search_tnrs, file = "~/Desktop/datelife_paper1/data/jetz_new_search_tnrs.RData")
tol_jetz1[[1]]$ott_ids[is.na(tol_jetz1[[1]]$ott_ids)] <- as.numeric(new_search_tnrs$ott_id)
# the ones that definitely do not match ot taxonomy:
tol_jetz1[[1]]$tip.label[is.na(tol_jetz1[[1]]$ott_ids)]
jetz_new_search_tnrs[is.na(jetz_new_search_tnrs$ott_id),]
tnrs_match(new_search[is.na(jetz_new_search_tnrs$ott_id)]) # yep, definitely no match.
save(tol_jetz1, file = "~/Desktop/datelife_paper1/data/tol_jetz1.RData")

load("data/tol_jetz1.RData")

tol_jetz1[[1]]$ott_id
which(is.na(tol_jetz1[[1]]$ott_id)) # 17 spp.
# get ott Families
jetz_ff <- get_ott_clade(ott_ids = tol_jetz1[[1]]$ott_id, ott_rank = "family")
save(jetz_ff, file = "~/Desktop/datelife_paper1/data/jetz_ff.RData")
length(ff$input) == length(tol_jetz1[[1]]$tip.label)
ff$input[is.na(ff$family)] # tip labels that did not match a family (there are 78)
# plus the 17 spp that are not in ott gives a total of 95 tips with no family data
# these will appear as NA in the family vector:
tol_jetz1[[1]]$ott_family <- ff$family[match(tol_jetz1[[1]]$ott_id, ff$input)]
save(tol_jetz1, file = "~/Desktop/datelife_paper1/data/tol_jetz1.RData")

# get jetz study Families
tt <- read.csv("data-raw/nature11631-s2/2012-03-04206D-master_taxonomy.csv")
nrow(tt)
new.tree <- rotl::get_study_tree(study_id= "ot_809",tree_id="tree1",
								tip_label="original_label", deduplicate = TRUE)
tol_jetz1[[1]]$original.tip.label <- new.tree$tip.label # they are in the same order, I checked it with match
save(tol_jetz1, file = "~/Desktop/datelife_paper1/data/tol_jetz1.RData")

head(tt)
mm <- match(tol_jetz1[[1]]$original.tip.label, as.character(tt$TipLabel))
tol_jetz1[[1]]$jetz2012_family <- as.character(tt$BLFamilyLatin[mm])
richness <- sapply(unique(as.character(tol_jetz1[[1]]$jetz2012_family)),
  function(x) sum(as.character(tt$BLFamilyLatin) %in% x))
mm <- match(tol_jetz1[[1]]$jetz2012_family, names(richness))
tol_jetz1[[1]]$jetz2012_richness <- richness[mm]
tail(data.frame(fam = tol_jetz1[[1]]$jetz2012_family, rich = tol_jetz1[[1]]$jetz2012_richness))
save(tol_jetz1, file = "~/Desktop/datelife_paper1/data/tol_jetz1.RData")

# once with the families, get the crown and stem ages of each Family:
get_clade_nodes <- function(phy, tips, clade_name = NULL){
  tips <- tips[!is.na(tips)]
  if(length(tips) ==1){
    cn <- NA
    sn <- phy$edge[phy$edge[,2] == match(tips, phy$tip.label),1]
  }
  if(length(tips) > 1){
    cn <- phytools::findMRCA(tree = phy, type = "node", tips = tips)
    sn <- phytools::getParent(tree = phy, node = cn)
  }
  res <- data.frame(crown_node = cn, stem_node = sn)
  if(inherits(clade_name, "character")){
    row.names(res) <- clade_name
  }
  return(res)
}
get_clade_nodes.list <- function(phy, tips_list){
  fn <- lapply(seq(tips_list), function(i) get_clade_nodes(phy = phy,
    tips = tips_list[[i]], clade_name = NULL))
  fn <- data.table::rbindlist(fn)
  if(inherits(names(tips_list), "character")){
    attributes(fn)$row.names <- names(tips_list)
  }
  return(fn)
}
get_node_ages <- function(phy, clade_nodes, clade_name = NULL){
  # ca <- ape::branching.times(phy)[as.character(clade_nodes$crown_node)] # same as the next one, but less safe
  ca <- ape::branching.times(phy)[clade_nodes$crown_node - ape::Ntip(phy)]
  sa <- ape::branching.times(phy)[clade_nodes$stem_node - ape::Ntip(phy)]
  res <- data.frame(crown_age = ca, stem_age = sa)
  if(inherits(row.names(clade_nodes), "character")){
    row.names(res) <- row.names(clade_nodes)
  }
  return(res)
}

get_clade_age_and_rich <- function(phy, tip_clade, richness = NULL){
  clade <- unique(tip_clade)
  clade <- clade[!is.na(clade)]
  clade_tips <- lapply(clade, function(x) phy$tip.label[tip_clade %in% x])
  names(clade_tips) <- clade
  clade_nodes <- get_clade_nodes.list(phy = phy, tips_list = clade_tips)
  clade_ages <- get_node_ages(phy = phy, clade_nodes = clade_nodes)
  if(inherits(richness, "numeric") | inherits(richness, "integer")){
    clade_ages$richness <- richness[match(row.names(clade_ages), names(richness))]
  } else {
    clade_ages$richness <- sapply(clade_tips, length)
  }
  return(clade_ages)
}

fams <- unique(tol_jetz1[[1]]$ott_family)
fams <- fams[!is.na(fams)]
# just to check:
# all(sapply(fams, function(x) sum(tol_jetz1[[1]]$ott_family %in% x)) == sapply(fam_tips, length))
sum(sapply(fam_tips, length))
fam_tips <- sapply(fams, function(x) tol_jetz1[[1]]$tip.label[tol_jetz1[[1]]$ott_family %in% x])
names(fam_tips) <- names(tol_jetz1[[1]]$ott_family)[match(fams, tol_jetz1[[1]]$ott_family)] # because it is ott ids
fam_nodes <- get_clade_nodes.list(phy = tol_jetz1[[1]], tips_list = fam_tips)
fam_ages <- get_node_ages(phy = tol_jetz1[[1]], clade_nodes = fam_nodes)
fam_ages_and_richness <- fam_ages
fam_ages_and_richness$richness <- sapply(fam_tips, length)
jetz_fam_ages_and_richness <- fam_ages_and_richness
save(fam_ages_and_richness, file = "data/fam_ages_and_richness.RData")

jetz_jetz2012fam_age_and_rich <- get_clade_age_and_rich(phy = tol_jetz1[[1]],
  tip_clade = tol_jetz1[[1]]$jetz2012_family, richness = tol_jetz1[[1]]$jetz2012_richness)
save(jetz_jetz2012fam_age_and_rich, file = "data/jetz_jetz2012fam_age_and_rich.RData")

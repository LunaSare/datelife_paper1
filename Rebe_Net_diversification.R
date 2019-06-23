##Estimación de tasas de diversificación con el método de momentos usando las ecuaciones de 
##Magallón y Sanderson 2001 aplicado al árbol fechado FBD80 de Malvales.
install.packages("geiger")
require ("geiger")
getwd()
##################################################
#2 de febrero de 2018
#corregí las edades de cada grupo
#voy a obtener la diversificación neta con el método de 
#momentos.
#las edades son del árbol FBD80_v4_comb.treeanot.tree
data<-read.csv("CrownAges_species_richness.csv")
data
class(data)
##diversificación neta con el comando bd.ms
#nombre del taxón_r(diversificación neta)_epsilon_c(crown)/s(stem)
malvoi_r_001_c<-bd.ms(time=data$time[1], n=data$sp[1], epsilon=0.01)
malvoi_r_001_c
#voy a tratar de hacer este cálculo para cada familia y subfamilia con un
#loop:
#Primero voy a crear un objeto en el que se deben imprimir los resultados
#del loop
net_div<-0
net_div
#loop
for(i in 1:19){
  net_div[i] <- bd.ms(time=data$time[i], n=data$sp[i],epsilon=0.01)
  print(net_div[i])
}

print(i)
net_div
data_net_div<-data.frame(data$taxon, net_div)
data_net_div
#Hecho
###############################################################################
#Ahora voy a calcular r (diversificación neta) con el valor de turnoverFBD
#que estimó el modelo: 0.9195
net_div_0.91<-0
for(i in 1:19){
	net_div_0.91[i]<-bd.ms(time=data$time[i], n=data$sp[i],epsilon=0.9195)
	print (net_div_0.91[i])
}
net_div_e0.91<-data.frame(data$taxon, net_div_0.91)
net_div_e0.91
colnames(net_div_e0.91)<- c("taxon", "crown_e0.91")
##############################################################################
#Ahora voy a estimar la diversificación neta con la edad troncal
stem<-read.csv("StemAges_species_richness.csv")
stem
stem_div_0.01<-0
#Epsilon 0.01
for(i in 1:19){
	stem_div_0.01[i]<-bd.ms(time=stem$time[i], n=stem$sp[i], epsilon=0.01)
	print(stem_div_0.01[i])
}
stem_div_0.01
stem
stem_div<-data.frame(stem$taxon, stem_div_0.01)
stem_div
#epsilon 0.9
stem_div_0.9<-0
stem_div[,3]<-stem_div_0.9
stem_div
for(i in 1:19){
	stem_div[,3][i]<-bd.ms(time=stem$time[i], n=stem$sp[i], epsilon=0.9)
	print(stem_div[,3][i])
}	
stem_div
colnames(stem_div)<-c("taxon", "e0.01", "e0.9")
stem_div
crown_div<-data_net_div
crown_div
write.csv(stem_div, file="Stem_net_div.csv")
write.csv(crown_div, file="Crown_net_div.csv")
###########################################################################
#Ahora voy a calcular la tasa de diversificación neta con la edad troncal
#y el valor de epsilon será el estimado por el modelo de FBD: 0.9195
stem<-read.csv("StemAges_species_richness.csv")
stem
stem_div_0.91<-0
for (i in 1:19){
	stem_div_0.91[i]<-bd.ms(time=stem$time[i], n=stem$sp[i], epsilon=0.9195)
	print(stem_div_0.91[i])
}
net_div_stem_e0.91<-data.frame(stem$taxon, stem_div_0.91)
net_div_stem_e0.91
colnames(net_div_stem_e0.91)<- c("taxon", "stem_e0.91")
###########################################################################
write.csv(net_div_e0.91, file="Crown_r_e0.91.csv")
write.csv(net_div_stem_e0.91, file="Stem_r_e0.91.csv")
###########################################################################
###17.3.18
###Voy a calcular la tasa de diversificación neta con el método de momentos pero ahora
#con las edades estimadas de ND (ND14)
#Crown age
#epsilon=0.01
nd_crown_data<-read.csv("ND_crownages_richness.csv")
nd_crown_data
nd_crown_div_0.01<-0
for (i in 1:19){
  nd_crown_div_0.01[i]<-bd.ms(time=nd_crown_data$time[i], n=nd_crown_data$sp[i], epsilon=0.01)
  print(nd_crown_div_0.01[i])
}
div_nd_crown_0.01<-data.frame(nd_crown_data$taxon, nd_crown_div_0.01)
div_nd_crown_0.01
colnames(div_nd_crown_0.01)<-c("taxon", "e=0.01")
#epsilon=0.5
nd_crown_div_0.5<-0
for (i in 1:19){
  nd_crown_div_0.5[i]<-bd.ms(time=nd_crown_data$time[i], n=nd_crown_data$sp[i], epsilon=0.5)
  print(nd_crown_div_0.5[i])
}
#voy a agregar los valores de e=0.5 en el data.frame que ya había hecho
div_nd_crown_0.01[["e=0.5"]] <-nd_crown_div_0.5
div_nd_crown_0.01
#ahora lo voy a renombrar
nd_div_crown<-div_nd_crown_0.01
nd_div_crown
#epsilon=0.9
nd_crown_div_0.9<-0
for(i in 1:19){
  nd_crown_div_0.9[i]<-bd.ms(time=nd_crown_data$time[i], n=nd_crown_data$sp[i], epsilon=0.9)
  print(nd_crown_div_0.9[i])
}
nd_div_crown[["e=0.9"]]<-nd_crown_div_0.9
nd_div_crown
plot(nd_div_crown)
#stem ages
#epsilon=0.01
nd_stem_data<-read.csv("ND_stemages_richness.csv")
nd_stem_data
nd_stem_0.01<-0
for(i in 1:19){
  nd_stem_0.01[i]<-bd.ms(time=nd_stem_data$time[i], n=nd_stem_data$sp[i], epsilon=0.01)
  print(nd_stem_0.01[i])
}
nd_div_stem<-data.frame(nd_stem_data$taxon, nd_stem_0.01)
nd_div_stem
colnames(nd_div_stem)<-c("taxon", "e=0.01")
#epsilon=0.5
nd_stem_0.5<-0
for(i in 1:19){
  nd_stem_0.5[i]<-bd.ms(time=nd_stem_data$time[i], n=nd_stem_data$sp[i], epsilon=0.5)
  print(nd_stem_0.5[i])
}
nd_div_stem[["e=0.5"]]<-nd_stem_0.5
#epsilon=0.9
nd_stem_0.9<-0
for(i in 1:19){
  nd_stem_0.9[i]<-bd.ms(time=nd_stem_data$time[i], n=nd_stem_data$sp[i], epsilon=0.9)
  print(nd_stem_0.9[i])
}
nd_div_stem[["e=0.9"]]<-nd_stem_0.9
nd_div_stem
#exportar a archivos .csv
write.csv(nd_div_crown, file="ND_div_crown.csv")
write.csv(nd_div_stem, file="ND_div_stem.csv")

#######################################################################
#30.1.19
#Prueba para incluir el intervalo de confianza y probar la diversidad dada la tasa estimada
#y la edad (ver Magallón & Sanderson 1999 y el manual de geiger).
#las edades son del árbol FBD80_v4_comb.treeanot.tree
#Voy a obtener los valores de la diversidad dada la tasa de diversificaicón neta y la edad:

crown_fbd<-read.csv("CrownAges_species_richness.csv")
stem_fbd<-read.csv("StemAges_species_richness.csv")

#Prueba de diversidad: crown.p/stem.p (phy=NULL, time, n, r, epsilon)
#Intervalo de confianza: crown.limits/stem.limits (time, r, epsilon, CI=0.95)

#Datos de diversificación:
div_crown_fbd<-read.csv("Crown_r_e0.91.csv")
div_stem_fbd<-read.csv("Stem_r_e0.91.csv")

#instrucción:
malvoideae_diversidad<-crown.p(time=crown_fbd$time[1], n=crown_fbd$sp[1], r=div_crown_fbd$crown_e0.91[19], epsilon=0.9195)
malvoideae_diversidad
#[1] 0.09989179

#loop para sacar la probabilidad para cada familia y subfamilia.
#Primero voy a crear un objeto en el que se deben imprimir los resultados
#del loop
diversity_probs_crown<-0
diversity_probs_crown
#loop
for(i in 1:19){
  diversity_probs_crown[i] <- crown.p(time=crown_fbd$time[i], n=crown_fbd$sp[i], r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195)
  print(diversity_probs_crown[i])
}

print(i)
diversity_probs_crown
diversity_probs_crown_data<-data.frame(crown_fbd$taxon, diversity_probs_crown)
diversity_probs_crown_data

#para stem

diversity_probs_stem<-0

#loop
for(i in 1:19){
	diversity_probs_stem[i]<-stem.p(time=stem_fbd$time[i],n=stem_fbd$sp[i],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195)
	print(diversity_probs_stem[i])
}

print(i)
diversity_probs_stem
diversity_probs_stem_data<-data.frame(stem_fbd$taxon,diversity_probs_stem)
diversity_probs_stem_data


#####
#Intervalo de confianza
#Instrucción:
malvoideae_interval<-crown.limits(time=crown_fbd$time[1],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195, CI=0.95)
malvoideae_interval
#            lb       ub
#71.13 54.85692 7823.027

bomb_interval<-crown.limits(time=crown_fbd$time[2],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
bomb_interval

ster_interval<-crown.limits(time=crown_fbd$time[3],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
til_interval<-crown.limits(time=crown_fbd$time[4],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
dom_interval<-crown.limits(time=crown_fbd$time[5],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
bro_interval<-crown.limits(time=crown_fbd$time[6],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
hel_interval<-crown.limits(time=crown_fbd$time[7],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
gre_interval<-crown.limits(time=crown_fbd$time[8],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
byt_interval<-crown.limits(time=crown_fbd$time[9],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
mal_interval<-crown.limits(time=crown_fbd$time[10],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
dip_interval<-crown.limits(time=crown_fbd$time[11],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
sar_interval<-crown.limits(time=crown_fbd$time[12],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
cis_interval<-crown.limits(time=crown_fbd$time[13],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
bix_interval<-crown.limits(time=crown_fbd$time[14],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
sph_interval<-crown.limits(time=crown_fbd$time[15],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
thy_interval<-crown.limits(time=crown_fbd$time[16],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
neu_interval<-crown.limits(time=crown_fbd$time[17],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
cyt_interval<-crown.limits(time=crown_fbd$time[18],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
malvales_interval<-crown.limits(time=crown_fbd$time[19],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)

lb_crown<-c(malvoideae_interval[1],bomb_interval[1],ster_interval[1],til_interval[1],
	dom_interval[1],bro_interval[1],hel_interval[1],gre_interval[1],
	byt_interval[1],mal_interval[1],dip_interval[1],sar_interval[1],
	cis_interval[1],bix_interval[1],sph_interval[1],thy_interval[1],
	neu_interval[1],cyt_interval[1],malvales_interval[1])
lb_crown

ub_crown<-c(malvoideae_interval[2],bomb_interval[2],ster_interval[2],til_interval[2],
	dom_interval[2],bro_interval[2],hel_interval[2],gre_interval[2],
	byt_interval[2],mal_interval[2],dip_interval[2],sar_interval[2],
	cis_interval[2],bix_interval[2],sph_interval[2],thy_interval[2],
	neu_interval[2],cyt_interval[2],malvales_interval[2])
ub_crown


intervals_crown<-data.frame(crown_fbd$taxon,lb_crown,ub_crown)
intervals_crown


#intervalos con la edad troncal

malvoideae_interval_stem<-stem.limits(time=stem_fbd$time[1],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
bomb_interval_stem<-stem.limits(time=stem_fbd$time[2],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
ster_interval_stem<-stem.limits(time=stem_fbd$time[3],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
til_interval_stem<-stem.limits(time=stem_fbd$time[4],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
dom_interval_stem<-stem.limits(time=stem_fbd$time[5],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
bro_interval_stem<-stem.limits(time=stem_fbd$time[6],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
hel_interval_stem<-stem.limits(time=stem_fbd$time[7],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
gre_interval_stem<-stem.limits(time=stem_fbd$time[8],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
byt_interval_stem<-stem.limits(time=stem_fbd$time[9],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
mal_interval_stem<-stem.limits(time=stem_fbd$time[10],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
mun_interval_stem<-stem.limits(time=stem_fbd$time[11],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
dip_interval_stem<-stem.limits(time=stem_fbd$time[12],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
sar_interval_stem<-stem.limits(time=stem_fbd$time[13],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
cis_interval_stem<-stem.limits(time=stem_fbd$time[14],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
bix_interval_stem<-stem.limits(time=stem_fbd$time[15],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
sph_interval_stem<-stem.limits(time=stem_fbd$time[16],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
thy_interval_stem<-stem.limits(time=stem_fbd$time[17],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
neu_interval_stem<-stem.limits(time=stem_fbd$time[18],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)
cyt_interval_stem<-stem.limits(time=stem_fbd$time[19],r=div_crown_fbd$crown_e0.91[19],epsilon=0.9195,CI=0.95)

lb_stem<-c(malvoideae_interval_stem[1],bomb_interval_stem[1],ster_interval_stem[1],
	til_interval_stem[1],dom_interval_stem[1],bro_interval_stem[1],
	hel_interval_stem[1],gre_interval_stem[1],byt_interval_stem[1],
	mal_interval_stem[1],mun_interval_stem[1],dip_interval_stem[1],
	sar_interval_stem[1],cis_interval_stem[1],bix_interval_stem[1],
	sph_interval_stem[1],thy_interval_stem[1],neu_interval_stem[1],
	cyt_interval_stem[1])
lb_stem

ub_stem<-c(malvoideae_interval_stem[2],bomb_interval_stem[2],ster_interval_stem[2],
	til_interval_stem[2],dom_interval_stem[2],bro_interval_stem[2],
	hel_interval_stem[2],gre_interval_stem[2],byt_interval_stem[2],
	mal_interval_stem[2],mun_interval_stem[2],dip_interval_stem[2],
	sar_interval_stem[2],cis_interval_stem[2],bix_interval_stem[2],
	sph_interval_stem[2],thy_interval_stem[2],neu_interval_stem[2],
	cyt_interval_stem[2])
ub_stem


intervals_stem<-data.frame(stem_fbd$taxon,lb_stem,ub_stem)
intervals_stem


#########################################################################
#########################################################################
#Voy a corregir la tasa de Malvoideae porque cambié el número de especies (-10)

###FBD80
#crown age
malvoide<-bd.ms(time=71.13, n=2114, epsilon=0.9195)
malvoide
#0.07171567

#stem age
malvoide_stem<-bd.ms(time=74.9, n=2114, epsilon=0.9195)
malvoide_stem
# 0.06810595


###ND
#crown age
malvoide_c_nd_e0.9<-bd.ms(time=65.66, n=2114, epsilon=0.9)
malvoide_c_nd_e0.9
#0.08082082

malvoide_c_nd_e0.01<-bd.ms(time=65.66, n=2114, epsilon=0.01)
malvoide_c_nd_e0.01
#0.1060477


#stem age
malvoide_s_nd_e0.9<-bd.ms(time=68.64, n=2114, epsilon=0.9)
malvoide_s_nd_e0.9
#0.07731199

malvoide_s_nd_e0.01<-bd.ms(time=68.64, n=2114, epsilon=0.01)
malvoide_s_nd_e0.01
#0.1014436


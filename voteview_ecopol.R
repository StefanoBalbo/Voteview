# Economía Política 2023 - FCE UNC - Córdoba, Argentina #

rm(list=ls())

getwd()
directorio <- "/Users/IDECOR/Documents/Code/Voteview/" # Definimos Workspace
setwd(directorio)
dir.create("Graphs")

##############################################################################################################

# Librerías #

# install.packages('wnominate','devtools', 'ggplot2', 'dplyr', 'pscl')

devtools::install_github("voteview/Rvoteview", force = TRUE)

library(ggplot2)
library(devtools)
library(dplyr)
library(Rvoteview)
library(pscl)
library(wnominate)

##############################################################################################################
############################ IMPACTOS DE GUERRAS SOBRE VOTOS LEGISLATIVOS ####################################
##############################################################################################################
#  5.  Foreign and Defense Policy 
#International policy; foreign aid; aid to international 
#organizations; armament policy; defense procurement; international 
#trade; military pensions; etc. 


## 1939 - 1945: SEGUNDA GUERRA MUNDIAL #######################################################################
## 1944: Acuerdo de Bretton Woods ############################################################################
## 1948: Estado de Israel. Respaldo de GB y EEUU. Comienza el conflicto árabe-israelí.########################

# Puntos ideales #
{
print("tranqui tarda un poco, prepara el mate")
res_pre2GM <- voteview_search("codes.Clausen:Foreign and Defense Policy support:[15 to 85]",startdate = "1935-01-20", enddate = "1939-01-20")
res_dur2GM <- voteview_search("codes.Clausen:Foreign and Defense Policy support:[15 to 85]",startdate = "1940-01-20", enddate = "1945-01-20")
res_post2GM <- voteview_search("codes.Clausen:Foreign and Defense Policy support:[15 to 85]",startdate = "1946-01-20", enddate = "1950-01-20")

rc_pre2GM <- voteview_download(res_pre2GM$id)
rc_post2GM <- voteview_download(res_post2GM$id)
rc_dur2GM <- voteview_download(res_dur2GM$id)
}

names(res_pre2GM)
names(rc_pre2GM)
View(res_pre2GM)

# Buscar los "legisladores extremos" para la variable Polaridad #
{
cons1_pre2GM <- rc_pre2GM$legis.long.dynamic[which.max(rc_pre2GM$legis.data$dim1), c("name", "icpsr")]
cons2_pre2GM <- rc_pre2GM$legis.long.dynamic[which.max(rc_pre2GM$legis.data$dim2), c("name", "icpsr")]
defIdeal_pre2GM <- wnominate(rc_pre2GM,
                      polarity = list("icpsr", c(cons1_pre2GM$icpsr, cons2_pre2GM$icpsr)))

cons1_dur2GM <- rc_dur2GM$legis.long.dynamic[which.max(rc_dur2GM$legis.data$dim1), c("name", "icpsr")]
cons2_dur2GM <- rc_dur2GM$legis.long.dynamic[which.max(rc_dur2GM$legis.data$dim2), c("name", "icpsr")]
defIdeal_dur2GM <- wnominate(rc_dur2GM,
                      polarity = list("icpsr", c(cons1_dur2GM$icpsr, cons2_dur2GM$icpsr)))

cons1_post2GM <- rc_post2GM$legis.long.dynamic[which.max(rc_post2GM$legis.data$dim1), c("name", "icpsr")]
cons2_post2GM <- rc_post2GM$legis.long.dynamic[which.max(rc_post2GM$legis.data$dim2), c("name", "icpsr")]
defIdeal_post2GM <- wnominate(rc_post2GM,
                      polarity = list("icpsr", c(cons1_post2GM$icpsr, cons2_post2GM$icpsr)))

}

summary(rc_pre2GM)

cons1_pre2GM; cons2_pre2GM # Extremos pre 2GM
cons1_dur2GM; cons2_dur2GM # Extremos durante 2GM
cons1_post2GM; cons2_post2GM # Extremos post 2GM


# dim1 = economics // dim2 = social
# Crear las etiquetas de nombres de partidos y graficar #

{
defIdeal_pre2GM$legislators$partyName <- ifelse(defIdeal_pre2GM$legislators$party == 200, "Republican",ifelse(defIdeal_pre2GM$legislators$party == 100, "Democrat", "Independent"))
graph_pre2GM <- ggplot(defIdeal_pre2GM$legislators,aes(x=coord1D, y=coord2D, color=partyName, label=state_abbrev)) +  geom_text() + scale_color_manual("Party", values = c("Republican" = "red","Democrat" = "blue","Independent" = "darkgreen")) + theme_bw() + labs(x = "Economics", y = "Social", title = "Previo a la 2GM")
ggsave(filename = "Graphs/pre_2GM.jpg", plot = graph_pre2GM, width = 6, height = 4)

defIdeal_dur2GM$legislators$partyName <- ifelse(defIdeal_dur2GM$legislators$party == 200, "Republican",ifelse(defIdeal_dur2GM$legislators$party == 100, "Democrat", "Independent"))
graph_dur2GM <- ggplot(defIdeal_dur2GM$legislators,aes(x=coord1D, y=coord2D, color=partyName, label=state_abbrev)) +  geom_text() + scale_color_manual("Party", values = c("Republican" = "red","Democrat" = "blue","Independent" = "darkgreen")) + theme_bw() + labs(x = "Economics", y = "Social", title = "Durante la 2GM")
ggsave(filename = "Graphs/dur_2GM.jpg", plot = graph_dur2GM, width = 6, height = 4)

defIdeal_post2GM$legislators$partyName <- ifelse(defIdeal_post2GM$legislators$party == 200, "Republican",ifelse(defIdeal_post2GM$legislators$party == 100, "Democrat", "Independent"))
graph_post2GM <- ggplot(defIdeal_post2GM$legislators,aes(x=coord1D, y=coord2D, color=partyName, label=state_abbrev)) +  geom_text() + scale_color_manual("Party", values = c("Republican" = "red","Democrat" = "blue","Independent" = "darkgreen")) + theme_bw() + labs(x = "Economics", y = "Social", title = "Luego de la 2GM")
ggsave(filename = "Graphs/post_2GM.jpg", plot = graph_post2GM, width = 6, height = 4)
}

graph_pre2GM
graph_dur2GM
graph_post2GM

rm(list=ls())


## GUERRA DE VIETNAM: EE.UU ingresa en 1965 ################################################################
## Contexto de Guerra Fría: EEUU vs URSS. Carrera económica, espacial y armamentística #####################
## Continúa el conflicto árabe-israelí #####################################################################
## 1961: Construcción Muro de Berlín #######################################################################
## 1963: Asesinato de John F. Kennedy ######################################################################
## 1966: Comienza la revolución cultural en China ##########################################################
## 1969: Llegada a la Luna #################################################################################

# Puntos ideales #
{
print("tranqui tarda un poco, prepara el mate")
res_preV <- voteview_search("codes.Clausen:Foreign and Defense Policy support:[15 to 85]",startdate = "1955-01-20", enddate = "1964-01-20")
res_postV <- voteview_search("codes.Clausen:Foreign and Defense Policy support:[15 to 85]",startdate = "1965-01-20", enddate = "1975-01-20")
res_durV <- voteview_search("codes.Clausen:Foreign and Defense Policy support:[15 to 85]",startdate = "1976-01-20", enddate = "1985-01-20")
  
rc_preV <- voteview_download(res_preV$id)
rc_postV <- voteview_download(res_postV$id)
rc_durV <- voteview_download(res_durV$id)
}

# Buscar los "legisladores extremos" para la variable Polaridad #
{
  cons1_preV <- rc_preV$legis.long.dynamic[which.max(rc_preV$legis.data$dim1), c("name", "icpsr")]
  cons2_preV <- rc_preV$legis.long.dynamic[which.max(rc_preV$legis.data$dim2), c("name", "icpsr")]
  defIdeal_preV <- wnominate(rc_preV,
                               polarity = list("icpsr", c(cons1_preV$icpsr, cons2_preV$icpsr)))
  cons1_durV <- rc_durV$legis.long.dynamic[which.max(rc_durV$legis.data$dim1), c("name", "icpsr")]
  cons2_durV <- rc_durV$legis.long.dynamic[which.max(rc_durV$legis.data$dim2), c("name", "icpsr")]
  defIdeal_durV <- wnominate(rc_durV,
                               polarity = list("icpsr", c(cons1_durV$icpsr, cons2_durV$icpsr)))
  cons1_postV <- rc_postV$legis.long.dynamic[which.max(rc_postV$legis.data$dim1), c("name", "icpsr")]
  cons2_postV <- rc_postV$legis.long.dynamic[which.max(rc_postV$legis.data$dim2), c("name", "icpsr")]
  defIdeal_postV <- wnominate(rc_postV,
                                polarity = list("icpsr", c(cons1_postV$icpsr, cons2_postV$icpsr)))
}

summary(rc_preV)

cons1_preV; cons2_preV # Extremos pre Vietnam
cons1_durV; cons2_durV # Extremos durante Vietnam
cons1_postV; cons2_postV # Extremos post Vietnam


# Crear las etiquetas de nombres de partidos y graficar #
{
  defIdeal_preV$legislators$partyName <- ifelse(defIdeal_preV$legislators$party == 200, "Republican",ifelse(defIdeal_preV$legislators$party == 100, "Democrat", "Independent"))
  graph_preV <- ggplot(defIdeal_preV$legislators,aes(x=coord1D, y=coord2D, color=partyName, label=state_abbrev)) +  geom_text() + scale_color_manual("Party", values = c("Republican" = "red","Democrat" = "blue","Independent" = "darkgreen")) + theme_bw() + labs(x = "Economics", y = "Social", title = "Previo a la Guerra de Vietnam")
  ggsave(filename = "Graphs/pre_V.jpg", plot = graph_preV, width = 6, height = 4)
  
  defIdeal_durV$legislators$partyName <- ifelse(defIdeal_durV$legislators$party == 200, "Republican",ifelse(defIdeal_durV$legislators$party == 100, "Democrat", "Independent"))
  graph_durV <- ggplot(defIdeal_durV$legislators,aes(x=coord1D, y=coord2D, color=partyName, label=state_abbrev)) +  geom_text() + scale_color_manual("Party", values = c("Republican" = "red","Democrat" = "blue","Independent" = "darkgreen")) + theme_bw() + labs(x = "Economics", y = "Social", title = "Durante la Guerra de Vietnam")
  ggsave(filename = "Graphs/dur_V.jpg", plot = graph_durV, width = 6, height = 4)
  
  defIdeal_postV$legislators$partyName <- ifelse(defIdeal_postV$legislators$party == 200, "Republican",ifelse(defIdeal_postV$legislators$party == 100, "Democrat", "Independent"))
  graph_postV <- ggplot(defIdeal_postV$legislators,aes(x=coord1D, y=coord2D, color=partyName, label=state_abbrev)) +  geom_text() + scale_color_manual("Party", values = c("Republican" = "red","Democrat" = "blue","Independent" = "darkgreen")) + theme_bw() + labs(x = "Economics", y = "Social", title = "Luego de la Guerra de Vietnam")
  ggsave(filename = "Graphs/post_V.jpg", plot = graph_postV, width = 6, height = 4)
}

graph_preV
graph_durV
graph_postV

rm(list=ls())


## INVASION DE AFGANISTAN (2001) #############################################################################
## 1998: atentados en las embajadas de EEUU en Tanzania y Kenia ##############################################
## 2000: bomba en Yemen contra intereses de EEUU.#############################################################
## 2001: Ataque a las Torres Gemelas #########################################################################
## 2003: Invasión de Irak ####################################################################################

# Puntos ideales #
{
  print("tranqui tarda un poco, prepara el mate")
  res_preA <- voteview_search("codes.Clausen:Foreign and Defense Policy support:[15 to 85]",startdate = "1995-01-20", enddate = "2000-01-20")
  res_postA <- voteview_search("codes.Clausen:Foreign and Defense Policy support:[15 to 85]",startdate = "2001-01-20", enddate = "2005-01-20")
  rc_preA <- voteview_download(res_preA$id)
  rc_postA <- voteview_download(res_postA$id)
}

# Buscar los "legisladores extremos" para la variable Polaridad #
{
  cons1_preA <- rc_preA$legis.long.dynamic[which.max(rc_preA$legis.data$dim1), c("name", "icpsr")]
  cons2_preA <- rc_preA$legis.long.dynamic[which.max(rc_preA$legis.data$dim2), c("name", "icpsr")]
  defIdeal_preA <- wnominate(rc_preA,
                               polarity = list("icpsr", c(cons1_preA$icpsr, cons2_preA$icpsr)))
  cons1_postA <- rc_postA$legis.long.dynamic[which.max(rc_postA$legis.data$dim1), c("name", "icpsr")]
  cons2_postA <- rc_postA$legis.long.dynamic[which.max(rc_postA$legis.data$dim2), c("name", "icpsr")]
  defIdeal_postA <- wnominate(rc_postA,
                                polarity = list("icpsr", c(cons1_postA$icpsr, cons2_postA$icpsr)))
  
}

summary(rc_preA)

cons1_preA; cons2_preA # Extremos pre Afganistan
cons1_postA; cons2_postA # Extremos post Afganistan


# Crear las etiquetas de nombres de partidos y graficar #

{
  defIdeal_preA$legislators$partyName <- ifelse(defIdeal_preA$legislators$party == 200, "Republican",ifelse(defIdeal_preA$legislators$party == 100, "Democrat", "Independent"))
  graph_preA <- ggplot(defIdeal_preA$legislators,aes(x=coord1D, y=coord2D, color=partyName, label=state_abbrev)) +  geom_text() + scale_color_manual("Party", values = c("Republican" = "red","Democrat" = "blue","Independent" = "darkgreen")) + theme_bw() + labs(x = "Economics", y = "Social", title = "Previo a la invasión de Afganistan")
  ggsave(filename = "Graphs/pre_A.jpg", plot = graph_preA, width = 6, height = 4)
  
  defIdeal_postA$legislators$partyName <- ifelse(defIdeal_postA$legislators$party == 200, "Republican",ifelse(defIdeal_postA$legislators$party == 100, "Democrat", "Independent"))
  graph_postA <- ggplot(defIdeal_postA$legislators,aes(x=coord1D, y=coord2D, color=partyName, label=state_abbrev)) +  geom_text() + scale_color_manual("Party", values = c("Republican" = "red","Democrat" = "blue","Independent" = "darkgreen")) + theme_bw() + labs(x = "Economics", y = "Social", title = "Luego de la invasión de Afganistan")
  ggsave(filename = "Graphs/post_A.jpg", plot = graph_postA, width = 6, height = 4)
}

graph_preA
graph_postA

rm(list=ls())

##############################################################################################################
##############################################################################################################
##############################################################################################################

# Testing OTHER CLAUSEN CATEGORIES

#  1.  Government Management 
#Environmental control; government regulation of business; 
#natural resource management; government ownership of business; 
#government control of the economy; budget balancing; tax policy; 
#interest rates; management of the bureaucracy; etc.

res1 <- voteview_search("codes.Clausen:Government Management support:[15 to 85]",startdate = "1940-01-20", enddate = "1950-01-20")
rc1 <- voteview_download(res1$id)

cons1 <- rc1$legis.long.dynamic[which.max(rc1$legis.data$dim1), c("name", "icpsr")]
cons2 <- rc1$legis.long.dynamic[which.max(rc1$legis.data$dim2), c("name", "icpsr")]
defIdeal <- wnominate(rc1,
                           polarity = list("icpsr", c(cons1$icpsr, cons2$icpsr)))

defIdeal$legislators$partyName <- ifelse(defIdeal$legislators$party == 200, "Republican",ifelse(defIdeal$legislators$party == 100, "Democrat", "Independent"))
ggplot(defIdeal$legislators,aes(x=coord1D, y=coord2D, color=partyName, label=state_abbrev)) +  geom_text() + scale_color_manual("Party", values = c("Republican" = "red","Democrat" = "blue","Independent" = "darkgreen")) + theme_bw() + labs(x = "Economics", y = "Social")


#  2.  Social Welfare 
#Social security; public housing; urban renewal; labor 
#regulation; education; urban affairs; employment opportunities and 
#rewards; welfare; medicare; unemployment; minimum wage; legal 
#services; immigration, etc. 

res2 <- voteview_search("codes.Clausen:Social Welfare support:[15 to 85]",startdate = "1935-01-20", enddate = "2008-01-20")
rc2 <- voteview_download(res2$id)


#  3.  Agriculture 
#Price supports and subsidies; commodity control; acreage 
#limitations; etc. 

res3 <- voteview_search("codes.Clausen:Agriculture support:[15 to 85]",startdate = "1935-01-20", enddate = "2008-01-20")
rc3 <- voteview_download(res3$id)


#  4.  Civil Liberties 
#Civil rights; equality; criminal procedure; privacy; 
#guarantees of the Bill of Rights; slavery; Hatch Act; etc. 

res4 <- voteview_search("codes.Clausen:Civil Liberties support:[15 to 85]",startdate = "1935-01-20", enddate = "2008-01-20")
rc4 <- voteview_download(res4$id)


#  6.  Miscellaneous Policy 
#Unclassifiable or unidentifiable votes; all votes concerned 
#with internal organization of Congress; procedural motions. 

res6 <- voteview_search("codes.Clausen:Miscellaneous Policy support:[15 to 85]",startdate = "1935-01-20", enddate = "2008-01-20")
rc6 <- voteview_download(res6$id)






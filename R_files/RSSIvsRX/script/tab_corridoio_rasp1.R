# Year: 2017
# Title: Test Lineare, due raspberry pi e dispositivi a distanze note (1, 2, 4, 5)
# Goal: Capire dipendenza tra rssi e rx
# Author: Edoardo Longo
#
# 

# Define your working directory
# Ensure to use the forward / slash 
setwd("/Users/edoardesd/Documents/R_files")
getwd()

#es: DATASET: timestamp | rssi |  rx
#               12:24:23|  -10 | -68

#INIZIO IMPORT
library(readr)
require(ggplot2)
require(gridExtra)

SAM_1METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/SAM_1METRO_RASP1.csv")
SAM_2METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/SAM_2METRO_RASP1.csv")
SAM_4METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/SAM_4METRO_RASP1.csv")
SAM_5METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/SAM_5METRO_RASP1.csv")

#FINE IMPORT
# CONSIDERAZIONI SU QUANTITÀ DATI OTTENUTI:
#   LG ottiene circa la metà degli RX sia per Rasp1 che per rasp2: 
#     es: LG_2mRasp1 = 36 vs SAM_2mRasp1 = 77
#   Samsung TAB si mantiene sempre sulle 75/85 misurazioni in 20 minuti
# Sono state scartate alcuni campi da rx in quanto erano corrotti 

#Tra rasp1 e rasp2 la quantità dei valori è molto simile

####################################################################

#SAMSUNG TAB RASPBERRY PI 1
#Inizio con lui perchè mi ha dato più valori

################# 1 METRO ##################
#
# CREAZIONE ISTOGRAMMA: 
#   si nota che ad 1 metro per il samsung TAB, l'rssi si assesta su 0 (51 valori), mentre
#   l'rx è nella fascia compresa tra -72 e -75 (tra i venti e i 9/8 valori)
#
#In entrambi i grafici c'è un picco, che secondo me va ad indicare abbastanza univocamente
#  la distanza
SAM_1metro_r1_rx.tab <- table(SAM_1METRO_RASP1$rx)
SAM_1metro_r1_rssi.tab <- table(SAM_1METRO_RASP1$rssi)
SAM_1metro_r1_rx.tab
SAM_1metro_r1_rssi.tab

#VISUALIZZO LE FREQUENZE
par(mfrow=c(1,2)) #2 righe, 1 colonna
barplot(SAM_1metro_r1_rssi.tab, 
        xlab = "RSSI", ylab = "Frequency", main = "1m SAM_TAB RSSI rasp1")
barplot(SAM_1metro_r1_rx.tab,
        xlab = "RX", ylab = "Frequency", main = "1m SAM_TAB RX rasp1")
par(mfrow=c(1,1))
#VISUALIZZO L'ANDAMENTO TEMPORALE
#Come già si notava dall'istogramma delle frequenze, l'rssi rimane sempre abbastanza stabile su 1metro 
# con qualche piccola variazione (probabilmente il suo GRPR è 1 metro circa).
# RX varia maggiormente tra i -70 e i -88
ggplot(data = SAM_1METRO_RASP1, aes(x = timestamp, y = rx, color=rx)) + geom_line() + ggtitle("1metro Sam_TAB Rasp1 RX nel tempo")
ggplot(data = SAM_1METRO_RASP1, aes(x = timestamp, y = rssi, color=rx)) + geom_line() +ggtitle("1metro Sam_TAB Rasp1 RSSI nel tempo")

#INIZIO FASE DI PLOT
#Prima fase, rx asse x e rssi asse y -> vedere come si comportano nello stesso secondo
#
#CONFRONTO RX (asse x) VS (RSSI, asse y)
ggplot(data = SAM_1METRO_RASP1,aes(x = rx,y = rssi)) + stat_sum(color="darkblue") + ggtitle("1metro Sam_TAB Rasp1 RX vs RSSI") + geom_abline(intercept = 0.7616, slope = 0.0247)







################# 2 METRI ##################
#
# CREAZIONE ISTOGRAMMA: 
# Anche qua le frequenze mostrano che l'rssi è praticamente fisso a 0 (GRPR forse è a 2 metri?)
# RX abbastanza stabile tra -70 e -75
#

SAM_2metro_r1_rx.tab <- table(SAM_2METRO_RASP1$rx)
SAM_2metro_r1_rssi.tab <- table(SAM_2METRO_RASP1$rssi)
SAM_2metro_r1_rx.tab
SAM_2metro_r1_rssi.tab

#VISUALIZZO LE FREQUENZE
par(mfrow=c(1,2)) #2 righe, 1 colonna
barplot(SAM_2metro_r1_rssi.tab, 
        xlab = "RSSI", ylab = "Frequency", main = "2m SAM_TAB RSSI rasp1")
barplot(SAM_2metro_r1_rx.tab,
        xlab = "RX", ylab = "Frequency", main = "2m SAM_TAB RX rasp1")
par(mfrow=c(1,1))
#VISUALIZZO L'ANDAMENTO TEMPORALE
# RSSI praticamente a zero
# RX con picchi sui -78 ma tutto sommato stabile
ggplot(data = SAM_2METRO_RASP1, aes(x = timestamp, y = rx, color=rx)) + geom_line() + ggtitle("2metri Sam_TAB Rasp1 RX nel tempo")
ggplot(data = SAM_2METRO_RASP1, aes(x = timestamp, y = rssi, color=rx)) + geom_line() +ggtitle("2metri Sam_TAB Rasp1 RSSI nel tempo")

#INIZIO FASE DI PLOT
#Prima fase, rx asse x e rssi asse y -> vedere come si comportano nello stesso secondo
#
#CONFRONTO RX (asse x) VS (RSSI, asse y)
# Visto che l'rssi era praticamente sempre a zero è come se ci fosse una retta parallela all'asse x in 0
ggplot(data = SAM_2METRO_RASP1,aes(x = rx,y = rssi)) + stat_sum(color="darkblue") + ggtitle("2metri Sam_TAB Rasp1 RX vs RSSI") + geom_abline(intercept = 2.00364, slope = 0.03262)


################# 4 METRI ##################
#
# CREAZIONE ISTOGRAMMA: 
# L'andamento sui 4 metri è abbastanza a campana, ovviamente senza il lato destro, per entrambi i campi
# Ci si inizia a discostare dal valore di 0 andandosi a posizionare tra i -10 e gli 0
# Per Rx picco in 84
#

SAM_4metro_r1_rx.tab <- table(SAM_4METRO_RASP1$rx)
SAM_4metro_r1_rssi.tab <- table(SAM_4METRO_RASP1$rssi)
SAM_4metro_r1_rx.tab
SAM_4metro_r1_rssi.tab

#VISUALIZZO LE FREQUENZE
par(mfrow=c(1,2)) #2 righe, 1 colonna
barplot(SAM_4metro_r1_rssi.tab, 
        xlab = "RSSI", ylab = "Frequency", main = "4m SAM_TAB RSSI rasp1")
barplot(SAM_4metro_r1_rx.tab,
        xlab = "RX", ylab = "Frequency", main = "4m SAM_TAB RX rasp1")
par(mfrow=c(1,1))
#VISUALIZZO L'ANDAMENTO TEMPORALE
# RX abbastanza fisso tra i -86 e i -92, rssi molto variabile
ggplot(data = SAM_4METRO_RASP1, aes(x = timestamp, y = rx, color=rx)) + geom_line() + ggtitle("4metri Sam_TAB Rasp1 RX nel tempo")
ggplot(data = SAM_4METRO_RASP1, aes(x = timestamp, y = rssi, color=rx)) + geom_line() +ggtitle("4metri Sam_TAB Rasp1 RSSI nel tempo")

#INIZIO FASE DI PLOT
#Prima fase, rx asse x e rssi asse y -> vedere come si comportano nello stesso secondo
#
#CONFRONTO RX (asse x) VS (RSSI, asse y)
# A prima vista sembrano ancora sparpagliati ma si nota leggermente l'andamento verso il basso a sinistra (corretto)
# al decrescere dell'rx decresce l'rssi
ggplot(data = SAM_4METRO_RASP1,aes(x = rx,y = rssi)) + stat_sum(color="darkblue") + ggtitle("4metri Sam_TAB Rasp1 RX vs RSSI") + geom_abline(intercept = -6.248242, slope = 0.005386)


################# 5 METRI ##################
#
# CREAZIONE ISTOGRAMMA: 
# La campana per RSSI si perde un po'
# Molto più a campana l'RX con picco su -82

SAM_5metro_r1_rx.tab <- table(SAM_5METRO_RASP1$rx)
SAM_5metro_r1_rssi.tab <- table(SAM_5METRO_RASP1$rssi)
SAM_5metro_r1_rx.tab
SAM_5metro_r1_rssi.tab

#VISUALIZZO LE FREQUENZE
par(mfrow=c(1,2)) #2 righe, 1 colonna
barplot(SAM_5metro_r1_rssi.tab, 
        xlab = "RSSI", ylab = "Frequency", main = "5m SAM_TAB RSSI rasp1")
barplot(SAM_5metro_r1_rx.tab,
        xlab = "RX", ylab = "Frequency", main = "5m SAM_TAB RX rasp1")
par(mfrow=c(1,1))
#VISUALIZZO L'ANDAMENTO TEMPORALE
# RX ha picchi molto alti ogni tanto, rssi sempre molto variabile
ggplot(data = SAM_5METRO_RASP1, aes(x = timestamp, y = rx, color=rx)) + geom_line() + ggtitle("5metri Sam_TAB Rasp1 RX nel tempo")
ggplot(data = SAM_5METRO_RASP1, aes(x = timestamp, y = rssi, color=rx)) + geom_line() +ggtitle("5metri Sam_TAB Rasp1 RSSI nel tempo")

#INIZIO FASE DI PLOT
#Prima fase, rx asse x e rssi asse y -> vedere come si comportano nello stesso secondo
#
#CONFRONTO RX (asse x) VS (RSSI, asse y)
# Dispersione praticamente uniforme
# Completamente a caso, si vanno ad assestare nella zona compresa tra gli 80 e gli 85 e tra 0 e 10. Scomprasa di una forma di dipendenza
ggplot(data = SAM_5METRO_RASP1,aes(x = rx,y = rssi)) + stat_sum(color="darkblue") + ggtitle("5metri Sam_TAB Rasp1 RX vs RSSI") + geom_abline(intercept = -13.12187, slope = -0.08056)


################# FUSIONE ##################
# I valori dell'rx danno sembrano essere più precisi soprattutto nelle distanze di 4 e 5 metri
# Però tra i 4 e 5 metri sono INVERTITI (come è successo nell'LG).. Non è un problema di export dati
# Non ho capito perchè i 5 metri sembrano più vicini dei 4 metri (forse perchè è su un tappeto?)
# 1 metro e due metri sono un po' più sovrapposti nei valori centrali ma 1 metro stranamente da RX molto più bassi
# L'rssi sembra abbastanza confusionario

SAM_1METRO_RASP1$distance <- "01"
SAM_2METRO_RASP1$distance <- "02"
SAM_4METRO_RASP1$distance <- "04"
SAM_5METRO_RASP1$distance <- "05"
visual_sam_1 <- rbind(SAM_1METRO_RASP1, SAM_2METRO_RASP1, SAM_4METRO_RASP1, SAM_5METRO_RASP1)

sam_rasp1 <- ggplot(visual_sam_1 , aes(x=rx, y=rssi, color=distance)) + stat_sum() 
sam_rasp1 <- sam_rasp1 + scale_color_manual(breaks = c("1", "2", "4", "5"),values=c("green", "violet", "blue", "red")) + ggtitle("SAMSUNG TAB - RASP1 - Impronta in base alla distanza")
sam_rasp1


#Calcolo correlazione
corr_1_sam_1 <- SAM_1METRO_RASP1
corr_1_sam_1$timestamp = NULL 
corr_1_sam_1$distance = NULL
cor(corr_1_sam_1,  method="kendall") 
cor(corr_1_sam_1,  method="pearson") 
cor(corr_1_sam_1,  method="spearman") 
#è molto bassa, spearman è il più alto ma è solo 0.085, gli altri due sono 0.064

corr_2_sam_1 <- SAM_2METRO_RASP1
corr_2_sam_1$timestamp = NULL 
corr_2_sam_1$distance = NULL
cor(corr_2_sam_1,  method="kendall") 
cor(corr_2_sam_1,  method="pearson") 
cor(corr_2_sam_1,  method="spearman") 
#sui due metri è praticamente agli stessi livelli di prima

corr_4_sam_1 <- SAM_4METRO_RASP1
corr_4_sam_1$timestamp = NULL 
corr_4_sam_1$distance = NULL
cor(corr_4_sam_1,  method="kendall") 
cor(corr_4_sam_1,  method="pearson") 
cor(corr_4_sam_1,  method="spearman") 
#sui 4 metri spearman riesce ad arrivare a 0,1.
#kendal rimane stabile sui soliti risultati (0.06)
#pearson è molto più basso del solito 0.003

corr_5_sam_1 <- SAM_5METRO_RASP1
corr_5_sam_1$timestamp = NULL 
corr_5_sam_1$distance = NULL
cor(corr_5_sam_1,  method="kendall") 
cor(corr_5_sam_1,  method="pearson") 
cor(corr_5_sam_1,  method="spearman") 
#qua diventa addirittura negativa
#ma comunque a livelli bassissimi

################# BOXPLOT ##################
#Boxplot standard con mediana (valore in mezzo alla distribuzione), primo e terzo quartile
#Non è detto che indichi perfettamente la realtà andando a prendere la mediana
#Un po' tutto confusionario
boxplot(SAM_1METRO_RASP1$rssi, SAM_2METRO_RASP1$rssi, SAM_4METRO_RASP1$rssi, SAM_5METRO_RASP1$rssi, 
        xlab="Distance", ylab="RSSI", las=1, col=topo.colors(4), main="RSSI Samsung TAB per distanza RASP 1")

boxplot(SAM_1METRO_RASP1$rx, SAM_2METRO_RASP1$rx, SAM_4METRO_RASP1$rx, SAM_5METRO_RASP1$rx,
        xlab="Distance", ylab="RX", las=1, col=topo.colors(4), main="RX Samsung TAB per distanza RASP 1")



#Boxplot con media e deviazione standard

#function for computing mean, DS, max and min values
min.mean.sd.max <- function(x) {
  r <- c(min(x), mean(x) - sd(x), mean(x), mean(x) + sd(x), max(x))
  names(r) <- c("ymin", "lower", "middle", "upper", "ymax")
  r
}

bplot_sam1_rssi <- ggplot(aes(y = rssi, x = factor(distance), color= distance), data = visual_sam_1)
bplot_sam1_rssi <- bplot_sam1_rssi + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)

bplot_sam1_rssi <- bplot_sam1_rssi + ggtitle("Samsung TAB RASP 1: RSSI media, st dev +/- media") + xlab("Distanza") + ylab("RSSI") + scale_color_manual(breaks = c("1", "2", "4", "5"),values=c("darkgreen", "darkviolet", "darkblue", "darkred"))
bplot_sam1_rssi

bplot_sam1_rx <- ggplot(aes(y = rx, x = factor(distance), color= distance), data = visual_sam_1)
bplot_sam1_rx <- bplot_sam1_rx + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)

bplot_sam1_rx <-bplot_sam1_rx + ggtitle("Samsung TAB RASP 1: RX media, st dev +/- media") + xlab("Distanza") + ylab("RX") + scale_color_manual(breaks = c("1", "2", "4", "5"),values=c("lightgreen", "violet", "lightblue", "darkorange"))
bplot_sam1_rx
grid.arrange(bplot_sam1_rssi, bplot_sam1_rx, widths=c(0.5, 0.5), ncol=2)




################# CONCLUSIONE ##################
# Non c'è una dipendenza lineare tra RSSI e RX.
# Azzarderei dicendo che non c'è nessuna dipendenza tra i due valori.
# Uno dei possibili motivi è il fatto che prenderli precisi nello stesso istante è impossibile
# c'è "solo" 1 secondo di finestra temporale
# 
# Ciò nonostante i valori sembrano variare abbastanza consistentemente al variare della distanza
# Soprattutto l'RX sembra una valida misurazione per quanto riguarda i 4 e i 5 metri,
# mentre sui 2 e 1 metri sono un po' confusionari.
# 
# Il fingerprinting è probabilmente l'unica via da percorrere per andare a stimare la distanza


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
require(ggplot2)
require(gridExtra)
require(grid)
library(readr)
SAM_1METRO_RASP2 <- read_csv("~/Documents/R_files/RSSIvsRX/data/SAM_1METRO_RASP2.csv")
SAM_2METRO_RASP2 <- read_csv("~/Documents/R_files/RSSIvsRX/data/SAM_2METRO_RASP2.csv")
SAM_4METRO_RASP2 <- read_csv("~/Documents/R_files/RSSIvsRX/data/SAM_4METRO_RASP2.csv")
SAM_5METRO_RASP2 <- read_csv("~/Documents/R_files/RSSIvsRX/data/SAM_5METRO_RASP2.csv")


#SAMSUNG TAB RASPBERRY PI 2
#Inizio con lui perchè mi ha dato più valori

################# 1 METRO ##################
#
# CREAZIONE ISTOGRAMMA: 
#  Per l'rssi ci si assesta sullo 0 praticamente fisso
# Per Rx sono molto variabili, ho 2/3 picchi
SAM_1metro_r2_rx.tab <- table(SAM_1METRO_RASP2$rx)
SAM_1metro_r2_rssi.tab <- table(SAM_1METRO_RASP2$rssi)
SAM_1metro_r2_rx.tab
SAM_1metro_r2_rssi.tab

#VISUALIZZO LE FREQUENZE
par(mfrow=c(1,2)) #2 righe, 1 colonna
barplot(SAM_1metro_r2_rssi.tab, 
        xlab = "RSSI", ylab = "Frequency", main = "1m SAM_TAB RSSI rasp2")
barplot(SAM_1metro_r2_rx.tab,
        xlab = "RX", ylab = "Frequency", main = "1m SAM_TAB RX rasp2")
par(mfrow=c(1,1))
#VISUALIZZO L'ANDAMENTO TEMPORALE
#Come già si notava dall'istogramma delle frequenze, l'rssi rimane sempre abbastanza stabile su 1metro 
# con qualche piccola variazione (probabilmente il suo GRPR è 1 metro circa). -> tipo rasp1
# RX molto variabile
ggplot(data = SAM_1METRO_RASP2, aes(x = timestamp, y = rx, color=rx)) + geom_line() + ggtitle("1metro Sam_TAB Rasp2 RX nel tempo")
ggplot(data = SAM_1METRO_RASP2, aes(x = timestamp, y = rssi, color=rx)) + geom_line() +ggtitle("1metro Sam_TAB Rasp2 RSSI nel tempo")

#INIZIO FASE DI PLOT
#Prima fase, rx asse x e rssi asse y -> vedere come si comportano nello stesso secondo
#
#CONFRONTO RX (asse x) VS (RSSI, asse y)
#Come era abbastanza ovvio, mi trovo praticamente fisso sullo 0
ggplot(data = SAM_1METRO_RASP2,aes(x = rx,y = rssi)) + stat_sum(color="darkred") + ggtitle("1metro Sam_TAB Rasp2 RX vs RSSI")


################# 2 METR1 ##################
#
# CREAZIONE ISTOGRAMMA: 
# Picco su 0 per rssi -> buono 
# Rx questa volta a campana su -70/-71-> buono
SAM_2metro_r2_rx.tab <- table(SAM_2METRO_RASP2$rx)
SAM_2metro_r2_rssi.tab <- table(SAM_2METRO_RASP2$rssi)
SAM_2metro_r2_rx.tab
SAM_2metro_r2_rssi.tab

#VISUALIZZO LE FREQUENZE
par(mfrow=c(1,2)) #2 righe, 1 colonna
barplot(SAM_2metro_r2_rssi.tab, 
        xlab = "RSSI", ylab = "Frequency", main = "2m SAM_TAB RSSI rasp2")
barplot(SAM_2metro_r2_rx.tab,
        xlab = "RX", ylab = "Frequency", main = "2m SAM_TAB RX rasp2")
par(mfrow=c(1,1))
#VISUALIZZO L'ANDAMENTO TEMPORALE
# Fisso su 0 praticamente
# RX meno variabile rispetto a prima
p1<-ggplot(data = SAM_2METRO_RASP2, aes(x = timestamp, y = rx, color=rx)) + geom_line() + ggtitle("2metri Sam_TAB Rasp2 RX nel tempo")
p2<-ggplot(data = SAM_2METRO_RASP2, aes(x = timestamp, y = rssi, color=rx)) + geom_line() +ggtitle("2metri Sam_TAB Rasp2 RSSI nel tempo")
p1
p2

#INIZIO FASE DI PLOT
#Prima fase, rx asse x e rssi asse y -> vedere come si comportano nello stesso secondo
#
#CONFRONTO RX (asse x) VS (RSSI, asse y)
#Come era abbastanza ovvio, mi trovo praticamente fisso sullo 0
ggplot(data = SAM_2METRO_RASP2,aes(x = rx,y = rssi)) + stat_sum(color="darkred") + ggtitle("2metr1 Sam_TAB Rasp2 RX vs RSSI")



################# 4 METR1 ##################
#
# CREAZIONE ISTOGRAMMA: 
# si nota un andamento a campana un po' storpia, ma sembra abbastanza buono comunque
SAM_4metro_r2_rx.tab <- table(SAM_4METRO_RASP2$rx)
SAM_4metro_r2_rssi.tab <- table(SAM_4METRO_RASP2$rssi)
SAM_4metro_r2_rx.tab
SAM_4metro_r2_rssi.tab

#VISUALIZZO LE FREQUENZE
par(mfrow=c(1,2)) #2 righe, 1 colonna
barplot(SAM_4metro_r2_rssi.tab, 
        xlab = "RSSI", ylab = "Frequency", main = "4m SAM_TAB RSSI rasp2")
barplot(SAM_4metro_r2_rx.tab,
        xlab = "RX", ylab = "Frequency", main = "4m SAM_TAB RX rasp2")
par(mfrow=c(1,1))
#VISUALIZZO L'ANDAMENTO TEMPORALE
# Tutto molto variabile
ggplot(data = SAM_4METRO_RASP2, aes(x = timestamp, y = rx, color=rx)) + geom_line() + ggtitle("4metri Sam_TAB Rasp2 RX nel tempo")
ggplot(data = SAM_4METRO_RASP2, aes(x = timestamp, y = rssi, color=rx)) + geom_line() +ggtitle("4metri Sam_TAB Rasp2 RSSI nel tempo")

#INIZIO FASE DI PLOT
#Prima fase, rx asse x e rssi asse y -> vedere come si comportano nello stesso secondo
# 
#CONFRONTO RX (asse x) VS (RSSI, asse y)
# Come era già successo sembra fissarsi su una zona più che su una retta
ggplot(data = SAM_4METRO_RASP2,aes(x = rx,y = rssi)) + stat_sum(color="darkred") + ggtitle("4metri Sam_TAB Rasp2 RX vs RSSI")


################# 5 METR1 ##################
#
# CREAZIONE ISTOGRAMMA: 
#l'rssi si torna a fissarsi su 0 inspiegabilmente
# RX ha un paio di picchi, si potrebbe intuire una campana
SAM_5metro_r2_rx.tab <- table(SAM_5METRO_RASP2$rx)
SAM_5metro_r2_rssi.tab <- table(SAM_5METRO_RASP2$rssi)
SAM_5metro_r2_rx.tab
SAM_5metro_r2_rssi.tab

#VISUALIZZO LE FREQUENZE
par(mfrow=c(1,2)) #2 righe, 1 colonna
barplot(SAM_5metro_r2_rssi.tab, 
        xlab = "RSSI", ylab = "Frequency", main = "5m SAM_TAB RSSI rasp2")
barplot(SAM_5metro_r2_rx.tab,
        xlab = "RX", ylab = "Frequency", main = "5m SAM_TAB RX rasp2")
par(mfrow=c(1,1))
#VISUALIZZO L'ANDAMENTO TEMPORALE
# Tutto molto variabile
ggplot(data = SAM_5METRO_RASP2, aes(x = timestamp, y = rx, color=rx)) + geom_line() + ggtitle("5metri Sam_TAB Rasp2 RX nel tempo")
ggplot(data = SAM_5METRO_RASP2, aes(x = timestamp, y = rssi, color=rx)) + geom_line() +ggtitle("5metri Sam_TAB Rasp2 RSSI nel tempo")

#INIZIO FASE DI PLOT
#Prima fase, rx asse x e rssi asse y -> vedere come si comportano nello stesso secondo
# 
#CONFRONTO RX (asse x) VS (RSSI, asse y)
# Come era già successo sembra fissarsi su una zona più che su una retta
# Ma tutto molto sparso
ggplot(data = SAM_5METRO_RASP2,aes(x = rx,y = rssi)) + stat_sum(color="darkred") + ggtitle("5metri Sam_TAB Rasp2 RX vs RSSI")


################# FUSIONE ##################
# I valori dell'rx danno sembrano essere più precisi soprattutto nelle distanze di 1 e 2 metri
# 3 e 4 metri sono abbastanza sovrapposti
# L'rssi sembra abbastanza confusionario


SAM_1METRO_RASP2$distance <- "1"
SAM_2METRO_RASP2$distance <- "2"
SAM_4METRO_RASP2$distance <- "4"
SAM_5METRO_RASP2$distance <- "5"
visual_tab_rasp2 <- rbind(SAM_1METRO_RASP2, SAM_2METRO_RASP2, SAM_4METRO_RASP2, SAM_5METRO_RASP2)

p_tab_rasp2 <- ggplot(visual_tab_rasp2, aes(x=rx, y=rssi, color=distance)) + stat_sum() 
p_tab_rasp2 + scale_color_manual(breaks = c("1", "2", "4", "5"),  values=c("green", "violet", "blue", "red")) + ggtitle("SAMSUNG TAB - RASP2 - Impronta in base alla distanza")


################# BOXPLOT ##################
#Boxplot standard con mediana (valore in mezzo alla distribuzione), primo e terzo quartile
#Non è detto che indichi perfettamente la realtà andando a prendere la mediana
#In questo caso l'rssi è confusionario, ma l'rx sembra dare dei valori sensati andando a scendere al variare della distanza
boxplot(SAM_1METRO_RASP2$rssi, SAM_2METRO_RASP2$rssi, SAM_4METRO_RASP2$rssi, SAM_5METRO_RASP2$rssi, 
        xlab="Distance", ylab="RSSI", las=1, col=topo.colors(4), main="RSSI Samsung TAB per distanza RASP 2")

boxplot(SAM_1METRO_RASP2$rx, SAM_2METRO_RASP2$rx, SAM_4METRO_RASP2$rx, SAM_5METRO_RASP2$rx,
        xlab="Distance", ylab="RX", las=1, col=topo.colors(4), main="RX Samsung TAB per distanza RASP 2")


#Boxplot con media e deviazione standard

#function for computing mean, DS, max and min values
min.mean.sd.max <- function(x) {
  r <- c(min(x), mean(x) - sd(x), mean(x), mean(x) + sd(x), max(x))
  names(r) <- c("ymin", "lower", "middle", "upper", "ymax")
  r
}

bplot_sam2_rssi <- ggplot(aes(y = rssi, x = factor(distance), color= distance), data = visual_tab_rasp2)
bplot_sam2_rssi <- bplot_sam2_rssi + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)
bplot_sam2_rssi <- bplot_sam2_rssi + ggtitle("Samsung TAB RASP 2: RSSI media, st dev +/- media") + xlab("Distanza") + ylab("RSSI") + scale_color_manual(breaks = c("1", "2", "4", "5"),values=c("darkgreen", "darkviolet", "darkblue", "darkred"))
bplot_sam2_rssi

bplot_sam2_rx <- ggplot(aes(y = rx, x = factor(distance), color= distance), data = visual_tab_rasp2)
bplot_sam2_rx <- bplot_sam2_rx + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)
bplot_sam2_rx <-bplot_sam2_rx + ggtitle("Samsung TAB RASP 2: RX media, st dev +/- media") + xlab("Distanza") + ylab("RX") + scale_color_manual(breaks = c("1", "2", "4", "5"),values=c("lightgreen", "violet", "lightblue", "darkorange"))
bplot_sam2_rx
grid.arrange(bplot_sam2_rssi, bplot_sam2_rx, widths=c(0.5, 0.5), ncol=2)



## CONFRONTO TRA RASP 1 e RASP 2
#RSSI molto molto simile, 
#RX c'è il solito problema dei 5 metri della rasp1
#fa ben sperare che tra due rasp diverse i risultati siano simili
grid.arrange(bplot_sam1_rssi, bplot_sam2_rssi, widths=c(0.5, 0.5), ncol=2)
grid.arrange(bplot_sam1_rx, bplot_sam2_rx, widths=c(0.5, 0.5), ncol=2)



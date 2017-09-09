# Year: 2017
# Title: Test Lineare, due raspberry pi e dispositivi a distanze note (1, 2, 4, 5)
# Goal: Capire come si comporta RSSI e echo_time
# Author: Edoardo Longo
#
# 

# Define your working directory 
# Ensure to use the forward / slash
setwd("/Users/edoardesd/Documents/R_files")
getwd()

#es: DATASET: timestamp | rssi |  echo_time
#               12:24:23|  -10 |   12.34ms

#INIZIO IMPORT
library(readr)
library(ggplot2)
require(ggplot2)
require(gridExtra)

RSSI_SAM_1METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/RSSI_SAM_1METRO_RASP1.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%S")))
RSSI_SAM_2METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/RSSI_SAM_2METRO_RASP1.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%S")))
RSSI_SAM_4METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/RSSI_SAM_4METRO_RASP1.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%S")))
RSSI_SAM_5METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/RSSI_SAM_5METRO_RASP1.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%S")))

RSSI_SAM_1METRO_RASP2 <- read_csv("~/Documents/R_files/RSSIvsRX/data/RSSI_SAM_1METRO_RASP2.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%S")))
RSSI_SAM_2METRO_RASP2 <- read_csv("~/Documents/R_files/RSSIvsRX/data/RSSI_SAM_2METRO_RASP2.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%S")))
RSSI_SAM_4METRO_RASP2 <- read_csv("~/Documents/R_files/RSSIvsRX/data/RSSI_SAM_4METRO_RASP2.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%S")))
RSSI_SAM_5METRO_RASP2 <- read_csv("~/Documents/R_files/RSSIvsRX/data/RSSI_SAM_5METRO_RASP2.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%S")))


###### IMPRONTA RSSI ######
#sulle varie distanza
#Non si nota molto la differenza in quanto anche le distanze più lontane ogni tanto beccano valori vicino allo 0
#E poi è troppo fitto
RSSI_SAM_1METRO_RASP1$distance <- "1"
RSSI_SAM_2METRO_RASP1$distance <- "2"
RSSI_SAM_4METRO_RASP1$distance <- "4"
RSSI_SAM_5METRO_RASP1$distance <- "5"


RSSI_SAM_1METRO_RASP2$distance <- "1"
RSSI_SAM_2METRO_RASP2$distance <- "2"
RSSI_SAM_4METRO_RASP2$distance <- "4"
RSSI_SAM_5METRO_RASP2$distance <- "5"

rssi_sam_rasp1 <- rbind(RSSI_SAM_1METRO_RASP1, RSSI_SAM_2METRO_RASP1, RSSI_SAM_4METRO_RASP1, RSSI_SAM_5METRO_RASP1)
rssi_sam_rasp2 <- rbind(RSSI_SAM_1METRO_RASP2, RSSI_SAM_2METRO_RASP2, RSSI_SAM_4METRO_RASP2, RSSI_SAM_5METRO_RASP2)

rssi_all_rasp1 <- ggplot(rssi_sam_rasp1 , aes(x=timestamp, y=rssi, color=distance))  + geom_point() +
    scale_color_manual(breaks = c("1", "2", "4", "5"),values=c("green", "violet", "blue", "red")) + ggtitle("SAMSUNG TAB - RASP1 - Impronta nel tempo in base alla distanza")

rssi_all_rasp2 <- ggplot(rssi_sam_rasp2 , aes(x=timestamp, y=rssi, color=distance))  + geom_point() +
  scale_color_manual(breaks = c("1", "2", "4", "5"),values=c("green", "violet", "blue", "red")) + ggtitle("SAMSUNG TAB - RASP2 - Impronta nel tempo in base alla distanza")

rssi_all_rasp1
rssi_all_rasp2

grid.arrange(rssi_all_rasp1, rssi_all_rasp2, widths=c(0.5, 0.5), ncol=2)
#RASP2 sembra molto uniforme ma non è detto che lo sia, bisogna vedere la densità che in questo caso non è molto chiara


######## RSSI VS ECHO RESPONSE TIME  ######
#Dai grafici non sembra esserci una dipendenza
ggplot(data = RSSI_SAM_1METRO_RASP1,aes(x = rssi,y = echo_time)) + stat_sum(color="darkblue") + ggtitle("1metro RAB Rasp1 RSSI vs echo resp time")
ggplot(data = RSSI_SAM_2METRO_RASP1,aes(x = rssi,y = echo_time)) + stat_sum(color="darkblue") + ggtitle("2metri RAB Rasp1 RSSI vs echo resp time")
ggplot(data = RSSI_SAM_4METRO_RASP1,aes(x = rssi,y = echo_time)) + stat_sum(color="darkblue") + ggtitle("4metri RAB Rasp1 RSSI vs echo resp time")
ggplot(data = RSSI_SAM_5METRO_RASP1,aes(x = rssi,y = echo_time)) + stat_sum(color="darkblue") + ggtitle("5metri RAB Rasp1 RSSI vs echo resp time")

#Controllo correlazione per distanza 5 metri
corr_5_rssi_sam_1 <- RSSI_SAM_5METRO_RASP1
corr_5_rssi_sam_1$timestamp = NULL 
corr_5_rssi_sam_1$distance = NULL
cor(corr_5_rssi_sam_1,  method="kendall") 
cor(corr_5_rssi_sam_1,  method="pearson") 
cor(corr_5_rssi_sam_1,  method="spearman") 

#Anche correlation non da risultati soddisfacenti

#Come visto nei precedenti box plot tra rssi ridotti e rssi completi i risultati sono molto simili

#Rasp2
plot_all_sam2_rssi <- ggplot(aes(y = rssi, x = factor(distance), color= distance), data = rssi_sam_rasp2)
plot_all_sam2_rssi <- plot_all_sam2_rssi + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)
plot_all_sam2_rssi <- plot_all_sam2_rssi + ggtitle("Samsung TAB RASP 2: RSSI COMPLETI media, st dev +/- media") + xlab("Distanza") + ylab("RSSI") + scale_color_manual(breaks = c("1", "2", "4", "5"),values=c("darkgreen", "darkviolet", "darkblue", "darkred"))

plot_all_sam2_rssi


#I confronti tra le due rasp sono abbastanza simili, ma non perfettamente uguali
grid.arrange( plot_all_sam1_rssi, plot_all_sam2_rssi, widths=c(0.5, 0.5), ncol=2)


#Anche in questo caso la differenza tra il ridotto e il completo e poca, si accentua di più sui due metri
grid.arrange( bplot_sam2_rssi, plot_all_sam2_rssi, widths=c(0.5, 0.5), ncol=2)



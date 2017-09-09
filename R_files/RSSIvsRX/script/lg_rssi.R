# Year: 2017
# Title: Test Lineare, due raspberry pi e dispositivi a distanze note (1, 2, 4, 5)
# Goal: Capire come si comporta RSSI e echo_time su LG
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

RSSI_LG_1METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/RSSI_LG_1METRO_RASP1.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%S")))
RSSI_LG_2METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/RSSI_LG_2METRO_RASP1.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%S")))
RSSI_LG_4METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/RSSI_LG_4METRO_RASP1.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%S")))
RSSI_LG_5METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/RSSI_LG_5METRO_RASP1.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%S")))

LG_NOTTURNO <- read_csv("~/Documents/R_files/RSSIvsRX/data/LG_NOTTURNO.csv",  col_types = cols(`1` = col_character()))

colnames(LG_NOTTURNO)[4] <- "attempt"
RSSI_LG_1METRO_RASP1$distance <- "01"
RSSI_LG_2METRO_RASP1$distance <- "02"
RSSI_LG_4METRO_RASP1$distance <- "04"
RSSI_LG_5METRO_RASP1$distance <- "05"

rssi_lg_rasp1 <- rbind(RSSI_LG_1METRO_RASP1, RSSI_LG_2METRO_RASP1, RSSI_LG_4METRO_RASP1, RSSI_LG_5METRO_RASP1)



##### IMPRONTA #####
lg_rssi_all_rasp1 <- ggplot(rssi_lg_rasp1 , aes(x=timestamp, y=rssi, color=distance))  + geom_point() +
  scale_color_manual(breaks = c("1", "2", "4", "5"),values=c("green", "violet", "blue", "red")) + ggtitle("LG - RASP1 - Impronta nel tempo in base alla distanza")
lg_rssi_all_rasp1

#Ok l'impronta dell'LG in base alla distanza, ma solito problema dei 4 e 5 metri


################# BOXPLOT ##################
#Boxplot standard con mediana (valore in mezzo alla distribuzione), primo e terzo quartile
#Non è detto che indichi perfettamente la realtà andando a prendere la mediana
#Non molto chiaro
boxplot(RSSI_LG_1METRO_RASP1$rssi, RSSI_LG_2METRO_RASP1$rssi, RSSI_LG_4METRO_RASP1$rssi, RSSI_LG_5METRO_RASP1$rssi, 
        xlab="Distance", ylab="RSSI", las=1, col=topo.colors(4), main="RSSI completi LG per distanza RASP 1")

#è molto simile al boxplot dei valori rssi ridotti (quello con i corrispondenti rx)


#Boxplot con media e deviazione standard

#function for computing mean, DS, max and min values
min.mean.sd.max <- function(x) {
  r <- c(min(x), mean(x) - sd(x), mean(x), mean(x) + sd(x), max(x))
  names(r) <- c("ymin", "lower", "middle", "upper", "ymax")
  r
}

#Rasp1 
plot_all_lg1_rssi <- ggplot(aes(y = rssi, x = factor(distance), color= distance), data = rssi_lg_rasp1)
plot_all_lg1_rssi <- plot_all_lg1_rssi + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)
plot_all_lg1_rssi <- plot_all_lg1_rssi + ggtitle("LG RASP 1: RSSI COMPLETI media, st dev +/- media") + xlab("Distanza") + ylab("RSSI") + scale_color_manual(breaks = c("1", "2", "4", "5"),values=c("darkgreen", "darkviolet", "darkblue", "darkred"))
plot_all_lg1_rssi

grid.arrange(bplot_lg1_rssi, plot_all_lg1_rssi, widths=c(0.5, 0.5), ncol=2)
#I risultati sono abbastanza simili ai valori dell'rssi ridotto


###### NOTTURNO #######
lg_notturno_finger <- ggplot(LG_NOTTURNO, aes(x=timestamp, y=rssi, color=attempt))  + geom_point() +
  scale_color_manual(breaks = c("1", "2", "3"),values=c("green", "violet", "blue", "red")) + ggtitle("LG - RASP1 - Distanza 3 metri - 3 misurazioni")
lg_notturno_finger

#mistero dei misteri perchè a un certo punto si è messo ad avere un rssi più vicino allo 0
lg_notturno_line <- ggplot(LG_NOTTURNO, aes(x=timestamp, y=rssi, color=attempt))  + geom_line(data=subset(LG_NOTTURNO,attempt=="1")) +
  scale_color_manual(breaks = c("1", "2", "3"),values=c("green", "violet", "blue", "red")) + ggtitle("LG - RASP1 - Distanza 3 metri - 3 misurazioni")
lg_notturno_line


box_notturno <- ggplot(aes(y = rssi, x = factor(attempt), color= attempt), data = LG_NOTTURNO)
box_notturno <- box_notturno + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)
box_notturno <- box_notturno + ggtitle("LG su 3 metri: media, st dev +/- media") + xlab("Distanza") + ylab("RSSI") + scale_color_manual(breaks = c("1", "2", "3"),values=c("darkgreen", "darkviolet", "darkblue", "darkred"))

box_notturno



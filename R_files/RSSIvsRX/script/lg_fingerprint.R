# Year: 2017
# Title: Fingerprint corridoio, LG 10 metri
# Goal: Classificare distanza in base rssi
# Author: Edoardo Longo
#
# 

# Define your working directory
# Ensure to use the forward / slash
setwd("/Users/edoardesd/Documents/R_files")
getwd()

#es: DATASET: rssi | echotime |  distance
#             -10       23.34        "1"

###### IMPORT ###### 
require(class)
library(readr)
require(ggplot2)
LG_FINGERPRINT_CORRIDOIO <- read_csv("~/Documents/R_files/RSSIvsRX/data/LG_FINGERPRINT_CORRIDOIO.csv",  col_types = cols(`01` = col_character()))
LG_FINGERPRINT_CORRIDOIO <- read_csv("~/Documents/R_files/RSSIvsRX/data/LG_FINGERPRINT_CORRIDOIO.csv",  col_types = cols(`01` = col_character()))

LG_FINGERPRINT_CORRIDOIO_RX <- read_csv("~/Documents/R_files/RSSIvsRX/data/LG_FINGERPRINT_CORRIDOIO_RX.csv",  col_types = cols(`01` = col_character()))
TAB_FINGERPRINT_CORRIDOIO_RX <- read_csv("~/Documents/R_files/RSSIvsRX/data/TAB_FINGERPRINT_CORRIDOIO_RX.csv",  col_types = cols(`01` = col_character()))


colnames(LG_FINGERPRINT_CORRIDOIO)[3] <- "distance"
colnames(LG_FINGERPRINT_CORRIDOIO_RX)[4] <- "distance"
colnames(TAB_FINGERPRINT_CORRIDOIO_RX)[4] <- "distance"



ggplot(data = LG_FINGERPRINT_CORRIDOIO,aes(x = distance,y = rssi, group=distance, color=distance)) + stat_sum() + ggtitle("LG RSSI distanza")
ggplot(data = LG_FINGERPRINT_CORRIDOIO,aes(x = rssi,y = echo_time, group=distance, color=distance)) + geom_point() + ggtitle("LG + RSSI ECHO RESP TIME distanza")
ggplot(data = LG_FINGERPRINT_CORRIDOIO_RX,aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("LG RSSI vs RX distanza")
ggplot(data = LG_FINGERPRINT_CORRIDOIO_RX,aes(x = rx,y = rssi, group=distance, color=distance)) + stat_sum() + ggtitle("LG RX vs RSSI distanza")
ggplot(data = TAB_FINGERPRINT_CORRIDOIO_RX,aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("TAB RSSI vs RX distanza")
ggplot(data = TAB_FINGERPRINT_CORRIDOIO_RX,aes(x = rx,y = rssi, group=distance, color=distance)) + stat_sum() + ggtitle("TAB RX vs RSSI distanza")

#Boxplot con media e deviazione standard

#function for computing mean, DS, max and min values
min.mean.sd.max <- function(x) {
  r <- c(min(x), mean(x) - sd(x), mean(x), mean(x) + sd(x), max(x))
  names(r) <- c("ymin", "lower", "middle", "upper", "ymax")
  r
}

normalize <- function(x){ return( (x - min(x)) / (max(x) - min(x) ))  }


bplot_lg_finger <- ggplot(aes(y = rssi, x = factor(distance), color= distance), data = LG_FINGERPRINT_CORRIDOIO)
bplot_lg_finger <- bplot_lg_finger + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)
bplot_lg_finger <- bplot_lg_finger + ggtitle("LG fingerprint: RSSI media, st dev +/- media") + xlab("Distanza") + ylab("RSSI")
bplot_lg_finger



######## TODO #######
#knn con echo e rssi, vedere quando è l'errore <- FATTO!
#knn monocolonna solo con rssi, vedere errore <- FATTO
#knn con rssi e rx (cambiare dataset)
#knn con media, mediana, moda, deviazione standard, andando a separare il dataset in gruppi da 100


###### k-NN Normalizzto  RSSI + ECHO ###### 
#Errore alto

gp <- runif(nrow(LG_FINGERPRINT_CORRIDOIO))
unordered_finger_set <- LG_FINGERPRINT_CORRIDOIO[order(gp),] #mischio il set
summary(unordered_finger_set)

#Normalizzo
norm_finger <- as.data.frame(lapply(unordered_finger_set[,c(1,2)], normalize))
summary(norm_finger)

finger_train_norm <- norm_finger[1:4622,]
finger_test_norm <- norm_finger[4623:4632,]
dim(finger_train_norm )
dim(finger_test_norm )

finger_train_target_norm  <- head(unordered_finger_set$distance, 4622)
length(finger_train_target_norm )

finger_correct_norm  <- tail(unordered_finger_set$distance, 10)
length(finger_correct_norm )

lg_err_norm<-numeric()

for(i in 1:60){
  lg_knn_norm <- knn(finger_train_norm , finger_test_norm , finger_train_target_norm , k=i)
  lg_err_norm <- c(lg_err_norm, mean(lg_knn_norm == finger_correct_norm))
}

plot(1-lg_err_norm,type="l",ylab="Error Rate",
     xlab="K",main="Error Rate for LG Normalized With Varying K")

##### k-NN NON Normalizzato RSSI + ECHO#####

finger_train <- unordered_finger_set[1:4622,]
finger_train
finger_test <- unordered_finger_set[4623:4642,]
test_2 <- rssi_lg_rasp1[20: 40,]
dim(test_2)
test_2$timestamp= NULL

finger_train_target  <- head(unordered_finger_set$distance, 4622)

cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

#plot test + train fusi <- CAMBIARE COLORE DI TEST PLOT
train_plot <-   geom_point(data = finger_train,aes(x = echo_time,y = rssi, group=distance, color=distance)) 
test_plot <- stat_sum(data = finger_test,aes(x = echo_time,y = rssi, colour=distance)) 

g <- ggplot()
g + train_plot + test_plot


#controllare errore
lg_err<-numeric()

for(i in 1:100){
  lg_knn <- knn(finger_train , test_2, finger_train_target , k=i)
  lg_err <- c(lg_err, mean(lg_knn == test_2$distance))
  
}
dim(finger_train)
dim(finger_test)
dim(finger_train_target)
for(i in 1:100){
  lg_knn <- knn(finger_train , finger_test, finger_train_target , k=i)
  lg_err <- c(lg_err, mean(lg_knn == finger_test$distance))
  
}
plot(1-lg_err,type="l",ylab="Error Rate",
     xlab="K",main="Error Rate for LG With Varying K")


##### k-NN solo RSSI #####

finger_train_mono <- unordered_finger_set[1:4622, 1]
#finger_test_mono <- unordered_finger_set[4633:4642,3] li prendo dal mio set
dim(finger_train_mono)
#dim(finger_test_mono)

test_mono <- rssi_lg_rasp1[2500: 2940,4]
test_mono
dim(test_mono)


finger_train_target_mono  <- head(unordered_finger_set$distance, 4622)
#length(finger_train_target_mono)

#controllare errore
lg_err_mono<-numeric()
for(i in 1:100){
  lg_knn_mono <- knn(finger_train_mono , test_mono, finger_train_target_mono , k=i)
  lg_err_mono <- c(lg_err_mono, mean(lg_knn_mono == test_mono$distance))
  
}
plot(1-lg_err_mono,type="l",ylab="Error Rate",
     xlab="K",main="Error Rate for LG only RSSI With Varying K")

##### k-NN RSSI + RX #####
#Info iniziali
LG_FINGERPRINT_CORRIDOIO_RX <- read_csv("~/Documents/R_files/RSSIvsRX/data/LG_FINGERPRINT_CORRIDOIO_RX.csv")
TAB_FINGERPRINT_CORRIDOIO_RX <- read_csv("~/Documents/R_files/RSSIvsRX/data/TAB_FINGERPRINT_CORRIDOIO_RX.csv")

colnames(LG_FINGERPRINT_CORRIDOIO_RX)[4] <- "distance"
colnames(TAB_FINGERPRINT_CORRIDOIO_RX)[4] <- "distance"

ggplot(data = LG_FINGERPRINT_CORRIDOIO_RX,aes(x = rx,y = rssi, group=distance, color=distance)) + stat_sum() + ggtitle("LG RSSI/RX distanza")
ggplot(data = TAB_FINGERPRINT_CORRIDOIO_RX,aes(x = rx,y = rssi, group=distance, color=distance)) + stat_sum() + ggtitle("LG RSSI/RX distanza")


bplot_tab_finger <- ggplot(aes(y = rssi, x = factor(distance), color= distance), data = TAB_FINGERPRINT_CORRIDOIO_RX)
bplot_tab_finger <- bplot_tab_finger + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)
bplot_tab_finger <- bplot_tab_finger + ggtitle("TAB fingerprint: RSSI media, st dev +/- media") + xlab("Distanza") + ylab("RSSI")
bplot_tab_finger

bplot_tab_finger_rx <- ggplot(aes(y = rx, x = factor(distance), color= distance), data = TAB_FINGERPRINT_CORRIDOIO_RX)
bplot_tab_finger_rx <- bplot_tab_finger_rx + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)
bplot_tab_finger_rx <- bplot_tab_finger_rx + ggtitle("TAB fingerprint: RSSI media, st dev +/- media") + xlab("Distanza") + ylab("RSSI")
bplot_tab_finger_rx


#knn rssi/rx samsung

finger_train_tab <- TAB_FINGERPRINT_CORRIDOIO_RX
finger_test_tab <- subset(visual_sam_1, distance == "02")
finger_test_tab
dim(finger_test_tab)
dim(finger_train_tab)
finger_train_tab$timestamp=NULL
finger_test_tab$timestamp=NULL

finger_train_target_tab  <- TAB_FINGERPRINT_CORRIDOIO_RX$distance

#plot test + train fusi <- CAMBIARE COLORE DI TEST PLOT
train_plot <-   geom_point(data = finger_train_tab,aes(x = rx,y = rssi, group=distance, color=distance)) 
test_plot <- stat_sum(data = finger_test_tab,aes(x = rx,y = rssi, colour=distance))
g <- ggplot()
g + train_plot + test_plot


#controllare errore
tab_err<-numeric()

for(i in 1:100){
  tab_knn <- knn(finger_train_tab , finger_test_tab, finger_train_target_tab , k=i)
  tab_err <- c(tab_err, mean(tab_knn == finger_test_tab$distance))
  
}
plot(1-tab_err,type="l",ylab="Error Rate",
     xlab="K",main="Error Rate for TAB RSSI/RX With Varying K")

#In alcuni casi è abbastanza alto


unmetro_lg <- subset(LG_FINGERPRINT_CORRIDOIO, LG_FINGERPRINT_CORRIDOIO$distance == "01")
mean(unmetro_lg$rssi)

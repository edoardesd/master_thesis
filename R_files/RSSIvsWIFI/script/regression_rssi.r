# Year: 2017
# Title: Regrezzione
# Goal: Capire dipendenza tra rssi e WIFI rx
# Author: Edoardo Longo
#
# 

# Define your working directory
# Ensure to use the forward / slash 
setwd("/Users/edoardesd/Documents/R_files")
getwd()

#es: DATASET: timestamp | rssi |  rx(wifi)
#               12:24:23|  -10 | -68

#INIZIO IMPORT
require(class)
library(readr)
require(ggplot2)
library(readxl)
ipad_distanze_tutte <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/ipad_distanze_tutte.csv")
ipad_movimento <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/ipad_movimento.csv")
tab_movimento <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/tab_movimento.csv")
s3_distanze_tutte <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/s3_distanze_tutte.csv")
tab_distanze_tutte <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/tab_distanze_tutte.csv")
ipad_distanze <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/ipad_distanze.csv")
s3_distanze <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/s3_distanze.csv")
tab_distanze <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/tab_distanze.csv")
movimentato_lg <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/movimentato_lg.csv")
movimentato_lg_milli <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/movimentato_lg_milli.csv")
sams_wifiVSbt <- read_excel("~/Documents/R_files/RSSIvsWIFI/data/sams_wifiVSbt.xlsx")
lg_wifiVSbt <- read_excel("~/Documents/R_files/RSSIvsWIFI/data/lg_wifiVSbt.xlsx", col_types = c("text", "numeric", "numeric"))
ipad_filtro <- read_csv("~/Documents/TEST/TEST_2/ipad_movimento/ipad_filtro.csv")
lg_filtro <- read_csv("~/Documents/TEST/TEST_2/movimentato/lg_filtro.csv")



colnames(s3_distanze)[1] <- "rssi"
colnames(s3_distanze)[2] <- "rx"
colnames(ipad_distanze)[1] <- "rssi"
colnames(ipad_distanze)[2] <- "rx"
colnames(tab_distanze)[1] <- "rssi"
colnames(tab_distanze)[2] <- "rx"
tab_distanze = tab_distanze[-6,]
tab_distanze = tab_distanze[-8,]
ipad_distanze = ipad_distanze[-6,]

#LG
plot(lg_wifiVSbt$wifi, lg_wifiVSbt$bluetooth)
lgdist.lm = lm(lg_wifiVSbt$wifi ~ lg_wifiVSbt$bluetooth)
abline(lm(lg_wifiVSbt$bluetooth ~ lg_wifiVSbt$wifi))
summary(lgdist.lm)$r.squared 

#SAMS
plot(sams_wifiVSbt$wifi, sams_wifiVSbt$bluetooth)
sams.lm = lm(sams_wifiVSbt$wifi ~ sams_wifiVSbt$bluetooth)
abline(lm(sams_wifiVSbt$bluetooth ~ sams_wifiVSbt$wifi))
summary(sams.lm)$r.squared 

#LG movimento
plot(movimentato_lg_milli$rssi, movimentato_lg_milli$rx)
abline(lm(movimentato_lg_milli$rx ~ movimentato_lg_milli$rssi))
plot(movimentato_lg$rssi, movimentato_lg$rx)
abline(lm(movimentato_lg$rx ~ movimentato_lg$rssi))
lg.lm = lm(movimentato_lg$rx ~ movimentato_lg$rssi)
summary(lg.lm)$r.squared 
fit <- lm(movimentato_lg$rx~log(abs(movimentato_lg$rssi)))


rssi_abs_lg = abs(movimentato_lg$rssi)
rx_abs_lg = abs(movimentato_lg$rx)
plot(rssi_abs_lg, rx_abs_lg)
glm(rssi_abs_lg, rx_abs_lg)
fit <- lm(rx_abs_lg~rssi_abs_lg)
summary(fit)

ggplot(movimentato_lg, aes(x=rssi, y=rx)) + geom_point() +stat_smooth(method="glm", se=FALSE)

#TAB movimento
plot(tab_movimento$rssi, tab_movimento$rx)
abline(lm(tab_movimento$rx ~ tab_movimento$rssi))
tab.lm = lm(tab_movimento$rx ~ tab_movimento$rssi)
summary(tab.lm)$r.squared 

#IPAD movimento
plot(ipad_movimento$rssi, ipad_movimento$rx)
abline(lm(ipad_movimento$rx ~ ipad_movimento$rssi))
ipad.lm = lm(ipad_movimento$rx ~ ipad_movimento$rssi)
summary(ipad.lm)$r.squared 

plot(ipad_filtro$rssi, ipad_filtro$rx)
plot(lg_filtro$rssi, lg_filtro$rx)
abline(lm(ipad_filtro$rx ~ ipad_filtro$rssi))
ipad_filtro.lm = lm(ipad_filtro$rx ~ ipad_filtro$rssi)
summary(ipad_filtro.lm)$r.squared
ipad_pos = ipad_filtro
lg_pos = lg_filtro
lg_pos$rssi = abs(lg_filtro$rssi) + 0.001
lg_pos$rx = abs(lg_filtro$rx)
plot(lg_pos$rssi, lg_pos$rx)
ipad_pos$rssi = abs(ipad_filtro$rssi) + 0.001
ipad_pos$rx = abs(ipad_filtro$rx)
plot(ipad_pos$rssi, ipad_pos$rx)
log_ipad = glm(ipad_pos$rx ~ ipad_pos$rssi)
linear_ipad_1 = lm(ipad_pos$rx ~ ipad_pos$rssi)
linear_ipad_2 = lm(ipad_pos$rx ~ poly(ipad_pos$rssi,2,raw=TRUE))
linear_ipad_3 = lm(ipad_pos$rx ~ poly(ipad_pos$rssi,3,raw=TRUE))
linear_ipad_4 = lm(ipad_pos$rx ~ poly(ipad_pos$rssi,4,raw=TRUE))

ip.lm <- predict(linear_ipad)
ip.log <- predict(log_ipad)
lines(ip.log, col="blue", lwd=2)


plot(ipad_pos$rssi, ipad_pos$rx)
fit <- lm(ipad_pos$rx~log(ipad_pos$rssi))
dim(ipad_pos)
n = 163
x=seq(0,100, length=163)
y=predict(fit,newdata=list(x=seq(from=1,to=n,length.out=1000)), interval="confidence")
matlines(x,y,lwd=2)
dim(x)
dim(y)


xx <- seq(0,100, length=163)
lines(ipad_pos, predict(linear_ipad_1, data.frame(x=ipad_pos)), col="red")
lines(xx, predict(linear_ipad_2, data.frame(x=xx)), col="red")
lines(xx, predict(linear_ipad_3, data.frame(x=xx)), col="red")
lines(xx, predict(linear_ipad_4, data.frame(x=xx)), col="red")

#write.csv(ipad_pos, "ipad_positivi.csv")

#S3
plot(s3_distanze_tutte$rssi, s3_distanze_tutte$rx)
abline(lm(s3_distanze_tutte$rx ~ s3_distanze_tutte$rssi))
s3.lm = lm(s3_distanze_tutte$rx ~ s3_distanze_tutte$rssi)
summary(s3.lm)$r.squared 
lm(s3_distanze_tutte$rx ~ s3_distanze_tutte$rssi)
#plot(ipad_distanze_tutte$rssi, ipad_distanze_tutte$rx)
#abline(lm(ipad_distanze$rx ~ ipad_distanze$rssi))
#plot(tab_distanze_tutte$rssi, tab_distanze_tutte$rx)
#abline(lm(tab_distanze$rx ~ tab_distanze$rssi))

subset(lg_wifiVSbt, lg_wifiVSbt$distance == "01")


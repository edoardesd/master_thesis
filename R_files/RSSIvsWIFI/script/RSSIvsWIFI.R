# Year: 2017
# Title: Test Lineare, due raspberry pi e dispositivi a distanze note da 2 a 10 metri
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
tab_distanze <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/disti.csv",  col_types = cols(rssi = col_number(), rx = col_number()))
movimentato_lg <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/movimentato_lg.csv")
movimentato_lg_milli <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/movimentato_lg_milli.csv")
sams_wifiVSbt <- read_excel("~/Documents/R_files/RSSIvsWIFI/data/sams_wifiVSbt.xlsx", col_types = c("numeric"))
lg_wifiVSbt <- read_excel("~/Documents/R_files/RSSIvsWIFI/data/lg_wifiVSbt.xlsx", col_types = c("numeric", "numeric", "numeric"))
LG_WIFI_rssi_rx <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/LG_WIFI_rssi+rx.csv")
SAMS_WIFI_rssi_rx <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/SAMS_WIFI_rssi+rx.csv")
SAMS_1milli <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/SAMS_1milli.csv")
LG_1milli <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/LG_1milli.csv")


colnames(LG_WIFI_rssi_rx)[4] <- "distance"
colnames(SAMS_WIFI_rssi_rx)[4] <- "distance"
colnames(SAMS_1milli)[4] <- "distance"
colnames(LG_1milli)[4] <- "distance"
colnames(s3_distanze)[1] <- "rssi"
colnames(s3_distanze)[2] <- "rx"
colnames(ipad_distanze)[1] <- "rssi"
colnames(ipad_distanze)[2] <- "rx"
#colnames(tab_distanze)[1] <- "rssi"
#colnames(tab_distanze)[2] <- "rx"
#tab_distanze = tab_distanze[-6,]
#tab_distanze = tab_distanze[-8,]
#ipad_distanze = ipad_distanze[-6,]

###### LG ######
ggplot(data = LG_WIFI_rssi_rx,aes(x = distance,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("LG WIFI distance")
ggplot(data = LG_WIFI_rssi_rx,aes(x = distance,y = rssi, group=distance, color=distance)) + stat_sum() + ggtitle("LG RSSI distance")

ggplot(data = LG_WIFI_rssi_rx,aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("LG WIFI rssiVSrx")

ggplot(data = LG_1milli,aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("LG precisione decimo secondi")
plot(lg_wifiVSbt$wifi, lg_wifiVSbt$bluetooth)
abline(lm(lg_wifiVSbt$bluetooth ~ lg_wifiVSbt$wifi))

#da wifi a distanze 
plot(lg_wifiVSbt$wifi, lg_wifiVSbt$distance)
abline(lm(lg_wifiVSbt$distance ~ lg_wifiVSbt$wifi))

lm(sams_wifiVSbt$distance ~ sams_wifiVSbt$wifi)
lm(s3_distanze_tutte$distance ~ s3_distanze_tutte$rx)
lm(tab_distanze_tutte$distance ~ tab_distanze_tutte$rx)
lm(ipad_distanze_tutte$distance ~ ipad_distanze_tutte$rx)

#da bt a distanze
lm(lg_wifiVSbt$distance ~ lg_wifiVSbt$bluetooth)

plot(sams_wifiVSbt$bluetooth ~ sams_wifiVSbt$distance)
lm(s3_distanze_tutte$distance ~ s3_distanze_tutte$rssi)
lm(tab_distanze_tutte$distance ~ tab_distanze_tutte$rssi)
lm(ipad_distanze_tutte$distance ~ ipad_distanze_tutte$rssi)

plot(sams_wifiVSbt$wifi, sams_wifiVSbt$bluetooth)
lgdist.lm = lm(lg_wifiVSbt$wifi ~ lg_wifiVSbt$bluetooth)
sams.lm = lm(sams_wifiVSbt$wifi ~ sams_wifiVSbt$bluetooth)
summary(lgdist.lm)$r.squared 
summary(sams.lm)$r.squared 
abline(lm(sams_wifiVSbt$bluetooth ~ sams_wifiVSbt$wifi))

plot(movimentato_lg_milli$rssi, movimentato_lg_milli$rx)
abline(lm(movimentato_lg_milli$rx ~ movimentato_lg_milli$rssi))

plot(tab_movimento$rssi, tab_movimento$rx)
abline(lm(tab_movimento$rx ~ tab_movimento$rssi))

plot(ipad_movimento$rssi, ipad_movimento$rx)
abline(lm(ipad_movimento$rx ~ ipad_movimento$rssi))
ipad.lm = lm(ipad_movimento$rx ~ ipad_movimento$rssi)
summary(ipad.lm)$r.squared 

plot(movimentato_lg$rssi, movimentato_lg$rx)
abline(lm(movimentato_lg$rx ~ movimentato_lg$rssi))
lg.lm = lm(movimentato_lg$rx ~ movimentato_lg$rssi)
summary(lg.lm)$r.squared 

plot(s3_distanze_tutte$rssi, s3_distanze_tutte$rx)
abline(lm(s3_distanze_tutte$rx ~ s3_distanze_tutte$rssi))
s3.lm = lm(s3_distanze_tutte$rx ~ s3_distanze_tutte$rssi)
summary(s3.lm)$r.squared 

lm(s3_distanze_tutte$rx ~ s3_distanze_tutte$rssi)
#plot(ipad_distanze_tutte$rssi, ipad_distanze_tutte$rx)
#abline(lm(ipad_distanze$rx ~ ipad_distanze$rssi))
#plot(tab_distanze_tutte$rssi, tab_distanze_tutte$rx)
#abline(lm(tab_distanze$rx ~ tab_distanze$rssi))

ggplot(data = subset(LG_WIFI_rssi_rx, distance=="02"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("LG WIFI rssiVSrx 2 metri") + geom_abline(intercept = -69.492104, slope = 0.001928)
ggplot(data = subset(LG_WIFI_rssi_rx, distance=="03"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("LG WIFI rssiVSrx 3 metri") + geom_abline(intercept = -75.538239, slope = -0.005886)
ggplot(data = subset(LG_WIFI_rssi_rx, distance=="04"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("LG WIFI rssiVSrx 4 metri") + geom_abline(intercept = -76.55839, slope = -0.09703)
ggplot(data = subset(LG_WIFI_rssi_rx, distance=="05"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("LG WIFI rssiVSrx 5 metri") + geom_abline(intercept = -72.70959, slope = 0.03244)
ggplot(data = subset(LG_WIFI_rssi_rx, distance=="06"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("LG WIFI rssiVSrx 6 metri") + geom_abline(intercept = -79.332647, slope = -0.003577)
ggplot(data = subset(LG_WIFI_rssi_rx, distance=="07"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("LG WIFI rssiVSrx 7 metri") + geom_abline(intercept = -75.64089, slope = 0.04908)
ggplot(data = subset(LG_WIFI_rssi_rx, distance=="08"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("LG WIFI rssiVSrx 8 metri") + geom_abline(intercept = -82.60443, slope = -0.09167)
ggplot(data = subset(LG_WIFI_rssi_rx, distance=="09"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("LG WIFI rssiVSrx 9 metri") + geom_abline(intercept = -70.986, slope = 0.314)
ggplot(data = subset(LG_WIFI_rssi_rx, distance=="10"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("LG WIFI rssiVSrx 10 metri") + geom_abline(intercept = -79.8382, slope = 0.1691)


###### SAMS ######
ggplot(data = SAMS_WIFI_rssi_rx,aes(x = distance,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS WIFI distance")
ggplot(data = SAMS_WIFI_rssi_rx,aes(x = distance,y = rssi, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS WIFI distance")

ggplot(data = SAMS_WIFI_rssi_rx,aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS WIFI rssiVSrx")


ggplot(data = subset(SAMS_WIFI_rssi_rx, distance=="02"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS WIFI rssiVSrx 2 metri") + geom_abline(intercept = -57.17278, slope = 0.06604)
ggplot(data = subset(SAMS_WIFI_rssi_rx, distance=="03"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS WIFI rssiVSrx 3 metri") + geom_abline(intercept = -63.544673, slope = 0.004319)
ggplot(data = subset(SAMS_WIFI_rssi_rx, distance=="04"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS WIFI rssiVSrx 4 metri") + geom_abline(intercept = -58.94305, slope = -0.03643)
ggplot(data = subset(SAMS_WIFI_rssi_rx, distance=="05"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS WIFI rssiVSrx 5 metri") + geom_abline(intercept = -63.29443, slope = 0.07733)
ggplot(data = subset(SAMS_WIFI_rssi_rx, distance=="06"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS WIFI rssiVSrx 6 metri") + geom_abline(intercept = -76.700, slope = -0.041)
ggplot(data = subset(SAMS_WIFI_rssi_rx, distance=="07"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS WIFI rssiVSrx 7 metri") + geom_abline(intercept = -86.16365, slope = -0.02398)
ggplot(data = subset(SAMS_WIFI_rssi_rx, distance=="08"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS WIFI rssiVSrx 8 metri") + geom_abline(intercept = -73.92652, slope = -0.02643)
ggplot(data = subset(SAMS_WIFI_rssi_rx, distance=="09"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS WIFI rssiVSrx 9 metri") + geom_abline(intercept = -82.4991, slope = 0.1214)
ggplot(data = subset(SAMS_WIFI_rssi_rx, distance=="10"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS WIFI rssiVSrx 10 metri") + geom_abline(intercept = -72.93996, slope = 0.04053)

ggplot(data = SAMS_1milli,aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS precisione decimo secondi")

ggplot(data = subset(SAMS_WIFI_rssi_rx, distance=="02"),aes(x = rssi,y = rx, group=distance, color=distance)) + stat_sum() + ggtitle("SAMS WIFI rssiVSrx 2 metri")
plot(subset(SAMS_WIFI_rssi_rx, distance=="02")$rssi,subset(SAMS_WIFI_rssi_rx, distance=="02")$rx)
lm(subset(SAMS_WIFI_rssi_rx, distance=="03")$rx ~ subset(SAMS_WIFI_rssi_rx, distance=="03")$rssi)
mean(subset(SAMS_WIFI_rssi_rx, distance=="03")$rx)


min.mean.sd.max <- function(x) {
  r <- c(min(x), mean(x) - sd(x), mean(x), mean(x) + sd(x), max(x))
  names(r) <- c("ymin", "lower", "middle", "upper", "ymax")
  r
}

bplot_sam1_rssi <- ggplot(aes(y = rssi, x = factor(distance), color= distance), data = LG_WIFI_rssi_rx)
bplot_sam1_rssi <- bplot_sam1_rssi + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)
bplot_sam1_rssi <- bplot_sam1_rssi + ggtitle("LG") + xlab("Distanza") + ylab("RSSI") 
bplot_sam1_rssi


mean(subset(LG_WIFI_rssi_rx$rx, LG_WIFI_rssi_rx$distance == "02"))

c(mean(subset(SAMS_WIFI_rssi_rx$rssi, SAMS_WIFI_rssi_rx$distance == "02")), mean(subset(SAMS_WIFI_rssi_rx$rssi, SAMS_WIFI_rssi_rx$distance == "03")), mean(subset(SAMS_WIFI_rssi_rx$rssi, SAMS_WIFI_rssi_rx$distance == "04")), mean(subset(SAMS_WIFI_rssi_rx$rssi, SAMS_WIFI_rssi_rx$distance == "05")), mean(subset(SAMS_WIFI_rssi_rx$rssi, SAMS_WIFI_rssi_rx$distance == "06")), mean(subset(SAMS_WIFI_rssi_rx$rssi, SAMS_WIFI_rssi_rx$distance == "07")), mean(subset(SAMS_WIFI_rssi_rx$rssi, SAMS_WIFI_rssi_rx$distance == "08")), mean(subset(SAMS_WIFI_rssi_rx$rssi, SAMS_WIFI_rssi_rx$distance == "09")), mean(subset(SAMS_WIFI_rssi_rx$rssi, SAMS_WIFI_rssi_rx$distance == "10")))

plot(movimentato_lg_milli)


#disegnare i log di tutti i dispositivi
#LOGARITMICO
ggplot() + geom_point(data=s3_distanze, aes(x=abs(distance), y=abs(rssi)), color = 'blue') + stat_smooth(data=s3_distanze, aes(x=abs(distance), y=abs(rssi)),method="lm",formula=y~log(x), se=FALSE, color = 'blue', fullrange = TRUE) + 
  geom_point(data=sams_wifiVSbt, aes(x=abs(distance), y=abs(bluetooth)), color = 'red') + stat_smooth(data=sams_wifiVSbt, aes(x=abs(distance), y=abs(bluetooth)), method="lm",formula=y~log(x), se=FALSE, color = 'red', fullrange = TRUE) + 
  geom_point(data=lg_wifiVSbt, aes(x=abs(distance), y=abs(bluetooth)), color = 'green') + stat_smooth(data=lg_wifiVSbt, aes(x=abs(distance), y=abs(bluetooth)), method="lm",formula=y~log(x), se=FALSE, color = 'green', fullrange = FALSE) +
  geom_point(data=tab_distanze, aes(x=abs(distance), y=abs(rssi)), color = 'yellow') + stat_smooth(data=tab_distanze, aes(x=abs(distance), y=abs(rssi)), method="lm",formula=y~log(x), se=FALSE, color = 'yellow', fullrange = TRUE) + 
  geom_point(data=ipad_distanze, aes(x=abs(distance), y=abs(rssi)), color = 'black') + stat_smooth(data=ipad_distanze, aes(x=abs(distance), y=abs(rssi)), method="lm",formula=y~log(x), se=FALSE, color = 'black', fullrange = TRUE) #+ coord_cartesian(ylim = c(50, 90))

  
ggplot() + geom_point(data=s3_distanze, aes(x=abs(distance), y=abs(rx)), color = 'blue') + stat_smooth(data=s3_distanze, aes(x=abs(distance), y=abs(rx)),method="lm",formula=y~log(x), se=FALSE, color = 'blue', fullrange = TRUE) + 
  geom_point(data=sams_wifiVSbt, aes(x=abs(distance), y=abs(wifi)), color = 'red') + stat_smooth(data=sams_wifiVSbt, aes(x=abs(distance), y=abs(wifi)), method="lm",formula=y~log(x), se=FALSE, color = 'red', fullrange = TRUE) + 
  geom_point(data=lg_wifiVSbt, aes(x=abs(distance), y=abs(wifi)), color = 'green') + stat_smooth(data=lg_wifiVSbt, aes(x=abs(distance), y=abs(wifi)), method="lm",formula=y~log(x), se=FALSE, color = 'green', fullrange = FALSE) +
  geom_point(data=tab_distanze, aes(x=abs(distance), y=abs(rx)), color = 'yellow') + stat_smooth(data=tab_distanze, aes(x=abs(distance), y=abs(rx)), method="lm",formula=y~log(x), se=FALSE, color = 'yellow', fullrange = TRUE) + 
  geom_point(data=ipad_distanze, aes(x=abs(distance), y=abs(rx)), color = 'black') + stat_smooth(data=ipad_distanze, aes(x=abs(distance), y=abs(rx)), method="lm",formula=y~log(x), se=FALSE, color = 'black', fullrange = TRUE) #+ coord_cartesian(ylim = c(50, 90))



### LINEARE
ggplot() + geom_point(data=s3_distanze, aes(x=abs(distance), y=abs(rssi)), color = 'blue') + stat_smooth(data=s3_distanze, aes(x=abs(distance), y=abs(rssi)),method="lm", se=FALSE, color = 'blue', fullrange = TRUE) + 
  geom_point(data=sams_wifiVSbt, aes(x=abs(distance), y=abs(bluetooth)), color = 'red') + stat_smooth(data=sams_wifiVSbt, aes(x=abs(distance), y=abs(bluetooth)), method="lm", se=FALSE, color = 'red', fullrange = TRUE) + 
  geom_point(data=lg_wifiVSbt, aes(x=abs(distance), y=abs(bluetooth)), color = 'green') + stat_smooth(data=lg_wifiVSbt, aes(x=abs(distance), y=abs(bluetooth)), method="lm", se=FALSE, color = 'green', fullrange = FALSE) +
  geom_point(data=tab_distanze, aes(x=abs(distance), y=abs(rssi)), color = 'yellow') + stat_smooth(data=tab_distanze, aes(x=abs(distance), y=abs(rssi)), method="lm", se=FALSE, color = 'yellow', fullrange = TRUE) + 
  geom_point(data=ipad_distanze, aes(x=abs(distance), y=abs(rssi)), color = 'black') + stat_smooth(data=ipad_distanze, aes(x=abs(distance), y=abs(rssi)), method="lm", se=FALSE, color = 'black', fullrange = TRUE) #+ coord_cartesian(ylim = c(50, 90))


ggplot() + geom_point(data=s3_distanze, aes(x=abs(distance), y=abs(rx)), color = 'blue') + stat_smooth(data=s3_distanze, aes(x=abs(distance), y=abs(rx)),method="lm", se=FALSE, color = 'blue', fullrange = TRUE) + 
  geom_point(data=sams_wifiVSbt, aes(x=abs(distance), y=abs(wifi)), color = 'red') + stat_smooth(data=sams_wifiVSbt, aes(x=abs(distance), y=abs(wifi)), method="lm", se=FALSE, color = 'red', fullrange = TRUE) + 
  geom_point(data=lg_wifiVSbt, aes(x=abs(distance), y=abs(wifi)), color = 'green') + stat_smooth(data=lg_wifiVSbt, aes(x=abs(distance), y=abs(wifi)), method="lm", se=FALSE, color = 'green', fullrange = FALSE) +
  geom_point(data=tab_distanze, aes(x=abs(distance), y=abs(rx)), color = 'yellow') + stat_smooth(data=tab_distanze, aes(x=abs(distance), y=abs(rx)), method="lm", se=FALSE, color = 'yellow', fullrange = TRUE) + 
  geom_point(data=ipad_distanze, aes(x=abs(distance), y=abs(rx)), color = 'black') + stat_smooth(data=ipad_distanze, aes(x=abs(distance), y=abs(rx)), method="lm", se=FALSE, color = 'black', fullrange = TRUE) #+ coord_cartesian(ylim = c(50, 90))


ggplot(data=tab_di, aes(x=abs(rssi), y=abs(rx))) + geom_point(data=tab_di, aes(x=abs(rssi), y=abs(rx))) + geom_line(data=tab_di, aes(x=abs(rssi), y=abs(rx))) + stat_smooth(data=tab_di, aes(x=abs(rssi), y=abs(rx)), method="lm",formula=y~log(x), se=FALSE) + scale_x_continuous(limits = c(0, 15))
g2 <- ggplot(data=sams_wifiVSbt, aes(x=abs(bluetooth), y=abs(wifi))) + geom_point() #+ geom_line() #+ stat_smooth(method="lm",formula=y~log(x), se=FALSE) + scale_x_continuous(limits = c(0, 15))
g3 <- ggplot(data=lg_wifiVSbt, aes(x=abs(bluetooth), y=abs(wifi))) + geom_point() #+ geom_line() #+ stat_smooth(method="lm",formula=y~log(x), se=FALSE)+ scale_x_continuous(limits = c(0, 15))

gtot <- g1+g2+g3

# Year: 2017
# Title: Massa di cellulari, wifi acceso, schermo acceso/spento
# Goal: Capire numero di probe request
# Author: Edoardo Longo
#
# 

# Define your working directory
# Ensure to use the forward / slash 
setwd("/Users/edoardesd/Documents/R_files")
getwd()



#INIZIO IMPORT
require(class)
library(readr)
require(ggplot2)

##### IMPORT ####

probe_wifi_spento <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/probe_wifi_spento.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%OS")))
probe_wifi_acceso <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/probe_wifi_acceso.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%OS")))

probe2_spento <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/probe2_spento.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%OS")))
probe2_acceso <- read_csv("~/Documents/R_files/RSSIvsWIFI/data/probe2_acceso.csv", col_types = cols(timestamp = col_time(format = "%H:%M:%OS")))

lg_original_off_wifi <- read_csv("~/lg_original_off_wifi.csv")
lg_original_on_wifi <- read_csv("~/lg_original_on_wifi.csv")

dim(probe_wifi_acceso)
dim(probe_wifi_spento)

##### SUBSET####

lg_acceso = subset(probe_wifi_acceso, mac_address == 'C4:43:8F:B3:0A:F7')
s3_acceso = subset(probe_wifi_acceso, mac_address == 'C8:14:79:31:3C:2A')
tab_acceso = subset(probe_wifi_acceso, mac_address == '84:11:9E:FD:16:B3')
ipadpro_acceso = subset(probe_wifi_acceso, mac_address == 'A4:F1:E8:A9:DB:61')
ipad_acceso = subset(probe_wifi_acceso, mac_address == 'DC:A9:04:4F:D9:35')
asus_acceso = subset(probe_wifi_acceso, mac_address == '34:97:F6:B8:E7:E3')
mac_acceso = subset(probe_wifi_acceso, mac_address == '98:01:A7:B6:B2:BD')

lg_spento = subset(probe_wifi_spento, mac_address == 'C4:43:8F:B3:0A:F7')
s3_spento = subset(probe_wifi_spento, mac_address == 'C8:14:79:31:3C:2A')
tab_spento = subset(probe_wifi_spento, mac_address == '84:11:9E:FD:16:B3')
ipadpro_spento = subset(probe_wifi_spento, mac_address == 'A4:F1:E8:A9:DB:61')
ipad_spento = subset(probe_wifi_spento, mac_address == 'DC:A9:04:4F:D9:35')
asus_spento = subset(probe_wifi_spento, mac_address == '34:97:F6:B8:E7:E3')
mac_spento = subset(probe_wifi_spento, mac_address == '98:01:A7:B6:B2:BD')


lg_acceso_2 = subset(probe2_acceso, mac_address == 'C4:43:8F:B3:0A:F7')
sams_acceso_2 = subset(probe2_acceso, mac_address == 'D8:90:E8:29:AD:3F')
s3_acceso_2 = subset(probe2_acceso, mac_address == 'C8:14:79:31:3C:2A')
tab_acceso_2 = subset(probe2_acceso, mac_address == '84:11:9E:FD:16:B3')
ipadpro_acceso_2 = subset(probe2_acceso, mac_address == 'A4:F1:E8:A9:DB:61')
ipad_acceso_2 = subset(probe2_acceso, mac_address == 'DC:A9:04:4F:D9:35')
asus_acceso_2 = subset(probe2_acceso, mac_address == '34:97:F6:B8:E7:E3')
mac_acceso_2 = subset(probe2_acceso, mac_address == '98:01:A7:B6:B2:BD')

lg_spento_2 = subset(probe2_spento, mac_address == 'C4:43:8F:B3:0A:F7')
sams_spento_2 = subset(probe2_spento, mac_address == 'D8:90:E8:29:AD:3F')
s3_spento_2 = subset(probe2_spento, mac_address == 'C8:14:79:31:3C:2A')
tab_spento_2 = subset(probe2_spento, mac_address == '84:11:9E:FD:16:B3')
ipadpro_spento_2 = subset(probe2_spento, mac_address == 'A4:F1:E8:A9:DB:61')
ipad_spento_2 = subset(probe2_spento, mac_address == 'DC:A9:04:4F:D9:35')
asus_spento_2 = subset(probe2_spento, mac_address == '34:97:F6:B8:E7:E3')
mac_spento_2 = subset(probe2_spento, mac_address == '98:01:A7:B6:B2:BD')

colnames(lg_original_off_wifi)[1] <- "mac_address"
colnames(lg_original_on_wifi)[1] <- "mac_address"


lg_spento_original = subset(lg_original_off_wifi, mac_address == 'C4:43:8F:B3:0A:F7')
lg_acceso_original = subset(lg_original_on_wifi, mac_address == 'C4:43:8F:B3:0A:F7')



##### CREO FRAME ####

on_frame = data.frame(
  group = c("lg", "s3", "tab", "ipadpro", "ipad", "asus", "mac"),
  value = c(dim(lg_acceso)[1], dim(s3_acceso)[1], dim(tab_acceso)[1], dim(ipadpro_acceso)[1], dim(ipad_acceso)[1], dim(asus_acceso)[1], dim(mac_acceso)[1])
  )

off_frame = data.frame(
  group = c("lg", "s3", "tab", "ipadpro", "ipad", "asus", "mac"),
  value = c(dim(lg_spento)[1], dim(s3_spento)[1], dim(tab_spento)[1], dim(ipadpro_spento)[1], dim(ipad_spento)[1], dim(asus_spento)[1], dim(mac_spento)[1])
)

on_frame2 = data.frame(
  group = c("lg", "s3", "tab", "ipadpro", "ipad", "asus", "mac", "sam s"),
  value = c(dim(lg_acceso_2)[1], dim(s3_acceso_2)[1], dim(tab_acceso_2)[1], dim(ipadpro_acceso_2)[1], dim(ipad_acceso_2)[1], dim(asus_acceso_2)[1], dim(mac_acceso_2)[1], dim(sams_acceso_2)[1])
)

off_frame2 = data.frame(
  group = c("lg", "s3", "tab", "ipad", "asus", "sam s"),
  value = c(dim(lg_spento_2)[1], dim(s3_spento_2)[1], dim(tab_spento_2)[1], dim(ipad_spento_2)[1], dim(asus_spento_2)[1], dim(sams_spento_2)[1])
)


original_vs_mod_spento = data.frame(
  group = c("original", "mod"),
  value = c(dim(lg_spento_original)[1], dim(lg_spento_2)[1])
)


original_vs_mod_acceso = data.frame(
  group = c("original", "mod"),
  value = c(dim(lg_acceso_original)[1], dim(lg_acceso_2)[1])
)
##### PLOT #####

bp_acceso<- ggplot(on_frame, aes(x="", y=value, fill=group))+
  geom_bar(width = 1, stat = "identity")
pie_acceso <- bp_acceso + coord_polar("y", start=0) + ggtitle("Schermo Acceso")
pie_acceso

vs_acceso<- ggplot(original_vs_mod_acceso, aes(x="", y=value, fill=group))+
  geom_bar(width = 1, stat = "identity")
vs_original_acceso <- vs_acceso + coord_polar("y", start=0) + ggtitle("Schermo Acceso")
vs_original_acceso

vs_spento<- ggplot(original_vs_mod_spento, aes(x="", y=value, fill=group))+
  geom_bar(width = 1, stat = "identity")
vs_original_spento <- vs_spento + coord_polar("y", start=0) + ggtitle("Schermo spento")
vs_original_spento

bp_spento<- ggplot(off_frame, aes(x="", y=value, fill=group))+
  geom_bar(width = 1, stat = "identity")
pie_spento <- bp_spento + coord_polar("y", start=0) + ggtitle("Schermo Spento")
pie_spento


bp2_acceso<- ggplot(on_frame2, aes(x="", y=value, fill=group))+
  geom_bar(width = 1, stat = "identity")
pie2_acceso <- bp2_acceso + coord_polar("y", start=0) + ggtitle("Schermo Acceso prova 2")
pie2_acceso


bp2_spento<- ggplot(off_frame2, aes(x="", y=value, fill=group))+
  geom_bar(width = 1, stat = "identity")
pie2_spento <- bp2_spento + coord_polar("y", start=0) + ggtitle("Schermo Spento prova 2")
pie2_spento


barplot(on_frame$value, names=on_frame$group, ylim=c(0,3000), main="Schermo acceso")
barplot(off_frame$value, names=off_frame$group, ylim=c(0,3000), main="Schermo spento")


barplot(on_frame2$value, names=on_frame2$group, ylim=c(0,3000), main="Schermo acceso prova 2")
barplot(off_frame2$value, names=off_frame2$group, ylim=c(0,3000), main="Schermo spento prova 2")

dim(lg_spento_2)
dim(sams_spento_2)
dim(s3_spento_2)
dim(tab_spento_2)
dim(ipad_spento_2)
dim(asus_spento_2)

dim(lg_acceso_2)
dim(sams_acceso_2)
dim(s3_acceso_2)
dim(tab_acceso_2)
dim(ipad_acceso_2)
dim(asus_acceso_2)

dim(lg_acceso_original)
dim(lg_spento_original)

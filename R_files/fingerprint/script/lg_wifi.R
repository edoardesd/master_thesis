setwd("/Users/edoardesd/Documents/master_thesis/R_files")
getwd()


library(readr)

v1_lg_wifi <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/lg_wifi_ok.csv")
v2_lg_wifi <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/lg_wifi_check_v2.csv")


v1_lg_wifi.mean = aggregate(.~location, data=v1_lg_wifi, mean)
v1_lg_wifi.mean <- v1_lg_wifi.mean[,c(2,3,4,5,1)]

v2_lg_wifi.mean = aggregate(.~location, data=v2_lg_wifi, mean)
v2_lg_wifi.mean <- v2_lg_wifi.mean[,c(2,3,4,5,1)]


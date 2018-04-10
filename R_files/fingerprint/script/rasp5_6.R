library(readr)
#IMPORT
rasp5_6_bluetooth <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/rasp5_6_bluetooth.csv")
rasp5_6_wifi <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/rasp5_6_wifi.csv")
avg_wifi <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/avg_wifi.csv")
avg_bluetooth <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/avg_bluetooth.csv")

#MERGE
avg_bluetooth_all <- cbind(avg_bluetooth[,-c(5,6)], rasp5_6_bluetooth)
avg_wifi_all <- cbind(avg_wifi[,-c(5,6)], rasp5_6_wifi)

#OUTPUT
write.csv(avg_bluetooth_all[,-c(7,8)], file = "df_completo_bt.txt",row.names=FALSE)
write.csv(avg_wifi_all[,-c(7,8)], file = "df_completo_wifi.txt",row.names=FALSE)

#NORM
max(avg_bluetooth_all[6])

normalize_wifi <- function(x) { return ((x + 91.7776) / (-44.5000 + 91.7776)) }
normalize_bt <- function(x) { return ((x + 35) / (6.4875 + 35)) }
normalize_line <- function(x) { return ((x - min(x)) / (max(x) - min(x))) }

avg_wifi_numbers = avg_wifi_all
avg_wifi_numbers$location = NULL
avg_wifi_numbers$device = NULL

avg_bluetooth_numbers = avg_bluetooth_all
avg_bluetooth_numbers$location = NULL
avg_bluetooth_numbers$device = NULL

#norm_generale
norm_wifi = t(apply(avg_wifi_numbers, 1, normalize_wifi))
norm_bluetooth = t(apply(avg_bluetooth_numbers, 1, normalize_bt))

#normalizzo su singole linee
norm_wifi_line = t(apply(avg_wifi_numbers,1,normalize_line))
norm_bluetooth_line = t(apply(avg_bluetooth_numbers,1,normalize_line))

#normalizzo su singole linee
norm_wifi_line_3 = t(apply(avg_wifi_numbers[-c(4,5,6)],1,normalize_line))
norm_bluetooth_line_3 = t(apply(avg_bluetooth_numbers[-c(4,5,6)],1,normalize_line))

#OUTPUT NORM
write.csv(norm_wifi_line, file = "df_completo_norm_line_wifi.txt",row.names=FALSE)
write.csv(norm_bluetooth_line, file = "df_completo_norm_line_bt.txt",row.names=FALSE)


###### FINGERPRINT ######
fingerprint_lg_rasp5_bt <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/fingerprint_lg_rasp5_bt.csv")
fingerprint_lg_rasp6_bt <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/fingerprint_lg_rasp6_bt.csv")
fingerprint_sams_rasp5_bt <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/fingerprint_sams_rasp5_bt.csv")
fingerprint_sams_rasp6_bt <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/fingerprint_sams_rasp6_bt.csv")
fingerprint_s3_rasp5_bt <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/fingerprint_s3_rasp5_bt.csv")
fingerprint_s3_rasp6_bt <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/fingerprint_s3_rasp6_bt.csv")


lg_finger_bt_56 <- cbind(fingerprint_lg_rasp5_bt[,-2], fingerprint_lg_rasp6_bt[,-2])
sams_finger_bt_56 <- cbind(fingerprint_sams_rasp5_bt[,-2], fingerprint_sams_rasp6_bt[,-2])
s3_finger_bt_56 <- cbind(fingerprint_lg_rasp5_bt[,-2], fingerprint_s3_rasp6_bt[,-2])

all_finger_bt_56 <- (lg_finger_bt_56 + sams_finger_bt_56 + s3_finger_bt_56)/3




fingerprint_lg_rasp5_wifi <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/fingerprint_lg_rasp5_wifi.csv")
fingerprint_lg_rasp6_wifi <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/fingerprint_lg_rasp6_wifi.csv")
fingerprint_sams_rasp5_wifi <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/fingerprint_sams_rasp5_wifi.csv")
fingerprint_sams_rasp6_wifi <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/fingerprint_sams_rasp6_wifi.csv")
fingerprint_s3_rasp5_wifi <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/fingerprint_s3_rasp5_wifi.csv")
fingerprint_s3_rasp6_wifi <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/fingerprint_s3_rasp6_wifi.csv")



lg_finger_wifi_56 <- cbind(fingerprint_lg_rasp5_wifi[,-2], fingerprint_lg_rasp6_wifi[,-2])
sams_finger_wifi_56 <- cbind(fingerprint_sams_rasp5_wifi[,-2], fingerprint_sams_rasp6_wifi[,-2])
s3_finger_wifi_56 <- cbind(fingerprint_lg_rasp5_wifi[,-2], fingerprint_s3_rasp6_wifi[,-2])

all_finger_wifi_56 <- (lg_finger_wifi_56 + sams_finger_wifi_56 + s3_finger_wifi_56)/3

#### CREAZIONE DATASET FINGERPRINT #### nome = f_6_dispositivo.bt/wifi
#all
f_6_all.wifi <- cbind(wifi_avg, all_finger_wifi_56)
f_6_all.wifi <- f_6_all.wifi[, c(1,2,3,4,6,7,5)]

f_6_all.bt <- cbind(bt_avg, all_finger_bt_56)
f_6_all.bt <- f_6_all.bt[, c(1,2,3,4,6,7,5)]

#lg
f_6_lg.wifi <- cbind(lg_wifi_avg, lg_finger_wifi_56)
f_6_lg.wifi <- f_6_lg.wifi[, c(1,2,3,4,6,7,5)]

f_6_lg.bt <- cbind(lg_bt_avg, lg_finger_bt_56)
f_6_lg.bt <- f_6_lg.bt[, c(1,2,3,4,6,7,5)]

#sams
f_6_sams.wifi <- cbind(sams_wifi_avg, sams_finger_wifi_56)
f_6_sams.wifi <- f_6_sams.wifi[, c(1,2,3,4,6,7,5)]

f_6_sams.bt <- cbind(sams_bt_avg, sams_finger_bt_56)
f_6_sams.bt <- f_6_sams.bt[, c(1,2,3,4,6,7,5)]

#s3
f_6_s3.wifi <- cbind(s3_wifi_avg, s3_finger_wifi_56)
f_6_s3.wifi <- f_6_s3.wifi[, c(1,2,3,4,6,7,5)]

f_6_s3.bt <- cbind(s3_bt_avg, s3_finger_bt_56)
f_6_s3.bt <- f_6_s3.bt[, c(1,2,3,4,6,7,5)]


##### EXPORT ####
write.csv(f_6_all.wifi, file = "f_6_all_wifi.txt",row.names=FALSE)
write.csv(f_6_all.bt, file = "f_6_all_bt.txt",row.names=FALSE)
write.csv(f_6_lg.wifi, file = "f_6_lg_wifi.txt",row.names=FALSE)
write.csv(f_6_lg.bt, file = "f_6_lg_bt",row.names=FALSE)
write.csv(f_6_sams.wifi, file = "f_6_sams_wifi.txt",row.names=FALSE)
write.csv(f_6_sams.bt, file = "f_6_sams_bt.txt",row.names=FALSE)
write.csv(f_6_s3.wifi, file = "f_6_s3_wifi.txt",row.names=FALSE)
write.csv(f_6_s3.bt, file = "f_6_s3_bt.txt",row.names=FALSE)

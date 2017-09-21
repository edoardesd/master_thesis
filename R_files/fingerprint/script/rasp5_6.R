rasp5_6_bluetooth <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/rasp5_6_bluetooth.csv")
rasp5_6_wifi <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/rasp5_6_wifi.csv")

avg_wifi <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/avg_wifi.csv")
avg_bluetooth <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/avg_bluetooth.csv")


avg_bluetooth_all <- cbind(avg_bluetooth[,-c(5,6)], rasp5_6_bluetooth)
avg_wifi_all <- cbind(avg_wifi[,-c(5,6)], rasp5_6_wifi)

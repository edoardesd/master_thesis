full_bluetooth_lab <- read_csv("~/Documents/master_thesis/dataset/lab/full_bluetooth_lab.csv")
full_wifi_lab <- read_csv("~/Documents/master_thesis/dataset/lab/full_wifi_lab.csv")
rid_bluetooth_lab <- read_csv("~/Documents/master_thesis/R_files/rid_bluetooth_lab.csv")
piu_rid_bluetooth_lab <- read_csv("~/Documents/master_thesis/dataset/lab/piu_rid_bluetooth_lab.csv")
conv_lg_wifi_bt <- read_csv("~/Documents/master_thesis/dataset/lab/conv_lg_wifi_bt.csv")
conv_sams_wifi_bt <- read_csv("~/Documents/master_thesis/dataset/lab/conv_sams_wifi_bt.csv")
piu_rid_bluetooth_lab_tarocco <- read_csv("~/Documents/master_thesis/dataset/lab/piu_rid_bluetooth_lab_tarocco.csv")
full_wifi_lab_tarocco <- read_csv("~/Documents/master_thesis/dataset/lab/full_wifi_lab_tarocco.csv")
curve_lab <- read_csv("~/Documents/master_thesis/dataset/lab/curve_lab.csv")

#normalize function
normalize <- function(x){ ((x-min(x))/ (max(x) - min(x)))}

full_bluetooth_lab$mac_address = NULL
rid_bluetooth_lab$mac_address = NULL
full_wifi_lab$mac_address = NULL
piu_rid_bluetooth_lab$mac_address = NULL
full_wifi_lab_tarocco$mac_address = NULL
piu_rid_bluetooth_lab_tarocco$mac_address = NULL

norm_bluetooth_lab = t(apply(full_bluetooth_lab, 1, normalize))
norm_wifi_lab = t(apply(full_wifi_lab, 1, normalize))
norm_bluetooth_lab = t(apply(piu_rid_bluetooth_lab, 1, normalize))
norm_wifi_lab_tarocco = t(apply(full_wifi_lab_tarocco, 1, normalize))
norm_bluetooth_lab_tarocco = t(apply(piu_rid_bluetooth_lab_tarocco, 1, normalize))

### Conversioni bt wifi
#lg
plot(conv_lg_wifi_bt$wifi ~ conv_lg_wifi_bt$bt)
abline(lm(conv_lg_wifi_bt$wifi ~ conv_lg_wifi_bt$bt))
lm(conv_lg_wifi_bt$wifi ~ conv_lg_wifi_bt$bt)
#sams
plot(conv_sams_wifi_bt$wifi ~ conv_sams_wifi_bt$bt)
abline(lm(conv_sams_wifi_bt$wifi ~ conv_sams_wifi_bt$bt))
lm(conv_sams_wifi_bt$wifi ~ conv_sams_wifi_bt$bt)
#mix
conv_mix_wifi_bt <- rbind(conv_lg_wifi_bt,conv_sams_wifi_bt)
plot(conv_mix_wifi_bt$wifi, conv_mix_wifi_bt$bt)
abline(lm(conv_mix_wifi_bt$bt ~ conv_mix_wifi_bt$wifi))
lm(conv_mix_wifi_bt$bt ~ conv_mix_wifi_bt$wifi)


plot(curve_lab$wifi+ 60, curve_lab$distance)
plot(curve_lab$bt + 15, curve_lab$distance)

fit <- lm(curve_lab$distance ~log(curve_lab$wifi + 60))
coef(fit)
fit <- lm(curve_lab$distance~log(curve_lab$bt + 15))
coef(fit)

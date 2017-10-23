library(readr)
ipad_all_corridoio <- read_csv("~/Documents/master_thesis/parametri_corridoio/ipad_all_corridoio.csv")
lg_all_corridoio <- read_csv("~/Documents/master_thesis/parametri_corridoio/lg_all_corridoio.csv")


plot(lg_all_corridoio$distance, lg_all_corridoio$rssi)
plot(lg_all_corridoio$distance, lg_all_corridoio$lq)
plot(lg_all_corridoio$distance, lg_all_corridoio$tpl)
plot(lg_all_corridoio$distance, lg_all_corridoio$echo_time)
plot(lg_all_corridoio$distance, lg_all_corridoio$bt_rx)
plot(lg_all_corridoio$distance, lg_all_corridoio$wifi_rx)

plot(ipad_all_corridoio$distance, ipad_all_corridoio$rssi)
plot(ipad_all_corridoio$distance, ipad_all_corridoio$lq)
plot(ipad_all_corridoio$distance, ipad_all_corridoio$tpl)
plot(ipad_all_corridoio$distance, ipad_all_corridoio$echo_time)
plot(ipad_all_corridoio$distance, ipad_all_corridoio$bt_rx)
plot(ipad_all_corridoio$distance, ipad_all_corridoio$wifi_rx)





library(readr)
require(ggplot2)
library(ggplot2)


ipad_all_corridoio <- read_csv("~/Documents/master_thesis/parametri_corridoio/ipad_all_corridoio.csv")
lg_all_corridoio <- read_csv("~/Documents/master_thesis/parametri_corridoio/lg_all_corridoio.csv")
rssi_vs_rx_bluetooth <- read_csv("~/Documents/master_thesis/parametri_corridoio/rssi_vs_rx_bt.csv", 
                          col_types = cols(distance = col_character()))
number_bluetooth <- read_csv("~/Documents/master_thesis/parametri_corridoio/number_of_val_bt.csv", 
                                 col_types = cols(distance = col_character()))

lg_wifi_vs_bt <- read_csv("~/Documents/master_thesis/parametri_corridoio/lg_wifi_vs_bt.csv", 
                             col_types = cols(distance = col_character()))


number_of_val_bt <- read_csv("~/Documents/master_thesis/R_files/corridoio_finale/number_of_val_bt.csv")

lg_all_corridoio$device <- "lg"
ipad_all_corridoio$device <- "ipad"

all_corridoio <- rbind(lg_all_corridoio, ipad_all_corridoio)
p1 <- ggplot(data = all_corridoio, aes(x = distance, y = rssi, group=device, color = device)) + geom_line() + ggtitle("bt_rssi vs distance")
p2 <- ggplot(data = all_corridoio, aes(x = distance, y = lq, group=device, color = device)) + geom_line() + ggtitle("lq vs distance")
p3 <- ggplot(data = all_corridoio, aes(x = distance, y = tpl, group=device, color = device)) + geom_line() + ggtitle("tpl vs distance")
p4 <- ggplot(data = all_corridoio, aes(x = distance, y = echo_time, group=device, color = device)) + geom_line() + ggtitle("echo_time vs distance")
p5 <- ggplot(data = all_corridoio, aes(x = distance, y = bt_rx, group=device, color = device)) + geom_line() + ggtitle("bt_rx vs distance")
p6 <- ggplot(data = all_corridoio, aes(x = distance, y = wifi_rx, group=device, color = device)) + geom_line() + ggtitle("wifi_rssi vs distance")

multiplot(p1, p2, p3, p4, cols=2)

p7 <- ggplot(data = subset(all_corridoio, all_corridoio$device == 'lg') ,aes(x = rssi, y = bt_rx, group=device, color = device)) + geom_point(color='blue') + ggtitle("LG: bt_rssi vs bt_rx") + geom_smooth(method='lm',formula=y~x, color='blue')
p8 <- ggplot(data = subset(all_corridoio, all_corridoio$device == 'ipad') ,aes(x = rssi, y = bt_rx, group=device, color = device)) + geom_point(color = 'red') + ggtitle("IPAD: bt_rssi vs bt_rx") + geom_smooth(method='lm',formula=y~x, color = 'red')

multiplot(p7, p8, cols = 1)

ggplot(data = subset(rssi_vs_rx_bluetooth, rssi_vs_rx_bluetooth$mac_address == '88:C9:D0:1F:3E:48'), aes(x=rssi, y=rx, group=mac_address, color=distance)) + geom_point() + ggtitle("LG: rssi vs rx bluetooth")
ggplot(data = subset(rssi_vs_rx_bluetooth, rssi_vs_rx_bluetooth$mac_address == 'DC:A9:04:4F:D9:36'), aes(x=rssi, y=rx, group=mac_address, color=distance)) + geom_point() + ggtitle("IPAD: rssi vs rx bluetooth")

ggplot(data = lg_wifi_vs_bt, aes(x=rx, y=rssi, group=mac_address, color=distance)) + geom_point() + ggtitle("IPAD: rssi vs rx bluetooth")

ggplot(data = subset(number_bluetooth, number_bluetooth$device == 'ipad'), aes(y=rssi, group=device, color=distance)) + geom_histogram() + ggtitle("LG: rssi vs rx bluetooth")




qplot(number_of_val_bt$distance,
      geom="histogram",
      binwidth = 0.5,  
      main = "Histogram for Age", 
      xlab = "Age")


plot(lg_all_corridoio$distance, lg_all_corridoio$rssi)
plot(lg_all_corridoio$distance, lg_all_corridoio$lq)
plot(lg_all_corridoio$distance, lg_all_corridoio$tpl)
plot(lg_all_corridoio$distance, lg_all_corridoio$echo_time)
plot(lg_all_corridoio$distance, lg_all_corridoio$bt_rx)
plot(lg_all_corridoio$distance, lg_all_corridoio$wifi_rx)

plot(lg_all_corridoio$rssi, lg_all_corridoio$wifi_rx)


plot(ipad_all_corridoio$distance, ipad_all_corridoio$rssi)
plot(ipad_all_corridoio$distance, ipad_all_corridoio$lq)
plot(ipad_all_corridoio$distance, ipad_all_corridoio$tpl)
plot(ipad_all_corridoio$distance, ipad_all_corridoio$echo_time)
plot(ipad_all_corridoio$distance, ipad_all_corridoio$bt_rx)
plot(ipad_all_corridoio$distance, ipad_all_corridoio$wifi_rx)


which(rssi_vs_rx_bluetooth$mac_address == '88:C9:D0:1F:3E:48')

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

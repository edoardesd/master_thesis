require(ggplot2)
require(gridExtra)
require(grid)
library(readr)

SCOCCA_NO_SAMTAB <- read_csv("~/Documents/R_files/RSSIvsRX/data/SCOCCA_NO_SAMTAB.csv")
SCOCCA_NO_LG <- read_csv("~/Documents/R_files/RSSIvsRX/data/SCOCCA_NO_LG.csv")

#NESSUNA DIFFERENZA TRA SCOCCA E NON SCOCCA!

ggplot(data = SCOCCA_NO_SAMTAB,aes(x = timestamp,y = rssi, group=scocca, colour=scocca)) + geom_point() + ggtitle("Samsung TAB - Differenze case/no case")


#function for computing mean, DS, max and min values
min.mean.sd.max <- function(x) {
  r <- c(min(x), mean(x) - sd(x), mean(x), mean(x) + sd(x), max(x))
  names(r) <- c("ymin", "lower", "middle", "upper", "ymax")
  r
}

bplot_scocca_sam <- ggplot(aes(y = rssi, x = scocca, color= scocca), data = SCOCCA_NO_SAMTAB)
bplot_scocca_sam <- bplot_scocca_sam + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)
bplot_scocca_sam <- bplot_scocca_sam + ggtitle("Samsung TAB, differenze scocca") + xlab("") + ylab("RSSI") + scale_color_manual(values=c("darkgreen", "darkorange"))
bplot_scocca_sam

bplot_scocca_lg <- ggplot(aes(y = rssi, x = scocca, color= scocca), data = SCOCCA_NO_LG)
bplot_scocca_lg <- bplot_scocca_lg + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)
bplot_scocca_lg <- bplot_scocca_lg + ggtitle("LG, differenze scocca") + xlab("") + ylab("RSSI") + scale_color_manual(values=c("darkgreen", "darkorange"))
bplot_scocca_lg

#STANDARD DEVIATION
sd(subset(SCOCCA_NO_SAMTAB$rssi, SCOCCA_NO_SAMTAB$scocca=="scocca"))
sd(subset(SCOCCA_NO_SAMTAB$rssi, SCOCCA_NO_SAMTAB$scocca=="noscocca"))


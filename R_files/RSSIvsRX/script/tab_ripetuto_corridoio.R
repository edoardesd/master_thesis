#Solo Samsung TAB a botte di 8 minuti l'una di fila
library(readr)
SAM_4_TEST1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/SAM_4_TEST1.csv")
SAM_4_TEST2 <- read_csv("~/Documents/R_files/RSSIvsRX/data/SAM_4_TEST2.csv")
SAM_4_TEST3 <- read_csv("~/Documents/R_files/RSSIvsRX/data/SAM_4_TEST3.csv")
SAM_4_TEST4 <- read_csv("~/Documents/R_files/RSSIvsRX/data/SAM_4_TEST4.csv") 


SAM_4_TEST1$test <- "1"
SAM_4_TEST2$test <- "2"
SAM_4_TEST3$test <- "3"
SAM_4_TEST4$test <- "4"
visual_ripetuto <- rbind(SAM_4_TEST1, SAM_4_TEST2, SAM_4_TEST3, SAM_4_TEST4)

p_ripetuto <- ggplot(visual_ripetuto, aes(x=timestamp, y=rx, color=test)) + stat_sum() 
p_ripetuto + scale_color_manual(breaks = c("1", "2", "3", "4"),  values=c("green", "violet", "blue", "red")) + ggtitle("SAMSUNG TAB - RASP1 - Impronta su 4 test ripetuti di fila")

ggplot(data = subset(visual_ripetuto, test == "1"),aes(x = rx,y = rssi)) + stat_sum(color="darkblue") + ggtitle("Ripetuto regression line test 1") + geom_abline(intercept = -24.0864, slope = -0.1323)
ggplot(data = subset(visual_ripetuto, test == "2"),aes(x = rx,y = rssi)) + stat_sum(color="darkblue") + ggtitle("Ripetuto regression line test 2") + geom_abline(intercept = -10.9523, slope = 0.0118)
ggplot(data = subset(visual_ripetuto, test == "3"),aes(x = rx,y = rssi)) + stat_sum(color="darkblue") + ggtitle("Ripetuto regression line test 3") + geom_abline(intercept = -0.1574, slope = 0.1340)
ggplot(data = subset(visual_ripetuto, test == "4"),aes(x = rx,y = rssi)) + stat_sum(color="darkblue") + ggtitle("Ripetuto regression line test 4") + geom_abline(intercept = -15.28778, slope = -0.03221)


lm(subset(visual_ripetuto, test == "4")$rssi ~ subset(visual_ripetuto, test == "4")$rx)


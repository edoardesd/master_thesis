require(ggplot2)
require(gridExtra)
require(grid)
library(readr)
LG_1METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/LG_1METRO_RASP1.csv")
LG_2METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/LG_2METRO_RASP1.csv")
LG_4METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/LG_4METRO_RASP1.csv")
LG_5METRO_RASP1 <- read_csv("~/Documents/R_files/RSSIvsRX/data/LG_5METRO_RASP1.csv")

#LG ha un po' pochi valori, solo una trentina a misurazione circa

################# 1 METRO ##################
#
# CREAZIONE ISTOGRAMMA: 
#  L'rssi a un metro già si discosta molto da 0, sembra una buona campana
#  L'RX invece ha un sacco di valori simili tra -73 e -70, ma comunque buono perchè sono tutti vicini
LG_1metro_r1_rx.tab <- table(LG_1METRO_RASP1$rx)
LG_1metro_r1_rssi.tab <- table(LG_1METRO_RASP1$rssi)
LG_1metro_r1_rx.tab
LG_1metro_r1_rssi.tab

#VISUALIZZO LE FREQUENZE
par(mfrow=c(1,2)) #2 righe, 1 colonna
barplot(LG_1metro_r1_rssi.tab, 
        xlab = "RSSI", ylab = "Frequency", main = "1m LG RSSI rasp1")
barplot(LG_1metro_r1_rx.tab,
        xlab = "RX", ylab = "Frequency", main = "1m LG RX rasp1")
par(mfrow=c(1,1))
#VISUALIZZO L'ANDAMENTO TEMPORALE

ggplot(data = LG_1METRO_RASP1, aes(x = timestamp, y = rx, color=rx)) + geom_line() + ggtitle("1metro LG Rasp1 RX nel tempo")
ggplot(data = LG_1METRO_RASP1, aes(x = timestamp, y = rssi, color=rssi)) + geom_line() +ggtitle("1metro LG Rasp1 RSSI nel tempo")

#INIZIO FASE DI PLOT
#Prima fase, rx asse x e rssi asse y -> vedere come si comportano nello stesso secondo
#Come al solito sembrano abbastanza scorrelati
#CONFRONTO RX (asse x) VS (RSSI, asse y)
ggplot(data = LG_1METRO_RASP1,aes(x = rx,y = rssi)) + stat_sum(color="darkblue") + ggtitle("1metro LG Rasp1 RX vs RSSI")

################# 2 METRI ##################
#
# CREAZIONE ISTOGRAMMA: 


LG_2metro_r1_rx.tab <- table(LG_2METRO_RASP1$rx)
LG_2metro_r1_rssi.tab <- table(LG_2METRO_RASP1$rssi)
LG_2metro_r1_rx.tab
LG_2metro_r1_rssi.tab

#VISUALIZZO LE FREQUENZE
#Si comporta più meno come prima. Con una sottospecie di campana per l'rssi 
# e abbastanza costante per l'rx tra gli -83 e -81

par(mfrow=c(1,2)) #2 righe, 1 colonna
barplot(LG_2metro_r1_rssi.tab, 
        xlab = "RSSI", ylab = "Frequency", main = "2m LG RSSI rasp1")
barplot(LG_2metro_r1_rx.tab,
        xlab = "RX", ylab = "Frequency", main = "2m LG RX rasp1")
par(mfrow=c(1,1))
#VISUALIZZO L'ANDAMENTO TEMPORALE
#
ggplot(data = LG_2METRO_RASP1, aes(x = timestamp, y = rx, color=rx)) + geom_line() + ggtitle("2metri LG Rasp1 RX nel tempo")
ggplot(data = LG_2METRO_RASP1, aes(x = timestamp, y = rssi, color=rx)) + geom_line() +ggtitle("2metri LG Rasp1 RSSI nel tempo")

#INIZIO FASE DI PLOT
#Prima fase, rx asse x e rssi asse y -> vedere come si comportano nello stesso secondo
# Come era evidente dagli istogrammi il valore è abbastanza fisso sui -15
#CONFRONTO RX (asse x) VS (RSSI, asse y)
ggplot(data = LG_2METRO_RASP1,aes(x = rx,y = rssi)) + stat_sum(color="darkblue") + ggtitle("2metri LG Rasp1 RX vs RSSI")


################# 4 METRI ##################
#
# CREAZIONE ISTOGRAMMA: 

#

LG_4metro_r1_rx.tab <- table(LG_4METRO_RASP1$rx)
LG_4metro_r1_rssi.tab <- table(LG_4METRO_RASP1$rssi)
LG_4metro_r1_rx.tab
LG_4metro_r1_rssi.tab

#VISUALIZZO LE FREQUENZE
#probabilmente qua ho troppi pochi valori per fare una stima decente

par(mfrow=c(1,2)) #2 righe, 1 colonna
barplot(LG_4metro_r1_rssi.tab, 
        xlab = "RSSI", ylab = "Frequency", main = "4m LG RSSI rasp1")
barplot(LG_4metro_r1_rx.tab,
        xlab = "RX", ylab = "Frequency", main = "4m LG RX rasp1")
par(mfrow=c(1,1))
#VISUALIZZO L'ANDAMENTO TEMPORALE
# RX abbastanza fisso tra i -86 e i -92, rssi molto variabile
ggplot(data = LG_4METRO_RASP1, aes(x = timestamp, y = rx, color=rx)) + geom_line() + ggtitle("4metri LG Rasp1 RX nel tempo")
ggplot(data = LG_4METRO_RASP1, aes(x = timestamp, y = rssi, color=rx)) + geom_line() +ggtitle("4metri LG Rasp1 RSSI nel tempo")

#INIZIO FASE DI PLOT
#Prima fase, rx asse x e rssi asse y -> vedere come si comportano nello stesso secondo
#
#CONFRONTO RX (asse x) VS (RSSI, asse y)

ggplot(data = LG_4METRO_RASP1,aes(x = rx,y = rssi)) + stat_sum(color="darkblue") + ggtitle("4metri LG Rasp1 RX vs RSSI")


################# 5 METRI ##################
#
# CREAZIONE ISTOGRAMMA: 


LG_5metro_r1_rx.tab <- table(LG_5METRO_RASP1$rx)
LG_5metro_r1_rssi.tab <- table(LG_5METRO_RASP1$rssi)
LG_5metro_r1_rx.tab
LG_5metro_r1_rssi.tab

#VISUALIZZO LE FREQUENZE
par(mfrow=c(1,2)) #2 righe, 1 colonna
barplot(LG_5metro_r1_rssi.tab, 
        xlab = "RSSI", ylab = "Frequency", main = "5m LG RSSI rasp1")
barplot(LG_5metro_r1_rx.tab,
        xlab = "RX", ylab = "Frequency", main = "5m LG RX rasp1")
par(mfrow=c(1,1))
#VISUALIZZO L'ANDAMENTO TEMPORALE
ggplot(data = LG_5METRO_RASP1, aes(x = timestamp, y = rx, color=rx)) + geom_line() + ggtitle("5metri LG Rasp1 RX nel tempo")
ggplot(data = LG_5METRO_RASP1, aes(x = timestamp, y = rssi, color=rx)) + geom_line() +ggtitle("5metri LG Rasp1 RSSI nel tempo")

#INIZIO FASE DI PLOT
#Prima fase, rx asse x e rssi asse y -> vedere come si comportano nello stesso secondo
#
#CONFRONTO RX (asse x) VS (RSSI, asse y)
ggplot(data = LG_5METRO_RASP1,aes(x = rx,y = rssi)) + stat_sum(color="darkblue") + ggtitle("5metri LG Rasp1 RX vs RSSI")


################# FUSIONE ##################
#Sono tutti molto distinti -> fa bene sperare
#Unico problema. A 5 metri i valori sono molto simili ai 2 metri. Speriamo sia perchè ne ho pochi

LG_1METRO_RASP1$distance <- "1"
LG_2METRO_RASP1$distance <- "2"
LG_4METRO_RASP1$distance <- "4"
LG_5METRO_RASP1$distance <- "5"
visual_lg_rasp1 <- rbind(LG_1METRO_RASP1, LG_2METRO_RASP1, LG_4METRO_RASP1, LG_5METRO_RASP1)

p_lg_rasp1 <- ggplot(visual_lg_rasp1, aes(x=rx, y=rssi, color=distance)) + stat_sum() 
p_lg_rasp1 + scale_color_manual(breaks = c("1", "2", "4", "5"),values=c("green", "violet", "blue", "red")) + ggtitle("LG - RASP1 - Impronta in base alla distanza")

################# BOXPLOT ##################
#Boxplot standard con mediana (valore in mezzo alla distribuzione), primo e terzo quartile
#Non è detto che indichi perfettamente la realtà andando a prendere la mediana
#Come si notava dagli altri grafici i 5 metri sono sballati (più "vicini" dei 4 metri)
boxplot(LG_1METRO_RASP1$rssi, LG_2METRO_RASP1$rssi, LG_4METRO_RASP1$rssi, LG_5METRO_RASP1$rssi, 
        xlab="Distance", ylab="RSSI", las=1, col=topo.colors(4), main="RSSI LG per distanza RASP 1")

boxplot(LG_1METRO_RASP1$rx, LG_2METRO_RASP1$rx, LG_4METRO_RASP1$rx, LG_5METRO_RASP1$rx,
        xlab="Distance", ylab="RX", las=1, col=topo.colors(4), main="RX LG per distanza RASP 1")


bplot_lg1_rssi <- ggplot(aes(y = rssi, x = factor(distance), color= distance), data = visual_lg_rasp1)
bplot_lg1_rssi <- bplot_lg1_rssi + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)
bplot_lg1_rssi <- bplot_lg1_rssi + ggtitle("LG RASP 1: RSSI media, st dev +/- media") + xlab("Distanza") + ylab("RSSI") + scale_color_manual(breaks = c("1", "2", "4", "5"),values=c("darkgreen", "darkviolet", "darkblue", "darkred"))
bplot_lg1_rssi

bplot_lg1_rx <- ggplot(aes(y = rx, x = factor(distance), color= distance), data = visual_lg_rasp1)
bplot_lg1_rx <- bplot_lg1_rx + stat_summary(fun.data = min.mean.sd.max, geom = "boxplot") + geom_jitter(position=position_jitter(width=.2), size=3)
bplot_lg1_rx <- bplot_lg1_rx + ggtitle("LG RASP 1: RX media, st dev +/- media") + xlab("Distanza") + ylab("RX") + scale_color_manual(breaks = c("1", "2", "4", "5"),values=c("lightgreen", "violet", "lightblue", "darkorange"))
bplot_lg1_rx

grid.arrange(bplot_lg1_rssi, bplot_lg1_rx, widths=c(0.5, 0.5), ncol=2)

grid.arrange(bplot_lg1_rssi, bplot_lg2_rssi, widths=c(0.5, 0.5), ncol=2)
grid.arrange(bplot_lg1_rx, bplot_lg2_rx, widths=c(0.5, 0.5), ncol=2)

#Per quanto riguarda l'lg dalle due raspberry il risultato sembra un po' diverso
#sia sul rx sia su rssi. non è una bella cosa

#Calcolo correlazione
corr_1_lg_1 <- LG_1METRO_RASP1
corr_1_lg_1$timestamp = NULL 
corr_1_lg_1$distance = NULL
cor(corr_1_lg_1,  method="kendall") 
cor(corr_1_lg_1,  method="pearson") 
cor(corr_1_lg_1,  method="spearman") 

corr_2_lg_1 <- LG_2METRO_RASP1
corr_2_lg_1$timestamp = NULL 
corr_2_lg_1$distance = NULL
cor(corr_2_lg_1,  method="kendall") 
cor(corr_2_lg_1,  method="pearson") 
cor(corr_2_lg_1,  method="spearman") 


corr_4_lg_1 <- LG_4METRO_RASP1
corr_4_lg_1$timestamp = NULL 
corr_4_lg_1$distance = NULL
cor(corr_4_lg_1,  method="kendall") 
cor(corr_4_lg_1,  method="pearson") 
cor(corr_4_lg_1,  method="spearman") 

corr_5_lg_1 <- LG_5METRO_RASP1
corr_5_lg_1$timestamp = NULL 
corr_5_lg_1$distance = NULL
cor(corr_5_lg_1,  method="kendall") 
cor(corr_5_lg_1,  method="pearson") 
cor(corr_5_lg_1,  method="spearman") 

#La correlazione è un pelo più alta ma niente di che. 


# Year: 2017
# Title: Cross validation
# Goal: capire quanto è buono il dataset
# Author: Edoardo Longo
#
# 

# Define your working directory
# Ensure to use the forward / slash 
setwd("/Users/edoardesd/Documents/R_files")
getwd()

#es: DATASET: rasp1 | rasp2 | rasp3 | rasp4 | location
#              -39     -50     -78     -50       3.4

#INIZIO IMPORT
#install.packages('e1071', dependencies=TRUE)
install.packages('caret', dependencies = TRUE)
require(class)
library(readr)
require(ggplot2)
library(caret)
library(caTools)
library(MASS, quietly=TRUE)
library(randomForest)
sam_bt_fingerprint <- read_csv("~/Documents/R_files/fingerprint/data/sam_bt_fingerprint.csv", col_types = cols(location = col_character()))
sam_wifi_fingerprint <- read_csv("~/Documents/R_files/fingerprint/data/sam_wifi_fingerprint.csv", col_types = cols(location = col_character()))

DataFrameBt <- sam_bt_fingerprint
DataFrameWifi <- sam_wifi_fingerprint

## SORT DATAFRAMES
gp <- runif(nrow(DataFrameBt))
DataFrameBt <- DataFrameBt[order(gp),] 

gp2 <- runif(nrow(DataFrameWifi))
DataFrameWifi <- DataFrameWifi[order(gp2),] 

#RANDOM FOREST 1 BT
train_bt <- DataFrameBt[1:1200, c("rasp1", "rasp2", "rasp3", "rasp4")]
label <- as.factor(DataFrameBt$location)

set.seed(1234)

rf.1 <- randomForest(x = train_bt, y = label[1:1200], importance = TRUE, ntree = 1000)
rf.1
varImpPlot(rf.1)

#RANDOM FOREST 1 WIFI
train_wifi <- DataFrameWifi[1:10000, c("rasp1", "rasp2", "rasp3", "rasp4")]
label_wifi <- as.factor(DataFrameWifi$location)

set.seed(1234)
rf.2 <- randomForest(x = train_wifi, y = label_wifi[1:10000], importance = TRUE, ntree = 700)
rf.2
varImpPlot(rf.2)


###### RANDOM FOREST 2 #####
names(DataFrameBt)

sample.ind <- sample(2, nrow(DataFrameBt), replace = T, prob = c(0.7,0.3))

bt.train <- DataFrameBt[sample.ind==1,]
bt.val <- DataFrameBt[sample.ind==2,]


rf.3<- randomForest(as.factor(location) ~., data = bt.train, importance=TRUE,ntree=1000)
rf.3

varImpPlot(rf.3)

Predicion <- predict(rf.3, bt.val)


#### WIFI 2####
sample.ind.wifi.2 <- sample(2, nrow(DataFrameWifi), replace = T, prob = c(0.7,0.3))

train.wifi.2 <- DataFrameWifi[sample.ind==1,]
val.wifi.2 <- DataFrameWifi[sample.ind==2,]


rf.4<- randomForest(as.factor(location) ~., data = train.wifi.2, importance=TRUE,ntree=1000)
rf.4

varImpPlot(rf.4)

Predicion <- predict(rf.4, val.wifi.2)


#### TEST KNN ####
knn_bt_target  <- bt.train$location
sam_knn <- knn(bt.train , bt.val , knn_bt_target , k=5)
sam_knn

mean(sam_knn == bt.val$location)

knn_wifi_target <-train.wifi.2$location
sam_knn_wifi <- knn(train.wifi.2, val.wifi.2, knn_wifi_target, k=1)
mean(sam_knn_wifi == val.wifi.2$location)


knn_err<-numeric()

prop.table(table(sam_knn, bt.val$location))

for(i in 1:60){
  sam_knn_bis <- knn(bt.train , bt.val , knn_bt_target , k=i)
  sam_err_bis <- c(knn_err, mean(sam_knn_bis == bt.val$location))
}

plot(1-sam_err_bis,type="l",ylab="Error Rate",
     xlab="K",main="Error Rate for LG Normalized With Varying K")

install.packages("gmodels")

setwd("/Users/edoardesd/Documents/master_thesis/R_files")
getwd()
require(class)
library(caret)
library(randomForest)

train.wifi.sam
test.wifi.sam
train.bt.sam
test.wifi.sam

set.seed(1234)



##### SAMSUNG #####
##### SAMSUNG.WIFI #####
rf.wifi_sam <- randomForest(as.factor(location) ~., data = train.wifi.sam, importance=TRUE,ntree=500)
rf.wifi_sam # OOB estimate of  error rate: 11.74%
importance(rf.wifi_sam)
varImpPlot(rf.wifi_sam)

prediction.wifi_sam <- predict(rf.wifi_sam, test.wifi.sam)

#accuracy = 87,66345%
mean(prediction.wifi_sam == test.wifi.sam$location)


##### SAMSUNG.BT #####
rf.bt_sam <- randomForest(as.factor(location) ~., data = train.bt.sam, importance=TRUE,ntree=500)
rf.bt_sam # OOB estimate of  error rate: 54.23%
importance(rf.bt_sam)
varImpPlot(rf.bt_sam)

prediction.bt_sam <- predict(rf.bt_sam, test.bt.sam)

#accuracy = 43,75%
mean(prediction.bt_sam == test.bt.sam$location)

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

### WIFI WITH SAME NUMBER OF ROW FOR EACH LOCATION
rf.wifi_sam.ten <- randomForest(as.factor(location) ~., data = train.wifi_sam.ten, importance=TRUE,ntree=500)
rf.wifi_sam.ten #OOB estimate of  error rate: 25.72%

prediction.wifi_sam.ten <- predict(rf.wifi_sam.ten, test.wifi_sam.ten)

#accuracy = 72,08%
mean(prediction.wifi_sam.ten == test.wifi_sam.ten$location)


##### SAMSUNG.BT #####
rf.bt_sam <- randomForest(as.factor(location) ~., data = train.bt.sam, importance=TRUE,ntree=500)
rf.bt_sam # OOB estimate of  error rate: 54.23%
importance(rf.bt_sam)
varImpPlot(rf.bt_sam)

prediction.bt_sam <- predict(rf.bt_sam, test.bt.sam)

#accuracy = 43,75%
mean(prediction.bt_sam == test.bt.sam$location)

### BT WITH SAME NUMBER OF ROW FOR EACH LOCATION
rf.bt_sam.ten <- randomForest(as.factor(location) ~., data = train.bt_sam.ten, importance=TRUE,ntree=500)
rf.bt_sam.ten #OOB estimate of  error rate: 61.56%

prediction.bt_sam.ten <- predict(rf.bt_sam.ten, test.bt_sam.ten)

#accuracy = 38,96%
mean(prediction.bt_sam.ten == test.bt_sam.ten$location)


##### SAMSUNG WIFI + BT #####

rf.bt_wifi.sam <- randomForest(as.factor(location) ~., data = train.bt_wifi.sam, importance=TRUE,ntree=500)
rf.bt_wifi.sam  #OOB estimate of  error rate: 46.78%

prediction.bt_wifi.sam <- predict(rf.bt_wifi.sam, test.bt_wifi.sam)

#accuracy = 59.04%
mean(prediction.bt_wifi.sam == test.bt_wifi.sam$location)

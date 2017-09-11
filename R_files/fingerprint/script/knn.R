setwd("/Users/edoardesd/Documents/master_thesis/R_files")
getwd()
require(class)

train.wifi.sam
test.wifi.sam
train.bt.sam
test.wifi.sam

set.seed(1234)


#separate labels
labels.train.wifi_sam <- train.wifi.sam$location #target feature
labels.test.wifi_sam <- test.wifi.sam$location #target feature

labels.train.bt_sam <- train.bt.sam$location #target feature
labels.test.bt_sam <- test.bt.sam$location #target feature

#delete label. not needed
#train.wifi.sam <- train.wifi.sam[, -5] 
#test.wifi.sam <- test.wifi.sam[, -5]


##### SAMSUNG #####
##### SAMSUNG.WIFI #####
#knn algorithm
knn.wifi_sam.1 <-knn(train = train.wifi.sam, test = test.wifi.sam, cl = labels.train.wifi_sam, k = 1) 
knn.wifi_sam.5 <-knn(train = train.wifi.sam, test = test.wifi.sam, cl = labels.train.wifi_sam, k = 5) 
knn.wifi_sam.11 <-knn(train = train.wifi.sam, test = test.wifi.sam, cl = labels.train.wifi_sam, k = 11) 


knn.wifi_sam.85 <-knn(train = train.wifi.sam, test = test.wifi.sam, cl = labels.train.wifi_sam, k = 85) 


table (labels.test.wifi_sam, knn.wifi_sam) #confusion matrix, bruttissima da vedere

sum(labels.test.wifi_sam == knn.wifi_sam.1) / length(knn.wifi_sam.1)  #k = 1  ---> 0.9272314
sum(labels.test.wifi_sam == knn.wifi_sam.5) / length(knn.wifi_sam.5)  #k = 5  ---> 0.9107447
sum(labels.test.wifi_sam == knn.wifi_sam.11) / length(knn.wifi_sam.11)  #k = 11  ---> 0.8965321
sum(labels.test.wifi_sam == knn.wifi_sam.85) / length(knn.wifi_sam.85)  #k = 85  ---> 0.7310972

##### SAMSUNG.BT #####
#knn algorithm

knn.bt_sam.1 <-knn(train = train.bt.sam, test = test.bt.sam, cl = labels.train.bt_sam, 1) 
knn.bt_sam.5 <-knn(train = train.bt.sam, test = test.bt.sam, cl = labels.train.bt_sam, k = 5) 
knn.bt_sam.11 <-knn(train = train.bt.sam, test = test.bt.sam, cl = labels.train.bt_sam, k = 11) 

knn.bt_sam.85 <-knn(train = train.bt.sam, test = test.bt.sam, cl = labels.train.bt_sam, k = 85) 


sum(labels.test.bt_sam == knn.bt_sam.1) / length(knn.bt_sam.1)  #k = 1  ---> 0.4193548
sum(labels.test.bt_sam == knn.bt_sam.5) / length(knn.bt_sam.5)  #k = 5  ---> 0.4576613
sum(labels.test.bt_sam == knn.bt_sam.11) / length(knn.bt_sam.11)  #k = 11  ---> 0.5
sum(labels.test.bt_sam == knn.bt_sam.85) / length(knn.bt_sam.85)  #k = 85  ---> 0.3850806

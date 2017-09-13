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

labels.train.wifi_sam.ten <- train.wifi_sam.ten$location
labels.test.wifi_sam.ten <- test.wifi_sam.ten$location

labels.train.bt_sam <- train.bt.sam$location #target feature
labels.test.bt_sam <- test.bt.sam$location #target feature

labels.train.bt_sam.ten <- train.bt_sam.ten$location
labels.test.bt_sam.ten <- test.bt_sam.ten$location

labels.train.bt_wifi.sam <- train.bt_wifi.sam$location
labels.test.bt_wifi.sam <- test.bt_wifi.sam$location


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

### WIFI WITH SAME NUMBER OF ROW FOR EACH LOCATION
sqrt(500)

knn.bt_sam.1.ten <-knn(train = train.bt_sam.ten, test = test.wifi_sam.ten, cl = labels.train.wifi_sam.ten, 1)
knn.wifi_sam.3.ten <-knn(train = train.wifi_sam.ten, test = test.wifi_sam.ten, cl = labels.train.wifi_sam.ten, 3)
knn.wifi_sam.5.ten <-knn(train = train.wifi_sam.ten, test = test.wifi_sam.ten, cl = labels.train.wifi_sam.ten, 5) 
knn.wifi_sam.11.ten <-knn(train = train.wifi_sam.ten, test = test.wifi_sam.ten, cl = labels.train.wifi_sam.ten, 11) 
knn.wifi_sam.21.ten <-knn(train = train.wifi_sam.ten, test = test.wifi_sam.ten, cl = labels.train.wifi_sam.ten, 21) 


sum(labels.test.wifi_sam.ten == knn.wifi_sam.1.ten) / length(knn.wifi_sam.1.ten)  #k = 1  ---> 0.8116883
sum(labels.test.wifi_sam.ten == knn.wifi_sam.3.ten) / length(knn.wifi_sam.3.ten)  #k = 3  ---> 0.7337662
sum(labels.test.wifi_sam.ten == knn.wifi_sam.5.ten) / length(knn.wifi_sam.5.ten)  #k = 5  ---> 0.7402597
sum(labels.test.wifi_sam.ten == knn.wifi_sam.11.ten) / length(knn.wifi_sam.11.ten)  #k = 11  ---> 0.5194805
sum(labels.test.wifi_sam.ten == knn.wifi_sam.21.ten) / length(knn.wifi_sam.21.ten)  #k = 21  ---> 0.3896104


## SAMSUNG NORM WIFI
knn.wifi_sam.1.norm <-knn(train = df.sam_wifi.norm.train, test = df.sam_wifi.norm.test, cl = labels.train.wifi_sam.ten, 1)
knn.wifi_sam.3.norm <-knn(train = df.sam_wifi.norm.train, test = df.sam_wifi.norm.test, cl = labels.train.wifi_sam.ten, 3)
knn.wifi_sam.5.norm <-knn(train = df.sam_wifi.norm.train, test = df.sam_wifi.norm.test, cl = labels.train.wifi_sam.ten, 5) 
knn.wifi_sam.11.norm <-knn(train = df.sam_wifi.norm.train, test = df.sam_wifi.norm.test, cl = labels.train.wifi_sam.ten, 11) 
knn.wifi_sam.21.norm <-knn(train = df.sam_wifi.norm.train, test = df.sam_wifi.norm.test, cl = labels.train.wifi_sam.ten, 21) 

sum(labels.test.wifi_sam.ten == knn.wifi_sam.1.norm) / length(knn.wifi_sam.1.norm)  #k = 1  ---> 0.7597403
sum(labels.test.wifi_sam.ten == knn.wifi_sam.3.norm) / length(knn.wifi_sam.3.norm)  #k = 3  ---> 0.7077922
sum(labels.test.wifi_sam.ten == knn.wifi_sam.5.norm) / length(knn.wifi_sam.5.norm)  #k = 5  ---> 0.6818182
sum(labels.test.wifi_sam.ten == knn.wifi_sam.11.norm) / length(knn.wifi_sam.11.norm)  #k = 11  ---> 0.525974
sum(labels.test.wifi_sam.ten == knn.wifi_sam.21.norm) / length(knn.wifi_sam.21.norm)  #k = 21  ---> 0.3896104


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


### BT WITH SAME NUMBER OF ROW FOR EACH LOCATION
sqrt(500)

knn.bt_sam.1.ten <-knn(train = train.bt_sam.ten, test = test.bt_sam.ten, cl = labels.train.bt_sam.ten, 1)
knn.bt_sam.3.ten <-knn(train = train.bt_sam.ten, test = test.bt_sam.ten, cl = labels.train.bt_sam.ten, 3)
knn.bt_sam.5.ten <-knn(train = train.bt_sam.ten, test = test.bt_sam.ten, cl = labels.train.bt_sam.ten, 5) 
knn.bt_sam.11.ten <-knn(train = train.bt_sam.ten, test = test.bt_sam.ten, cl = labels.train.bt_sam.ten, 11) 
knn.bt_sam.21.ten <-knn(train = train.bt_sam.ten, test = test.bt_sam.ten, cl = labels.train.bt_sam.ten, 21) 


sum(labels.test.bt_sam.ten == knn.bt_sam.1.ten) / length(knn.bt_sam.1.ten)  #k = 1  ---> 0.3831169
sum(labels.test.bt_sam.ten == knn.bt_sam.3.ten) / length(knn.bt_sam.3.ten)  #k = 3  ---> 0.3701299
sum(labels.test.bt_sam.ten == knn.bt_sam.5.ten) / length(knn.bt_sam.5.ten)  #k = 5  ---> 0.4025974
sum(labels.test.bt_sam.ten == knn.bt_sam.11.ten) / length(knn.bt_sam.11.ten)  #k = 11  ---> 0.3571429
sum(labels.test.bt_sam.ten == knn.bt_sam.21.ten) / length(knn.bt_sam.21.ten)  #k = 21  ---> 0.2727273

## BT NORM
knn.bt_sam.1.norm <-knn(train = df.sam_bt.norm.train, test = df.sam_bt.norm.test, cl = labels.train.bt_sam.ten, 1)
knn.bt_sam.3.norm <-knn(train = df.sam_bt.norm.train, test = df.sam_bt.norm.test, cl = labels.train.bt_sam.ten, 3)
knn.bt_sam.5.norm <-knn(train = df.sam_bt.norm.train, test = df.sam_bt.norm.test, cl = labels.train.bt_sam.ten, 5) 
knn.bt_sam.11.norm <-knn(train = df.sam_bt.norm.train, test = df.sam_bt.norm.test, cl = labels.train.bt_sam.ten, 11) 
knn.bt_sam.21.norm <-knn(train = df.sam_bt.norm.train, test = df.sam_bt.norm.test, cl = labels.train.bt_sam.ten, 21) 

sum(labels.test.bt_sam.ten == knn.bt_sam.1.norm) / length(knn.bt_sam.1.norm)  #k = 1  ---> 0.1753247
sum(labels.test.bt_sam.ten == knn.bt_sam.3.norm) / length(knn.bt_sam.3.norm)  #k = 3  ---> 0.1558442
sum(labels.test.bt_sam.ten == knn.bt_sam.5.norm) / length(knn.bt_sam.5.norm)  #k = 5  ---> 0.1948052
sum(labels.test.bt_sam.ten == knn.bt_sam.11.norm) / length(knn.bt_sam.11.norm)  #k = 11  ---> 0.1428571
sum(labels.test.bt_sam.ten == knn.bt_sam.21.norm) / length(knn.bt_sam.21.norm)  #k = 21  ---> 0.1168831




##### SAMSUNG BT + WIFI ####
knn.wifi_bt.sam.1 <-knn(train = train.bt_wifi.sam, test = test.bt_wifi.sam, cl = labels.train.bt_wifi.sam, 1)
knn.wifi_bt.sam.3 <-knn(train = train.bt_wifi.sam, test = test.bt_wifi.sam, cl = labels.train.bt_wifi.sam, 3)
knn.wifi_bt.sam.5 <-knn(train = train.bt_wifi.sam, test = test.bt_wifi.sam, cl = labels.train.bt_wifi.sam, 5) 
knn.wifi_bt.sam.11 <-knn(train = train.bt_wifi.sam, test = test.bt_wifi.sam, cl = labels.train.bt_wifi.sam, 11) 
knn.wifi_bt.sam.21 <-knn(train = train.bt_wifi.sam, test = test.bt_wifi.sam, cl = labels.train.bt_wifi.sam, 21) 

sum(labels.test.bt_wifi.sam == knn.wifi_bt.sam.1) / length(knn.wifi_bt.sam.1)  #k = 1  ---> 0.8745387
sum(labels.test.bt_wifi.sam == knn.wifi_bt.sam.3) / length(knn.wifi_bt.sam.3)  #k = 3  ---> 0.8523985
sum(labels.test.bt_wifi.sam == knn.wifi_bt.sam.5) / length(knn.wifi_bt.sam.5)  #k = 5  ---> 0.8376384
sum(labels.test.bt_wifi.sam == knn.wifi_bt.sam.11) / length(knn.wifi_bt.sam.11)  #k = 11  ---> 0.7527675
sum(labels.test.bt_wifi.sam == knn.wifi_bt.sam.21) / length(knn.wifi_bt.sam.21)  #k = 21  ---> 0.498155


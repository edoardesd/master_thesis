setwd("/Users/edoardesd/Documents/master_thesis/R_files")
getwd()


library(readr)
sam_bt_ok <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/sam_bt_ok.csv")
sam_wifi_ok <- read_csv("~/Documents/master_thesis/R_files/fingerprint/data/sam_wifi_ok.csv", 
                        col_types = cols(location = col_character()))

set.seed(1234)

#unsort wifi dataframe
gp1 <- runif(nrow(sam_bt_ok))
df.sam_bt <- sam_bt_ok[order(gp1),] 

#unsort bt dataframe
gp2 <- runif(nrow(sam_wifi_ok))
df.sam_wifi <- sam_wifi_ok[order(gp2),]

#split wifi df in test and training
sample.ind.wifi.sam <- sample(2, nrow(df.sam_wifi), replace = T, prob = c(0.7,0.3))

train.wifi.sam <- df.sam_wifi[sample.ind.wifi.sam==1,]
test.wifi.sam <- df.sam_wifi[sample.ind.wifi.sam==2,]

#split bt df in test and training
sample.ind.bt.sam <- sample(2, nrow(df.sam_bt), replace = T, prob = c(0.7,0.3))

train.bt.sam <- df.sam_bt[sample.ind.bt.sam==1,]
test.bt.sam <- df.sam_bt[sample.ind.bt.sam==2,]

#fix some formatting problem
test.bt.sam$location[421] = 2.2
train.bt.sam$location[619] = 2.2
train.bt.sam$location[1016] = 2.2


#normalize function
normalize <- function(x){ ((x-min(x))/ (max(x) - min(x)))}

#normalized dataframe
df.sam_wifi.norm <- as.data.frame(lapply(df.sam_wifi[,-5], normalize))
df.sam_bt.norm <- as.data.frame(lapply(df.sam_bt[, -5], normalize))

#add the labels to the normalized dataset
df.sam_wifi.norm["location"] <- df.sam_wifi$location
df.sam_bt.norm["location"] <- df.sam_bt$location


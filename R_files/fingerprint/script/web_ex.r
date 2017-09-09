#load required library – randomForest
library(randomForest)
#mlbench for Glass dataset – load if not already loaded
#library(mlbench)
#load Glass
data(Glass)
#set seed to ensure reproducible results
set.seed(42)
#split into training and test sets
sample.ind.glass <- sample(2, nrow(Glass), replace = T, prob = c(0.8,0.2))

trainGlass <- Glass[sample.ind.glass==1,]
testGlass <- Glass[sample.ind.glass==2,]
dim(trainGlass)
dim(testGlass)
#get column index of train flag
trainColNum <- 170

#get column index of predicted variable in dataset
typeColNum <- grep(Type,names(Glass))
#build model
Glass.rf <- randomForest(Type ~.,data = trainGlass, importance=TRUE,ntree=1000)
#Get summary info
Glass.rf

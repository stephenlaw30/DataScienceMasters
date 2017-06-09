'*********USE CROSS-VALIATION FOR K-NEAREST NEIGHBORS MODEL********************'
#install.packages('kknn')
library(kknn)

#load data
setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/GATech/Modeling')
cc <- read.table('credit_card_data-headers.txt', header = T, sep = '\t')
head(cc)

set.seed(1)

#set max value of k to test
kmax <- 30

'use train.kknn (sets kmax to run knn from k=1 to k=kmax(30)) to perform *leave-one out cross-validation* 
  up to k = kmax'
model <- train.kknn(R1~., cc, kmax = kmax, scale = T)

#create vector to hold predictions
correctPredictions <- rep(0,kmax)
acc <- rep(0,kmax)

#calculate predictions (round them to get 1 or 0 since model doesn't output them)
for (k in 1:kmax) {
  predicted <- as.integer(fitted(model)[[k]][1:nrow(cc)]+0.5) 
  correctPredictions[k] <- sum(predicted == cc[,11])
  acc[k] <- sum(predicted == cc[,11]) / nrow(cc)
}

correctPredictions
acc
which.max(acc)
'> correctPredictions
 [1] 533 533 533 533 557 553 554 555 554 557 557 558 557 557 558 558 558 557 556 556 555 554 552 553 553 552 550 548 549
[30] 550
> acc
[1] 0.8149847 0.8149847 0.8149847 0.8149847 0.8516820 0.8455657 0.8470948 0.8486239 0.8470948 0.8516820 0.8516820
[12] 0.8532110 0.8516820 0.8516820 0.8532110 0.8532110 0.8532110 0.8516820 0.8501529 0.8501529 0.8486239 0.8470948
[23] 0.8440367 0.8455657 0.8455657 0.8440367 0.8409786 0.8379205 0.8394495 0.8409786
> which.max(acc)
[1] 12

best accuracy comes from = 12 nearest neighbors'

'*********DO THE SAME BUT WITH CV.KKNN()********************'
library(kknn)

#load data
setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/GATech/Modeling')
cc <- read.table('credit_card_data-headers.txt', header = T, sep = '\t')
head(cc)

set.seed(1)

#set max value of k to test
kmax <- 30

#results vectors
correctPredictions.cv <- rep(0,kmax)
acc.cv <- rep(0,kmax) 


#calculate predictions
for (k in 1:kmax) {
  model.cv <- cv.kknn(R1~., cc,  
                   kcv = 10,       # 10 folds cross-validation
                   k = k,          # test on 1-kmax = 30 neighbors   
                   scale = T)
  
  predicted.cv <- as.integer(model.cv[[1]][,2]+0.5) 
  correctPredictions.cv[k] <- sum(predicted.cv == cc[,11])
  acc.cv[k] <- sum(predicted.cv == cc[,11]) / nrow(cc)
}

correctPredictions.cv
acc.cv
which.max(acc.cv)
'> correctPredictions.cv
 [1] 531 532 538 535 554 551 549 554 543 559 560 558 555 552 547 555 553 556 551 548 554 566 556 546 546 553 549 541 548
[30] 548
> acc.cv
[1] 0.8119266 0.8134557 0.8226300 0.8180428 0.8470948 0.8425076 0.8394495 0.8470948 0.8302752 0.8547401 0.8562691
[12] 0.8532110 0.8486239 0.8440367 0.8363914 0.8486239 0.8455657 0.8501529 0.8425076 0.8379205 0.8470948 0.8654434
[23] 0.8501529 0.8348624 0.8348624 0.8455657 0.8394495 0.8272171 0.8379205 0.8379205
> which.max(acc.cv)
[1] 22

get best accuracy w/ 22 neighbors'

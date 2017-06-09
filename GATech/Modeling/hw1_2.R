#install k-nearest neighbors package
install.packages('kknn')
library(kknn)

'kknn = k-nearest neighbors AND k-fold cross validation'

#load data
setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/GATech/Modeling')
cc <- read.table('credit_card_data-headers.txt', header = T, sep = '\t')
head(cc)

#create function to calculate model accuracy
check_acc <- function(x) {
  predicted <- rep(9,nrow(cc)) #empty vector to hold predictions of each record's outcome
  
  for (i in 1:nrow(cc)) {
    #create model + include data[-i] to remove row i when finding its nearest neighbors
    # - if not removed, it will be its own neatest neighbor
    model <- kknn(R1~.,      # formula to train on
                  cc[-i,],  # data to train on = data set w/ current row removed
                  cc[i,],  # data to test on = data set only w/ current row
                  k = x,     # number of neighbors = input variable
                  scale = T) # scale the data for us
    
    #record whether prediciton is at least 0.5 (round to 1) or less than 0.5 (round to 0)
      #not given integers by model output
    predicted[i] <- as.integer(fitted(model)+0.5) 
  }
  #calculate accuracy/fraction of correct predictions by taking sum of all predicted records that match outcome
  # and dividing by # all records
  acc <- sum(predicted == cc[,11]) / nrow(cc)
}

#check accuracy for 1 neighbor up to 20 neighbors
acc_20 <- rep(0,20)
for (j in 1:length(acc_20)) {
  acc_20[j] <- check_acc(j)
}

#check
acc_20

'0.8149847 0.8149847 0.8149847 0.8149847 0.8516820 0.8455657 0.8470948 0.8486239 0.8470948 0.8501529 0.8516820
0.8532110 0.8516820 0.8516820 0.8532110 0.8516820 0.8516820 0.8516820 0.8501529 0.8501529

See we consistently get around 85% accuracy around k = 11+, w/ k = 12 and k = 15 being the best

does NOT tell how good model is b/c we havent done any cross-validation or ran this model on test data

this is only TRAINING ACCURACY - will probably be lower on test data, but not required for this question'





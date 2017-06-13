'*********USE K-FOLDS CROSS-VALIATION w/ CARET********************'
library(kernlab)
library(kknn)

#load data
setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/GATech/Modeling')
cc <- read.table('credit_card_data-headers.txt', header = T, sep = '\t')
head(cc)

set.seed(1)

'**********SPLITTING**************'

#split into 60-20-20 for training, validation, and testing
#create a "mask" using sample() --> set of row indices, such as (1,4,5,8) for those respective rows

#60% training via a random sample out of specified #'s to choose from (# of rows in dataset) 
#   with size specified as the 60% of total rows given
mask_train <- sample(nrow(cc), size = floor(nrow(cc) * 0.6))

#create set via random rows from above
cc_train <- cc[mask_train,]

#20% validation + 20% test
remainingRows <- cc[-mask_train,]
mask_val <- sample(nrow(remainingRows), size = floor(nrow(remainingRows) * 0.5))
cc_val <- remainingRows[mask_val,]
cc_test <- remainingRows[-mask_val,]

#pick best 9 SVM models + best 20 KNN models via storing all results in 1 vector
acc <- rep(0,29)

'*********TRAIN SVM**************'
#9 values of C to test
c_amounts <- c(0.00001, 0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000)

#fit model w/ training set for each value of c
for (i in 1:9) {
  modelTrain <- ksvm(R1~.,                  #predict V11 outcome variable by all others
                cc_train,
                type = 'C-svc',         #use C classification
                kernel = 'vanilladot',  #simple linear kernel 
                C = c_amounts[i],       #lambda
                scaled = T,             #have ksvm scale the data
                cross = 10)             #number of folds
  
  #check preditions from model against validation set
  predictions <- predict(modelTrain,cc_val)
  
  #store in vector our accuracy of current c value model
  #acc[i] <- 1 - modelTrain@error 
  acc[i] <- sum(predictions == cc_val[,11]) / nrow(cc_val)

  
}
#check accuracy values for each c value
acc[1:9]
'[1] 0.5114504 0.5114504 0.7328244 0.8320611 0.8320611 0.8320611 0.8320611 0.8320611 0.8320611

See higher values of C (c >= 0.01)'

#present best performing SVM model
cat('The best SVM model is model number', which.max(acc[1:9]), 'with an validation set correctness/accuracy of',
    max(acc[1:9]), 'with a C/lambda value of', c_amounts[which.max(acc[1:9])])

#overwrite final loop model to get best model to use their values later 
set.seed(1)

modelTrain <- ksvm(R1~.,                  #predict V11 outcome variable by all others
                   cc_train,
                   type = 'C-svc',         #use C classification
                   kernel = 'vanilladot',  #simple linear kernel 
                   C = 0.01,       #lambda
                   scaled = T,             #have ksvm scale the data
                   cross = 10)             #number of folds

best_svm_model_acc <- sum(predict(modelTrain,cc_test) == cc_test[,11])/nrow(cc_test)

#test best model on test set
#cat('Best model perfomance on test set:', 1 - modelTrain@error)
cat('Best model perfomance on test set:', best_svm_model_acc)

'Best model actually does better on test set vs. validation set (85% vs. 83%), which is interesting'

'*********TRAIN KNN**************'

#remember we are testing 20 models w/ 20 different k's
for (k in 1:20) {
  #create model + use train and validation sets in this version
  modelTrain <- kknn(R1~.,      # formula to train on
                cc_train,  # data to train on = data set w/ current row removed
                cc_val,    # data to test on = data set only w/ current row
                k = k,     # number of neighbors = input variable
                scale = T) # scale the data for us
  
  #record whether prediciton is >= 0.5 (round to 1) or < 0.5 (round to 0) b/c model doesn't give int results
  predicted <- as.integer(fitted(modelTrain)+0.5)
  
  #store current model accuracy in acc vector
  acc[k+9] <- sum(predicted == cc_val[,11]) / nrow(cc_val)
}

#check
acc[10:29]
' [1] 0.7862595 0.7862595 0.7862595 0.7862595 0.7938931 0.7862595 0.7786260 0.7862595 0.7786260 0.7938931 0.7938931
[12] 0.7938931 0.7862595 0.7938931 0.7938931 0.8091603 0.8091603 0.8091603 0.8091603 0.8091603'

#present best performing KNN model
cat('The best KNN model is the model with k =', which.max(acc[10:29]),
    'folds with an validation set correctness/accuracy of',max(acc[10:29]))

#overwrite final loop model to get best model to use their values later 
set.seed(1)

modelTrain <- kknn(R1~.,      # formula to train on
                    cc_train,  # data to train on = data set w/ current row removed
                    cc_test,    # data to test on = data set only w/ current row
                    k = which.max(acc[10:29]),     # number of neighbors = input variable
                    scale = T) # scale the data for us

#get predictions
predicted <- as.integer(fitted(modelTrain)+0.5)
best_knn_model_acc <- sum(predicted == cc_test[,11])/nrow(cc_test)

#test best model on test set
#cat('Best model perfomance on test set:', 1 - modelTrain@error)
cat('Best model perfomance on test set:', best_knn_model_acc)

'Best model actually does better on test set vs. validation set (87% vs. 80%), which is interesting'


'************EVALUATE OVERALL BEST MODEL ON TEST SET*********************'

#check max VALIDATION accuracy from whole vector (SVM and KNN accuracies) and use that on the TEST SET
if (which.max(acc) <= 9) {
  #if SVM model was best, evaluate SVM method on the test set to find estimated quality
  cat('The best overall model was SVM model', which.max(acc[1:9]), 'with test set correctness/accuracy of',
      best_svm_model_acc, 'with a C/lambda value of', c_amounts[which.max(acc[1:9])])
} else {
  #if KNN model was best, evaluate KNN method on the test set to find estimated quality
  cat('The best overall model was the KNN model k =', which.max(acc[10:29]),
      'folds with a test set correctness/accuracy of',best_knn_model_acc)
}

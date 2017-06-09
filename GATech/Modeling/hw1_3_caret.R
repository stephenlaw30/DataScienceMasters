'*********USE K-FOLDS CROSS-VALIATION w/ CARET********************'
install.packages('caret',dependencies = T)
install.packages('quantreg')
library(caret)

'Caret uses a lot of other packages along w/ it to create a comprehensive toolkit for model building + validation'

#load data
setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/GATech/Modeling')
cc <- read.table('credit_card_data-headers.txt', header = T, sep = '\t')
head(cc)

set.seed(1)

#set max value of k to test/# of k-nearest neighbors models
kmax <- 15

#function below only runs KNN on odd # of k's (skips evens)
knn_fit <- train(as.factor(R1)~., cc,
                 method = 'knn',                     # choose k-nn model
                 trControl = trainControl(           # takes in type of CV to do
                   number = 10,                      # number of FOLDS (k in cross-validation)
                   repeats = 5),                     # number of times to repeat the k-fold CV
                preProcess = c('center','scale'),    # standardize data by centering (mean = 0, SD = 1) + scaling it
                tuneLength = kmax)                   #max number of neighbors
      
#check results to ID best value of k + its associated accuracy
knn_fit

'k-Nearest Neighbors 

654 samples
 10 predictor
  2 classes: 0, 1 

Pre-processing: centered (10), scaled (10) 
Resampling: Bootstrapped (10 reps) 
Summary of sample sizes: 654, 654, 654, 654, 654, 654, ... 
Resampling results across tuning parameters:

  k   Accuracy   Kappa    
   5  0.8219958  0.6409997
   7  0.8270557  0.6516329
   9  0.8262068  0.6502544
  11  0.8367675  0.6713953
  13  0.8315734  0.6610216
  15  0.8332530  0.6637710
  17  0.8418954  0.6815413
  19  0.8385436  0.6745468
  21  0.8368904  0.6711086
  23  0.8359810  0.6690640
  25  0.8364725  0.6696077
  27  0.8309739  0.6584089
  29  0.8325292  0.6613829
  31  0.8352139  0.6665544
  33  0.8360986  0.6679180

Accuracy was used to select the optimal model using  the largest value.
The final value used for the model was k = 17.

See only odd k values, and accuracy w assimilary to previous models

STILL HAVE NOT PICKED BEST MODEL B/C HAVE NOT USED ON TEST SET'
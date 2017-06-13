install.packages('lme4') #generalized linear mixed models
install.packages('geepack') #generalized estimating equations models
install.packages('survival') #survival analyses
install.packages('kernlab') #ksvm = support vector machine function

setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/GATech/Modeling')
cc <- read.table('credit_card_data-headers.txt', header = T, sep = '\t')
head(cc)

#need data in a matrix for vanilladot simple linear kernel
cc_m <- as.matrix(cc)

library(lme4)
library(geepack)
library(survival)
library(kernlab)

set.seed(1)

#kvsm(predictors,outcome,type (C for C classification), vanilladot kernel = simple linear kernel)
' - Use "scaled = TRUE" to get ksvm to *scale the data* as part of calculating a classifier.
  - C = The value of ?? in ksvm function/equation used to trade off the 2 components of 
      correctness/error and margin
        - 1 challenge of this homework is to find a value of C that works well
        - for many values of C, almost all predictions will be "yes" or all will be "no".
  - ksvm does not directly return the coefficients a[0], a[1], ..., a[m]
  - Need to do the last step of the calculation yourself.'

#call kvsm w/ vanilladot simle linear kernel
model <- ksvm(cc_m[,1:10],            #cols 1-10 = predictors/IV's
              cc_m[,11],              #col 11 = outcome variable/DV
              type = 'C-svc',         #use C classification
              kernel = 'vanilladot',  #simple linear kernel 
              C = 100,                #lambda
              scaled = T)             #have ksvm scale the data

'*******-OR****************'
model <- ksvm(V11~.,                  #predict V11 outcome variable by all others
              type = 'C-svc',         #use C classification
              kernel = 'vanilladot',  #simple linear kernel 
              C = 100,                #lambda
              scaled = T)             #have ksvm scale the data

'Support Vector Machine object of class "ksvm" 
  - SV type: C-svc  (classification) 
  - parameter : cost C (lambda) = 100 
  - Linear (vanilla) kernel function. 
  - Number of Support Vectors : 189 
  - Objective Function Value : -17887.92 
  - Training error : 0.136086 '

#see the different attributes of the model we can access, such as b = intercept and SVIndex = coefficients, error
attributes(model)

#calculate a[0],a[1],....,a[m]
' - Classification is done using LINEAR KERNELS --> y = a[0] + a[m]*scaled(x)
  - can use model output to calculate a[1]-a[m], as model doesnt direclty output it
  - use stored data points values in the model + the corresponding coefficients
  - xmatrix multiplied by the coef = lienar combination of data points that define a[1]-a[m]
  - use matrix attribute since the model stores data points as scaled'

a <- colSums(model@xmatrix[[1]]*model@coef[[1]])
a0 <- -model@b

'The above define our linear classifier
  V11 = 0.08158492 - 0.0010065348x1 - 0.0011729048x2 - 0.0016261967x3 + 0.0030064203x4 + 1.0049405641x5 - 
          0.0028259432x6 + 0.0002600295x7 - 0.0005349551x8 - 0.0012283758x9 + 0.1063633995x10'

#get model predictions via calculations
' 1) Going to calculate predicted values using our a values
  2) model coefficients are based on scaled data points --> need to scale our data points by using the scaled mean and
      scaled SD for V1-V10 in the model data structure to get correct predictions
  3) model@scaling$x.scale$"scaled:center" = means for V1:V10
  3) model@scaling$x.scale$"scaled:scale" = SDs for V1:V10
  5) then transform the data points into scaled equivalent via:
      scaledDataPoint[i,1:10] = 
        (dataPoint[i,1:10] - model@scaling$x.scale$"scaled:center")/model@scaling$x.scale$"scaled:scale"
  '
#create vector to hold predictions to preallocate memory (important in other languages)
predictedScaled <- rep(NA,nrow(cc_m))

#for each data point, transform into scaled equivalent + calculate a*scaledDataPoint + a[0], + predict value of data 
# point based on that result
for (i in 1:nrow(cc_m)) {
  #if predicted value is above classifier's value, predict 1, if below, predict 0
  if (sum(a*(cc_m[1,1:10] - model@scaling$x.scale$`scaled:center`)/model@scaling$x.scale$`scaled:scale`) + a >= 0) {
    predictedScaled[i] <- 1
  }
  if (sum(a*(cc_m[i,1:10] - model@scaling$x.scale$`scaled:center`)/model@scaling$x.scale$`scaled:scale`) + a < 0) {
    predictedScaled[i] <- 0
  }   
}

#get model predictions via predict()
pred <- predict(model,cc_m[,1:10])
pred

#get accuracy via 2 methods
sum(pred == cc_m[,11]) / nrow(cc_m)
sum(predictedScaled == cc_m[,11]) / nrow(cc_m)
1 - model@error
# = 86.39%

'*******************CROSS-FOLD VALIDATION FOR KVSM*************'
'*********SAME CODE AS BEFORE BUT W/ EXTRA ARG IN MODEL CREATION FOR # OF CROSS VALIDATIONS - cross = x'

setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/GATech/Modeling')
cc <- read.table('credit_card_data-headers.txt', header = T, sep = '\t')
head(cc)

#need data in a matrix for vanilladot simple linear kernel
cc_m <- as.matrix(cc)

library(lme4)
library(geepack)
library(survival)
library(kernlab)

set.seed(1)

#call kvsm w/ vanilladot simle linear kernel
model <- ksvm(R1~.,                  #predict V11 outcome variable by all others
              cc_m,
              type = 'C-svc',         #use C classification
              kernel = 'vanilladot',  #simple linear kernel 
              C = 100,                #lambda
              scaled = T,             #have ksvm scale the data
              cross = 10)             #number of folds

'Support Vector Machine object of class "ksvm" 
- SV type: C-svc  (classification) 
- parameter : cost C (lambda) = 100 
- Linear (vanilla) kernel function. 
- Number of Support Vectors : 189 
- Objective Function Value : -17887.92 
- Training error : 0.136086 '

'Support Vector Machine object of class "ksvm" 
- SV type: C-svc  (classification) 
- parameter : cost C = 100 
- Linear (vanilla) kernel function. 
- Number of Support Vectors : 189 
- Objective Function Value : -17887.92 
- Training error : 0.136086 
- Cross validation error : 0.137622 ---> new data point'

#calculate a[0],a[1],....,a[m]
a <- colSums(model@xmatrix[[1]]*model@coef[[1]])
a0 <- -model@b

'The above define our linear classifier
R1 = 0.08158492 - 0.0010065348x1 - 0.0011729048x2 - 0.0016261967x3 + 0.0030064203x4 + 1.0049405641x5 - 
0.0028259432x6 + 0.0002600295x7 - 0.0005349551x8 - 0.0012283758x9 + 0.1063633995x10'

#get model predictions via calculations

#create vector to hold predictions to preallocate memory (important in other languages)
predictedScaled <- rep(NA,nrow(cc_m))

#for each data point, transform into scaled equivalent + calculate a*scaledDataPoint + a[0], + predict value of data 
# point based on that result
for (i in 1:nrow(cc_m)) {
  #if predicted value is above classifier's value, predict 1, if below, predict 0
  if (sum(a*(cc_m[1,1:10] - model@scaling$x.scale$`scaled:center`)/model@scaling$x.scale$`scaled:scale`) + a >= 0) {
    predictedScaled[i] <- 1
  }
  if (sum(a*(cc_m[i,1:10] - model@scaling$x.scale$`scaled:center`)/model@scaling$x.scale$`scaled:scale`) + a < 0) {
    predictedScaled[i] <- 0
  }   
}

#get model predictions via predict()
pred <- predict(model,cc_m[,1:10])
pred

#get accuracy via 2 methods
sum(pred == cc_m[,11]) / nrow(cc_m)
sum(predictedScaled == cc_m[,11]) / nrow(cc_m)
1 - model@error
# = 0.8639144 = 86.39%
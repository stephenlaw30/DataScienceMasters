# Data Preprocessing

# Importing the dataset
setwd('C:/Users/Nimz/Dropbox/DataScienceMasters/R/MachineLearningAZ/02_Regression/Multiple_Linear_Regression')
startups <- read.csv('50_Startups.csv')

str(startups) #extracts from P&L

#check for NA's
summary(startups) #only CA and FL
head(startups)

'Business Value = create a model to tell a VC fund which is the most interesting new company to invest in (which types make most profit)

Dummy Variable Trap (NY and CA dummy variables from State Variable)
  - cant include both at same time
  - omit CA dummy, and if we include it we are basically duplicating a variable
  - D2 = 1- D1 --> Multicollinearity --> 1+ IVs in a linear regression predict another
  - as a result, a model cannot distinguish between the effects of D1 from the effects of D2 and therefore wont work properly
  - cant have the Constant/Intercept and both dummy variables at the same time
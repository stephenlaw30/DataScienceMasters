state <- c('CT','DE','MN','MA','NH','NJ','NY','PA','RI','VT')
millionares <- c(86,18,22,141,25,207,368,228,20,11)
pop <- c(35,8,13,64,13,87,193,124,11,6)

df <- cbind(millionares,pop)
df <- as.data.frame(df)

rownames(df) <- state

df

cor(df$millionares,df$pop) #0.9923768

#coefficient of determination --> R2 --> correlation coefficient ^ 2
cor(df$millionares,df$pop)^2
linFit(df$pop, df$millionares)

#Millionaires = 6.296 + (1.921 * State.Population)

# y for this model, if y represents the variable, Millionaires is the predicted number of millionaires, based on a 
#   population in a state.

#This linear model crosses the y-axis at 6.296, so a state with a population of 0 is expected to have 6,296 
# millionaires.

new_pop <- pop - min(pop)
df$new_pop <- new_pop

library(SDSFoundations)
linFit(df$new_pop, df$millionares)
#Millionaires=17.82 + (1.921 * State.Population)

#1.921 in the above model = As population of a state increases by 100k, they will gain 1,921 millionaires
#17.82 = On average, a state with a population equal to the lowest population has 17,820 millionaires


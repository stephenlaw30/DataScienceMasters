'Problem Set 6.4: Austin Hedgehogs 

A group of hedgehogs was released in the south-Austin area. Each year, the size of the population was recorded. 
Their population growth over time was modeled with a logistic growth curve. The model fit (R2) was 0.972. The model
parameters were:
  * C = 2,000
  * a = 152.10
  * b = 2.17

According to this model, the maximum number of hedgehogs in South Austin is 2k and the size of the hedgehog 
population began to slow down about 6.5 years after the project start, with a population of 1k (halfway point to 
max)'

#log(a)/log(b)
log(152.10)/log(2.17) #= 6.485558

2000/(1+152.10*(2.17)^-(log(152.10)/log(2.17))) #= 1000

'The hedgehogs were released in South Austin in 2001. 1750.458 hedgehogs were living in South Austin by 2010, 
according to the model.
'
2000/(1+152.10*(2.17)^-(9)) #=1750.458
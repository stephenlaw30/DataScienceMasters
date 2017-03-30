'Have you ever been curious about how long it takes for an animal to be adopted?  To investigate questions like this, we 
contacted the Austin Animal Shelter and they provided us with info about 473 cats and dogs.  Included in the dataset are 
info about how animals arrived at the shelter, their sex, breed, age, weight, and the number of days spent in the shelter.  '

library(SDSFoundations)
animaldata <- AnimalData

table(animaldata$Intake.Type[animaldata$Animal.Type == 'Dog'])
prop.table(table((animaldata$Intake.Type[animaldata$Animal.Type == 'Dog'])))

dogs <- animaldata[animaldata$Animal.Type == 'Dog',]
ownerSurrenderedDogs <- dogs[dogs$Intake.Type == 'Owner Surrender',]
table(ownerSurrenderedDogs$Outcome.Type)

returnedSurrenderedDogs <- ownerSurrenderedDogs[ownerSurrenderedDogs$Outcome.Type == 'Return to Owner',]
mean(returnedSurrenderedDogs$Days.Shelter)

'"Stray" was the most common way that dogs arrived in the shelter, and 0.278350515 = 27.84% of dogs brought to the 
shelter as an owner surrender, and of these dogs, 2 were returned to their owner. The mean number of days the dogs 
returned to owners spent at the shelter before being returned to their owner was 3.5 days. The correct graph type to
show the distribution of dog intake types is a Bar graph'
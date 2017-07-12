'******Course Week 4: Hypothesis Testing (Categorical Data) Problem Set Question 4**************

A telephone survey asked a random sample of Indiana voters about their home internet usage, as well as what type of 
community (rural, suburban or urban) they lived in. 

Of the 123 survey respondents, 28 were from rural areas, 42 were from suburban areas, 53 were from urban areas.  

13 rural respondents, 35 suburban respondents, and 50 urban respondents said they had access to internet at home. 

4a. What is the appropriate null hypothesis for this test?'

# Home internet access and community type are independent.

'4b. What proportion of respondents had + did not have internet access at home?'

area <- c(28,42,53)
internet.yes <- c(13,35,50)

round(internet.yes/area,3)
round(sum(internet.yes)/sum(area),3) # 0.797
1 - round(sum(internet.yes)/sum(area),3) # 0.203

'4d. How many rural residents would we expect to have home internet?'

obs.yes.rural <- internet.yes[1]
obs.yes.suburban <- internet.yes[2]
obs.yes.urban <- internet.yes[3]

obs.no.rural <- area[1] - internet.yes[1]
obs.no.suburban <- area[2] - internet.yes[2]
obs.no.urban <- area[3] - internet.yes[3]

obs.rural <- obs.yes.rural + obs.no.rural
obs.suburban <- obs.yes.suburban + obs.no.suburban
obs.urban <- obs.yes.urban + obs.no.urban

obs.yes.ttl <- sum(obs.yes.rural,obs.yes.suburban,obs.yes.urban)
obs.no.ttl <- sum(obs.no.rural,obs.no.suburban,obs.no.urban)

obs.ttl <- obs.yes.ttl + obs.no.ttl

exp.yes.rural <- round((obs.rural*obs.yes.ttl)/obs.ttl,2)
exp.yes.suburban <- round((obs.suburban*obs.yes.ttl)/obs.ttl,2)
exp.yes.urban <- round((obs.urban*obs.yes.ttl)/obs.ttl,2)

exp.no.rural <- round((obs.rural*obs.no.ttl)/obs.ttl,2)
exp.no.suburban <- round((obs.suburban*obs.no.ttl)/obs.ttl,2)
exp.no.urban <- 10.76 #round((obs.urban*obs.no.ttl)/obs.ttl,2)

'4f. Does this data provide sufficient evidence that internet access at home depends on what type of 
community the Indiana voters live in?'

chi<- round(sum((obs.yes.rural - exp.yes.rural)^2/exp.yes.rural,
                (obs.yes.suburban - exp.yes.suburban)^2/exp.yes.suburban,
                (obs.yes.urban - exp.yes.urban)^2/exp.yes.urban,
                (obs.no.rural - exp.no.rural)^2/exp.no.rural,
                (obs.no.suburban - exp.no.suburban)^2/exp.no.suburban,
                (obs.no.urban - exp.no.urban)^2/exp.no.urban),2)

crit <- 5.991

chi > crit

# Yes
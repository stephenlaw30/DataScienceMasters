'Pre-Lab 3: Post Student-Survey Data

Students at UT at Austin answered a set of questions at the beginning + end of the semester.

We will use this data to compare different groups + to explore what has (or has not) 
changed over time for these students.

******Primary Research Questions*****
  1.  Who is happier at the beginning of the semester:  under-classmen or upper-classmen?
  2.  Does student happiness change from the beginning of the semester to the end?

Begin by examining the data in R.'

library(SDSFoundations)
post <- PostSurvey

'1a. How many students are in the dataset?'

dim(post)
length(unique(post$ID)) #214

'1b. What is the classification of the 1st male student?'

head(post[post$gender == 'Male',]) #Freshman

'1c. Of the 1st 10 students in the dataset, what % live on campus?'

first10 <- post[1:10,]
nrow(first10[first10$live_campus == 'yes',])/nrow(first10) # 50%

'Check the Variables of Interest to find the variables we need to answer the question.

2a. Which variable tells us whether a student is a lower-classman (freshman or sophomore)?'

names(post) # classification --> categorical

'2b. Which variable tells us how happy students were at the beginning of the semester?'

#happy --> quantitative

'2c. Which variable tells us how happy students were at the end of the semester?'

# post_happy --> quantitative

'***Which method should we be using for this analysis and why?***

3a. We will use an independent t-test to help us compare the *happiness of the under + 
upper-classmen*. Why?'

# We want to compare the happiness of two different populations of students.

'3b. We will use a dependent t-test to help us determine *whether happiness levels 
changed over the semester*. Why?'

# We are looking for a change over time for the same group of students.
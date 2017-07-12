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



'Break this analysis into its required steps:
  
***Question 1:  Independent t-test****
1. Make a vector of happiness scores for each sample (under- and upper-classmen).'

happy_under <- post[post$classification == 'Freshman' | post$classification == 'Sophomore',]
happy_upper <- post[post$classification == 'Junior' | post$classification == 'Senior',]

'2. Generate histograms to check the Normality assumption. '
library(ggplot2)
ggplot(happy_under) + geom_histogram(aes(x = happy), bins = 11)
ggplot(happy_upper) + geom_histogram(aes(x = happy), bins = 8)

'3. Run an independent t-test.'
mu.un <- mean(happy_under$happy)
mu.up <- mean(happy_upper$happy)

s.un <- sd(happy_under$happy)
s.up <- sd(happy_upper$happy)

n.un <- nrow(happy_under)
n.up <- nrow(happy_upper)

se <- sqrt(((s.un^2)/n.un) + ((s.up^2)/n.up))

t <- (mu.un - mu.up)/se #0.4230241

  
t.test(happy_under$happy, happy_upper$happy)
'	Welch Two Sample t-test

data:  happy_under$happy and happy_upper$happy
t = 0.42302, df = 35.358, p-value = 0.6748
alternative hypothesis: true difference in means is not equal to 0
95% CI: (-5.210391, 7.954653)
sample estimates:
  mean of x = 79.67213
  mean of y = 78.30000 '

'4. Interpret the results.'

# Cannot reject the null

'*****Question 2:  Dependent t-test******

1. Make a vector of difference scores for student happiness from the beginning to the end of semester.'

post$happy_diff <-post$happy - post$post_happ

'2. Generate a histogram of the difference scores to check the Normality assumption.'

ggplot(post) + geom_histogram(aes(x = happy_diff), bins = 15)

'3. Run a dependent t-test.'
mu.d <- mean(post$happy_diff)

s.d <- sd(post$happy_diff)

n.d <- nrow(post)

se.d <- s.d/sqrt(n.d)

t <- (mu.d)/se.d #1.683824

t.test(post$happy_diff)
'	One Sample t-test

data:  post$happy_diff
t = 1.6838, df = 213, p-value = 0.09368
alternative hypothesis: true mean is not equal to 0
95% CI = (-0.2168971, 2.7589532)
sample estimates:
  mean of x = 1.271028 

4. Interpret the results.'

#Fail to reject null

'Suppose we wanted to test the happiness scores of those who live on campus against those who live off campus. What has caused the
error below?
    
    post <- PostSurvey
    on_campus <- post[post$live_campus == yes,]
    off_campus <- post[post$live_campus == no,]
    on_campus_happy <- on_campus$happy
    off_campus_happy <- off_campus$happy
    t.test(on_campus_happy, off_campus_happy, paired = T)

Error in complete.cases(x, y) : not all arguments have the same length'

# We ran the wrong type of test --> these are not paired samples


'*********Primary Research Quesitons********
  1.  Who is happier at the beginning of the semester:  under-classmen or upper-classmen?
  2.   Does student happiness change from the beginning of the semester to the end?

At the beginning of the semester:
  1a. What % of the time, on average, were underclassmen happy?'

round(mu.un,1) #79.7

'1b. What percent of the time, on average, were upperclassmen happy?'

round(mu.up,1) #78.3

'Report test results, rounded to 3 decimal places:'

round((mu.un - mu.up)/se,3) # t =0.423 w/ p = 0.675

'We should FAIL to reject h(0) that there is no difference in happiness between under + upper classmen at the beginning of the 
semester. p is too high and t is not in the critical region

2a. How many students were in this analysis?'

nrow(post) #214

'2b. The average change in happiness was 1.27%. Was this an increase or decrease over the semester'

mean(post$happy_diff) # = happy - post_happy was positive = DECREASE

'Report test results, rounded to 3 decimal places:'

round((mu.d)/se.d,3) #t = 1.684 w/ p = 0.09368

'We should FAIL to reject h(0) that there is no change in happiness over the semester.



3a. The distribution of both under + upper-classmen happiness was left/negatively-skewed, while the distribution of happiness 
difference scores was relatively normal w/ a slight right/positive-skew



The average happiness scores for under (79.7%) + upper-classmen (78.3%) were not found to be significantly different (t = 0.423, 
p = .675). The distribution of scores for each group were negatively /left-skewed. However, the sample sizes were both sufficiently 
large to meet the assumption for Normality (>= 30). Over the semester, student happiness decreased by an average of 1.27%. This
was not a statistically significant change (t = 1.684 p = .094). Overall, there does not appear to be any significant difference in 
levels of student happiness based on their year in college, or the time of the semester.'
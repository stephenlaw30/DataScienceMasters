'*****Lab 3: Post Student-Survey Data*****


Students at UT at Austin answered a set of questions at the beginning + end of the semester.  
Wewill use this data to compare different groups + to explore what has or has not changed over 
time for these students. 

In this lab, you will use 2-sample t-tests to answer a question of interest. 

2 samples are considered dependent when:'
  
#each score in one sample is paired with a specific score in the other sample.

'Two samples are considered independent when'

#the scores of one sample do not affect the scores of the other sample.

library(SDSFoundations)
post <- PostSurvey

'Which type of t-test is needed to run the analysis.
  - Q1: Do students at UT spend more time on homework per week in college than in HS?'
    # - Dependent samples t-test
  '- Q2: Do students in fraternities + sororities get less sleep on weekends than other students?'
    # - Independent samples t-test

'*****Primary Research Questions*****

1. Do students at UT spend more time on homework per week in college than in HS?
2. Do students in fraternities + sororities get less sleep on weekends than other students?

*******Analysis************

Break this question down into the different statistics needed to construct an answer.

For each hypothesis test, 
  1. Create vectors of the scores you wish to analyze.
  2. Check the assumption of normality by generating a histogram for each variable of interest. 
  3. Find the t-statistic + p-value.
  4. Interpret the results of each test. 

NOTE:  If running *directional* hypotheses tests, remember you must modify the code to reflect 
this direction.
  - A one-sided test looks like this:   '

        #t.test(Variable1, Variable2, alternative = 'less'), when you expect Mean1 < Mean2
        #t.test(Variable1, Variable2, alternative = 'greater'), when you expect Mean1 > Mean2


'1a. On average, students spent how many hours more on homework each week in college than in HS?'

round(mean((post$hw_hours_college - post$hw_hours_HS)),2)
round(mean(post$hw_hours_college) - mean(post$hw_hours_HS),2)
# both = 10.94626 = 10.95

hw_diff <- (post$hw_hours_college - post$hw_hours_HS)

t.test(hw_diff)
'One Sample t-test

data:  hw_diff
t = 16.812, df = 213, p-value < 2.2e-16
alternative hypothesis: true mean is not equal to 0
95% CI: (9.662804, 12.229720)
sample estimates: mean of x = 10.94626 

p < 0.05, and based on these test results, we would conclude that students DO spend more time on 
homework in college than they did in high school.'



'2a. On average, Greek students sleep how many hours less than Non-Greek students on Saturday nights?'

greek <- post[post$greek == 'yes',]
non.greek <- post[post$greek == 'no',]

round(mean(greek$sleep_Sat) - mean(non.greek$sleep_Sat),1)

t.test(greek$sleep_Sat, non.greek$sleep_Sat, alternative = 'less')
'	Welch Two Sample t-test

data:  greek$sleep_Sat and non.greek$sleep_Sat
t = -0.98077, df = 62.948, p-value = 0.1652
alternative hypothesis: true difference in means is less than 0
95% CI: (-Inf, 0.2214398)
sample estimates:
mean of x     mean of y 
7.727273      8.042647

Based on these results, we conclude people in fraternities or sororities do NOT get less sleep on 
weekends than other students.'
                                            
library(ggplot2)
hist(hw_diff)
hist(greek$sleep_Sat)
hist(non.greek$sleep_Sat)

'3. The Normality assumption  WAS met in each hypothesis test.

The average amount of di???erence in the time that UT students spent on HW in HS versus college was found 
to be approximately normal. The di???erence showed that, in college, students spend 10.95 hours more on HW
per week than in HS. This di???erence is signi???cant (t(213) = 16.81 , p < .0.05).

The distributions for the amount of sleep for greek students + other students are both approximately 
normal. There was NOT a signi???cant di???erence between in amount of Saturday night sleep for Greek students
(mean = 7.73) and those who are not (mean = 8.04), with a t = -0.981 (dF = 62.95) + p = 0.1652
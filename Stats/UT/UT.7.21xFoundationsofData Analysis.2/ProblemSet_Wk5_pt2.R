'******Course Week 5: Hypothesis Testing (More Than Two Group Means)****

Question 2

45 dog lovers are recruited for a study examining the calming effects of pets during
stressful situations. 15 subjects were randomly assigned to each of 3 different groups: 
  - performing the task alone (control),
  - performing the task with a good friend present
  - performing the task with their dog present. 

The peak heart rate (in BPM) during the task was measured for each subject, 
with the following results:
      Alone 	Good Friend 	Pet Dog
Mean 	82.52 	91.32       	73.48
SD 	  9.24 	  8.34 	        9.97

2a. What is the appropriate null hypothesis for this test?'

# H(0) = H1 = H2 = H3

'2b. To run a reliable ANOVA, what must be true of this data?'

# The heart rate data should be normally distributed in each group.
# Each group should have approximately equal standard deviations.
# Each group has independent, random data.

'2c. What are the degrees of freedom for this test?'

# Numerator Degree of Freedom = groups - 1 = k - 1 = 3 - 1 = 2
# Denominator Degree of Freedom = sample - groups = N - k = 45 - 3 = 42

'2d. What is the critical F for this test, assuming ??= 0.05? (Round to 2 decimal places.)'

# 3.23

'2e. In this problem, you find that SStotal = 5949.1 and SSBetween = 2387.7. 
What is the F statistic for the test? (Round to 2 decimal places.)'

SS.t = 5949.1
SS.b = 2387.7
SS.w = SS.t - SS.b # 3561.4

MS.b = SS.b / 2
MS.w = SS.w / 42

f = MS.b / MS.w # 14.07921 = 14.08

'2f. What is the outcome of this test?'

# Reject the null hypothesis
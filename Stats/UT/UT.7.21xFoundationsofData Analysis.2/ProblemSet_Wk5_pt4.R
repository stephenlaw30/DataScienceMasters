'******Course Week 5: Hypothesis Testing (More Than Two Group Means)****

Question 4

Below is the source table for a study on sleep aids, comparing the effectiveness of 
3 different treatments.  Note that some of the elements of the table are missing. 

                    SS 	      df 	  MS 	  F
Between Treatments 	782.00 			
Within Treatments 		        34 		
Total 	            2147.00 			

4a. What is SSWithin ?'

SS.t <- 2147
SS.b <- 782
SS.w <- SS.t - SS.b

'4b. What is dfTotal ?'

# 36

'4c. What is MSWithin ? (Round to 2 decimal places.)'

MS.w <- round(SS.w / 34,2) # 40.14706 = 40.15

'4d. What is the F statistic? (Round to 2 decimal places, and use your rounded answer from 4c.)'

MS.b <- round(SS.b / 2,2)
f <- MS.b / MS.w # 9.74

'4e. Using an F-critical of 3.28, what is the appropriate conclusion of the test?'

# At least one of the sleep aids performs better than the others.

'4f. You decide to perform a post-hoc analysis on these group means using a Bonferroni 
correction. How many group mean comparisons will you do?'

bonferroni <- (3 * (3-1)) / 2 # 3

'4g. What should be the new significance level for your post-hoc tests, 
assuming an original ??=0.05? (Round to 3 decimal places.)'

round(0.05 / bonferroni,3) # 0.017

'4h. Here are the results from your post-hoc analysis. These are the p-values from the 
actual t-tests. They are NOT adjusted, so be sure to compare them to the significance 
level  calculated above.

                    T-Statistic 	P-Value
Group 1 - Group 2 	1.90 	        0.137
Group 1 - Group 3 	3.79 	        0.004
Group 2 - Group 3 	3.44 	        0.028

What do you conclude?'

# The Sleep Aid 1 was significantly different from the Sleep Aid 3 group.
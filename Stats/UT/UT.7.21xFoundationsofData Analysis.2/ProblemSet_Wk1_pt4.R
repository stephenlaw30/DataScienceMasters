'Question 4
Dixie Queen uses an automatic ice cream dispenser to fill pint-sized containers of ice cream. The company that makes 
the dispenser says the volume it dispenses into each container follows a normal distribution with ?? = 1.5 ml.
The Dixie Queen manager randomly selected 15 ice cream pints + found average volume = 471.46 ml. She wants to know if 
her machine is performing as expected.

4a. What is the expected variability in sample means of size n=15?'
sig <- 1.5
n = 15
dF <- n - 1
se1 <- sig/sqrt(n) #0.3872983

'4b. What is the margin of error, assuming 95% confidence?'
z.crit.95 <- 1.96 #95% = 5% split into 2 tails = 2.5% --> look for 0.025 in z-table + use that score
moe <- z.crit.95*se1

'4c. Find the 95%  CI for the mean volume for this sample of 15 randomly selected ice cream pint containers.'
x <- 471.46
low <- x - moe #470.7009
upp <- x + moe #472.2191

'4d. A pint is equivalent to 473.20 ml. Do you think the dispenser is working as reported?'
# - No
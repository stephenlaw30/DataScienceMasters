Udacity Intro to Inferential Statistics Final Project - Wine Quality
================

Analysis of Wine Quality
========================

Utilizing the **Wine Quality Data Set** from the [UCI Machine Learning Repository.](https://archive.ics.uci.edu/ml/datasets/Wine+Quality)

This is actually 2 datasets, which, respectively, are related to red and white variants of the Portuguese "Vinho Verde" wine. The data sets contain the same variables, and the inputs/independent variables are physicochemical data, and sensory/output variables are also available (e.g. there is no data about grape type, brand, selling price, etc.).

I was interested in finding out if there's a significant difference in quality of wines with higher alcohol content compared to the population of wines gathered in these 2 data sets.

The first thing I did was load in both data sets and merge them together, while also creating a new feature to signify if a wine was a red or a white.

``` r
# inspect
head(wine)
```

    ##   fixed.acidity volatile.acidity citric.acid residual.sugar chlorides
    ## 1           7.4             0.70        0.00            1.9     0.076
    ## 2           7.8             0.88        0.00            2.6     0.098
    ## 3           7.8             0.76        0.04            2.3     0.092
    ## 4          11.2             0.28        0.56            1.9     0.075
    ## 5           7.4             0.70        0.00            1.9     0.076
    ## 6           7.4             0.66        0.00            1.8     0.075
    ##   free.sulfur.dioxide total.sulfur.dioxide density   pH sulphates alcohol
    ## 1                  11                   34  0.9978 3.51      0.56     9.4
    ## 2                  25                   67  0.9968 3.20      0.68     9.8
    ## 3                  15                   54  0.9970 3.26      0.65     9.8
    ## 4                  17                   60  0.9980 3.16      0.58     9.8
    ## 5                  11                   34  0.9978 3.51      0.56     9.4
    ## 6                  13                   40  0.9978 3.51      0.56     9.4
    ##   quality isRed
    ## 1       5     1
    ## 2       5     1
    ## 3       5     1
    ## 4       6     1
    ## 5       5     1
    ## 6       5     1

My hypothese here were: \* h(0) = There is no signifcant difference in wine quality between all wines and wines of higher alcohol content \* h(a) = Wines with a higher alcohol content significantly differ in quality than the population of wines

My first step after defining my hypothesis was to check the distribution of the **quality** variable of the dataset.

`{ r check population} ggplot(wine) + geom_histogram(aes(x = (quality)),                               bins = 6,                               fill = 'purple',                                colour = 'black') +    ggtitle('Distribution of Wine Quality Scores') +    xlab('Quality') +    ylab('Count')` \# population parameters mu &lt;- mean(wine$quality) \# 5.818378 sigma &lt;- sd(wine$quality) \# 0.8732553

create sample wines with above average alcohol content
======================================================

set.seed(15) highAlcQuality &lt;- wine*q**u**a**l**i**t**y*\[*w**i**n**e*alcohol &gt; mean(wine$alcohol)\]

ggplot() + \#geom\_histogram(aes(x = log(wine$alcohol)), fill = 'blue') + geom\_histogram(aes(x = highAlcQuality), bins = 6, fill = 'dark red', colour = 'black') + ggtitle('Distribution of Quality of Above-Average Alcohol Content Wine') + xlab('Quality') + ylab('Count')

sample statistics
=================

x &lt;- mean(highAlcQuality) \# 6.184963 stdErr &lt;- sigma/sqrt(length(highAlcQuality)) \# 0.01592747

calculate margin of error for z-critical score of 1.96 for 95% confidence
=========================================================================

margErr &lt;- 1.96\*stdErr \# 0.03121784

95% of samples means in this distribution are between
=====================================================

lowCI &lt;- mu.w - margErr.w highCI &lt;- mu.w + margErr.w

lowCI &lt; mu.w & mu.w &lt; highCI

z &lt;- (x - mu)/(stdErr) \# 23.01594 \#reject Null that higher alcoholic wine is the same quality as below average or average \# i.e. it's significantly different in quality (greater b/c positive z-score)

'\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*'

ggplot() + geom\_point(aes(x = wine*a**l**c**o**h**o**l*, *y* = *w**i**n**e*quality))

highAlc &lt;- wine\[wine*a**l**c**o**h**o**l* &gt; *m**e**a**n*(*w**i**n**e*alcohol),\]

cor(wine*a**l**c**o**h**o**l*, *w**i**n**e*quality) \# 0.4443185 = mildly positive linear relationship cor(wine*a**l**c**o**h**o**l*, *w**i**n**e*quality)^2 \# 0.1974189 = 19.74% of variation in quality is due to variation in alcohol %

'. Even if 2 variables appear to be related after looking at the data, it could just be due to chance . The actual population might not have this relationship . Or vice versa, where the population has a relationship but a sample from it does not . Things like this happen due to sampling error, which can be reduced w/ larger sample sizes ' \#test w/ a linear regression model summary(lm(quality~alcohol,wine)) \#see that alcohol is very significant w/ a very small p-value, so this relationship is statistically significant, \# but is not very strong, as there are plenty of other factors which may as well be affecting quality of the wine \`\`\`

Including Plots
---------------

You can also embed plots, for example:

![](finalMarkdown_files/figure-markdown_github-ascii_identifiers/pressure-1.png)

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

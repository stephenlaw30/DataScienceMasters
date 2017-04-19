#COURSERA STATS W/ R SPECIALIZATION
# - COURSE 1 - Introduction to Probability and Data
#   - WEEK 1

'
  * Numerical variables = quantitative = sensible to add/subtract, take averages, etc.\
    * continous --> infinite # of values w/in given range (height, weight)
      * rounding of continous can make a variable look discrete
    * discrete --> one of a specific set of numeric values, so we can account for/enumerate/count all 
        the numeric possibilites (# of cars in lot) = COUNTS
  * Categorical variables = qualitative = limited # of distinct categories, which can be IDed w/ #s but are not 
    sensible to do operations on (1 = male, 2 = female)
    * ordinal - levels w/ inherent ordering (not satisfied, satisfied, very satisfied)
    * regular categorical - levels w/ NO inherent ordering (morning person, afternoon person, night owl)

Studies
  * observational --> collect data in a way that does not directly interfere w/ how data arises ("observe")
    * can ONLY establish ASSOCIATION/CORRELATION between explanatory/dependent vars and indepenent/response vars
    * RETROSPECTIVE --> data from past
    * PROSPECTIVE --> data collected as study goes on to predict future
  * experiment -->  random assign subjects to treatments to assign causal connections between vars

CONFOUNDING VARIABLES - extraneous variables affecting both explanatory/dep and response/ind vars to make it seem 
  like there is some relationship between them

What determines if we can infer causation is the type of study (observation = correlation, experiment = causation)
  * some more advanced methods (causal inference) that allow us to make CAUSATION statements from observational studies'

'Conducting a census (entire population) takes lots of resources, some individuals may be hard to locate/measure and may be different 
from the rest of the population (ex: US Census --> illegal immigrants often not recorded properly, since they tend to be reluctant to
fill out census forms, w/ the concern this info could be shared with Immigration)
  * if they possess characteristics different than the rest of the population, not getting info from them might result in very 
    unreliable data from geographical regions w/ high concentrations of illegal immigrants. 
Also, populations rarely stand still --> never really possible to get a perfect measure. 

Sampling is actually quite natural.
  *  **Convenience sample bias** --> easily accessible individuals are more likely to be included in the sample. 
  *  **non-response** --> happens if only a non-random fraction of the randomly sampled people respond to a survey, such that the sample
      is no longer representative of the population (ex: lower socioeconomic status = less likely to respond to a city survey). 
  *  **voluntary response bias** --> sample consists of only people who volunteer to respond b/c they have strong opinions on an issue.
    * Ex: online polls --> people who responded definitely do not make up a representative sample of a world population, since these 
      are people who happen to have visited a website the day the poll was posted and felt strongly enough to vote. 

Difference between voluntary response bias and non-response bias
  * non-response = a random sample surveyed, but people who choose to 
  respond are not representative of the sample
  * voluntary response = no initial random sample. 

Ex: Literary Digest polled 10M + got responses from ~2.4M (now a days reliable polls in the US routinely poll about 1.5K people, so this
  was a huge sample), and showed Landon = overwhelming winner + FDR = 43% of the votes. 
  * FDR won w/ 62% b/c magazine surveyed its OWN readers, registered automobile owners and registered telephone users. 
  * These groups had incomes well above national average of the day (great depression era) = lists of voters far more likely to support 
    Republicans than a truly "typical" voter of the time.
  * While the poll was based on a huge sample, it was biased = did not yield an accurate prediction. 

### Sampling methods
  * **simple random sampling** = randomly select cases from population such that each case is equally likely to be selected (randomly 
    draw names from a hat)
  * **stratified sampling** = 1st divide population into homogenous groups (**strata**) and randomly sample from *within each stratum.* 
      * Ex: make sure both genders are equally represented in a study -> divide the population into males and females + *then* randomly
        sample from within each group. In 
  * **cluster sampling = divide population into **clusters**, randomly sample a few clusters, and *then* sample ALL observation w/in
      these clusters. 
    * clusters, unlike strata and stratified sampling, are *heterogeneous* w/in themselves, and each cluster is similar to another, 
      such that we can get away w/ just sampling from a few of the clusters. 
  * **multistage sampling** = adds another step to cluster sampling --> divide population into clusters, randomly sample a few 
      clusters, + then *randomly* sample observations from w/in these clusters. 
    * Usually, we use cluster sampling and multistage sampling for economical reasons. 
    * 1 might divide a city into geographic regions that are on average similar to each other + then sample randomly a few of these 
      regions, go to these randomly picked regions, and then sample a few people from w/in these regions to avoid need to travel to all 
      of regions in the city. 

QUIZ = Retail Store randomly samples 1K of their credit card holders to survey via phone during work hours, so a lower rate of response
  is recorded from members who work in these hours --> NON-RESPONSE BIAS = initially random, but not everyone in random sample is 
  reached

### Principles of experimental design
**4 principles of experimental design**  
  * **control** = to compare treatment of interest to a control group
  * **randomize** = randomly assigning subjects to treatments
  * **replicate** = collecting a sufficiently large sample within the study or to replicate the entire study
  * **block** = If there are variables known/suspected to effect the response variable, 1st group the subjects into blocks based on
      these variables + then randomly place cases from w/in each block to treatment groups. 

Ex: Design experiment to investigate if energy gels make you run faster. 
  * treatment group = gets energy gel +  control group = does not
  * It is suspected energy gels might effect pro and amateur athletes differently --> therefore we block for pro status. 
  * Divide sample into pro and amateur athletes + then randomly assign both pro and amateur athletes to treatment and control groups
  * therefore pro and amateur athletes are equally represented in the resulting treatment and control groups. 
  * Now if we do find a difference in running speed between treatment + control groups, we can attribute it to the treatment + be 
    assured the difference is NOT due to pro status (since both athletes were equally represented in the treatment + control groups) 

Difference between a blocking variable and an explanatory variable:
  * Explanatory variables (factors) = conditions *we can impose* on our experimental units. 
  * Blocking variables = characteristics that our experimental units *come with* that we would like to control for. 

Blocking is like stratifying, except used in experimental settings *when randomly assigning* as opposed to when sampling.

Ex: Study designed to test light and noise level on exam scores, while assuming both might have different effects on males and females
  * Want both genders equally represented --> 2 explanatory variables (light, noise), 1 blocking (gender), 1 response (exam score)

**placebo** = fake treatment, often used as the control group for medical studies. 
**placebo effect** = when experimental units show improvement simply b/c they believe they are receiving a special treatment. 
**Blinding** = when experimental units do not know whether they are in the control or treatment group
**double-blind** = both the experimental units and the researchers do not know who is in the control or in the treatment group. 

Random sampling and random assignment sound similar, but serve quite different purposes in study design. 
  * **Random sampling** occurs when subjects are being selected for a study. 
    * If subjects are selected randomly from the population, each subject is equally likely to be selected and a resulting sample is
      likely representative of the population so the study results are generalizable to the population at large. 
  * **Random assignment** occurs *only in experimental settings* when *subjects are assigned to various treatments*. 
    * Usually see that subjects in a sample exhibit slightly different characteristics from one another. 
    * Through random assignment, we ensure these different characteristics are represented equally in treatment and control groups to
      allow us to attribute any observed difference between treatment and control to the treatment being observed, since otherwise 
      these groups are essentially the same. 
    * In other words, random assignment allows us to make CAUSAL conclusions based on the study.

Ex: Want to conduct a study evaluating whether people read serif fonts or sans serif faster. 
  * Ideally --> 1st randomly subjects for from the population, *then* assign subjects in the sample to 2 treatment groups
  * 1 = read some text in serif font and 2 = read the same text in sans serif font. 
  * Through random assignment, we ensure other factors that may be contributing to reading speed (ex: fluency, how often a subject 
    reads for leisure, etc.) are represented equally in the 2 groups --> i.e. **confounders/confounding variables** 
  * In this setting, if we observe any difference between average reading speeds of the 2 groups, we can attribute it to the treatment
    (the font type) and know it is likely not due to a confounding variable. 

So to recap, sampling happens first + assignment happens second. 
  * ideal experiment = employs random sampling AND random assignment = causal conclusions that can be generalized to a whole population 
    * But site studies are usually difficult to carry out, especially if experimental units are humans, since it may be difficult to 
      randomly sample people from the population + then impose treatments on them. 
  * most experiments = recruit volunteer subjects = not random sampling, but yes random assignment = causal conclusions, but only apply
    to the sample and results cannot be generalized. 
  * typical observational study = NO random assignment, but DOES use random sampling = correlation statements but results can be 
    generalized to the population at large.
  * UN-ideal observational study = does not use random assignment OR random sampling + can only be used to make correlational 
    statements that are NOT generalizable
'Using visualisation + transformation to explore data in a systematic way = EDA, an iterative cycle.
  - Generate questions about your data.
  - Search for answers by visualising, transforming, + modeling data.
  - Use what you learn to refine questions and/or generate new questions.

EDA = not a formal process w/ strict set of rules ==> EDA is a state of mind. 

During initial phases of EDA, feel free to investigate every idea that occurs to you ==> Some will pan out, some will be dead ends. 

As exploration continues, you`ll hone in on a few particularly productive areas you'll eventually write up + communicate to others.

EDA = important part of any data analysis, even if questions are handed to you on a platter, b/c you always need to investigate
  quality of data. 

Data cleaning = just 1 application of EDA == ask questions about whether data meets expectations or not. 

To do data cleaning, you'll need to deploy ALL tools of EDA: visualisation, transformation, and modelling.'

library(tidyverse)

'Goal of EDA = to develop an understanding of your data using questions as tools to guide investigations 
  - questions focus attention on a specific part of a dataset + help decide which graphs, models, or transformations to make.

EDA = fundamentally a creative process 
  - like most creative processes, the key to asking quality questions = to generate a large quantity of questions. 
  - difficult to ask revealing questions at start of analyses b/c you do not know what insights are contained in a dataset. 
  - On the other hand, each new question asked exposes you to a new aspect of the data + increase chances of making a discovery. 

Can quickly drill down into the most interesting parts of data + develop a set of thought-provoking questions if you follow up each
  question w/ a new question based on what you find.

No rules about which questions to ask to guide your research ==> but 2 types of questions will always be useful for 
making discoveries w/in data.
  - What type of variation occurs within my variables?
  - What type of covariation occurs between my variables?

variable = a quantity, quality, or property you can measure.

value = the state of a variable when you measure it (may change from measurement to measurement)

observation/data point (DP) = a set of measurements made under similar conditions (usually all measurements in an observation made at 
  same time + on same object). 
    - An observation will contain several values, each associated w/ a different variable.  data point.

Tabular data = a set of values, each associated w/ a variable + an observation. 
  - Tabular = tidy if each value is placed in its own "cell", each variable in its own column, + each observation in its own row.
  - IRL, most data isn't tidy


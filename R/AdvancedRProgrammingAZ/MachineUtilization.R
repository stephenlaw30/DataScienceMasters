setwd("C:/Users/Nimz/Dropbox/NewLearn/UDEMY/R/AdvancedRProgrammingAZ")
machines <- read.csv("Machine-Utilization.csv")

'Need r list w/:

* machine name (CHAR)
* min, mean, ma utilization for month (excluding unknown hours) = VECTOR
* T/F utilization below 90% at any time (LOGICAL)
* all hours w/ unknown utilization (VECTOR)
* for this machine (DATA FRAME)
* for all machines (PLOT)'

str(machines)
head(machines)
tail(machines)
summary(machines)

#have idle, need utilization
machines$utilization <- 1 - machines$Percent.Idle
head(machines,10)

#convert to Portable Operating System Interface (calendar time) = POSIXct
machines$Timestamp <- as.POSIXct(machines$Timestamp, format = '%d/%m/%Y %H:%M')
head(machines,10)

#rearrange cols
#machines <- machines[,c(4,1,2,3)]

#subset for just machine RL1
rl1 <- subset(machines, machines$Machine == "RL1")
str(rl1)
summary(rl1)

#see other machines in summary still, so remove the legacy factors
rl1$Machine <- factor(rl1$Machine) #completely ignore NA's so that's good
summary(rl1)

#construct list
rl1_machineName <- as.character(rl1$Machine[1])
rl1_stats <- c(min(rl1$utilization, na.rm = TRUE), max(rl1$utilization, na.rm = TRUE), 
               mean(rl1$utilization, na.rm = TRUE))
class(rl1_machineName)
class(rl1_stats)

which(rl1$utilization < 0.9)
length(which(rl1$utilization < 0.9))
rl1_util <- length(which(rl1$utilization < 0.9)) > 0
class(rl1_util)

rl1_list <- list(rl1_machineName, rl1_stats, rl1_util)
rl1_list

#name components of list (instead of indices)
names(rl1_list)

#assign names to our list
names(rl1_list) <- c("Machine", "Stats", "Low Threshold")
names(rl1_list)
rl1_list

#another way to rename components of list --> with data frames
rl1_list2 <- list(Machine = rl1_machineName, Stats = rl1_stats, LowThreshold = rl1_util)
rl1_list2

#extracting components
rl1_list[] #whole list

rl1_list[2] #list within list
class(rl1_list[2])

rl1_list[[2]] #all elements withing 2nd list/object in a vector
class(rl1_list[[2]])
typeof(rl1_list[[2]])
typeof(rl1_list$Stats) #same thing


rl1_list$Machine #vector of the elements withing Machine list/object

#access 3rd element of 2nd vector
rl1_list[[2]][3]
rl1_list$Stats[3]

#add list component
rl1_list[4] <- "New Info"
rl1_list #no name

#add hours w/ unknown util via $
is.na(rl1$utilization)
rl1_list$UnknownHours <- rl1[is.na(rl1$utilization),"Timestamp"]
rl1_unknownHours <- rl1[is.na(rl1$utilization),"Timestamp"] #FOR LATER/FINAL LIST
rl1_list #see new 5th object

#what happens when you add a very high number to list
rl1_list[12] <- "New Info2"
rl1_list #adds NULL objects between 4 and 12

#remove component
rl1_list[4:12] <- NULL
rl1_list
rl1_list$UnknownHours <- rl1[is.na(rl1$utilization),"Timestamp"]
rl1_list
#if unknown hours was index 5, it would move up to index 4 if we delete index 4 --> NUMERATION SHIFTS

rl1_list$Data <- rl1
#now list is HUGE
rl1_list$Data
summary(rl1_list)

#subset list
rl1_list[[4]][1]
rl1_list$UnknownHours[1]
rl1_list[1:3]
rl1_list[c(1,4)] #get just machine + unk hrs
rl1_list[c("Machine","Stats")] #get just machine + stats

#double [] are NOT for subsetting
rl1_list[[1:3]] #error --> can only use [[]] to get a single element


#create time-series plot
library(ggplot2)
pl <- ggplot(machines)
pl + geom_line(aes(Timestamp, utilization))
pl + geom_line(aes(Timestamp, utilization, colour = Machine))
pl + geom_line(aes(Timestamp, utilization, colour = Machine), 
               size = 1.2) #still overlapping --> seperate w/ facet grid
pl + geom_line(aes(Timestamp, utilization, colour = Machine), 
               size = 1.2) + 
  facet_grid(Machine~.) #row for each machine

#see break in utilization in SR1 and SR4A

#add horizontal line at 90% util mark b/c this is our lowest acceptable threshold
pl + geom_line(aes(Timestamp, utilization, colour = Machine), 
               size = 1.2) + 
  facet_grid(Machine~.) +
  geom_hline(yintercept = 0.9, colour = "black", size = 1.2, linetype = 3) #dotted line

#see RL1 and SR6 have definitely dropped below min utilization, while each other machine has gotten close

#save plot into object to put into list
rl1_plot <- pl + geom_line(aes(Timestamp, utilization, colour = Machine), 
                           size = 1.2) + 
  facet_grid(Machine~.) +
  geom_hline(yintercept = 0.9, colour = "black", size = 1.2, linetype = 3)

#*********FINAL LIST
names(rl1_list)
final_rl1_list <- list(Machine = rl1_machineName, Stats = rl1_stats, LowThreshold = rl1_util, 
                       UnknownHours = rl1_unknownHours, Data = rl1, Plot = rl1_plot)
final_rl1_list #plot is printed
summary(final_rl1_list) #plots are stored as listsstr(final_rl1_list)
str(final_rl1_list)
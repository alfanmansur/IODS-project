# Alfan Mansur
# 2.12.2021

# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
names(BPRS) # Look at the (column) names of BPRS
str(BPRS)  # Look at the structure of BPRS
summary(BPRS) # print out summaries of the variables
# comment: 40 obs. of 11 variables; all numerical variables, but variables 'treatment' and 'subject' should not be numerical

# read the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
names(RATS)
str(RATS)
summary(RATS)
# Comment: 16 obs. of 13 variables; all numerical variables, but variables 'Group', and 'ID' should not be numerical

# Convert the categorical variables of both data sets to factors

# Factor variables 'treatment' and 'subject' in BPRS data
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
# Factor variables ID and Group in RATS data
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS.
library(dplyr)
library(tidyr)
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject) #long form
# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
# Convert to long form and add a Time variable to RATS
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

# take a serious look at the new data sets and compare them with their wide form versions
# Check the variable names, view the data contents and structures, and create some brief summaries of the variables
names(BPRS)
names(BPRSL)
str(BPRS)
str(BPRSL)
glimpse(BPRS)
glimpse(BPRSL)

names(RATS)
names(RATSL)
str(RATS)
str(RATSL)
glimpse(RATS)
glimpse(RATSL)

print(summary(BPRSL))
print(summary(RATSL))


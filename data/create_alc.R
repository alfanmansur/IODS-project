# Alfan Mansur
# 15.11.2021
# UCI Machine Learning Repository, Student Performance Data (incl. Alcohol consumption), student-mat.csv and student-por.csv
# Data ref: https://archive.ics.uci.edu/ml/machine-learning-databases/00320/

# Read student-mat.csv and student-por.csv
math <- read.csv('./data/student-mat.csv',header = TRUE,sep = ";")
por <- read.csv('./data/student-por.csv',header = TRUE,sep = ";")
# Explore the structure and dimensions of the data
dim(math)    #Find the dimensions (395 obs. of 33 variables)
str(math)         #Find the structure
colnames(math)   #Find the column names
View(math)       #View the data
summary(math)    #View summary of each of 60 variables

dim(por)    #Find the dimensions (649 obs. of 33 variables)
str(por)         #Find the structure
colnames(por)   #Find the column names
View(por)       #View the data
summary(por)    #View summary of each of 60 variables

# Join the two data sets
# without "failures","paid","absences","G1","G2","G3"
math_por=merge(math,por,by=c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","guardian","traveltime","studytime","schoolsup","famsup","activities","nursery","higher","internet","romantic","famrel","freetime","goout","Dalc","Walc","health"))
colnames(math_por) #there are two values for "failures","paid","absences","G1","G2","G3"
str(math_por)      #Find the structure
summary(math_por)  #summary

#Keep only the students present in both data sets
library(dplyr)
# print out the column names of 'math_por'
colnames(math_por)

# create a new data frame with only the joined columns
#alc <- select(math_por, one_of("failures.x","failures.y","paid.x","paid.y","absences.x","absences.y","G1.x","G1.y","G2.x","G2.y","G3.x","G3.y"))
join_by <- colnames(math_por[1:27])
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# Take the average of the answers related to weekday and weekend alcohol consumption
alc_use = (alc$Dalc + alc$Walc) / 2
high_use = alc_use > 2
data_alc <- cbind(alc,alc_use,high_use) #adding "alc_use" & "high_use" into the dataset

# glimpse at the new combined data
glimpse(data_alc)
str(data_alc)
dim(data_alc)

# Save created data to folder 'data' as .csv file
write.csv(data_alc,"C:/Users/Lenovo/Documents/R/IODS-project/data/data_alc.csv", row.names = FALSE)


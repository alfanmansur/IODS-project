# Alfan Mansur
# Firstly created in 25.11.2021
# Continued on 29.11.2021 starting from line 40 for Exercise 5
# The 'human' dataset is about Human Development Index which originates from the United Nations Development Programme.

# Read the “Human development” and “Gender inequality” datas into R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Explore the dataset
dim(hd)    #Find the dimensions (195 obs. of 8 variables)
dim(gii)   #195 obs. of 10 variables
str(hd)         #Find the structure
str(gii)
summary(hd)    #View summary of all variables
summary(gii)  

# Look at the meta files and rename the variables
# The meta files can bee seen here: http://hdr.undp.org/en/content/human-development-index-hdi and http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf
head(hd)
names(hd) <- c('hdirank', 'country', 'hdi', 'birth', 'educ_exp', 'educ_mean', 
                       'gni', 'gni-hdi')
head(hd) # check if OK

head(gii)
names(gii) <- c('giirank', 'country', 'gii', 'mmr', 'abr', 'pr', 
               'edu2F', 'edu2M', 'labF', 'labM')
head(gii) # check

# Mutate the “Gender inequality” data and create two new variables
gii$edu_ratio <- gii$edu2F/gii$edu2M
gii$lab_ratio <- gii$labF/gii$labM

# Join together the two datasets using the variable Country as the identifier
human <- merge(x=hd,y=gii,by="country",all=FALSE) #inner join
dim(human)   #check the dimension: 195 observations and 19 variables

write.csv(human,"C:/Users/Lenovo/Documents/R/IODS-project/data/human.csv", row.names = FALSE)

#29.11.2021: Continued for Exercise 5
# Load the data from my local folder
myData <- read.csv('./data/human.csv')
# Load the data from the provided link
human <- read.table(url("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt"),sep=",",header = TRUE)
# Both data sets are the same except the names of some variables. For the sake of simplicity, I will use the dataset from the provided link.

# Transform 'GNI' to numeric
str(human$GNI)  # look at the structure of GNI variable
human$GNI <- as.numeric(gsub(",", ".", human$GNI))
str(human$GNI)  # look at the structure of GNI variable again, it is now numeric

# Exclude unneeded variables
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))

# Remove all rows with missing values 
human <- filter(human, complete.cases(human))

# Remove the observations which relate to regions instead of countries
tail(human, 10) #look at the last 10 observations
last <- nrow(human) - 7   #last indice we want to keep
human <- human[1:last, ]

rownames(human) <- human$Country #Define the row names of the data by the country names
human <- human[-1]  #remove the country name column from the data
dim(human)          #check the dimension: 155 x 8

# Save the human data in data folder including the row names
write.csv(human,"C:/Users/Lenovo/Documents/R/IODS-project/data/human.csv", row.names = TRUE)


# Alfan Mansur
# 09.11.2021
# Read and analyze the learning2014 data

# Read the full learning2014 data
data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                 header = TRUE, sep = "\t")
# Explore the structure and dimensions of the data
d <- dim(data)    #Find the dimensions (183 obs. of 60 variables)
str(data)         #Find the structure
names <- names(data)   #Find the column names
View(data)       #View the data
summary(data)    #View summary of each of 60 variables

# Comments: This is a 183x60 data consisting of (i) 56 categorical-likert-scale 
# variables (scale 1-5), (ii) 3 numerical variables (age, attitude, points), and 
# (iii) 1 string variable (gender:female or male)

# Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points
#d_sm     Seeking Meaning           ~D03+D11+D19+D27
d_sm = rowMeans(cbind(data$D03, data$D11, data$D19, data$D27))
#d_ri     Relating Ideas            ~D07+D14+D22+D30
d_ri = rowMeans(cbind(data$D07, data$D14, data$D22, data$D30))
#d_ue     Use of Evidence           ~D06+D15+D23+D31
d_ue = rowMeans(cbind(data$D06, data$D15, data$D23, data$D31))
#Deep ~ Deep approach ~ d_sm+d_ri+d_ue; 
deep <- rowMeans(cbind(d_sm, d_ri, d_ue))

#st_os    Organized Studying        ~ST01+ST09+ST17+ST25
st_os = rowMeans(cbind(data$ST01, data$ST09, data$ST17, data$ST25))
#st_tm    Time Management           ~ST04+ST12+ST20+ST28
st_tm = rowMeans(cbind(data$ST04, data$ST12, data$ST20, data$ST28))
#Stra     Strategic approach        ~st_os+st_tm
stra <- rowMeans(cbind(st_os, st_tm))

#su_lp    Lack of Purpose           ~SU02+SU10+SU18+SU26
su_lp = rowMeans(cbind(data$SU02, data$SU10, data$SU18, data$SU26))
#su_um    Unrelated Memorising      ~SU05+SU13+SU21+SU29
su_um = rowMeans(cbind(data$SU05, data$SU13, data$SU21, data$SU29))
#su_sb    Syllabus-boundness        ~SU08+SU16+SU24+SU32
su_sb = rowMeans(cbind(data$SU08, data$SU16, data$SU24, data$SU32))
#Surf     Surface approach          ~su_lp+su_um+su_sb
surf <- rowMeans(cbind(su_lp, su_um, su_sb))

# Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points
mydataset <- data.frame(data$gender, data$Age, data$Attitude, deep, stra, surf, data$Points)
newdata <- mydataset[!(mydataset$data.Points==0),] #Exclude observations where the exam points variable is zero

names(newdata)[1] <- "gender"    #Rename headers 1,2,3,7
names(newdata)[2] <- "age"
names(newdata)[3] <- "attitude"
names(newdata)[7] <- "points"

# Set the working directory of you R session the iods project folder
setwd("C:/Users/Lenovo/Documents/R/IODS-project")
# Save the analysis dataset to the ‘data’ folder
write.csv(newdata,"C:/Users/Lenovo/Documents/R/IODS-project/data/newdata2014.csv", row.names = FALSE)
# read the data again
myData <- read.csv('./data/newdata2014.csv')
str(myData)
head(myData)

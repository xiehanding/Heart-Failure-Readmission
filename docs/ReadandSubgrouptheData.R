rm(list=ls())
getwd()
setwd("C:/Users/Work/Dropbox/WRJ medical school Research projects/MIDAS/DATA")
getwd()

# Tried open file to open the midas.RData.  SUCCESSFUL!!!
# Other methods that I tried but failed.
library(data.table) # not working
mydata<-fread("midas.RData") #not working
###########################
filename="midas.RData"  # not working
require(data.table)  # not working
tyr <- fread(filename, h=F, sep=";", nrows=81, skip=168, verbose=T) # not working
###########################
# Tried to click import dataset on the environment tab, can't stop



###########################
# Check what this data is and making it a correct dataframe
head(midas)
names(midas)
names(midas)[17:25]
midas[1:10,17:25]  #something weird about this midas data
midas[1,]
midas[1,1]
midas[1,1:3]
midas[1:2,1:3]
midas[1:2,1]
dim(midas) # Its dim seems alright, but we need to make a working data frame
as.data.frame(midas[1:1000,])
as.data.frame(midas[1:1000,]) -> md
md[1,]
md[1:2,1]
md
as.data.frame(midas) -> md
is.data.frame(md)
rm(midas) 
md[,1]
###############################

###############################
# We wanna label the primary 
dgns=md[,17:25]
table(dgns[,1])

#table(as.character(md[,17])
    
# testing the code of the data, leading zero.      
table("40100"==dgns[,1])
table("4108"==dgns[,1])
table("41080"==dgns[,1])
table("4100"==dgns[,1])
table("41000"==dgns[,1])
table("411"==dgns[,1])
table("41100"==dgns[,1])
table("4329"==dgns[,1])
nchar(as.character(dgns[,1]))[1:3]

###############################
# check how many different entries exist in dgns[,1]
dgns[,1]
dim(dgns[,1])

################################
# How to find the different level counts
library(data.table)
DT<-data.table(x=sample(1:10,1E7,TRUE))
DT[,.N,by=x]
################################
# Finding how many different levels of diagnosis are there in dtfactor
pridgns = dgns[,1]
library(data.table)
DT1 <- data.table(x = pridgns)
head(DT1)
names(DT1)
DT1
a1 = DT1[,.N,by=x]
a1
a1[1:100,]
a1[101:200,]
rm(a1,DT1)

# So there is 11890 levels of primary diagnosis in pridgns.
###############################
# Now we wanna write a function to add zero to every code so that they have equal length, say five digits so that we can work with them with ease in the future
# See FunctionToAddLeadingZero.R

####################################
dgns=md[,17:25]
pridgns = dgns[,1]


4280  #541481 B
4281  #1485 B
42820 #4185  A
42821 #14759  A
42822 #4676 A
42823 #47301 A
42830 #10277 A
42831 #14566 A
42832 #2523 A
42833 #36651 A
42840 #1151 A
42841 #3338 A
42842 #989 A
42843 #16952 A
4289  #471 B

table(pridgns == "4280" )  #541481
table(pridgns == "42800" ) #42800
table(pridgns == "04280" )#NO
table(pridgns == "428" )  #NO

table(pridgns == "4281" )   #1485
table(pridgns == "42810" )  #435 
table(pridgns == "04281" )  #NO


table(pridgns == "4282" )  #NO
table(pridgns == "42820" ) #4185
table(pridgns == "42821" ) 
table(pridgns == "42822" ) 
table(pridgns == "42823" ) 

table(pridgns == "42830" ) 
table(pridgns == "42831" ) 
table(pridgns == "42832" )
table(pridgns == "42833" ) 

table(pridgns == "42840" ) 
table(pridgns == "42841" ) 
table(pridgns == "42842" ) 
table(pridgns == "42843" ) 

table(pridgns == "4289" )   #471
table(pridgns == "42890" )  #51 
table(pridgns == "04289" )  # NO



##################NOW I just consider this list
# 4280  #541481 B
# 4281  #1485 B
# 42820 #4185  A
# 42821 #14759  A
# 42822 #4676 A
# 42823 #47301 A
# 42830 #10277 A
# 42831 #14566 A
# 42832 #2523 A
# 42833 #36651 A
# 42840 #1151 A
# 42841 #3338 A
# 42842 #989 A
# 42843 #16952 A
# 4289  #471 B


# We need to do some subsetting of the md dataframe first. Otherwise the order function won't work in the md data.frame. Too much memory size
# md1 
# select variables v1, v2, v3
attach(md)
detach(md)
myvars <- c("Patient_ID", "DISCHARGE.DATE", "PATIENT.BIRTH.DATE" ); myvars
md1 <- md[myvars]
head(md1);tail(md1)



# step 0, sort all data by birthdate, remove anyone who is younger than 18 when the study begins which is 2000/1/1, which means remove 
# anyone who was born after 1982/1/1, 1982,1983, etc.
# step 0.1

# md2 is the birthday sorted md1
str(md1$PATIENT.BIRTH.DATE) #Factors
md2 <- md1[order(as.Date(md1$PATIENT.BIRTH.DATE, format = "%m/%d/%Y")),] # you must use "%m/%d/%Y"
tail(md2,1000)



############################################################
library(lubridate)
detach("package:lubridate", unload=TRUE)

attach(md1)
detach(md1)

#############################################################################
# This is Garbage because they don't recognize the correct date format

#md3 is the older than 18 years old of md1 , we keep patients in md2
md3 <- subset(md1, PATIENT.BIRTH.DATE > as.Date("1982-01-01") ) #n of md3 = 160M

#md4 is the younger than 18 years old of md1, we drop patients in md3
md4 <- subset(md1, PATIENT.BIRTH.DATE < as.Date("1982-01-01") ) #n of md4 = 17M
head(md4);tail(md4)
rm(md3,md4)
##############################################################################

# step 0.2  Remove anyone with birthdate later than 1982/1/1

###############################################################################
# Using package lubridate to creat md5, which is same as md1 except the birthdate is transformed to date. format 
head(md1$PATIENT.BIRTH.DATE)
md5 <- md1
require(lubridate)
md5$PATIENT.BIRTH.DATE <- mdy(md1$PATIENT.BIRTH.DATE)
head(md1$PATIENT.BIRTH.DATE) #factor
head(md5$PATIENT.BIRTH.DATE) #date format

# now from md5, we drop the observations that is later than 1982/1/1, this data frame is called md6 
#md5's n = 17855328; md6's n = 17438660
md6 <- md5[md5$PATIENT.BIRTH.DATE < ymd(19820101),]
tail(md5$PATIENT.BIRTH.DATE) 
tail(md6$PATIENT.BIRTH.DATE)

# Now we sort md5 and md6 to check whether md6 is the correct subset

md51 <- md5[order(md5$PATIENT.BIRTH.DATE),]
md61 <- md6[order(md6$PATIENT.BIRTH.DATE),]

head(md1$PATIENT.BIRTH.DATE) 
head(md5$PATIENT.BIRTH.DATE)
tail(md51$PATIENT.BIRTH.DATE,1000) 
tail(md61$PATIENT.BIRTH.DATE,1000)


rm(md5,md51,md6)

# Conclusion: Yes! it worked!!!!  so md61 (n = 17438660) is the sub-data base that we're going to continue.
# We need to identify using the patient ID in md61 to match the patient ID in md, keep observations in md that agrees with the md6
# Check ManyNotes.R to find the Javier's suggestion

# str2 is the charactor of patient_ID
str2 

###########################################################################
#  read in the targetlist of the one that I wanna choose: tarlist and then transform it into vector tarstr
getwd()
tarlist =read.table("TargetList.txt", header = FALSE)
tarlist 
tarstr <- tarlist[,1]; tarstr; rm(tarlist)
##########################################################
#######This part is about matching
#101416 DO some matching to subset the data

tarstr
j <-!is.na(match(md,tarstr))
match(md,tarstr) [1:10]
table(is.na(match(md,tarstr) ))



#################Cabrera's suggestion
i <- md1$PATIENT.BIRTH.DATE > as.Date("1982-01-01")
i[is.na(i)] = F
i
md5 <- md1[i,]
table(i) # see that? my i is wrong


mdpaid <- as.vector(md$Patient_ID); str(mdpaid); dim(mdpaid) 
mdpaiduni <- unique(mdpaid); dim(mdpaiduni) #n = 4623503


###########################GARBAGE###############################################
# My matching strategy: facpid18 is the factor of patient id that we need to use to include from mdpa
names(md61)
fctpid18 <- md61$Patient_ID  #4623503 levels, so averagely, one patient have 3.77 admission records
str1 <- as.vector(fctpid18); head(str1)
str1uni <- unique(str1); head(str1uni,100) #chr n = 4359457
rm(str1)
# Use str1uni to identify the md, keep only the patient_ID that's included in str1uni
###################################################################################

#From 
head(md61)









md$DISCHARGE.DATE
md1 <- md[order(as.Date(md$DISCHARGE.DATE, format = "%m%d%Y")),]
head(md1$DISCHARGE.DATE);tail(md1$DISCHARGE.DATE)



      
      
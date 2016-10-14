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
))

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
DT1 <- data.table(x = pridgns)
head(DT1)
names(DT1)
DT1
a1 = DT1[,.N,by=x]
a1
a1[1:100,]
a1[101:200,]

# So there is 11890 levels of primary diagnosis in pridgns.
###############################
# Now we wanna write a function to add zero to every code so that they have equal length, say five digits so that we can work with them with ease in the future
# See FunctionToAddLeadingZero.R








      
      
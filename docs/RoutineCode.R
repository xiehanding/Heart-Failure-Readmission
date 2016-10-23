getwd()
setwd("C:/Users/Work/Dropbox/WRJ medical school Research projects/MIDAS/DATA")
getwd()
memory.limit()
memory.size(200000)
memory.limit()
library(bigmemory.sri)
library(bigmemory)

#Read in midas here

# correct the original data frame
md <- as.data.frame(midas) 
rm(midas) 


# Inport tarstr, which are the diagnosis list that we need to match in data and delete the patiens
getwd()
tarlist =read.table("TargetList.txt", header = FALSE)
tarstr <- tarlist[,1]; tarstr; rm(tarlist)

# md1 is the patient birthday sorted observation list that is older than 18 years old on the year of 2000

library(lubridate)
require(lubridate)
md1 <- md
md$PATIENT.BIRTH.DATE <- mdy(md$PATIENT.BIRTH.DATE)
md1 <- md[md$PATIENT.BIRTH.DATE < ymd(19820101),]
md11 <- md1[order(md1$PATIENT.BIRTH.DATE),]


md2 <- md11
md2$DISCHARGE.DATE <- mdy(md2$DISCHARGE.DATE);str(md2$DISCHARGE.DATE)
md3 <- md2[order(md2$DISCHARGE.DATE),]   # SO the discharge date is from 1985-2014
hist(md3$DISCHARGE.DATE,20, freq= TRUE, main="Density Plot of Discharge date, n = 17438660", ylab ="Frequency")
attach(md3)
md4 <- subset(md3,DISCHARGE.DATE < ymd(20000101) & DISCHARGE.DATE >= ymd(19950101))
detach(md3)

rm(list=setdiff(ls(), c("tarstr","md4","md")))







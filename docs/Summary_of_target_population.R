names(md5)
table(md5$SEX)
# there is an U sex in the md5 ,remove it.
summary(md5)

# Some variables that we care are: patient ID; admissiondate, discharge date, birthdate, 
# Summary: Sex, Race, Age when first had heart failure, diagnosis, hispanic, prime insurance provider


md6<- subset(md5, !(SEX %in% "U"))
mdtest <- md6[1:10000,]

table(md6$SEX)
table(md6$RACE)
plot(md6$RACE, main="Race Frequency in our target population")
table(md6$PRIME)
plot(md6$PRIME, main="Primary insurance in our target population")
?plot
library(ggplot2)
?qplot
str(md6)

names(md6)

qplot(SEX, data = md6, main="Sex Distribution in target population")
qplot(RACE, data = md6, main= "Race Frequency in target population")
qplot(PRIME, data = md6, main= "Primary Insurance in target population")
#hispanic
qplot(HISPAN, data = md6, main ="Hispanic Distribution in target population")
# Primary diagnosis
md6[,17]


# find the age that people first get admitted to HF-related desease
# step1: find the population that have HF-related diagnosis in the list and and find the discharge date minus the birthdate
getwd()
tarlist =read.table("TargetList.txt", header = FALSE)
tarstr <- tarlist[,1]; tarstr; rm(tarlist)
# subsetting md6 to get a md7 that has all the observations that include any of the HF primary diagnosis
# md6 is all the observations that excluded any observation that has any of HF in any diagnosis from 1995.1.1-1999.12.31
head(md6, 5)
qplot(DISCHARGE.DATE, data = md6, main ="Discharge date Distribution in target population md6")
names(md6)

# mxj[,i] <- !is.na(match(diagmtrx[,i],tarstr))
head(md6[,17])
a <- !is.na(match(md6[,17],tarstr)) 
dim(a)
table(a)

# Now we have a, a logical vector with 418177 true and 15195725 false, we want to get the age that people first get admitted to HF-related desease
# So 418177 observations exist with HF first diagnosis. we wanna know how many patients are there?

#################Earlier example code######################
# pidmd4 <- as.character(md4$Patient_ID) #character n=2704654
# mdsub <- cbind(pidmd4,vm1);mdsub;
# # dfmdsub <- as.data.frame(mdsub)
# dfmdsubt <- dfmdsub[which(dfmdsub$vm1=='TRUE'), ] # dfmdsubt's dim is 511363*2
# lspiduni <- unique(dfmdsubt$pidmd4) # n = 246163; 
# lspidunic <- as.character(lspiduni) # n = 246163;
##########################################################


# from md6, get md61 that only has the observations that has HF in first diagnosis
names(md6)
md61 <- subset(md6, (md6[,17] %in% tarstr))
dim(md6) # 15613902       48
dim(md61) #  418177     48
  
pidmd61 <-as.character(md61$Patient_ID)
pidmd61u <- unique(pidmd61) # 225099 unique patient ID in the md61

head(md61$DISCHARGE.DATE,1000)
tail(md61$DISCHARGE.DATE,1000)

head(md6$DISCHARGE.DATE,1000)
tail(md6$DISCHARGE.DATE,1000)

#You can see that in md61, the discharge dates are from 1994-1-1 to 2014-12-31, instead, in md5, the discharge dates are from 1977-2-26 to 2015-2-6

# from md61, we order the patient ID to obtain md62

md62 <- md61[order(md61$Patient_ID),] # 418177 *2 
dim(md62)
md62[,5] <-as.character(md62[,5])
md62[10000:20000,5]

# Make md63 which is sorted by both patient id and discharge date
md63<- md62[order(md62$DISCHARGE.DATE),]
md63$DISCHARGE.DATE
head(md63)
tail(md63$DISCHARGE.DATE)

# make md64 that is sorted by both patient id and discharge date sorted and the discharge date is between 2000-1-1 to 2013-12-31
head(md6$Patient_ID,1000)
head(md6$PATIENT.BIRTH.DATE,1000)

str(md61)
md61$Patient_ID

unique(md61$Patient_ID)

# eg: md4 <- subset(md3,DISCHARGE.DATE < ymd(20000101) & DISCHARGE.DATE >= ymd(19950101))
attach(md61)
md62<- subset(md61,DISCHARGE.DATE < ymd(20140101) & DISCHARGE.DATE >= ymd(20000101))

md63 <- md62[match(unique(md62$Patient_ID), md62$Patient_ID),]; 



head(md62$Patient_ID,100)
head(md63$Patient_ID,100)


age <- (md63$DISCHARGE.DATE - md63$PATIENT.BIRTH.DATE)/365
aveage <- mean(age);aveage 
#####CONCLUSION#######################Time difference of 75.43181 years

# long <- c((10:16), rep(3,20),(1:6))
# match(3, long)
# long

#md62 is the dataframe that we are going to fit survival model

########plotting of md

qplot(SEX, data = md62, main="Sex Distribution in target population")
qplot(RACE, data = md62, main= "Race Frequency in target population")
qplot(PRIME, data = md62, main= "Primary Insurance in target population")
qplot(HISPAN, data = md62, main ="Hispanic Distribution in target population")
# The average first time HF diagnosis is 75.43181


#######################SAMPLE CODE FOR FITTING SURVIVAL MODEL)
library(survival).
z.cox = coxph( Surv(y,dead)~.,data=z)
z.cox = coxph( Surv(y,dead)~.,data=z[,c(1:4,18,24,26)])
plot(cox.zph(z.cox))
print.zph(z.cox)

z.sur = survfit( Surv(y,dead)~group,data=z)
plot(survfit(z.cox))
########################

z.cox <- coxph(Surv(y, readmission)~., data = md62)


###################Tongue example for surv model
data(tongue)
attach(tongue)
tongue
my.surv.object <- Surv(time[type==1], delta[type==1])
my.surv.object
detach(tongue)


names(md62)
head(md62$DeathRNUM)
names(md62)
md62[3,]

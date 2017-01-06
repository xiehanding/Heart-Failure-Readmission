# Making Survival Objects
# Time to Readmission
# My population is all patients in md62, who had one of the HF in the primary diagnosis from 2000.1.1 -2013.12.31


# event= T/F; d2e = ;  age = first time being admitted to HF, DISCHARGE.DATE- BIRTHDAY; sex = 

# let's call the data table dt1, dt1 should have nrows = 200423  because each patient should have a event logical value T/F
# If he only has one record, then we consider him not readmitted and his days should be (20131231-19950101)+2days, If he's readmitted, then the d2e is admitted date2- admitted date1;

# We wanna create the response variable # survoj <- Surv(time1, time2, event)

head(md63)
###ALL causes Readmission or death
# 2 cases are possible: 1st: have been readmitted 2nd: have not been readmitted
# For HF readmission. time1 is the first admission date, time2 is second admission date, event is readmitted then 1, not then 0
# For DEATH,  time1 is first admission date, time2 is the death date, event is dead =1, not dead =zero

# d1 <- data.table(event, days2event, age, sex)
# event: a logical vector length(md63s)= 200423, if only one admission then F/0, if more than one admission then T/1
# d2e = 
# age = first time being admitted to HF, DISCHARGE.DATE- BIRTHDAY
# sex = md63s$SEX


library(survival)
library(data.table)
library(lubridate)
library(ggplot2)
require(data.table)
require(survival)
require(lubridate)
require(ggplot2)


# We need to sort md62 and md63 on patient ID
md62s <- md62[order(md62$Patient_ID),]
md63s <- md63[order(md63$Patient_ID),]

md62s$Patient_ID <- as.character(md62s$Patient_ID)
head(md62s$Patient_ID,20)


# md7 is patiend_id and admission date ordered, md7u is the unique patien_id dataset
md7 <- md62s[order(md62s[,5],md62s[,6]),]
table(md7$Patient_ID) 
md7u <- md7[match(unique(md7$Patient_ID), md7$Patient_ID),]
md7[1:30,c(5,6)]
md7u[1:30,c(5,6)]


rm(md6,md61,md62,md62s,md63,md63s)




# Preparing the components in the data table for survfit
attach(md7u)

md7u$SEX <- factor(md7u$SEX)
sex <- md7u$SEX
table(sex)
age <- round(((ADMISSION.DATE- PATIENT.BIRTH.DATE)/365.25),0)
detach(md7u)

##########Making vector - event.check "Finding the unique patient ID.R"###################### 
# Event = if a patient ID is used once, it gives FALSE, if not gives TRUE
event <- vector(mode = "logical", length = 200423)
event

# I want to find the Patient_ID that only occured once in md7[,5], and use this list to match md7u[,5]
# If it only occured once, then return a 0, if not return a 1
md7pid <- md7[,5]

# Define idxupid, a link vector that can help us make the event vector
idxupid <- order(md7pid)[!duplicated(sort(md7pid))] 


for (i in 1:length(event)){
  if (idxupid[i+1] -idxupid[i] != 1){
    event[i] <- TRUE
  }
}
# Modify the last one because the small error in the function loop above
event[length(event)] <- TRUE

#checking procedure
head(md7[,5],25)
head(md7u[,5],25)
head(idxupid,25)
head(event,25) # Event = TRUE indicates this has multiple admission
tail(md7[,5],25)
tail(md7u[,5],25)
tail(idxupid,25)
tail(event,25)
########################End of making vector - event 

###############Making of vector - d2event ####################
d2event <- vector(mode = "numeric", length = 200423)

# We define the maximal days is 20131231-20000101 +20 days
maxday <- as.numeric(ymd(20131231)-ymd(20000101)) +20  # 5133
# If a patient is not readmitted, his d2event is set to 5133
d2event[!event] <- 5133
# check the last one patient's condition,it's correct.
tail(md7[,5],25)
tail(md7u[,5],25)
tail(d2event,25)

# On the other hand, If a patient is readmitted, his d2event is set to 
# the date of second admission - the date of first admission.
# for every true element in the event vector, we have it's position and use the position+1's admission date
# minus that position's admission date

head(d2event,25)
table(event)
# FALSE   TRUE 
# 126285  74138
d2event[event]
head(md7$ADMISSION.DATE,25)

# Sub-Objective: make a vector pos1 indicate the position in md7 of the readmissioned patient's first admission. 
# pos1's length should be 74138
# Then pos1 is actually idxupid[event]
pos1 <- idxupid[event]
pos2 <- pos1+1
head(pos1,250)
tail(pos1,250)
head(pos2,250)
tail(pos2,250)

d2event[event] <- md7[pos2,]$ADMISSION.DATE - md7[pos1,]$ADMISSION.DATE
d2event


Surv(d2event,event)
plot(Surv(d2event,event))
library(data.table)
dt1 <- data.table(event,d2event,age,sex)
m1 <- coxph(Surv(d2event, event) ~ age + sex, data = dt1)
m1

summary(m1)
# Plot survival curves
survfit(m1)
plot(survfit(m1), mark.time = TRUE)
# Test the proportional hazards assumption for a Cox regression model fit (coxph).
plot(cox.zph(m1))
print(cox.zph(m1))
summary(dt1)




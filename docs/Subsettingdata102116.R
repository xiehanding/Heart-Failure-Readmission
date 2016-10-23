# Subsettingdata
# now you have the md11 dataset, which include all data that's older than 1982/1/1

# First we wanna creat temporary sub-dataset mdsub that only include the rows which discharge date is between 1995/1/1 to 1999/12/31
library(lubridate)
require(lubridate)
names(md11)
head(md11$DISCHARGE.DATE)

md2 <- md11
md2$DISCHARGE.DATE <- mdy(md2$DISCHARGE.DATE);str(md2$DISCHARGE.DATE)


md3 <- md2[order(md2$DISCHARGE.DATE),]   # SO the discharge date is from 1985-2014
head(md3$DISCHARGE.DATE,100)
tail(md3$DISCHARGE.DATE,100)
names(md3)

# Let us check the year distribution of the discharge date,if too much between 1985-1995, worried! if not just delete them. 
# So I graphed the histograph of discharge date by year. And decided to use 1995/1/1 and 2000/1/1 as the cutoff to build the mdsub.
# I followed the advise of Dr. Kostis 
a <- md3[,7]
ay <- year(a); ay
aytest <- head(ay,1000); aytest

hist(md3$DISCHARGE.DATE,20, freq= TRUE, main="Density Plot of Discharge date, n = 17438660", ylab ="Frequency")
histinfo <- hist(md3$DISCHARGE.DATE,20, freq= TRUE, main="Density Plot of Discharge date, n = 17438660", ylab ="Frequency") ;histinfo

# Now subset md3 (n = 17438660)to obtain md4 (n = 2704654), whose discharge date is from 1995-1-1 to 2014-12-31
attach(md3)
md4 <- subset(md3,DISCHARGE.DATE < ymd(20000101) & DISCHARGE.DATE >= ymd(19950101))
detach(md3)
head(md4)
tail(md4)

rm(md11,md2,md3,a,ay,aytest,histinfo)
##############################################
# Find the patient ID whose DX1 IS HF in md4[,17]
# ji is a logical vector that is n =2704654 within which 162819 is true and 2541835 is false
head(md4)
diagmtrx <- md4[,17:25]
diagmtrx <- as.matrix(diagmtrx); diagmtrx
dim(diagmtrx); head(diagmtrx)



# Correct method to match, x needs to be a vector.
match(diagmtrx[,1],tarstr)
j1 <-!is.na(match(diagmtrx[,1],tarstr))
j1
table(j1)  
# FALSE    TRUE 
# 2541835  162819
2541835+ 162819 =2704654


# Create a empty matrix named mxj that dim(2704654,9)
# loop to compute 9 logical vectors j1 - j9

mxj <- matrix(NA, nrow = 2704654, ncol = 9); mxj
for (i in 1:9){
  mxj[,i] <- !is.na(match(diagmtrx[,i],tarstr))
}
dim(mxj)
mxj
# now mxj is a matrix that we can use to 
# for each row, if any column is true, we return true
# for each row, if all columns are false, we return false
# using apply function here
# vm1 is the logical vector that we use to match, if it's true, we extract the patient_ID associated with this admission record
vm1 <- apply(mxj, 1, any)
table(vm1) 
# FALSE    TRUE 
# 2193291  511363 


######################################Need to add patient id in matrix of mxj, which is named mxjp
pidmd4 <- as.character(md4$Patient_ID) #character n=2704654

mdsub <- cbind(pidmd4,vm1)
mdsub; dim(mdsub)

#check the correctness of mdsub
head(mdsub)
head(md4)




##########draft 1#######
# for (i in 1 to 2704654){
#  for (j in 1:9){
#     if mxj[,j] has one or more TRUE
#        return TRUE
#  }
#  jall9[i,] = 
# }


# myfunction <- function(arg1, arg2, ... ){
#   statements
#   return(object)
# }


head(diagmtrx)
head(diagmtrx[,1])

################################################################
# Don't match against a large data frame
## Don't run like this!! it will die!
j2 <-!is.na(match(md4[,17:25],tarstr))
table(j2)
#################################################################
# Wrong method to do match against a matrix. match transform the matrix to a long vector. 
match(diagmtrx,tarstr) 
j0 <- !is.na(match(diagmtrx,tarstr))
j0
table(j0)
# FALSE     TRUE 
# 23830426   511460 
23830426+511460 =24341886
#################################################################


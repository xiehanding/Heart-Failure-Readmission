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


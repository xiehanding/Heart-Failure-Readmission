# vm1 is the logical vector that we use to match, if it's true, we extract the patient_ID associated with this admission record
# when we have the unique list for patient ID, we delete these patients' admissions records from md3
# md3 is the <18 years old all admissions record, sorted by birthdate and discharge date 
# the cleaned md3 is the sub group of admissions record that we're going to use in the analysis.

####################################IMPORTANT POINT########################
# wait, I got the vm1 from md4, which is a subset of md3, the observation number in md4 may not be same with md3
#####################################Need to add patient id in matrix of mxj, which is named mxjp
pidmd4 <- as.character(md4$Patient_ID) #character n=2704654

mdsub <- cbind(pidmd4,vm1)
mdsub; dim(mdsub)

#check the correctness of mdsub
head(mdsub)
head(md4)

# so we need to identify all the pidmd4 that is associated with true vm1 within mdsub
dim(mdsub) #2704654*2
str(mdsub[,1])
str(mdsub[,2])

# we build a data frame for mdsub

dfmdsub <- as.data.frame(mdsub)
# based on variable values
dfmdsubt <- dfmdsub[which(dfmdsub$vm1=='TRUE'), ] # dfmdsubt's dim is 511363*2

dim(dfmdsub)
dim(dfmdsubt)

# find the unique patient id character named "lspidunic" we will use to subset md3
head(dfmdsubt)
lspiduni <- unique(dfmdsubt$pidmd4) # n = 246163; 
lspidunic <- as.character(lspiduni) # n = 246163;

str(lspidunic)
str(md3$Patient_ID)

###############GARBAGE##############
# Don't do this again, because this time we want to subsetting the md3, 
# so we are dropping observations in md3 that has the patient id in lspidunic
# But how do we know the dim of new data frame? 
# pidmd3 <- as.character(md3$Patient_ID)
# rm(pidmd3)


###############here md5 maybe is the observations that we wanna remove
md5 <- md3
md5 <- md3[which(md3$Patient_ID %in% lspidunic), ] # n = 1824747, which i think is wrong, cause lspidunic's n is 246163, and averagely 3.77 admission per patient_ID

md6 <- md3
md6 <- md3[which(md3$Patient_ID %in% lspidunic), ]


                  











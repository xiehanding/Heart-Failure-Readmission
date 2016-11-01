# Now we have a dataframe md3 which is birthday ordered, discharge date ordered all observation.
# dim(md3) 17438660       48
# We have a unique character list lspidunic length # 246163, 15mb, we want susetting a md5 that don't have the patient ID that is in the list
# According to my manual sampling, about 10% of the whole in md3 is in lspidunic, so we need to get rid off about 10% of the data after matching

dim(md3)
md3test <-md3[20000:30000,]
dim(testdf)
# Two method to do the subseting!
md5test <- md3test[which(md3test$Patient_ID %in% lspidunic), ] 
md5test2 <- subset(md3test, Patient_ID %in% lspidunic)
# this is the way to make it negative
md5test3 <- subset(md3test, !(Patient_ID %in% lspidunic))


# now run the real data!
md5<- subset(md3, !(Patient_ID %in% lspidunic))
dim(md5) #15613903       48

# After I check the result, I believe that is correct, below is the checking process
hist(md5$DISCHARGE.DATE,20, freq= TRUE)
table(md5[,17])
table(md3[,17])


names(md5)
table(md5$SEX)
# there is an U sex in the md5 ,remove it.
summary(md5)







names(md5)
table(md5$SEX)
# there is an U sex in the md5 ,remove it.
summary(md5)

# Some variables that we care are: patient ID; admissiondate, discharge date, birthdate, 
# Summary: Sex, Race, Age when first had heart failure, diagnosis, hispanic, prime insurance provider

mdtest <- md5[10000,]

as.character(md5$SEX)
md6<- subset(md5, !(SEX %in% U))

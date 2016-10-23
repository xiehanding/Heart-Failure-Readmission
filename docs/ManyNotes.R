# Many notes

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
pridig=md[,17:25]


table(md[,17])
table(as.character(md[,17])
      
############################
nchar(pridig[,1])[1:3]
nchar(as.character(pridig[,1])[1:3]
))
nchar(as.character(pridig[,1]))[1:3]
5-nchar(as.character(pridig[,1]))[1:3]
paste(rep("0",))
j =5-nchar(as.character(pridig[,1]))[1:3]
paste(rep("0",j))
j
paste(rep("0",j[1:2]))
paste(rep("0",j[1]))
ff= function(x) paste(rep("0",x),sep="")
ff(3)
ff= function(x) paste(rep("0",x),collapse ="")
ff(3)
st1 = as.character(pridig[,1])
sapply(st1,ff)[1:20]
ff= function(x) if(x>0) paste(rep("0",x),collapse ="") else ""
sapply(st1,ff)[1:20]
st1
gg = function(x) { k = 5-nchar(x); paste(ff(k,x),sep="")}
gg(st1[1])
st1[1]
gg = function(x) { k = 5-nchar(x); paste(ff(k),x,sep="")}
gg(st1[1])
st2 = sapply(st1,gg)

##########################################################
#######This part is about matching
#101416 DO some matching to subset the data
str1 = c("42841","42842","42843","4289")
jj <-!is.na(match(pridgns5d,str1))
match(pridgns5d,str1) [1:10]
table(is.na(match(pridgns5d,str1) ))



#################Cabrera's suggestion
i <- md1$PATIENT.BIRTH.DATE > as.Date("1982-01-01")
i[is.na(i)] = F
i
md5 <- md1[i,]
table(i) # see that? my i is wrong

# How to detach package from R
detach("package:ff", unload=TRUE)


# remove object from globle environment except a few
rm(list=setdiff(ls(), "md"))


# How to compare to vector
a= as.numeric(tail(j0,1000))
b= as.numeric(tail(j1,1000))
a-b













      
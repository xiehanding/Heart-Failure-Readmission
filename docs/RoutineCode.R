getwd()
setwd("C:/Users/Work/Dropbox/WRJ medical school Research projects/MIDAS/DATA")
getwd()
# Read in the data
as.data.frame(midas)
md <- as.data.frame(midas) 
rm(midas) 
md[,1]
#######################
dgns=md[,17:25]
pridgns = dgns[,1]
tarlist =read.table("TargetList", header = FALSE)

4280  #541481 A
4281  #1485 A
42820 #4185  A
42821 #14759  A
42822 #4676 A
42823 #47301 A
42830 #10277 A
42831 #14566 A
42832 #2523 A
42833 #36651 A
42840 #1151 A
42841 #3338 A
42842 #989 A
42843 #16952 A
4289  #471 A

table(pridgns == "4280" )  #541481
table(pridgns == "42800" ) #42800
table(pridgns == "04280" )#NO
table(pridgns == "428" )  #NO

table(pridgns == "4281" )   #1485
table(pridgns == "42810" )  #435 
table(pridgns == "04281" )  #NO


table(pridgns == "4282" )  #NO
table(pridgns == "42820" ) #4185
table(pridgns == "42821" ) 
table(pridgns == "42822" ) 
table(pridgns == "42823" ) 

table(pridgns == "42830" ) 
table(pridgns == "42831" ) 
table(pridgns == "42832" )
table(pridgns == "42833" ) 

table(pridgns == "42840" ) 
table(pridgns == "42841" ) 
table(pridgns == "42842" ) 
table(pridgns == "42843" ) 

table(pridgns == "4289" )   #471
table(pridgns == "42890" )  #51 
table(pridgns == "04289" )  # NO

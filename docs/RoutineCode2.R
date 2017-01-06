getwd()
setwd("C:/Users/Work/Dropbox/WRJ medical school Research projects/MIDAS/DATA")
getwd()
load("md7.RData")  
load("md7u.RData")
tarlist =read.table("TargetList.txt", header = FALSE)
tarstr <- tarlist[,1]; tarstr; rm(tarlist)
ls()


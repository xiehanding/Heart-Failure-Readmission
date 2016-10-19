###############################
# Now we wanna write a function to add zero to every code so that they have equal length, say five digits
# nchar function needs a character variable

is.character(pridgns)
st1 <- as.character(pridgns)
is.character(pridgns)
table(pridgns)
table(st1)
dim(pridgns); dim(st1)
nchar(st1)[1:3]
##################################
#Some tries 
j= 5-nchar(st1)[1:3]; j;
paste(rep("0",5))
paste(rep("0",j[1:2]))
paste(rep("0",j[1]))
rm(j)
##################################
f1= function(x){
  paste(rep("0",x),sep="")
}
f1(3)
rm(f1)
##################################
# f2 is the function we need to calculate how many zero to add to st1
f2= function(x){
  if(x>0) paste(rep("0",x),collapse ="") 
  else ""
}
f2(3)
###################################
#This line is not working, coding format is wrong
sapply(st1[1:20],f2(3))

sapply(st1,f2)[1:20]
st1
########################################################
gg = function(x) { k = 5-nchar(x); paste(ff(k,x),sep="")}
gg(st1[1])
st1[1]
gg = function(x) { k = 5-nchar(x); paste(ff(k),x,sep="")}
gg(st1[1])
st2 = sapply(st1,gg)
#########################################################
# f3 is the function that we need to add several zero to st1
f3 <- function(x){
  k <- 5 - nchar(x)
  paste(f2(k),x,sep = "")
}
st1[1]
f3(st1[1])

##################################################
# Now we need to apply this f3 to every item in st1
# Let's test on the first 20 rows at first
sapply(st1,f3)[1:20]
# 5920    5920   53541    4239   29623    2113    7804    7804    7211   53081   38630    8472     311   78791   41110   41110 
# "05920" "05920" "53541" "04239" "29623" "02113" "07804" "07804" "07211" "53081" "38630" "08472" "00311" "78791" "41110" "41110" 
# 41110   40391   41091   36613 
# "41110" "40391" "41091" "36613" 
# We can see the results are correct!
# Now let's apply the f3 to st1 to obtain st2
st2<- sapply(st1,f3)
head(st2)
is.character(st1)
is.character(st2)
class(pridgns)
pridgns5d <- as.character(st2)
pridgns5d
table(pridgns5d)

#################################################
# This pridgns5d is the character variable that we need. 



#################################################
# Notice that here pridgns5d's level is different from pridgns and that pridgn5d have duplication at each level
# the problem is at the function of f3, you can see that st2's attribute is different from st1
head(st1)
head(st2)
dim(st1)
dim(st2)

####################################################
pridgns5d[1:100]
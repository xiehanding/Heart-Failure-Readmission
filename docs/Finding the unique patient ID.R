

# please GOOGLE get the index of unique value in r
# http://r.789695.n4.nabble.com/return-first-index-for-each-unique-value-in-a-vector-td4641640.html

# Define idxupid, a link vector that can help us make the event vector
idxupid <- order(md7pid)[!duplicated(sort(md7pid))] 
# My checking process
head(duplicated(sort(md7pid)),25)
head(!duplicated(sort(md7pid)),25)
head(md7pid[!duplicated(sort(md7pid))],25)
order(md7pid)
# End of my checking process
head(idxupid,25)
tail(idxupid,25)
# CONCLUSION: No this gives you the position of every pid's first apperance

# I want to check if every

head(event,25)

# For  position k th element in event vector, if the k+1 th element - k th element in idxupid vector is not 1, 
# then this k th element in event vector is not unique we give it the score of 1 or TRUE;
# else, if the k+1 th element - k th element in idxupid vector is 1, it means this kth element in event is unique
# and we give it the score of FALSE or zero


length(event)
for (i in 1:length(event)){
  if (idxupid[i+1] -idxupid[i] != 1){
    event[i] <- TRUE
  }
}
# Modify the last one because the small error in the function loop above
event[length(event)] <- TRUE

head(md7[,5],25)
head(md7u[,5],25)
head(event,25)

tail(md7[,5],25)
tail(md7u[,5],25)
tail(event,25)


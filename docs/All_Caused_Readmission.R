head(md7[,5:6],25)
head(md7u[,5:6],25)


# Make three vectors, length = 200423
# date1 <- first date of patient admission.  DONE
# date2 <- second date for patient admission. 
# dated <- the date of patient death

# ending date cutoff date is 20131231
#date1
date1 <- md7u[,6] # large date vector 
#done

#date2
# date2 <- 20131231 if just one record
# date2 <- the second date if more than one record

md7pid <- md7[,5]
idxupid <- order(md7pid)[!duplicated(sort(md7pid))] ; 
head(idxupid,25) # idxupid gives the index of the first admission obs 
                 #  for each unique patient in md7.

date2 <- vector(mode = "numeric", length = 200423)
for (i in 1:length(date2)){
  if (idxupid[i+1] -idxupid[i] != 1){
    event[i] <- TRUE
  }
}





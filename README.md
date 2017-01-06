# Heart-Failure-Readmission

# First we wanna delete all the patients that had HF before 1995


# We want to build a record for every patient, including all of his admissions data.
# If we identify any HF in the primary diagnosis of a patient that include Heart faliure
# Now how do you define heart failure?
# John Kostis will send me the file that has the codes for HF


# in the midas dataset, everything is 5 digits. 
# We go with the leading zero strategy
# If your diagnosis is Postmyocardial infarction syndrome, your translation is 4110, but your midas code would be 04110. 
# If your diagnosis is Tuberculosis of kidney, unspecified, your translation is 01600, but your midas code would be 1600.

# So our purpose is to add zero to any midas code to make every code is 5 digits, for example, 1600 should becomes 01600,





# See midas 1625,which represent 1625 in excel, it has 11486 counts; see midas 16250, which actually represent 01625, it has 65 counts. 
# See midas 1649, which represent 1649 in excel, it has 198 counts; see midas 16490, which actually represent V1649, it has 1 counts.

########################################################
# The HF codes that I identified from the excel are (25 levels in total):
# 39891
# 40201
# 40211
# 40291
# 40401
# 40403
# 40411
# 40413
# 40491
# 40493
# 4280
# 4281
# 42820 $
# 42821 $
# 42822
# 42823
# 42830
# 42831
# 42832
# 42833
# 42840
# 42841
# 42842
# 42843
# 4289
##########################################################
Nora said just use the ones initialed with 428
check here : http://www.icd9data.com/2015/Volume1/390-459/420-429/428/default.htm

4280
4281
42820
42821
42822
42823
42830
42831
42832
42833
42840
42841
42842
42843
4289
##############################################################
Ana Ruigómez, Alexander Michel, Mar Martín-Pérez and Luis A. García Rodríguez
International Journal of Cardiology, 2016-10-01, Volume 220, Pages 855-861, 
Age at first HF diagnosis, mean (SD)	74.7 (10.2)	75.3 (9.7)
So we don't worry about the HF rate or readmission rate on or before 30 years old.
So we use the 1982/1/1 as the first cut off to make sure that, no person younger than 18 years old will be included in the study.

#Please never remove md, it takes 10 mins to read in it.

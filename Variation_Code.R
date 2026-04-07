######## ======================================================================
######## Drought Secnarios.
######## 
######## Motasem S Abualqumboz and Braden Chamberlain, Utah State University 
######## ======================================================================


####### Install and load R packages============================================
#install.packages("openxlsx")   # This may not be needed if already installed.

require(rstudioapi)
library(openxlsx)
require(dplyr)

# Make sure that the following files are placed in main directory of your project
# "C:/Users/m_abu/Desktop/PhD/1_Courses/2_Spring2022
# /RiverBasinManagement/Project2022"

#1. CRSS_DIR (The folder that have the model inside) 
#2. This R file
#3. Monthly_Flows_DroughtScenario_2000-2018
#4. Run this code 

# Set working directory to source file location
setwd(dirname(getActiveDocumentContext()$path))       
path = getwd()
path   

# First Section
#######################
# The ISM1988 natural inflow (Not shown in the manuscript)

# Get the ISM1988 natural inflow from the stress test DMI

# READ IN ALL THE SITE INFLOW INFORMATION
InflowSites <- c("GlenwoodSpringsNF.Inflow",
                 "CameoNF.Inflow",
                 "TaylorParkNF.Inflow",
                 "BlueMesaNF.Inflow",
                 "CrystalNF.Inflow",
                 "GrandJunctionNF.Inflow",
                 "CiscoDoloresNF.Inflow",
                 "CiscoColoradoNF.Inflow",
                 "FontenelleNF.Inflow",
                 "GreenRiverWYNF.Inflow",
                 "GreendaleNF.Inflow",
                 "MaybellNF.Inflow",
                 "LilyNF.Inflow",
                 "RandlettNF.Inflow",
                 "WatsonNF.Inflow",
                 "GreenRiverUTGreenNF.Inflow",
                 "GreenRiverUTSanRafaelNF.Inflow",
                 "ArchuletaNF.Inflow",
                 "BluffNF.Inflow",
                 "LeesFerryNF.Inflow",
                 "LeesFerryPariaNF.Inflow",
                 "CameronNF.Inflow",
                 "GrandCanyonNF.Inflow",
                 "LittlefieldNF.Inflow",
                 "HooverNF.Inflow",
                 "DavisNF.Inflow",
                 "AlamoNF.Inflow",
                 "ParkerNF.Inflow",
                 "ImperialNF.Inflow")

DirName = "StressTest"
print(path)
setwd(path)
#CREATING THE PATH IT WILL USE TO READ A FILE
ISM1988path =paste0(path,"/CRSS.Aug2023v2/dmi/",DirName,'/trace1')
setwd(ISM1988path)
getwd()

FileNA =InflowSites[1] 
file=read.csv(FileNA)
rows = nrow(file)

col_num = length(InflowSites)
rownum = rows-1
NumYear =rownum/12 
ISM1988 <- data.frame(matrix(ncol = col_num, nrow = rownum))

m=1
for (j in InflowSites){
  FileNA =j 
  file=read.csv(FileNA)
  filenum =as.numeric(file[2:rows,])
  ISM1988[,m] = filenum
  m=m+1
}

ISM1988yearly <- data.frame(matrix(ncol = 2, nrow = NumYear))

# CONVERT MONTHLY FLOWS TO YEARLY FLOWS 
Yr = 1
x=1
for (k in 1:NumYear){
  y = x+11
  ISM = ISM1988[x:y,]
  s_rows = rowSums(ISM)
  total = sum(s_rows)
  ISM1988yearly[Yr,1] = Yr
  ISM1988yearly[Yr,2] = total/(10^6)
  x=x+12
  Yr=Yr+1
}
par(mar = c(3,3,3,3)+2)

# PLOTS HISTORICAL YEARLY RIVER FLOWS 
plot(ISM1988yearly[,2], type='b', col = 1, lwd = 2, cex=1,pch=19,
     main='The ISM1988 natural inflow',cex.main=3, xlab = 'Year', ylab= 'Yearly Flow, MAF',
     cex.lab = 2, cex.axis=2)

# Second Section
#######################
# Drought Hydrology Scenarios (Figure 1 in the manuscript)

setwd(path)       # Set working directory to source file location
getwd()

# get the data from the flow file generated using the first code
# LOAD IN THE DROUGHT DATASET
FlowMatrix <- read.xlsx("Monthly_Flows_DroughtScenario_2000-2018.xlsx")
#FILTERING ON ALL THE ROWS AND COLUMNS 3-31
subFlowMatrix <- FlowMatrix[,3:31]

# Reduction percentages to the inflow, you may change these numbers
# baseline is 12.95269

yearlyFlowfirst <- c()
yearlyFlowsecond<-c()
yearlyFlowthird <-c()
DateYear <- c()

m = 1
n=m+11
y =2022
year=c()

# READING THE NUMBERS FROM EXCEL AND PUTTING THEM INTO A MATRIX/DATAFRAME
for (i in 1:NumYear){
  year[i] = FlowMatrix[m,1]
  matrix = subFlowMatrix[m:n,]
  Flow = rowSums(matrix[,1:20])
  TotalFlow = sum(Flow)/1000000
  yearlyFlowfirst[i] = TotalFlow * FirstScenario
  yearlyFlowsecond [i] =TotalFlow * SecondScenario
  yearlyFlowthird [i] =TotalFlow * ThirdScenario

  DateYear[i] = y
  
  m=m+12
  n=n+12
  y=y+1
}

yearlyFlowfirst
yearlyFlowsecond
yearlyFlowthird
DateYear

mean(yearlyFlowfirst)  #------------------------------------------------------
mean(yearlyFlowsecond)
mean(yearlyFlowthird)


# Third Section

# Fourth Section
#######################
# Apply reduction percentages to the first year inflow. Then replicate for 40 
#years (Figure 2 in the manuscript)

# TAKES 1 YEAR OF DATA AND REPEATS IT 40 TIMES
#Drought <- FlowMatrix[1:12,]
#Drought <- do.call("rbind",replicate(40,Drought,simplify = FALSE))
set.seed(123)  # optional, for reproducibility ---------------------------------------new code from Chatgpt

baseYear <- FlowMatrix[1:12,]   # first year of data

Drought_var <- NULL

VarData = read.xlsx("Variability_table.xlsx", sheet= 'values')

multipliers <- as.numeric(VarData[,2])

for (i in 1:length(multipliers)) {
  
  multiplier <- multipliers[i]
  
  baseYear <- FlowMatrix[((i-1)*12+1):(i*12),]
  
  newYear <- baseYear
  newYear[,3:22] <- newYear[,3:22] * multiplier
  
  Drought_var <- rbind(Drought_var, newYear)
}

plot(multipliers, type='b', main="Variability Multipliers")

sum(Drought_var[1:12,3:22])/1000000


# Fifth Section
#######################
# Save the drought hydrology scenarios in excel sheets 


# Drought period
Swy1 <- 2000   ## 1953 or 2000 # was 1953
Swy2 <- 2018   ## 1977 or 2018 # was 1977

# headers for the .inflow files
# you may check other inflow files from the DMI directories 
# to have an idea how these files look

date = 'start_date: 2024-1-31 24:00'
units = 'units: acre-ft/month'
firstRow = c('','', rep(c(date), each=29))
secondRow = c('','', rep(c(units), each=29))
Drought_var <- rbind(firstRow, secondRow, Drought_var)

# save the inflow of each scenario into excel file (optional)
filename1 <-paste0("Monthly_Flows_DroughtScenario_Scen1_",Swy1,"-",Swy2,".xlsx")
filename2 <-paste0("Monthly_Flows_DroughtScenario_Scen2_",Swy1,"-",Swy2,".xlsx")
filename3 <-paste0("Monthly_Flows_DroughtScenario_Scen3_",Swy1,"-",Swy2,".xlsx")

setwd(path)
getwd()

# create the "DroughtScenarios" directory to save the drought scenarios
outputDir = "DroughtScenarios"

# The directories will be created only if they do not exist
if (file.exists(outputDir)){
  setwd(file.path(path, outputDir))
} else {
  dir.create(file.path(path, outputDir))
  setwd(file.path(path, outputDir))
}

getwd() # you should be in the "DroughtScenarios" directory

# SAVES THE DATA INTO AN EXCEL FILE 
write.xlsx(Drought_var, file=filename1, asTable = FALSE, overwrite = TRUE)



# Sixth Section
#######################
# Export the generated drought hydrology scenarios as .inflow files
# (CRSS input files)
# The files can be used to create new DMI in the CRSS

# create the following directories inside the DMI directory in the 
#CRSS directory
# Here we have three hydrology scenarios. Run the "DirName" and the "DroHy" 
# next line of the first scenario,
# then skip the other "DirName" and "DroHy" variables. Continue with the code 
# after that, then come back and 
# and run the "DirName" and the "DroHy" next line of the second scenario, 
# then Continue with the code.


#1. The 10 MAF Drought Hydrology
DirName = "VariableHydrology"
DroHy = Drought_var


NewPath =paste0(path,"/CRSS.Aug2023v2/dmi/",DirName,'/trace1')
NewPath

# you should see something like the path below when you run the previous line 
#("C:/Users/m_abu/Desktop/PhD/1_Courses/2_Spring2022/RiverBasinManagement/
# Project2022/CRSS_DIR/dmi/Drought_10MAF/trace1"

setwd(NewPath)
getwd()

# THIS IS WHERE WE CREATE INFLOW FILES
Sites=length(FlowMatrix[2,])-2
for (i in 1:Sites){
  j = i+2
  fName <- paste0(InflowSites[i])
  print(fName)
  write.table(DroHy[,j], file = fName,row.names = FALSE, 
              col.names = FALSE, quote = FALSE)
}

print('done')


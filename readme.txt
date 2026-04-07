# Base Hydrology for CEE6490 Spring 2026 Projects
Created by: Ashley Jones
Email: a02298482@usu.edu

## Repository Contents

1. VariableHydrology folder
	This folder contains the inflow files. 

2. VariableHydrology.CONTROL file
	This contains the information that tells CRSS where to find each of the files needed for inflow. 

3. Variation_Code.r
	This file contains the code that creates the inflow files that can be put in CRSS. You do not have to use this code since I have 	included the inflow files 

4. Variability_table.xlsx
	This contains the ratios that the code uses to create the variable inflow files. Column one is year, column two if a ratio relative to the 	baseline (12.95 MAF) of natural flow to Lake Powell. 

## Directions to use the Hydrology Outputs in CRSS Model 

1. You need to put the VariableHydrology folder into the "DMI" folder in your CRSS root folder.
1. Put the VariableHydrology.CONTROL file in your "Control" folder within your CRSS root folder.
1. Within Riverware create a new DMI for the new variable hydrology. Make a copy of an existing DMI (NaturalFlowInput). 
1. Change the name and inputs for this new DMI to reference the variable hydrology folder. The "top directory" should be set as the VariableHydrology Folder (from step 1). The "control file" should be changed to the VariableHydrology.control file (from step 2). 
1. When you create your dmi, it is helpful to check the box "confirm warnings". That way if there are weird things going on, you will be able to see it before it causes problems. 
1. Once you have created a DMI, you can click the green play button to invoke your DMI. Then you can run your model. 
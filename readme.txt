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


# Description of Hydrology Scenario

Hi Ashley!

So here are the papers regarding this data set:
Developing Storylines of Plausible Future Streamflow and Generating a New Warming‐Driven Declining Streamflow Ensemble: Colorado River Case Study - Salehabadi - 2025 - Water Resources Research - Wiley Online Library
https://agupubs.onlinelibrary.wiley.com/journal/19447973

Quantifying and Classifying Streamflow Ensembles Using a Broad Range of Metrics for an Evidence‐Based Analysis: Colorado River Case Study - Salehabadi - 2024 - Water Resources Research - Wiley Online Library
https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2024WR037225

The first paper basically tells us that CMIP5_LOCA fits the most Storylines, specifically 1 and 2. However, Dr. Rosenberg told me to focus on the Ensembles from Dr. Tarboton and Dr. Salehabadi created, which the ensemble that best fits those narratives from their specific work is DroughtYrRes_1576_1600. 

The spreadsheet attached is in the ensemble specifics metrics folder from:
R Scripts for Evaluating Annual Streamflow Ensemble Metrics and Data and Results from their Application in the Colorado River Basin | CUAHSI HydroShare
https://www.hydroshare.org/resource/d7b65c91dda047e1969a9f9cd09b489f/

I would recommend the following traces:

Sheet 	Trace	Notes
Drought_Paleo	Trace46	Average:10.33 MAF, Length: 50 years
CMIP5_LOCA	39	Average:11.52 MAF, Length: 150 years


Let me know if anything else is needed!
Brittany Fager
Brittany.Fager@USU.edu
Utah Water Research Lab
Utah State University 


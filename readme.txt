This folder contains four main files.

1. VariableHydrology folder
	This folder contains the inflow files. You need to put this folder into the "DMI" folder in your CRSS folder. 

2. VariableHydrology CONTROL file
	This contains the information that tells CRSS where to find each of the files needed for inflow. Put this file in your "Control" 	folder within your CRSS folder

3. Variation_Code
	This file contains the code that creates the inflow files that can be put in CRSS. You do not have to use this code since I have 	included the inflow files 

4. Variability_table
	This contains the ratios that the code uses to create the variable inflow files

When you create your dmi in CRSS it asks for two different files. The "top directory" is the VariableHydrology Folder. The "control file" is the VariableHydrology control file.

When you create your dmi, it is helpful to check the box "confirm warnings". That way if there are weird things going on, you will be able to see it before it causes problems. 
# 2020_Miladinovich_SpaceWeather
Scripts and plotting data for reproducing plots in Space Weather publication Miladinovich et al., (2020).

This package includes the scripts and files for reproducing the plots (or subplo
ts) in the paper Miladinovich, D. S., S. Datta-Barua, A. Lopez-Rubio, S. Zhang, 
and G. S. Bust (2020), Assimilation of GNSS Measurements for Estimation of High-
Latitude Convection Processes, Space Weather.

Specifically: 
plot_Fig1a.m -> Figure 1a
plot_Fig1b.m -> Figure 1b
plot_Fig1cdef.m -> Figures 1c, 1d, 1e, 1f
plot_Figs3and4.m -> Figures 3 and 4
plot_Fig5.m -> Figure 5
There is no script to generate Figure 2, which is a cartoon produced in Microsof
t Powerpoint and contains no data or processing. Additionally there is no script
 to combine subplots for Figure 1 into a single figure, as that was also done ma
nually in Powerpoint.

The package requires the use of Matlab.  The script plot_Fig5.m additionally req
uires the Matlab Mapping Toolbox.
It has been tested on Matlab R2015b on CentOS Linux and on Mac OSX 10.10.5.  

Unzipping the package will produce a folder containing the above listed scripts 
in the top level; support scripts are located in a folder 'scripts', and the dat
a to be plotted are in a folder 'data.'

After unzipping the package, preserve the directory structure of the package of 
plotting scripts in order for the script to run and find the necessary files.  R
un the scripts directly with the top level directory as the Matlab working direc
tory.  

Each plot*.m will automatically clear all variables and close all figures.
The scripts plot_Fig1a.m, plot_Fig1b.m, and plot_Fig1cdef.m will automatically a
dd the subdirectories of the package to the Matlab path.  Comment the relevant l
ines at the start of each script if these behaviors are not desired.  

Point of contact:
Seebany Datta-Barua, Illinois Institute of Technology
sdattaba@iit.edu
http://apollo.tbc.iit.edu/~spaceweather/live/
Created 2 May 2020

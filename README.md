# Lagranto tutorial
A detailed example of lagranto.ecmwf use for identifying warm conveyor belts. 

Based on Lagranto Documentation (Release 0.1) by Nicolas Piaget available at https://media.readthedocs.org/pdf/lagranto/latest/lagranto.pdf and Lagranto Tutorial by Michael Sprenger and Heini Wernli available at http://iacweb.ethz.ch/staff//sprenger/lagranto/tutorial/Lagranto-Tutorial.pdf.

In this tutorial, we find warm conveyor belts over the Atlantic and Europe on June 1-5, 2013.

This repository includes scripts for:

1) downloading ERA Interim data from ECMWF (ecmwf_download.py), 
2) processing them with NCO to meet LAGRANTO format requirements (ecmwf2nc_nco_script.sh), 
3) running LAGRANTO as a shell script (lagrantodata/run_lagranto.sh) and 
4) plotting the results in a Jupyter Notebook (Plotting_trajectories.ipynb). 

# Instructions:
mkdir erai

python ecmwf_download.py % or, in background: nohup python ecmwf_download.py > out.txt & 

sh ecmwf2nc_nco_script.sh

cd lagrantodata

sh run_lagranto.sh

cd ..

jupyter notebook

Then execute the code in Plotting_trajectories.ipynb.

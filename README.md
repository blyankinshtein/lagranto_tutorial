# Lagranto tutorial
A detailed example of lagranto.ecmwf use for identifying warm conveyor belts. 

Based on Lagranto Documentation (Release 0.1) by Nicolas Piaget available at https://media.readthedocs.org/pdf/lagranto/latest/lagranto.pdf and Lagranto Tutorial by Michael Sprenger and Heini Wernli available at http://iacweb.ethz.ch/staff//sprenger/lagranto/tutorial/Lagranto-Tutorial.pdf.

This repository includes scripts for:

1) downloading ERA Interim data from ECMWF (ecmwf_download.py), 
2) processing them with NCO, 
3) running LAGRANTO as a shell script and 
% 4) plotting the results in Jupyter Notebook. 

# Instructions:
mkdir erai

python ecmwf_download.py % in background: nohup python ecmwf_download.py > out.txt & 

sh ecmwf2nc_nco_script.sh

cd lagrantodata

sh rul_lagranto.sh



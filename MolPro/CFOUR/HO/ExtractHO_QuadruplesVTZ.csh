#!/bin/csh
#
# Generation of the input file for MOLPRO
#

set directory = /home/zcaposm/Scratch/HOCl/MolPro/CFOUR/HO/PQUADRUPLES_VTZ

set point

grep "The final electronic energy is" ${directory}/*FULLTRIPLES_VTZ* > HOCl-PQUADRUPLES_VTZ.dat
grep "Total CCSDT energy:" ${directory}/*FULLTRIPLES_VTZ* > HOCl-FULLTRIPLES_VTZ-2.dat

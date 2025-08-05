#!/bin/csh
#
# Generation of the input file for MOLPRO
#

set directory = /home/zcaposm/Scratch/HOCl/MolPro/CFOUR/HO/ComputedCorrections


grep "The final electronic energy is" ${directory}/*PTRIPLES_VTZ* > HOCl-PTriples_VTZ.dat
grep "The final electronic energy is" ${directory}/*FULLTRIPLES_VTZ* > HOCl-FullTriples_VTZ.dat
grep "The final electronic energy is" ${directory}/*PQUADRUPLES_VDZ* > HOCl-PQuadruples_VDZ.dat
grep "The final electronic energy is" ${directory}/*FULLTRIPLES_VDZ* > HOCl-FullTriples_VDZ.dat

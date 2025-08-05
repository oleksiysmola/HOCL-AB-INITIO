#!/bin/csh
#
# Generation of the input file for MOLPRO
#

set pwd = `pwd`

set point = $1        
set directory = /home/zcaposm/Scratch/HOCl/MolPro/MolPro/SR-Corrections-APVQdZ-DK
set fname = HOCl_SR_point_${point}

cat<<endb> ${fname}.inp
***, HOCl SR correction
memory,500,m;

gthresh,energy=1.d-14,zero=1.d-14,thrint=1.d-14,oneint=1.d-14,twoint=1.d-14,prefac=1.d-20

geometry={angstrom
o
h , 1, roh
cl , 1, rocl, 2, alpha
}

roh = $2
rocl = $3
alpha = $4

basis=aug-cc-pV(Q+d)Z-DK
hf
frozen
ccsd(t)
E_0 = energy

SET,DKROLL=1
hf
frozen
ccsd(t)
E_SR = energy-E_0

! Output the energy
xxx = "mmm"
point = ${point}
text ### HOCl
table,xxx,roh,rocl,alpha,E_SR,energy,point
DIGITS, 0, 8, 8, 8, 14, 12, 4

--- End of Script ---
endb

module load molpro/2020.1/openmp
molpro ${fname}.inp
rm ${fname}.inp
cp ${fname}.out ${directory}
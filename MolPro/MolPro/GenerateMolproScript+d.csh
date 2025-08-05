#!/bin/csh
#
# Generation of the input file for MOLPRO
#

set pwd = `pwd`

set point = $1        
set directory = /home/zcaposm/Scratch/HOCl/MolPro/MolPro/AUGVQ+dZ-Threshold
set fname = HOCl_AUG-CC-PVQ+dZ_point_${point}

cat<<endb> ${fname}.inp
***, HOCl Ground State Energy with CCSD(T) and aug-cc-pV(Q+d)Z
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

basis=aug-cc-pV(Q+d)Z
hf
frozen
ccsd(t)


xxx = "mmm"
point = ${point}
text ### HOCl
table,xxx,roh,rocl,alpha,energy,point
DIGITS, 0, 8, 8, 8, 14, 12, 4

--- End of Script ---
endb

module load molpro/2020.1/openmp
molpro ${fname}.inp
rm ${fname}.inp
cp ${fname}.out ${directory}
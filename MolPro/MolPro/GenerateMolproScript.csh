#!/bin/csh
#
# Generation of the input file for MOLPRO
#

set pwd = `pwd`

set point = $1        
set directory = /home/zcaposm/Scratch/HOCl/MolPro/MolPro/CBS-Computed
set fname = HOCl_CBS_point_${point}

cat<<endb> ${fname}.inp
***, HOCl Ground State Energy with CCSD(T)-F12 and aug-cc-pVQZ-F12
memory,500,m;

gthresh,energy=1.d-12,zero=1.d-14,thrint=1.d-14,oneint=1.d-14,twoint=1.d-14,prefac=1.d-20

geometry={angstrom
o
h , 1, roh
cl , 1, rocl, 2, alpha
}

roh = $2
rocl = $3
alpha = $4

basis=aug-cc-pVTZ-f12
hf
frozen
ccsd(t)-f12,ri_basis=cc-pV5Z/jkfit,df_basis=aug-cc-pwCV5Z/mp2fit

E_ccsd3 = ENERGC(2)
E_t3 = ENERGY(2) - ENERGC(2)

basis=aug-cc-pVQZ-f12
hf
frozen
ccsd(t)-f12,ri_basis=cc-pV5Z/jkfit,df_basis=aug-cc-pwCV5Z/mp2fit

E_ccsd4 = ENERGC(2)
E_t4 = ENERGY(2) - ENERGC(2)

E_ccsd = (E_ccsd4 - E_ccsd3)*1.363388 + E_ccsd3
E_t = (E_t4 - E_t3)*1.769474 + E_t3
E_total = E_ccsd + E_t

! Output the energy
xxx = "mmm"
point = ${point}
text ### HOCl
table,xxx,roh,rocl,alpha,E_total,energy,point
DIGITS, 0, 8, 8, 8, 14, 12, 4

--- End of Script ---
endb

module load molpro/2020.1/openmp
molpro ${fname}.inp
rm ${fname}.inp
cp ${fname}.out ${directory}
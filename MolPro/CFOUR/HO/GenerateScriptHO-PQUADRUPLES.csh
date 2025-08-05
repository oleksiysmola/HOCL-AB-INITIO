#!/bin/csh
#
# Generation of the input file for MOLPRO
#

setenv PATH /home/zcaposm/bin:$PATH

set pwd = `pwd`

set point = $1        
set directory = /home/zcaposm/Scratch/HOCl/MolPro/CFOUR/HO/ComputedCorrections

set fname4 = cfour_HOCl_HO_PQUADRUPLES_VDZ_${point}
set scf_conv = $2
set cc_conv = $3

cat<<endb> ZMAT
Hypochlorous acid CCSDT(Q)/aug-cc-pVDZ
O
H 1 ROH
CL 1 ROCL 2 A                                                                
                                                                                
ROH= $3
ROCL=$4
A=$5                                                                  
                                                                                
                                                                                
*CFOUR(CALC=CCSDT(Q),BASIS=AUG-PVDZ,SCF_CONV=$scf_conv                                     
CC_CONV=${cc_conv},FROZEN_CORE=ON,MEMORY=5000000000) 
endb

/home/zcaposm/bin/xcfour > ${fname4}.out
rm ZMAT
cp ${fname4}.out ${directory}
/home/zcaposm/bin/xclean


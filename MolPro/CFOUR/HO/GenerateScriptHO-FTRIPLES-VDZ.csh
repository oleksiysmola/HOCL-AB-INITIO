#!/bin/csh
#
# Generation of the input file for MOLPRO
#

setenv PATH /home/zcaposm/bin:$PATH

set pwd = `pwd`

set point = $1        
set directory = /home/zcaposm/Scratch/HOCl/MolPro/CFOUR/HO/ComputedCorrections

set fname3 = cfour_HOCl_HO_FULLTRIPLES_VDZ_${point}
set scf_conv = $2
set cc_conv = $3

cat<<endb> ZMAT
Hypochlorous acid CCSDT/aug-cc-pVDZ
O
H 1 ROH
CL 1 ROCL 2 A                                                                
                                                                                
ROH= $4
ROCL=$5
A=$6                                                                  
                                                                                
                                                                                
*CFOUR(CALC=CCSDT,BASIS=AUG-PVDZ,SCF_CONV=$scf_conv                                    
CC_CONV=${cc_conv},FROZEN_CORE=ON,MEMORY=5000000000) 
endb

/home/zcaposm/bin/xcfour > ${fname3}.out
rm ZMAT
cp ${fname3}.out ${directory}
/home/zcaposm/bin/xclean


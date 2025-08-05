#!/bin/csh
#
# Generation of the input file for MOLPRO
#

setenv PATH /home/zcaposm/bin:$PATH

set pwd = `pwd`

set point = $1        
set directory = /home/zcaposm/Scratch/HOCl/MolPro/CFOUR/HO/ComputedCorrections

set fname2 = cfour_HOCl_HO_FULLTRIPLES_VTZ_${point}
set scf_conv = $2
set cc_conv = $3


cat<<endb> ZMAT
Hypochlorous acid CCSDT/aug-cc-pVTZ
O
H 1 ROH
CL 1 ROCL 2 A                                                                
                                                                                
ROH= $4
ROCL=$5
A=$6                                                                  
                                                                                
                                                                                
*CFOUR(CALC=CCSDT,BASIS=AUG-PVTZ,SCF_CONV=$scf_conv                                     
CC_CONV=${cc_conv},FROZEN_CORE=ON,MEMORY=5000000000) 
endb

/home/zcaposm/bin/xcfour > ${fname2}.out
rm ZMAT
cp ${fname2}.out ${directory}
/home/zcaposm/bin/xclean

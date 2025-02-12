#!/bin/csh
#
# Generation of the input file for MOLPRO
#

setenv PATH /home/zcaposm/bin:$PATH

set pwd = `pwd`

set point = $1        
set directory = /scratch/scratch/zcaposm/HOCl/HOCl-DBOC/ComputedDBOCs
set fname = cfour_HOCL_DBOC_AUG-PCVTZ_${point}

cat<<endb> ZMAT
Hypochlorous acid DBOC calculation                                      
O                                                                               
H 1 ROH                                                                         
CL 1 ROCL 2 A                                                                   
                                                                                
ROH=$2                                                                        
ROCL=$3                                                                      
A=$4                                                                    
                                                                                
                                                                                
*CFOUR(CALC=CCSD,BASIS=AUG-PCVTZ,SCF_CONV=10
CC_CONV=10,DBOC=ON,MEMORY=500000000)
endb

# ls /home/zcaposm/bin/
# ls /home/zcaposm
/home/zcaposm/bin/xcfour > ${fname}.out
rm ZMAT
cp ${fname}.out ${directory}
/home/zcaposm/bin/xclean

#!/bin/csh
#
# Generation of the input file for MOLPRO
#

setenv PATH /home/zcaposm/bin:$PATH

set pwd = `pwd`

set point = $1        
set directory = /home/zcaposm/Scratch/HOCl/MolPro/CFOUR/HO/ComputedCorrections

set fname1 = cfour_HOCl_HO_PTRIPLES_VTZ_${point}
set scf_conv=11
set cc_conv=8

cat<<endb> ZMAT
Hypochlorous acid CCSD(T)/aug-cc-pVTZ
O
H 1 ROH
CL 1 ROCL 2 A                                                                
                                                                                
ROH= $2
ROCL=$3
A=$4                                                                  
                                                                                
                                                                                
*CFOUR(CALC=CCSD(T),BASIS=AUG-PVTZ,SCF_CONV=$scf_conv                                     
CC_CONV=${cc_conv},FROZEN_CORE=ON,MEMORY=5000000000) 
endb

/home/zcaposm/bin/xcfour > ${fname1}.out
rm ZMAT
cp ${fname1}.out ${directory}
/home/zcaposm/bin/xclean

set fname2 = cfour_HOCl_HO_FULLTRIPLES_VTZ_${point}

cat<<endb> ZMAT
Hypochlorous acid CCSDT/aug-cc-pVTZ
O
H 1 ROH
CL 1 ROCL 2 A                                                                
                                                                                
ROH= $2
ROCL=$3
A=$4                                                                  
                                                                                
                                                                                
*CFOUR(CALC=CCSDT,BASIS=AUG-PVTZ,SCF_CONV=$scf_conv                                      
CC_CONV=${cc_conv},FROZEN_CORE=ON,MEMORY=5000000000) 
endb

/home/zcaposm/bin/xcfour > ${fname2}.out
rm ZMAT
cp ${fname2}.out ${directory}
/home/zcaposm/bin/xclean

set fname3 = cfour_HOCl_HO_FULLTRIPLES_VDZ_${point}

cat<<endb> ZMAT
Hypochlorous acid CCSDT/aug-cc-pVDZ
O
H 1 ROH
CL 1 ROCL 2 A                                                                
                                                                                
ROH= $2
ROCL=$3
A=$4                                                                  
                                                                                
                                                                                
*CFOUR(CALC=CCSDT,BASIS=AUG-PVDZ,SCF_CONV=$scf_conv                                     
CC_CONV=${cc_conv},FROZEN_CORE=ON,MEMORY=5000000000) 
endb

/home/zcaposm/bin/xcfour > ${fname3}.out
rm ZMAT
cp ${fname3}.out ${directory}
/home/zcaposm/bin/xclean

set fname4 = cfour_HOCl_HO_PQUADRUPLES_VDZ_${point}

cat<<endb> ZMAT
Hypochlorous acid CCSDT(Q)/aug-cc-pVDZ
O
H 1 ROH
CL 1 ROCL 2 A                                                                
                                                                                
ROH= $2
ROCL=$3
A=$4                                                                  
                                                                                
                                                                                
*CFOUR(CALC=CCSDT(Q),BASIS=AUG-PVDZ,SCF_CONV=$scf_conv                                      
CC_CONV=${cc_conv},FROZEN_CORE=ON,MEMORY=5000000000) 
endb

/home/zcaposm/bin/xcfour > ${fname4}.out
rm ZMAT
cp ${fname4}.out ${directory}
/home/zcaposm/bin/xclean


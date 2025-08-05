#!/bin/csh
#

cd $TMPDIR

# module load molpro/2020.1/openmp

module load mpi/openmpi/3.1.4/intel-2018
export OMP_NUM_THREADS=14
export MKL_NUM_THREADS=14

cp /home/zcaposm/Scratch/HOCl/GENBAS .
ls

set point = $1
set endPoint = $2
echo $point 
while ($point < $endPoint)
    set line = `awk 'NR=='"$point" /home/zcaposm/Scratch/HOCl/MolPro/Grid/HOCl-FullGrid-DBOC.txt`

    if ("$line" != "") then
        csh -f /home/zcaposm/Scratch/HOCl/MolPro/CFOUR/HO/GenerateScriptHO.csh $line
    endif
@ point++
end
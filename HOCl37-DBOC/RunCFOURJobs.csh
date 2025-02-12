#!/bin/csh
#

cd $TMPDIR

# module load molpro/2020.1/openmp

module load mpi/openmpi/3.1.4/intel-2018
export OMP_NUM_THREADS=14
export MKL_NUM_THREADS=14

set point = $1
set endPoint = $2
echo $point 
cp /scratch/scratch/zcaposm/HOCl/GENBAS .
while ($point < $endPoint)
    set line = `awk 'NR=='"$point" /scratch/scratch/zcaposm/HOCl/HOCl37-DBOC/HOCL-Grid.txt`

    if ("$line" != "") then
        csh -f /scratch/scratch/zcaposm/HOCl/HOCl37-DBOC/GenerateCfourScript.csh $line
    endif
@ point++
end
/home/zcaposm/bin/xclean
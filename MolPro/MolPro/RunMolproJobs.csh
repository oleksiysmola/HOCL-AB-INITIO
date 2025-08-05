#!/bin/csh
#

cd $TMPDIR

module load molpro/2020.1/openmp

set point = $1
set endPoint = $2
echo $point 
while ($point < $endPoint)
    set line = `awk 'NR=='"$point" /home/zcaposm/Scratch/HOCl/MolPro/Grid/HOCl-FullGrid.txt`

    if ("$line" != "") then
        csh -f /home/zcaposm/Scratch/HOCl/MolPro/MolPro/GenerateMolproScript-CV-Correction-2.csh $line
    endif
@ point++
end
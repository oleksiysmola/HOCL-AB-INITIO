#!/bin/csh
#
# Generation of the input file for MOLPRO
#

grep -E "The total diagonal Born-Oppenheimer correction \(DBOC\) is:[[:space:]]+[+-]?[0-9]*\.?[0-9]+[[:space:]]+a\.u\." Computed/* > greppedDBOCs.txt
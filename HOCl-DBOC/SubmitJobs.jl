point::Int64 = 12601
jobSplit::Int64 = 8
numberOfJobs::Int64 = 5

for i in 1:numberOfJobs
    run(`qsub -e HOCL_CFOUR_DBOC_$(point)-$(point + jobSplit).e -o HOCL_CFOUR_DBOC_$(point)-$(point + jobSplit).o -l h_rt="11:59:00" -l mem=20G -l tmpfs=100G RunCFOURJobs.csh $(point) $(point + jobSplit)`)
    global point = point + jobSplit
    println(point)
end
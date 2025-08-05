point::Int64 = 6336
jobSplit::Int64 = 7
numberOfJobs::Int64 = 1000

for i in 1:numberOfJobs
    run(`qsub -e HOCl_CV_$(point)-$(point + jobSplit).e -o HOCl_CV_$(point)-$(point + jobSplit).o -l h_rt="11:59:00" -l mem=20G -l tmpfs=100G RunMolproJobs.csh $(point) $(point + jobSplit)`)
    global point = point + jobSplit
    println(point)
end
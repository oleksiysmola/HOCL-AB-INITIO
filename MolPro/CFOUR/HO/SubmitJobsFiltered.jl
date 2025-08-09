point::Int64 = 6670 # 1868 # 6670 6725
jobSplit::Int64 = 1
numberOfJobs::Int64 = 5

# Recompute up to point 55! on cc=11 and scf=11

include("ComputedPointsVTZ-PTriples.jl")
include("ComputedPointsVTZ-FullTriples.jl")
include("ComputedPointsVDZ-PQuadruples.jl")
include("ComputedPointsVDZ-FullTriples.jl")

for i in 1:numberOfJobs
    computedContributions::Vector{Bool} = [false, false, false, false]
    if point in pointsVDZpQuadruples
        computedContributions[1] = true
    end
    if point in pointsVDZfullTriples
        computedContributions[2] = true
    end
    if point in pointsVTZfullTriples
        computedContributions[3] = true
    end
    if point in pointsVTZpTriples
        computedContributions[4] = true
    end
    if count(==(false), computedContributions) >= 1
        run(`qsub -e HOCl_HO_$(point)-$(point + jobSplit).e -o HOCl_HO_$(point)-$(point + jobSplit).o -l h_rt="4:59:00" -l mem=20G -l tmpfs=100G RunMolproJobs.csh $(point) $(point + jobSplit)`)
        println(point, " submitted for computing HO corrections")
    end
    global point = point + jobSplit
    # println(point)
end
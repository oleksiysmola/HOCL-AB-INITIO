using Printf

stretchesSpacing::Vector{Float64} = [0.0000, -0.005, 0.005, -0.010, 0.010, -0.015, 0.015, -0.020, 0.020, -0.025, 0.025, -0.03, 0.03, -0.035, 0.035, -0.04, 0.04, -0.045, 0.045, -0.05, 0.05, -0.055, 0.055, -0.06, 0.06, -0.065, 0.065, -0.07, 0.07, -0.075, 0.075, -0.08, 0.08, -0.085, 0.085,-0.09, 0.09,  -0.095, 0.095, -0.1, 0.1, -0.11, 0.11, -0.12, 0.12, 0.12500, -0.125000, 0.1500, -0.1500,
   -0.200, 0.300, -0.300, 0.400, -0.400, 0.500, 0.600, 0.700, 0.800, 0.900, 1.000]
angleSpacing::Vector{Float64} = [0.0000, 1.000, -1.000, 2.0, -2.0, 2.5000, -2.5000, 3.0, -3.0, 4.0, -5.0, 5.00, -5.0000, 7.500, -7.500, -10.0000, 12.5000,-12.5000, 15.0000,-15.0000, 17.5000,-17.5000, 20.0000, -20.0000, 22.5000, -22.5000, 25.0000, -25.0000, 30.0000, -30.0000, 35.0000, -35.0000, 40.000, -40.000, 45.000, -45.000, 50.0000, -50.0000, 60.0000, -60.0000, 70.000000, -70.000000, 77.000, -80.000]

stretchesGrid::Int64 = size(stretchesSpacing)[1]
angleGrid::Int64 = size(angleSpacing)[1]
convertToRadians::Float64 = 2*pi/360

# Values computed with CCSD(T)-F12b/AUG-CC-pVQZ-F12b
gridSize::Int64 = 3
rOHeq::Float64 = 0.96446195
rOCleq::Float64 = 1.68888476
alpha::Float64 = 103.00
equilibriumGrid::Vector{Float64} = [rOHeq, rOCleq, alpha]

function PrintGeometry(point::Int64, grid::Vector{Float64})
    @printf("%12.8f %12.8f %12.8f %12.8f \n", point, grid[1], grid[2], grid[3])
end

# function SubmitJob(point::Int64, grid::Vector{Float64})
#     submission::Cmd = `qsub -e CH3+_1D_CBS_$(point).e -o CH3+_1D_CBS_$(point).o -l h_rt="11:59:00" -l mem=10G -l tmpfs=100G GenerateMolproScript1D.csh $(point) $(grid[1]) $(grid[2]) $(grid[3]) $(grid[4]) $(grid[5]) $(grid[6]) $(grid[7]) $(grid[8]) $(grid[9])`
#     run(submission)
# end

point::Int64 = 6162 # 6162 was the initial grid size
# SubmitJob(point, equilibriumGrid)
# PrintGeometry(point, equilibriumGrid)

numberOfPointsPerMode::Int64 = 200

rOHGrid::Vector{Float64} = LinRange(0.5, 2.0, 200)
rOClGrid::Vector{Float64} = LinRange(1.25, 2.5, 200)
alphaGrid::Vector{Float64} = LinRange(40, 180, 200)

for i in 1:numberOfPointsPerMode
    global point = point + 1
    grid::Vector{Float64} = copy(equilibriumGrid)
    grid[1] = rOHGrid[i]
    PrintGeometry(point, grid)
end

for i in 1:numberOfPointsPerMode
    global point = point + 1
    grid::Vector{Float64} = copy(equilibriumGrid)
    grid[2] = rOClGrid[i]
    PrintGeometry(point, grid)
end

for i in 1:numberOfPointsPerMode
    global point = point + 1
    grid::Vector{Float64} = copy(equilibriumGrid)
    grid[3] = alphaGrid[i]
    PrintGeometry(point, grid)
end

# for i in 1:2
#     for j in 2:stretchesGrid
#         global point = point + 1
#         displacementVector::Vector{Float64} = zeros(gridSize)
#         displacementVector[i] = stretchesSpacing[j]
#         grid::Vector{Float64} = equilibriumGrid + displacementVector
#         PrintGeometry(point, grid)
#     end
# end
# for j in 2:angleGrid
#     global point = point + 1
#     displacementVector::Vector{Float64} = zeros(gridSize)
#     displacementVector[3] = angleSpacing[j]
#     grid::Vector{Float64} = equilibriumGrid + displacementVector
#     PrintGeometry(point, grid)
# end
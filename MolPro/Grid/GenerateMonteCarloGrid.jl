using Printf

stretchesSpacing::Vector{Float64} = [0.0000, -0.010, 0.010, -0.025,0.025, -0.050, 0.05,  0.750, -0.7500, -0.1000, 0.1000, 0.12500, -0.125000, 0.1500, -0.1500, 0.200, 
   -0.200, 0.300, -0.300, 0.400, -0.400, 0.500, 0.600]
angleSpacing::Vector{Float64} = [0.0000, 1.000, -1.000, 2.5000, -2.5000, 5.00, -5.0000, 7.500, -7.500, -10.0000, 15.0000,-15.0000, 20.0000, -20.0000, 25.0000, -25.0000, 30.0000, -30.0000, 40.000, -40.000, 50.0000, -50.0000, 60.0000, -60.0000, 70.000000, -70.000000, 77.000, -80.000]

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


function PrintGeometry(point::Int64, grid::Vector{Float64})
    @printf("%12.8f %12.8f %12.8f %12.8f \n", point, grid[1], grid[2], grid[3])
end

# function SubmitJob(point::Int64, grid::Vector{Float64})
#     submission::Cmd = `qsub -e CH3+_1D_CBS_$(point).e -o CH3+_1D_CBS_$(point).o -l h_rt="11:59:00" -l mem=10G -l tmpfs=100G GenerateMolproScript1D.csh $(point) $(grid[1]) $(grid[2]) $(grid[3]) $(grid[4]) $(grid[5]) $(grid[6]) $(grid[7]) $(grid[8]) $(grid[9])`
#     run(submission)
# end


point::Int64 = 6163
# SubmitJob(point, equilibriumGrid)
# PrintGeometry(point, equilibriumGrid)

numberOfGridPoints1D::Int64 = 3000
numberOfGridPoints2D::Int64 = 2000
numberOfGridPoints3D::Int64 = 1000
degreesOfFreedom::Int64 = 3
equilibriumProbabilities::Vector{Float64} = [1/3, 1/3, 0.5]

function GenerateMonteCarloGrid(dimension::Int64, numberOfGridPoints::Int64, maxGridRange::Float64)
    generatedPoint::Int64 = 1
    while generatedPoint <= numberOfGridPoints
        chosenCoordinates::Vector{Int64} = zeros(dimension)
        equilibriumProbabilitiesOfChosenCoordinates::Vector{Float64} = zeros(dimension)
        currentCoordinate::Int64 = 1
        while currentCoordinate <= dimension
            newCoordinate::Int64 = rand(1:degreesOfFreedom)
            if newCoordinate in chosenCoordinates
                continue
            else
                chosenCoordinates[currentCoordinate] = newCoordinate
                equilibriumProbabilitiesOfChosenCoordinates[currentCoordinate] = equilibriumProbabilities[newCoordinate]
                currentCoordinate += 1
            end
        end
        probabilitiesOfChosenCoordinates::Vector{Float64} = rand(dimension)
        if prod(abs.(probabilitiesOfChosenCoordinates .- equilibriumProbabilitiesOfChosenCoordinates)) > maxGridRange^dimension
            continue
        else
            grid::Vector{Float64} = equilibriumGrid .+ 0.0
                for j in 1:size(chosenCoordinates)[1]
                    if 1 <= chosenCoordinates[j] < 3
                        stretchDisplacement::Float64 = 0
                        if probabilitiesOfChosenCoordinates[j] < 1/3
                            # PDF p(x) = m1 x + c  (values given not normalised)
                            # c = 0.3
                            # m1 = 1
                            stretchDisplacement = 3*(-1 + sqrt(3)*sqrt(probabilitiesOfChosenCoordinates[j]))/10
                            grid[chosenCoordinates[j]] += 1.25*stretchDisplacement
                        else
                            # PDF p(x) = m2 x + c  (values given not normalised)
                            # c = 0.3
                            # m2 = -1/2
                            stretchDisplacement = 3*(2-sqrt(6)*sqrt(1-probabilitiesOfChosenCoordinates[j]))/10
                            grid[chosenCoordinates[j]] += 1.25*stretchDisplacement
                        end
                    else
                        angleDisplacement::Float64 = real((25*(1-sqrt(3)*1im))/(-1+2*probabilitiesOfChosenCoordinates[j]+2*sqrt(Complex(-probabilitiesOfChosenCoordinates[j]+probabilitiesOfChosenCoordinates[j]^2)))^(1/3)+25*(1+sqrt(3)*1im)*(-1+2*probabilitiesOfChosenCoordinates[j]+2*sqrt(Complex(-probabilitiesOfChosenCoordinates[j]+probabilitiesOfChosenCoordinates[j]^2)))^(1/3))
                        grid[chosenCoordinates[j]] -= 2*angleDisplacement
                        if grid[chosenCoordinates[j]] > 180
                            grid[chosenCoordinates[j]] = 360 - grid[chosenCoordinates[j]]
                        end
                    end
                end
            PrintGeometry(point, grid)
            generatedPoint += 1
            global point += 1
        end
    end
end

# GenerateMonteCarloGrid(1, numberOfGridPoints1D, 0.95)
GenerateMonteCarloGrid(2, numberOfGridPoints2D, 0.80)
GenerateMonteCarloGrid(3, numberOfGridPoints3D, 0.60)
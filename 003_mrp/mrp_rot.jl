using Rotations
using LinearAlgebra
using Random
using StaticArrays
Random.seed!(42)

# Generate random rotation matrix (for axis1_.png)
R = rand(RotMatrix3{Float64})
str = string(vec(vcat(Matrix(R)',zeros(3)')'))
clipboard(str[2:end-1])

# Generate MRP
function insideball(p::SVector{3})
    x,y,z = p.data
    L = norm(p)
    if L < 1
        return p
    else
        return -p/L^2
    end
end
p = Rotations.params(MRP(R))
clipboard(string(p)[2:end-1])

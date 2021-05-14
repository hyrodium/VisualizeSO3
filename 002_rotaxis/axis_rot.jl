using Rotations
using LinearAlgebra
using Random
Random.seed!(42)

# Generate random rotation matrix (for axis1_.png)
R = rand(RotMatrix3{Float64})
str = string(vec(vcat(Matrix(R)',zeros(3)')'))
clipboard(str[2:end-1])

# Generate AngleAxis
R_aa = AngleAxis(R)
fieldnames(typeof(R_aa))
t = R_aa.theta
clipboard(t)
v = [R_aa.axis_x,R_aa.axis_y,R_aa.axis_z]
clipboard(string(v))


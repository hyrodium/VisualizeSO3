using Rotations
using Random
Random.seed!(42)

# Generate random rotation matrix (for axis1_.png)
R = rand(RotMatrix3{Float64})
str = string(vec(vcat(Matrix(R)',zeros(3)')'))
clipboard(str[2:end-1])

# Get Euler angle (for axis2_.png)
R_xyz = RotXYZ(R)
str = """
rotate z*$(rad2deg(R_xyz.theta3))
rotate y*$(rad2deg(R_xyz.theta2))
rotate x*$(rad2deg(R_xyz.theta1))
"""
clipboard(str)

# Get Euler angle (for axis3_.png)
R_xyx = RotXYX(R)
str = """
rotate x*$(rad2deg(R_xyx.theta3))
rotate y*$(rad2deg(R_xyx.theta2))
rotate x*$(rad2deg(R_xyx.theta1))
"""
clipboard(str)

using Rotations
using LinearAlgebra
using Random
using StaticArrays
Random.seed!(42)

function insideball(p::SVector{3})
    x,y,z = p.data
    L = norm(p)
    if L < 1
        return p
    else
        return -p/L^2
    end
end

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

# Generate MRP around x-axis
ts = range(0,stop=2π,length=61)[1:end-1]
lines = ""
for t in ts
    R = RotX(t)
    p = insideball(Rotations.params(MRP(R)))
    R_v = vec(Matrix(R))
    line = ""
    line *= "<$(string(R_v[1:3])[2:end-1])>,"
    line *= "<$(string(R_v[4:6])[2:end-1])>,"
    line *= "<$(string(R_v[7:9])[2:end-1])>,"
    line *= "<$(string(p)[2:end-1])>,"
    lines *= line * "\n"
end
print(lines)
write("003_mrp/02_mrp_x/rot_x.txt",lines)

# Generate MRP around y-axis
ts = range(0,stop=2π,length=61)[1:end-1]
lines = ""
for t in ts
    R = RotY(t)
    p = insideball(Rotations.params(MRP(R)))
    R_v = vec(Matrix(R))
    line = ""
    line *= "<$(string(R_v[1:3])[2:end-1])>,"
    line *= "<$(string(R_v[4:6])[2:end-1])>,"
    line *= "<$(string(R_v[7:9])[2:end-1])>,"
    line *= "<$(string(p)[2:end-1])>,"
    lines *= line * "\n"
end
print(lines)
write("003_mrp/03_mrp_y/rot_y.txt",lines)

# Generate MRP around z-axis
ts = range(0,stop=2π,length=61)[1:end-1]
lines = ""
for t in ts
    R = RotZ(t)
    p = insideball(Rotations.params(MRP(R)))
    R_v = vec(Matrix(R))
    line = ""
    line *= "<$(string(R_v[1:3])[2:end-1])>,"
    line *= "<$(string(R_v[4:6])[2:end-1])>,"
    line *= "<$(string(R_v[7:9])[2:end-1])>,"
    line *= "<$(string(p)[2:end-1])>,"
    lines *= line * "\n"
end
print(lines)
write("003_mrp/04_mrp_z/rot_z.txt",lines)

# Generate MRP around xy-axis
ts = range(0,stop=2π,length=61)[1:end-1]
lines = ""
for t in ts
    R1 = RotX(t)
    R2 = RotY(t)
    R = R1*R2
    p = insideball(Rotations.params(MRP(R)))
    R_v = vec(Matrix(R))
    line = ""
    line *= "<$(string(R_v[1:3])[2:end-1])>,"
    line *= "<$(string(R_v[4:6])[2:end-1])>,"
    line *= "<$(string(R_v[7:9])[2:end-1])>,"
    line *= "<$(string(p)[2:end-1])>,"
    lines *= line * "\n"
end
print(lines)
write("003_mrp/05_mrp_xy/rot_xy.txt",lines)

# Generate MRP around yx-axis
ts = range(0,stop=2π,length=61)[1:end-1]
lines = ""
for t in ts
    R1 = RotX(t)
    R2 = RotY(t)
    R = R2*R1
    p = insideball(Rotations.params(MRP(R)))
    R_v = vec(Matrix(R))
    line = ""
    line *= "<$(string(R_v[1:3])[2:end-1])>,"
    line *= "<$(string(R_v[4:6])[2:end-1])>,"
    line *= "<$(string(R_v[7:9])[2:end-1])>,"
    line *= "<$(string(p)[2:end-1])>,"
    lines *= line * "\n"
end
print(lines)
write("003_mrp/05_mrp_xy/rot_yx.txt",lines)

# Generate MRP around xy-axis, as surface
ts = range(0,stop=2π,length=41)
# ts = range(0,stop=π,length=10)
lines = ""
for t1 in ts
    for t2 in ts
        R1 = RotX(t1)
        R2 = RotY(t2)
        R = R1*R2
        p = insideball(Rotations.params(MRP(R)))
        R_v = vec(Matrix(R))
        line = ""
        line *= "<$(string(p)[2:end-1])>,"
        lines *= line
    end
    lines *= "\n"
end
print(lines)
write("003_mrp/06_mrp_xy_surface/rot_xy.txt",lines)

# Generate MRP around xyx-axis, as solid
ts = range(0,stop=2π,length=21)
lines = ""
for t1 in ts
    for t2 in ts
        for t3 in ts
            R = RotXYX(t1,t2,t3)
            p = insideball(Rotations.params(MRP(R)))
            R_v = vec(Matrix(R))
            line = ""
            line *= "<$(string(p)[2:end-1])>,"
            lines *= line
        end
        lines *= "\n"
    end
end
print(lines)
write("003_mrp/07_mrp_xyx_solid/rot_xyx.txt",lines)

# Generate 4-4 polyhedral group
M1 = [1 0 0;0 1 0;0 0 1]
M2 = [1 0 0;0 -1 0;0 0 -1]
M3 = [-1 0 0;0 1 0;0 0 -1]
M4 = [-1 0 0;0 -1 0;0 0 1]
M5 = [0 1 0;0 0 1;1 0 0]
M6 = [0 1 0;0 0 -1;-1 0 0]
M7 = [0 -1 0;0 0 1;-1 0 0]
M8 = [0 -1 0;0 0 -1;1 0 0]
M9 = [0 0 1;1 0 0;0 1 0]
M10 = [0 0 1;-1 0 0;0 -1 0]
M11 = [0 0 -1;1 0 0;0 -1 0]
M12 = [0 0 -1;-1 0 0;0 1 0]
Ms = [M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12]

Rs = RotMatrix3{Float64}.(Ms)

lines = ""
for R in Rs
    p = insideball(Rotations.params(MRP(R)))
    R_v = vec(Matrix(R))
    line = ""
    line *= "<$(string(p)[2:end-1])>,"
    lines *= line
    lines *= "\n"
end
print(lines)
write("003_mrp/08_mrp_4-4_/rot_4-4.txt",lines)

# Generate 6-8 polyhedral group
N = RotX(π/2)
Rs = RotMatrix3{Float64}[M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12,N*M1,N*M2,N*M3,N*M4,N*M5,N*M6,N*M7,N*M8,N*M9,N*M10,N*M11,N*M12]

lines = ""
for R in Rs
    p = insideball(Rotations.params(MRP(R)))
    R_v = vec(Matrix(R))
    line = ""
    line *= "<$(string(p)[2:end-1])>,"
    lines *= line
    lines *= "\n"
end
print(lines)
write("003_mrp/09_mrp_6-8_/rot_6-8.txt",lines)

# Generate 12-20 polyhedral group
φ = (1+√5)/2
V = [1,0,φ]
Qs = [AngleAxis(t, V...) for t in range(0,2π,length=6)[1:5]]
Rs = vec(RotMatrix3{Float64}[Q*M for Q in Qs, M in Ms])

lines = ""
for R in Rs
    p = insideball(Rotations.params(MRP(R)))
    R_v = vec(Matrix(R))
    line = ""
    line *= "<$(string(p)[2:end-1])>,"
    lines *= line
    lines *= "\n"
end
print(lines)
write("003_mrp/10_mrp_12-20_/rot_12-20.txt",lines)

[rad2deg(rotation_angle(R1/R2)) for R1 in Rs, R2 in Rs]

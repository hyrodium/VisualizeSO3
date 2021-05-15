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

# Generate MRP around xy-axis, as surface
ts = range(0,stop=2π,length=21)
# ts = range(0,stop=π,length=10)
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

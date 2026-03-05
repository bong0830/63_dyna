#!/usr/bin/env julia

using Printf

struct ModelParams
    plate_lx::Float64
    plate_ly::Float64
    plate_t::Float64
    punch_d::Float64
    die_d::Float64
    punch_x::Float64
    die_x::Float64
    punch_gap::Float64
    die_gap::Float64
    plate_nx::Int
    plate_ny::Int
    plate_nz::Int
    punch_ntheta::Int
    punch_ny::Int
    die_ntheta::Int
    die_ny::Int
    outdir::String
end

struct Node
    id::Int
    x::Float64
    y::Float64
    z::Float64
end

struct SolidElement
    id::Int
    pid::Int
    n1::Int
    n2::Int
    n3::Int
    n4::Int
    n5::Int
    n6::Int
    n7::Int
    n8::Int
end

struct ShellElement
    id::Int
    pid::Int
    n1::Int
    n2::Int
    n3::Int
    n4::Int
end

const PLATE_PID = 1
const PUNCH_PID = 2
const DIE_PID = 3

const PLATE_XSYM_SID = 10001
const PLATE_YSYM_SID = 10002
const PUNCH_ALL_SID = 20100
const PUNCH_YSYM_SID = 20002
const DIE_ALL_SID = 30100
const DIE_YSYM_SID = 30002

function parse_args(args::Vector{String})
    kv = Dict{String, String}()
    for a in args
        if occursin('=', a)
            k, v = split(a, "=", limit = 2)
            kv[strip(k)] = strip(v)
        else
            error("All arguments must be key=value. Invalid: $a")
        end
    end

    getf(key, default) = haskey(kv, key) ? parse(Float64, kv[key]) : default
    geti(key, default) = haskey(kv, key) ? parse(Int, kv[key]) : default
    gets(key, default) = haskey(kv, key) ? kv[key] : default

    die_d_default = haskey(kv, "die_opening_r") ? 2.0 * parse(Float64, kv["die_opening_r"]) : 70.0

    return ModelParams(
        getf("plate_lx", 300.0),
        getf("plate_ly", 300.0),
        getf("plate_t", 15.0),
        getf("punch_d", 45.0),
        getf("die_d", die_d_default),
        getf("punch_x", 0.0),
        getf("die_x", 70.0),
        getf("punch_gap", 0.2),
        getf("die_gap", 0.2),
        geti("plate_nx", 30),
        geti("plate_ny", 30),
        geti("plate_nz", 3),
        geti("punch_ntheta", geti("punch_n", 24)),
        geti("punch_ny", geti("tool_ny", 30)),
        geti("die_ntheta", geti("die_n", 24)),
        geti("die_ny", geti("tool_ny", 30)),
        gets("outdir", "kfiles_split"),
    )
end

function validate(p::ModelParams)
    p.plate_lx > 0 || error("plate_lx must be > 0")
    p.plate_ly > 0 || error("plate_ly must be > 0")
    p.plate_t > 0 || error("plate_t must be > 0")
    p.punch_d > 0 || error("punch_d must be > 0")
    p.die_d > 0 || error("die_d must be > 0")
    p.punch_x >= 0 || error("punch_x must be >= 0")
    p.die_x >= 0 || error("die_x must be >= 0")
    p.punch_gap >= 0 || error("punch_gap must be >= 0")
    p.die_gap >= 0 || error("die_gap must be >= 0")

    p.plate_nx >= 2 || error("plate_nx must be >= 2")
    p.plate_ny >= 2 || error("plate_ny must be >= 2")
    p.plate_nz >= 1 || error("plate_nz must be >= 1")

    p.punch_ntheta >= 4 || error("punch_ntheta must be >= 4")
    p.punch_ny >= 2 || error("punch_ny must be >= 2")
    p.die_ntheta >= 4 || error("die_ntheta must be >= 4")
    p.die_ny >= 2 || error("die_ny must be >= 2")

    half_lx = p.plate_lx / 2.0
    (p.punch_x + p.punch_d / 2.0) <= half_lx || error("punch_x + punch_radius must be <= plate_lx/2 for quarter model")
    (p.die_x + p.die_d / 2.0) <= half_lx || error("die_x + die_radius must be <= plate_lx/2 for quarter model")
    (p.die_x - p.die_d / 2.0) >= 0.0 || error("die_x - die_radius must be >= 0 for quarter model")
end

function generate_plate_mesh(p::ModelParams, node_start::Int, elem_start::Int)
    nx, ny, nz = p.plate_nx, p.plate_ny, p.plate_nz
    half_lx = p.plate_lx / 2.0
    half_ly = p.plate_ly / 2.0

    dx = half_lx / nx
    dy = half_ly / ny
    dz = p.plate_t / nz

    node_map = Array{Int}(undef, nx + 1, ny + 1, nz + 1)
    nodes = Node[]
    xsym_nodes = Int[]
    ysym_nodes = Int[]

    nid = node_start
    for k in 0:nz
        z = dz * k
        for j in 0:ny
            y = dy * j
            for i in 0:nx
                x = dx * i
                push!(nodes, Node(nid, x, y, z))
                node_map[i + 1, j + 1, k + 1] = nid
                if i == 0
                    push!(xsym_nodes, nid)
                end
                if j == 0
                    push!(ysym_nodes, nid)
                end
                nid += 1
            end
        end
    end

    solids = SolidElement[]
    eid = elem_start
    for k in 1:nz
        for j in 1:ny
            for i in 1:nx
                n1 = node_map[i, j, k]
                n2 = node_map[i + 1, j, k]
                n3 = node_map[i + 1, j + 1, k]
                n4 = node_map[i, j + 1, k]
                n5 = node_map[i, j, k + 1]
                n6 = node_map[i + 1, j, k + 1]
                n7 = node_map[i + 1, j + 1, k + 1]
                n8 = node_map[i, j + 1, k + 1]
                push!(solids, SolidElement(eid, PLATE_PID, n1, n2, n3, n4, n5, n6, n7, n8))
                eid += 1
            end
        end
    end

    return (
        nodes = nodes,
        solids = solids,
        xsym_nodes = xsym_nodes,
        ysym_nodes = ysym_nodes,
        all_node_ids = [n.id for n in nodes],
    )
end

function generate_cylinder_shell_y(
    radius::Float64,
    x_offset::Float64,
    ylen::Float64,
    ntheta::Int,
    ny::Int,
    z_centerline::Float64,
    pid::Int,
    node_start::Int,
    elem_start::Int;
    theta_start::Float64 = -pi / 2.0,
    theta_end::Float64 = pi / 2.0,
    flip_normal::Bool = false,
)
    node_map = Array{Int}(undef, ntheta + 1, ny + 1)
    nodes = Node[]
    xsym_nodes = Int[]
    ysym_nodes = Int[]
    tol = 1.0e-8
    nid = node_start

    for j in 0:ny
        y = ylen * j / ny
        for i in 0:ntheta
            theta = theta_start + (theta_end - theta_start) * i / ntheta
            x = x_offset + radius * cos(theta)
            z = z_centerline + radius * sin(theta)
            push!(nodes, Node(nid, x, y, z))
            node_map[i + 1, j + 1] = nid
            if abs(x) <= tol
                push!(xsym_nodes, nid)
            end
            if j == 0
                push!(ysym_nodes, nid)
            end
            nid += 1
        end
    end

    shells = ShellElement[]
    eid = elem_start
    for j in 1:ny
        for i in 1:ntheta
            n1 = node_map[i, j]
            n2 = node_map[i + 1, j]
            n3 = node_map[i + 1, j + 1]
            n4 = node_map[i, j + 1]
            if flip_normal
                push!(shells, ShellElement(eid, pid, n1, n4, n3, n2))
            else
                push!(shells, ShellElement(eid, pid, n1, n2, n3, n4))
            end
            eid += 1
        end
    end

    return (
        nodes = nodes,
        shells = shells,
        xsym_nodes = xsym_nodes,
        ysym_nodes = ysym_nodes,
        all_node_ids = [n.id for n in nodes],
    )
end

function write_nodes(io::IO, nodes::Vector{Node})
    println(io, "*NODE")
    for n in nodes
        @printf(io, "%d,%.6f,%.6f,%.6f\n", n.id, n.x, n.y, n.z)
    end
end

function write_solids(io::IO, elems::Vector{SolidElement})
    println(io, "*ELEMENT_SOLID")
    for e in elems
        @printf(io, "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n", e.id, e.pid, e.n1, e.n2, e.n3, e.n4, e.n5, e.n6, e.n7, e.n8)
    end
end

function write_shells(io::IO, elems::Vector{ShellElement})
    println(io, "*ELEMENT_SHELL")
    for e in elems
        @printf(io, "%d,%d,%d,%d,%d,%d\n", e.id, e.pid, e.n1, e.n2, e.n3, e.n4)
    end
end

function write_set_node_list(io::IO, sid::Int, node_ids::Vector{Int})
    isempty(node_ids) && return
    println(io, "*SET_NODE_LIST")
    println(io, sid)
    i = 1
    while i <= length(node_ids)
        j = min(i + 7, length(node_ids))
        println(io, join(node_ids[i:j], ","))
        i += 8
    end
end

function write_plate_mesh(
    path::String,
    plate_nodes::Vector{Node},
    plate_solids::Vector{SolidElement},
    xsym_nodes::Vector{Int},
    ysym_nodes::Vector{Int},
)
    open(path, "w") do io
        write_nodes(io, plate_nodes)
        write_solids(io, plate_solids)
        write_set_node_list(io, PLATE_XSYM_SID, xsym_nodes)
        write_set_node_list(io, PLATE_YSYM_SID, ysym_nodes)
    end
end

function write_tool_mesh(
    path::String,
    nodes::Vector{Node},
    shells::Vector{ShellElement},
    all_node_ids::Vector{Int},
    ysym_nodes::Vector{Int},
    all_sid::Int,
    ysym_sid::Int,
)
    open(path, "w") do io
        write_nodes(io, nodes)
        write_shells(io, shells)
        write_set_node_list(io, all_sid, all_node_ids)
        write_set_node_list(io, ysym_sid, ysym_nodes)
    end
end

function generate_mesh_files(p::ModelParams)
    mkpath(p.outdir)

    plate = generate_plate_mesh(p, 1, 1)

    yhalf = p.plate_ly / 2.0
    punch_r = p.punch_d / 2.0
    die_r = p.die_d / 2.0

    punch_centerline_z = p.plate_t + p.punch_gap + punch_r
    die_centerline_z = -p.die_gap - die_r

    punch = generate_cylinder_shell_y(
        punch_r,
        p.punch_x,
        yhalf,
        p.punch_ntheta,
        p.punch_ny,
        punch_centerline_z,
        PUNCH_PID,
        1_000_001,
        1_000_001;
        theta_start = -pi / 2.0,
        theta_end = 0.0,
        flip_normal = true,
    )

    die = generate_cylinder_shell_y(
        die_r,
        p.die_x,
        yhalf,
        p.die_ntheta,
        p.die_ny,
        die_centerline_z,
        DIE_PID,
        2_000_001,
        2_000_001;
        theta_start = pi / 2.0,
        theta_end = 1.0 * pi,
        flip_normal = false,
    )

    plate_path = joinpath(p.outdir, "10_plate_mesh.k")
    punch_path = joinpath(p.outdir, "20_punch_mesh.k")
    die_path = joinpath(p.outdir, "30_die_mesh.k")

    write_plate_mesh(plate_path, plate.nodes, plate.solids, plate.xsym_nodes, plate.ysym_nodes)
    write_tool_mesh(punch_path, punch.nodes, punch.shells, punch.all_node_ids, punch.ysym_nodes, PUNCH_ALL_SID, PUNCH_YSYM_SID)
    write_tool_mesh(die_path, die.nodes, die.shells, die.all_node_ids, die.ysym_nodes, DIE_ALL_SID, DIE_YSYM_SID)

    println("Mesh files written:")
    println("- $(abspath(plate_path))")
    println("- $(abspath(punch_path))")
    println("- $(abspath(die_path))")
    println("Counts: plate solids=$(length(plate.solids)), punch shells=$(length(punch.shells)), die shells=$(length(die.shells))")
end

function main()
    p = parse_args(ARGS)
    validate(p)
    generate_mesh_files(p)
end

main()

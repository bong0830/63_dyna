#!/usr/bin/env julia

struct MainParams
    outdir::String
    title::String
    t_end::Float64
    punch_disp_down::Float64
    punch_down_ratio::Float64
    punch_hold_ratio::Float64
    punch_final_disp::Float64
    d3plot_dt::Float64
    fs::Float64
    fd::Float64
    plate_rho::Float64
    plate_e::Float64
    plate_nu::Float64
    plate_sigy::Float64
    plate_etan::Float64
    plate_beta::Float64
    tool_rho::Float64
    tool_e::Float64
    tool_nu::Float64
    tool_shell_t::Float64
    tool_rigid::Bool
    mass_scaling_dt::Float64
    plate_xsym_sid::Int
    plate_ysym_sid::Int
    punch_all_sid::Int
    die_all_sid::Int
end

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

    gets(key, default) = haskey(kv, key) ? kv[key] : default
    getf(key, default) = haskey(kv, key) ? parse(Float64, kv[key]) : default
    geti(key, default) = haskey(kv, key) ? parse(Int, kv[key]) : default
    function getbool(key, default)
        raw = lowercase(strip(gets(key, default ? "true" : "false")))
        raw in ("1", "true", "yes", "y", "on") && return true
        raw in ("0", "false", "no", "n", "off") && return false
        error("$key must be one of true/false/1/0/yes/no. Got: $(gets(key, ""))")
    end

    return MainParams(
        gets("outdir", "kfiles_split"),
        gets("title", "Quarter model edge bending with y-axis cylinder punch"),
        getf("t_end", 0.010),
        getf("punch_disp_down", -6.0),
        getf("punch_down_ratio", 0.5),
        getf("punch_hold_ratio", 0.0),
        getf("punch_final_disp", 0.0),
        getf("d3plot_dt", 1.0e-4),
        getf("fs", 0.10),
        getf("fd", 0.08),
        getf("plate_rho", 7.85e-9),
        getf("plate_e", 210000.0),
        getf("plate_nu", 0.30),
        getf("plate_sigy", 350.0),
        getf("plate_etan", 1200.0),
        getf("plate_beta", 0.0),
        getf("tool_rho", 7.85e-9),
        getf("tool_e", 2.10e8),
        getf("tool_nu", 0.30),
        getf("tool_shell_t", 2.0),
        getbool("tool_rigid", false),
        getf("mass_scaling_dt", 0.0),
        geti("plate_xsym_sid", 10001),
        geti("plate_ysym_sid", 10002),
        geti("punch_all_sid", 20100),
        geti("die_all_sid", 30100),
    )
end

function write_contact_pair(io::IO, ssid::Int, msid::Int, fs::Float64, fd::Float64)
    println(io, "*CONTACT_AUTOMATIC_SURFACE_TO_SURFACE")
    println(io, "$(ssid),$(msid),2,2,0,0,0,0")
    println(io, "$(fs),$(fd),0.0,0.0,0.0,0,0.0,0.0")
    println(io, "1.0,1.0,0.0,0.0,1.0,1.0,1.0,1.0")
    println(io, "1,0.1,0,0,0,2,0,1")
    println(io, "0.0,0,0,0,0")
end

function write_tool_material(io::IO, mid::Int, p::MainParams)
    if p.tool_rigid
        println(io, "*MAT_RIGID")
        println(io, "$(mid),$(p.tool_rho),$(p.tool_e),$(p.tool_nu)")
        println(io, "0,0,0")
        println(io)
    else
        println(io, "*MAT_ELASTIC")
        println(io, "$(mid),$(p.tool_rho),$(p.tool_e),$(p.tool_nu)")
    end
end

function write_tool_boundaries(io::IO, p::MainParams)
    println(io, "*BOUNDARY_SPC_SET")
    if !p.tool_rigid
        println(io, "$(p.die_all_sid),0,1,1,1,1,1,1")
        println(io, "$(p.punch_all_sid),0,1,1,0,1,1,1")
    end
    println(io, "$(p.plate_xsym_sid),0,1,0,0,0,0,0")
    println(io, "$(p.plate_ysym_sid),0,0,1,0,0,0,0")

    if p.tool_rigid
        zero_curve_id = 2
        for dof in (1, 2, 3, 5, 6, 7)
            println(io, "*BOUNDARY_PRESCRIBED_MOTION_RIGID")
            println(io, "3,$dof,2,$zero_curve_id,1.0,0,1.0e28,0.0")
        end

        for dof in (1, 2, 5, 6, 7)
            println(io, "*BOUNDARY_PRESCRIBED_MOTION_RIGID")
            println(io, "2,$dof,2,$zero_curve_id,1.0,0,1.0e28,0.0")
        end
        println(io, "*BOUNDARY_PRESCRIBED_MOTION_RIGID")
        println(io, "2,3,2,1,1.0,0,1.0e28,0.0")
    else
        println(io, "*BOUNDARY_PRESCRIBED_MOTION_SET")
        println(io, "$(p.punch_all_sid),3,2,1,1.0,0,0.0,0.0")
    end
end

function write_main_kfile(path::String, p::MainParams)
    t_down = max(1.0e-8, min(p.t_end - 1.0e-8, p.t_end * p.punch_down_ratio))
    hold_duration = max(0.0, p.t_end * p.punch_hold_ratio)
    t_hold_end = max(t_down, min(p.t_end, t_down + hold_duration))

    open(path, "w") do io
        println(io, "*KEYWORD")
        println(io, "*TITLE")
        println(io, p.title)

        println(io, "*SECTION_SOLID")
        println(io, "1,1")
        println(io, "*SECTION_SHELL")
        println(io, "2,2,0.8333,5")
        println(io, "$(p.tool_shell_t),$(p.tool_shell_t),$(p.tool_shell_t),$(p.tool_shell_t)")

        println(io, "*MAT_PLASTIC_KINEMATIC")
        println(io, "1,$(p.plate_rho),$(p.plate_e),$(p.plate_nu),$(p.plate_sigy),$(p.plate_etan),$(p.plate_beta)")
        println(io, "0,0,0,0,0,0,0,0")
        write_tool_material(io, 2, p)
        write_tool_material(io, 3, p)

        println(io, "*PART")
        println(io, "Plate")
        println(io, "1,1,1,0,0,0,0,0")
        println(io, "*PART")
        println(io, "Punch_Rigid_YAxisCylinder")
        println(io, "2,2,2,0,0,0,0,0")
        println(io, "*PART")
        println(io, "Die_Rigid_YAxisCylinder")
        println(io, "3,2,3,0,0,0,0,0")

        println(io, "*INCLUDE")
        println(io, "10_plate_mesh.k")
        println(io, "*INCLUDE")
        println(io, "20_punch_mesh.k")
        println(io, "*INCLUDE")
        println(io, "30_die_mesh.k")

        println(io, "*SET_PART_LIST")
        println(io, "1001")
        println(io, "1")
        println(io, "*SET_PART_LIST")
        println(io, "1002")
        println(io, "2")
        println(io, "*SET_PART_LIST")
        println(io, "1003")
        println(io, "3")

        write_contact_pair(io, 1001, 1002, p.fs, p.fd)
        write_contact_pair(io, 1001, 1003, p.fs, p.fd)

        println(io, "*DEFINE_CURVE")
        println(io, "1")
        println(io, "0.0,0.0")
        println(io, "$(t_down),$(p.punch_disp_down)")
        if t_hold_end > t_down
            println(io, "$(t_hold_end),$(p.punch_disp_down)")
        end
        println(io, "$(p.t_end),$(p.punch_final_disp)")
        println(io, "*DEFINE_CURVE")
        println(io, "2")
        println(io, "0.0,0.0")
        println(io, "$(p.t_end),0.0")

        write_tool_boundaries(io, p)

        if p.mass_scaling_dt > 0.0
            println(io, "*CONTROL_TIMESTEP")
            println(io, "0.0,0.9,0,0.0,-$(p.mass_scaling_dt),0,0,0")
        end

        println(io, "*CONTROL_TERMINATION")
        println(io, p.t_end)
        println(io, "*DATABASE_BINARY_D3PLOT")
        println(io, p.d3plot_dt)
        println(io, "*END")
    end
end

function main()
    p = parse_args(ARGS)
    mkpath(p.outdir)
    main_path = joinpath(p.outdir, "00_main.k")
    write_main_kfile(main_path, p)
    println("Main file written:")
    println("- $(abspath(main_path))")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end





#!/usr/bin/env julia

using Printf

struct MainParams
    outdir::String
    title::String
    t_end::Float64
    history_node_ids::Vector{Int}
    punch_control_mode::String
    punch_disp_down::Float64
    punch_press_speed::Float64
    punch_release_speed::Float64
    punch_hold_time::Float64
    punch_press_time::Float64
    punch_release_time::Float64
    punch_down_ratio::Float64
    punch_hold_ratio::Float64
    punch_final_disp::Float64
    punch_force_peak::Float64
    punch_force_final::Float64
    d3plot_dt::Float64
    ascii_dt::Float64
    fs::Float64
    fd::Float64
    plate_rho::Float64
    plate_e::Float64
    plate_nu::Float64
    plate_sigy::Float64
    plate_etan::Float64
    plate_beta::Float64
    plate_src::Float64
    plate_srp::Float64
    plate_fs::Float64
    plate_vp::Float64
    plate_elform::Int
    gravity_z::Float64
    punch_rho::Float64
    punch_e::Float64
    punch_nu::Float64
    punch_rigid::Bool
    die_rho::Float64
    die_e::Float64
    die_nu::Float64
    die_rigid::Bool
    tool_shell_t::Float64
    mass_scaling_dt::Float64
    plate_xsym_sid::Int
    plate_ysym_sid::Int
    punch_all_sid::Int
    die_all_sid::Int
end

fmt(value::Real) = @sprintf("%.6g", Float64(value))

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
    function getints(key, default::Vector{Int})
        raw = strip(gets(key, ""))
        isempty(raw) && return default
        values = Int[]
        for item in split(raw, ",")
            stripped = strip(item)
            isempty(stripped) || push!(values, parse(Int, stripped))
        end
        isempty(values) && return default
        return values
    end
    function getmode(key, default)
        raw = lowercase(strip(gets(key, default)))
        raw in ("disp", "displacement", "motion") && return "disp"
        raw in ("force", "load") && return "force"
        error("$key must be one of disp/displacement/force/load. Got: $(gets(key, ""))")
    end
    function getbool(key, default)
        raw = lowercase(strip(gets(key, default ? "true" : "false")))
        raw in ("1", "true", "yes", "y", "on") && return true
        raw in ("0", "false", "no", "n", "off") && return false
        error("$key must be one of true/false/1/0/yes/no. Got: $(gets(key, ""))")
    end
    getffallback(key, fallback_key, default) = haskey(kv, key) ? parse(Float64, kv[key]) : getf(fallback_key, default)
    getboolfallback(key, fallback_key, default) = haskey(kv, key) ? getbool(key, default) : getbool(fallback_key, default)

    return MainParams(
        gets("outdir", "kfiles_split"),
        gets("title", "Quarter model edge bending with y-axis cylinder punch"),
        getf("t_end", 0.010),
        getints("history_node_ids", [1_000_001]),
        getmode("punch_control_mode", "disp"),
        getf("punch_disp_down", -12.0),
        getf("punch_press_speed", 1.0),
        getf("punch_release_speed", 1.0),
        getf("punch_hold_time", 0.8),
        getf("punch_press_time", 0.0),
        getf("punch_release_time", 0.0),
        getf("punch_down_ratio", 0.5),
        getf("punch_hold_ratio", 0.0),
        getf("punch_final_disp", 0.0),
        getf("punch_force_peak", -100.0),
        getf("punch_force_final", 0.0),
        getf("d3plot_dt", 1.0e-4),
        getf("ascii_dt", 1.0e-4),
        getf("fs", 0.10),
        getf("fd", 0.08),
        getf("plate_rho", 7.85e-9),
        getf("plate_e", 205000.0),
        getf("plate_nu", 0.28),
        getf("plate_sigy", 245.0),
        getf("plate_etan", 1500.0),
        getf("plate_beta", 1.0),
        getf("plate_src", 40.4),
        getf("plate_srp", 5.0),
        getf("plate_fs", 0.0),
        getf("plate_vp", 0.0),
        geti("plate_elform", 2),
        getf("gravity_z", 0.0),
        getffallback("punch_rho", "tool_rho", 7.85e-9),
        getffallback("punch_e", "tool_e", 2.10e8),
        getffallback("punch_nu", "tool_nu", 0.30),
        getboolfallback("punch_rigid", "tool_rigid", false),
        getffallback("die_rho", "tool_rho", 7.85e-9),
        getffallback("die_e", "tool_e", 2.10e8),
        getffallback("die_nu", "tool_nu", 0.30),
        getboolfallback("die_rigid", "tool_rigid", false),
        getf("tool_shell_t", 2.0),
        getf("mass_scaling_dt", 0.0),
        geti("plate_xsym_sid", 10001),
        geti("plate_ysym_sid", 10002),
        geti("punch_all_sid", 20100),
        geti("die_all_sid", 30100),
    )
end

function validate(p::MainParams)
    p.t_end > 0.0 || error("t_end must be > 0")
    p.d3plot_dt > 0.0 || error("d3plot_dt must be > 0")
    p.ascii_dt > 0.0 || error("ascii_dt must be > 0")
    isempty(p.history_node_ids) && error("history_node_ids must not be empty")
    p.punch_press_speed >= 0.0 || error("punch_press_speed must be >= 0")
    p.punch_release_speed >= 0.0 || error("punch_release_speed must be >= 0")
    p.punch_hold_time >= 0.0 || error("punch_hold_time must be >= 0")
    p.punch_press_time >= 0.0 || error("punch_press_time must be >= 0")
    p.punch_release_time >= 0.0 || error("punch_release_time must be >= 0")
    p.plate_elform in (1, 2) || error("plate_elform must be 1 (reduced) or 2 (full integration)")
    p.punch_e > 0.0 || error("punch_e must be > 0")
    p.die_e > 0.0 || error("die_e must be > 0")
    p.punch_rho > 0.0 || error("punch_rho must be > 0")
    p.die_rho > 0.0 || error("die_rho must be > 0")
end

function write_contact_pair(io::IO, ssid::Int, msid::Int, fs::Float64, fd::Float64)
    println(io, "*CONTACT_AUTOMATIC_SURFACE_TO_SURFACE")
    println(io, "$(ssid),$(msid),2,2,0,0,0,0")
    println(io, "$(fs),$(fd),0.0,0.0,0.0,0,0.0,0.0")
    println(io, "1.0,1.0,0.0,0.0,1.0,1.0,1.0,1.0")
    println(io, "1,0.1,0,0,0,2,0,1")
    println(io, "0.0,0,0,0,0")
end

function write_tool_material(io::IO, mid::Int, rigid::Bool, rho::Float64, e::Float64, nu::Float64)
    if rigid
        println(io, "*MAT_RIGID")
        println(io, "$(mid),$(rho),$(e),$(nu)")
        println(io, "0,0,0")
        println(io)
    else
        println(io, "*MAT_ELASTIC")
        println(io, "$(mid),$(rho),$(e),$(nu)")
    end
end

function write_rigid_zero_motion(io::IO, pid::Int, dof::Int, curve_id::Int)
    println(io, "*BOUNDARY_PRESCRIBED_MOTION_RIGID")
    println(io, "$pid,$dof,2,$curve_id,1.0,0,1.0e28,0.0")
end

function write_tool_boundaries(io::IO, p::MainParams)
    println(io, "*BOUNDARY_SPC_SET")
    if !p.die_rigid
        println(io, "$(p.die_all_sid),0,1,1,1,1,1,1")
    end
    if !p.punch_rigid
        println(io, "$(p.punch_all_sid),0,1,1,0,1,1,1")
    end
    println(io, "$(p.plate_xsym_sid),0,1,0,0,0,0,0")
    println(io, "$(p.plate_ysym_sid),0,0,1,0,0,0,0")

    zero_curve_id = 2
    if p.die_rigid
        for dof in (1, 2, 3, 5, 6, 7)
            write_rigid_zero_motion(io, 3, dof, zero_curve_id)
        end
    end

    if p.punch_rigid
        for dof in (1, 2, 5, 6, 7)
            write_rigid_zero_motion(io, 2, dof, zero_curve_id)
        end
        if p.punch_control_mode == "disp"
            println(io, "*BOUNDARY_PRESCRIBED_MOTION_RIGID")
            println(io, "2,3,2,1,1.0,0,1.0e28,0.0")
        end
    elseif p.punch_control_mode == "disp"
        println(io, "*BOUNDARY_PRESCRIBED_MOTION_SET")
        println(io, "$(p.punch_all_sid),3,2,1,1.0,0,0.0,0.0")
    end
end

function write_curve(io::IO, cid::Int, t_down::Float64, t_hold_end::Float64, t_end::Float64, peak::Float64, final::Float64)
    tol = 1.0e-12
    println(io, "*DEFINE_CURVE")
    println(io, cid)
    println(io, "0.0,0.0")
    println(io, "$(fmt(t_down)),$(fmt(peak))")
    if t_hold_end > t_down + tol && t_hold_end < t_end - tol
        println(io, "$(fmt(t_hold_end)),$(fmt(peak))")
    end
    if t_end > t_down + tol || abs(final - peak) > tol
        println(io, "$(fmt(t_end)),$(fmt(final))")
    end
end

function write_history_nodes(io::IO, node_ids::Vector{Int})
    println(io, "*DATABASE_HISTORY_NODE")
    for nid in node_ids
        println(io, nid)
    end
end

function count_set_nodes(path::String, sid::Int)
    isfile(path) || error("Punch mesh file not found for force loading: $path")
    lines = readlines(path)
    target = string(sid)
    state = 0
    count = 0

    for line in lines
        stripped = strip(line)
        isempty(stripped) && continue

        if startswith(stripped, "*")
            if state == 2
                break
            end
            state = stripped == "*SET_NODE_LIST" ? 1 : 0
            continue
        end

        if state == 1 && stripped == target
            state = 2
            continue
        elseif state == 2
            count += length(split(replace(stripped, "," => " ")))
        end
    end

    count > 0 || error("Node set $sid was not found or is empty in $path")
    return count
end

function resolve_motion_schedule(p::MainParams)
    tol = 1.0e-12

    if p.punch_press_time > tol || p.punch_release_time > tol || p.punch_hold_time > tol
        press_duration = if p.punch_press_time > tol
            p.punch_press_time
        elseif p.punch_control_mode == "disp" && p.punch_press_speed > tol
            abs(p.punch_disp_down) / p.punch_press_speed
        else
            max(1.0e-8, min(p.t_end - 1.0e-8, p.t_end * p.punch_down_ratio))
        end
        hold_duration = p.punch_hold_time > tol ? p.punch_hold_time : max(0.0, p.t_end * p.punch_hold_ratio)
        release_duration = if p.punch_release_time > tol
            p.punch_release_time
        elseif p.punch_control_mode == "disp"
            disp_delta_release = abs(p.punch_final_disp - p.punch_disp_down)
            if disp_delta_release <= tol
                0.0
            elseif p.punch_release_speed > tol
                disp_delta_release / p.punch_release_speed
            else
                max(0.0, p.t_end - (press_duration + hold_duration))
            end
        else
            max(0.0, p.t_end - (press_duration + hold_duration))
        end

        t_down = max(1.0e-8, press_duration)
        t_hold_end = t_down + hold_duration
        t_end_curve = max(t_hold_end, t_hold_end + release_duration)
        return (t_end_curve = t_end_curve, t_down = t_down, t_hold_end = t_hold_end)
    end

    if p.punch_control_mode == "disp" && (p.punch_press_speed > tol || p.punch_release_speed > tol)
        press_duration = p.punch_press_speed > tol ? abs(p.punch_disp_down) / p.punch_press_speed : max(1.0e-8, min(p.t_end - 1.0e-8, p.t_end * p.punch_down_ratio))
        hold_duration = max(0.0, p.t_end * p.punch_hold_ratio)
        disp_delta_release = abs(p.punch_final_disp - p.punch_disp_down)
        release_duration = if disp_delta_release <= tol
            0.0
        elseif p.punch_release_speed > tol
            disp_delta_release / p.punch_release_speed
        else
            max(0.0, p.t_end - (press_duration + hold_duration))
        end

        t_down = max(1.0e-8, press_duration)
        t_hold_end = t_down + hold_duration
        t_end_curve = max(t_hold_end, t_hold_end + release_duration)
        return (t_end_curve = t_end_curve, t_down = t_down, t_hold_end = t_hold_end)
    end

    t_down = max(1.0e-8, min(p.t_end - 1.0e-8, p.t_end * p.punch_down_ratio))
    hold_duration = max(0.0, p.t_end * p.punch_hold_ratio)
    t_hold_end = max(t_down, min(p.t_end, t_down + hold_duration))
    return (t_end_curve = p.t_end, t_down = t_down, t_hold_end = t_hold_end)
end

function write_main_kfile(path::String, p::MainParams)
    motion = resolve_motion_schedule(p)
    t_end_curve = motion.t_end_curve
    t_down = motion.t_down
    t_hold_end = motion.t_hold_end

    open(path, "w") do io
        println(io, "*KEYWORD")
        println(io, "*TITLE")
        println(io, p.title)

        println(io, "*SECTION_SOLID")
        println(io, "1,$(p.plate_elform)")
        println(io, "*SECTION_SHELL")
        println(io, "2,2,0.8333,5")
        println(io, "$(p.tool_shell_t),$(p.tool_shell_t),$(p.tool_shell_t),$(p.tool_shell_t)")

        println(io, "*MAT_PLASTIC_KINEMATIC")
        println(io, "1,$(fmt(p.plate_rho)),$(fmt(p.plate_e)),$(fmt(p.plate_nu)),$(fmt(p.plate_sigy)),$(fmt(p.plate_etan)),$(fmt(p.plate_beta))")
        println(io, "$(fmt(p.plate_src)),$(fmt(p.plate_srp)),$(fmt(p.plate_fs)),$(fmt(p.plate_vp))")
        write_tool_material(io, 2, p.punch_rigid, p.punch_rho, p.punch_e, p.punch_nu)
        write_tool_material(io, 3, p.die_rigid, p.die_rho, p.die_e, p.die_nu)

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

        if p.punch_control_mode == "force"
            write_curve(io, 1, t_down, t_hold_end, t_end_curve, p.punch_force_peak, p.punch_force_final)
        else
            write_curve(io, 1, t_down, t_hold_end, t_end_curve, p.punch_disp_down, p.punch_final_disp)
        end
        write_curve(io, 2, t_down, t_down, t_end_curve, 0.0, 0.0)

        write_tool_boundaries(io, p)

        if p.punch_control_mode == "force"
            if p.punch_rigid
                println(io, "*LOAD_RIGID_BODY")
                println(io, "2,3,1,1.0,0")
            else
                punch_mesh_path = joinpath(dirname(path), "20_punch_mesh.k")
                punch_node_count = count_set_nodes(punch_mesh_path, p.punch_all_sid)
                println(io, "*LOAD_NODE_SET")
                println(io, "$(p.punch_all_sid),3,1,$(@sprintf("%.6g", 1.0 / punch_node_count))")
            end
        end

        if abs(p.gravity_z) > 0.0
            write_curve(io, 3, t_down, t_end_curve, t_end_curve, 1.0, 1.0)
            println(io, "*LOAD_BODY_Z")
            println(io, "3,$(p.gravity_z)")
        end

        if p.mass_scaling_dt > 0.0
            println(io, "*CONTROL_TIMESTEP")
            println(io, "0.0,0.9,0,0.0,-$(fmt(p.mass_scaling_dt)),0,0,0")
        end

        println(io, "*CONTROL_TERMINATION")
        println(io, fmt(t_end_curve))
        println(io, "*DATABASE_GLSTAT")
        println(io, fmt(p.ascii_dt))
        println(io, "*DATABASE_MATSUM")
        println(io, fmt(p.ascii_dt))
        println(io, "*DATABASE_RCFORC")
        println(io, fmt(p.ascii_dt))
        println(io, "*DATABASE_NODOUT")
        println(io, fmt(p.ascii_dt))
        write_history_nodes(io, p.history_node_ids)
        println(io, "*DATABASE_BINARY_D3PLOT")
        println(io, fmt(p.d3plot_dt))
        println(io, "*END")
    end
end

function main()
    p = parse_args(ARGS)
    validate(p)
    mkpath(p.outdir)
    main_path = joinpath(p.outdir, "00_main.k")
    write_main_kfile(main_path, p)
    println("Main file written:")
    println("- $(abspath(main_path))")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end




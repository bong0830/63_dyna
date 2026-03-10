#!/usr/bin/env julia

using Printf

const ROOT = @__DIR__
const MESH_SCRIPT_DIR = joinpath(ROOT, "study_scripts", "mesh_convergence")
const PARAM_SCRIPT_DIR = joinpath(ROOT, "study_scripts", "param_study")
const PLAN_DIR = joinpath(ROOT, "study_plans")

const BASE_OVERRIDES = Pair{String,String}[
    "run"=>"false",
    "allow_existing"=>"true",
    "cases_root"=>"cases",
    "manifest_path"=>"cases/case_manifest.csv",
    "punch_control_mode"=>"disp",
    "punch_hold_time"=>"0.2",
    "punch_press_time"=>"0.0",
    "punch_release_time"=>"0.0",
    "punch_release_speed"=>"0.0",
    "punch_gap"=>"0.2",
    "tool_shell_t"=>"2.0",
    "mass_scaling_dt"=>"5e-06",
    "gravity_z"=>"0.0",
    "ncpu"=>"30",
    "memory"=>"50g",
]

const MESH_LEVELS = [
    (case_no=1, tag="m01", plate_nx=10, plate_ny=10, plate_nz=1, punch_ntheta=16, punch_ny=16, die_ntheta=16, die_ny=16),
    (case_no=2, tag="m02", plate_nx=14, plate_ny=14, plate_nz=1, punch_ntheta=20, punch_ny=20, die_ntheta=20, die_ny=20),
    (case_no=3, tag="m03", plate_nx=18, plate_ny=18, plate_nz=2, punch_ntheta=24, punch_ny=24, die_ntheta=24, die_ny=24),
    (case_no=4, tag="m04", plate_nx=24, plate_ny=24, plate_nz=2, punch_ntheta=28, punch_ny=28, die_ntheta=28, die_ny=28),
    (case_no=5, tag="m05", plate_nx=30, plate_ny=30, plate_nz=3, punch_ntheta=32, punch_ny=30, die_ntheta=32, die_ny=30),
    (case_no=6, tag="m06", plate_nx=36, plate_ny=36, plate_nz=4, punch_ntheta=36, punch_ny=36, die_ntheta=36, die_ny=36),
    (case_no=7, tag="m07", plate_nx=20, plate_ny=20, plate_nz=2, punch_ntheta=24, punch_ny=24, die_ntheta=24, die_ny=24),
    (case_no=8, tag="m08", plate_nx=20, plate_ny=20, plate_nz=3, punch_ntheta=24, punch_ny=24, die_ntheta=24, die_ny=24),
    (case_no=9, tag="m09", plate_nx=30, plate_ny=30, plate_nz=3, punch_ntheta=32, punch_ny=32, die_ntheta=32, die_ny=32),
    (case_no=10, tag="m10", plate_nx=20, plate_ny=20, plate_nz=4, punch_ntheta=24, punch_ny=24, die_ntheta=24, die_ny=24),
    (case_no=11, tag="m11", plate_nx=30, plate_ny=30, plate_nz=4, punch_ntheta=32, punch_ny=32, die_ntheta=32, die_ny=32),
]

const SELECTED_STUDY_MESH_INDEX = 4
const DIE_GAPS = [0.2, 1.0, 2.0, 4.0, 6.0]
const PUNCH_DEPTHS = [-8.0, -12.0, -16.0, -20.0, -24.0]
const PUNCH_SPEEDS = [1.0, 2.0, 4.0, 8.0]

fmt_num(value::Real) = @sprintf("%.6g", Float64(value))
fmt_case_no(value::Int) = @sprintf("%03d", value)

function parse_kv_args(args::Vector{String})
    kv = Dict{String,String}()
    for arg in args
        occursin('=', arg) || error("All arguments must be key=value. Invalid: $arg")
        key, value = split(arg, "=", limit=2)
        kv[strip(key)] = strip(value)
    end
    return kv
end

function get_mesh_level(tag::String)
    for mesh in MESH_LEVELS
        mesh.tag == tag && return mesh
    end
    error("Unknown mesh tag: $tag. Available tags: " * join(getfield.(MESH_LEVELS, :tag), ", "))
end

function csv_escape(value::AbstractString)
    text = String(value)
    escaped = replace(text, "\"" => "\"\"")
    if occursin(',', escaped) || occursin('"', escaped) || occursin('\n', escaped) || occursin('\r', escaped)
        return "\"$escaped\""
    end
    return escaped
end

function build_press_case_params(;
    case_name::String,
    case_version::String,
    mesh,
    die_gap::Real,
    punch_disp_down::Real,
    punch_speed::Real,
)
    press_time = abs(punch_disp_down) / punch_speed
    t_end = press_time + 0.2

    return Pair{String,String}[
        "case_name"=>case_name,
        "case_version"=>case_version,
        "case_keys"=>"die_gap,punch_disp_down,punch_press_speed",
        "die_gap"=>fmt_num(die_gap),
        "punch_disp_down"=>fmt_num(punch_disp_down),
        "punch_press_speed"=>fmt_num(punch_speed),
        "punch_final_disp"=>fmt_num(punch_disp_down),
        "t_end"=>fmt_num(t_end),
        "plate_nx"=>string(mesh.plate_nx),
        "plate_ny"=>string(mesh.plate_ny),
        "plate_nz"=>string(mesh.plate_nz),
        "punch_ntheta"=>string(mesh.punch_ntheta),
        "punch_ny"=>string(mesh.punch_ny),
        "die_ntheta"=>string(mesh.die_ntheta),
        "die_ny"=>string(mesh.die_ny),
    ]
end

function write_case_script(path::String, params::Vector{Pair{String,String}})
    mkpath(dirname(path))
    open(path, "w") do io
        println(io, "#!/usr/bin/env julia")
        println(io)
        println(io, "include(joinpath(@__DIR__, \"..\", \"..\", \"user_make_case.jl\"))")
        println(io)
        println(io, "run_user_case([")
        for (key, value) in params
            println(io, "    \"$(key)=$(value)\",")
        end
        println(io, "])")
    end
end

function write_plan_csv(path::String, header::Vector{String}, rows::Vector{Vector{String}})
    mkpath(dirname(path))
    candidate_paths = [path]
    base, ext = splitext(path)
    push!(candidate_paths, base * "_generated" * ext)

    last_error = nothing
    for candidate in candidate_paths
        try
            open(candidate, "w") do io
                println(io, join(header, ","))
                for row in rows
                    println(io, join(csv_escape.(row), ","))
                end
            end
            return candidate
        catch err
            last_error = err
        end
    end

    throw(last_error)
end

function generate_mesh_convergence_cases()
    rows = Vector{Vector{String}}()
    for mesh in MESH_LEVELS
        script_no = fmt_case_no(mesh.case_no)
        case_name = "meshconv_" * script_no
        script_name = "meshconv_case_" * script_no * ".jl"
        params = vcat(
            BASE_OVERRIDES,
            build_press_case_params(
                case_name=case_name,
                case_version="v" * script_no,
                mesh=mesh,
                die_gap=0.2,
                punch_disp_down=-12.0,
                punch_speed=2.0,
            ),
        )
        write_case_script(joinpath(MESH_SCRIPT_DIR, script_name), params)

        push!(rows, [
            script_no,
            script_name,
            case_name,
            mesh.tag,
            string(mesh.plate_nx),
            string(mesh.plate_ny),
            string(mesh.plate_nz),
            string(mesh.punch_ntheta),
            string(mesh.punch_ny),
            string(mesh.die_ntheta),
            string(mesh.die_ny),
            "0.2",
            "-12.0",
            "2.0",
        ])
    end

    write_plan_csv(
        joinpath(PLAN_DIR, "mesh_convergence_plan.csv"),
        ["script_no", "script_name", "case_name", "mesh_tag", "plate_nx", "plate_ny", "plate_nz", "punch_ntheta", "punch_ny", "die_ntheta", "die_ny", "die_gap", "punch_disp_down", "punch_speed"],
        rows,
    )
end

function generate_parameter_study_cases(selected_mesh_tag::String)
    selected_mesh = get_mesh_level(selected_mesh_tag)
    rows = Vector{Vector{String}}()
    case_no = 1

    for die_gap in DIE_GAPS
        for punch_disp_down in PUNCH_DEPTHS
            for punch_speed in PUNCH_SPEEDS
                script_no = fmt_case_no(case_no)
                case_name = "study_" * script_no
                script_name = "study_case_" * script_no * ".jl"
                params = vcat(
                    BASE_OVERRIDES,
                    build_press_case_params(
                        case_name=case_name,
                        case_version="v" * script_no,
                        mesh=selected_mesh,
                        die_gap=die_gap,
                        punch_disp_down=punch_disp_down,
                        punch_speed=punch_speed,
                    ),
                )
                write_case_script(joinpath(PARAM_SCRIPT_DIR, script_name), params)

                push!(rows, [
                    script_no,
                    script_name,
                    case_name,
                    selected_mesh.tag,
                    string(selected_mesh.plate_nx),
                    string(selected_mesh.plate_ny),
                    string(selected_mesh.plate_nz),
                    string(selected_mesh.punch_ntheta),
                    string(selected_mesh.punch_ny),
                    string(selected_mesh.die_ntheta),
                    string(selected_mesh.die_ny),
                    fmt_num(die_gap),
                    fmt_num(punch_disp_down),
                    fmt_num(punch_speed),
                ])
                case_no += 1
            end
        end
    end

    write_plan_csv(
        joinpath(PLAN_DIR, "parameter_study_plan.csv"),
        ["script_no", "script_name", "case_name", "selected_mesh_tag", "plate_nx", "plate_ny", "plate_nz", "punch_ntheta", "punch_ny", "die_ntheta", "die_ny", "die_gap", "punch_disp_down", "punch_speed"],
        rows,
    )
end

function main(args::Vector{String}=ARGS)
    kv = parse_kv_args(args)
    mode = lowercase(get(kv, "mode", "mesh"))
    selected_mesh_tag = get(kv, "selected_mesh", MESH_LEVELS[SELECTED_STUDY_MESH_INDEX].tag)

    if mode in ("mesh", "convergence")
        generate_mesh_convergence_cases()
        println("Generated mesh convergence scripts:")
        println("- " * MESH_SCRIPT_DIR)
        println("Generated convergence plan:")
        println("- " * joinpath(PLAN_DIR, "mesh_convergence_plan.csv"))
        println("Mesh convergence case count: " * string(length(MESH_LEVELS)))
        println("Next step: run meshconv cases, summarize results, then call mode=study selected_mesh=<tag>.")
        return
    end

    if mode in ("study", "parameter", "param")
        generate_parameter_study_cases(selected_mesh_tag)
        println("Generated parameter study scripts:")
        println("- " * PARAM_SCRIPT_DIR)
        println("Generated parameter study plan:")
        println("- " * joinpath(PLAN_DIR, "parameter_study_plan.csv"))
        println("Parameter study case count: " * string(length(DIE_GAPS) * length(PUNCH_DEPTHS) * length(PUNCH_SPEEDS)))
        println("Selected study mesh tag: " * selected_mesh_tag)
        return
    end

    if mode == "all"
        generate_mesh_convergence_cases()
        generate_parameter_study_cases(selected_mesh_tag)
        println("Generated both mesh convergence and parameter study scripts.")
        println("Selected study mesh tag: " * selected_mesh_tag)
        return
    end

    error("mode must be one of mesh/convergence/study/parameter/param/all. Got: $mode")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end

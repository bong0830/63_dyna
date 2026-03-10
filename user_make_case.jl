#!/usr/bin/env julia

# Edit the values below, then run:
#   julia user_make_case.jl
#
# Notes:
# - If case_name is not empty, that exact folder name is used.
# - If case_name is empty, run_case.jl builds the folder name from
#   case_prefix / case_version / case_keys.
# - run=false only generates the folder and .k files.
# - run=true also launches LS-DYNA through lsruncommand.bat.
# - This file also auto-runs when executed through an interactive
#   include(...) path such as the VS Code REPL "Run File" action.

include(joinpath(@__DIR__, "run_case.jl"))

const USER_CASE_PARAMS = Pair{String, String}[
    # Case management
    "case_name" => "user_make_case_v003",
    "case_prefix" => "bend",
    "case_version" => "v003",
    "case_keys" => "plate_t,punch_d,die_d,punch_disp_down",
    "cases_root" => "cases",
    "manifest_path" => "cases/case_manifest.csv",
    "run" => "false",
    "allow_existing" => "true",
    "ncpu" => "8",
    "memory" => "300m",
    "dyna_exe" => raw"C:\LSDYNA\program\ls-dyna_smp_d_R11_1_0_winx64_ifort160.exe",

    # Geometry
    "title" => "Quarter model edge bending with y-axis cylinder punch",
    "plate_lx" => "300",
    "plate_ly" => "300",
    "plate_t" => "15",
    "punch_d" => "45",
    "die_d" => "70",
    "punch_x" => "0",
    "die_x" => "70",
    "punch_gap" => "0.2",
    "die_gap" => "0.2",
    "tool_shell_t" => "2.0",

    # Mesh
    "plate_nx" => "10",
    "plate_ny" => "10",
    "plate_nz" => "1",
    "plate_elform" => "2",
    "punch_ntheta" => "24",
    "punch_ny" => "30",
    "die_ntheta" => "24",
    "die_ny" => "30",

    # Time / loading
    "t_end" => "0.01",
    "punch_control_mode" => "disp",
    "punch_disp_down" => "-10",
    "punch_press_speed" => "0.0",
    "punch_release_speed" => "0.0",
    "punch_hold_time" => "0.0",
    "punch_press_time" => "0.0",
    "punch_release_time" => "0.0",
    "punch_down_ratio" => "0.5",
    "punch_hold_ratio" => "0.0",
    "punch_final_disp" => "0.0",
    "punch_force_peak" => "-100.0",
    "punch_force_final" => "0.0",

    # Output / contact / solver
    "d3plot_dt" => "1.0e-4",
    "ascii_dt" => "1.0e-4",
    "fs" => "0.10",
    "fd" => "0.08",
    "mass_scaling_dt" => "0.0",
    "gravity_z" => "0.0",

    # Plate material: *MAT_PLASTIC_KINEMATIC
    "plate_rho" => "7.85e-9",
    "plate_e" => "205000.0",
    "plate_nu" => "0.28",
    "plate_sigy" => "245.0",
    "plate_etan" => "1500.0",
    "plate_beta" => "1.0",
    "plate_src" => "40.4",
    "plate_srp" => "5.0",
    "plate_fs" => "0.0",
    "plate_vp" => "0.0",

    # Punch material / rigidity
    "punch_rho" => "7.85e-9",
    "punch_e" => "2.10e8",
    "punch_nu" => "0.30",
    "punch_rigid" => "false",

    # Die material / rigidity
    "die_rho" => "7.85e-9",
    "die_e" => "2.10e8",
    "die_nu" => "0.30",
    "die_rigid" => "false",
]

function merge_user_params(
    base_pairs::Vector{Pair{String, String}},
    override_pairs::Dict{String, String},
)
    merged = copy(base_pairs)
    seen = Set{String}()

    for idx in eachindex(merged)
        key = merged[idx].first
        push!(seen, key)
        if haskey(override_pairs, key)
            merged[idx] = key => override_pairs[key]
        end
    end

    for (key, value) in override_pairs
        key in seen && continue
        push!(merged, key => value)
    end

    return merged
end

function to_kv_args(pairs::Vector{Pair{String, String}})
    return ["$(key)=$(value)" for (key, value) in pairs]
end

function run_user_case(args::Vector{String} = ARGS)
    override_kv = parse_kv_args(args)
    merged_pairs = merge_user_params(USER_CASE_PARAMS, override_kv)
    final_args = to_kv_args(merged_pairs)

    println("Running user_make_case.jl with parameters:")
    for (key, value) in merged_pairs
        println("- $key=$value")
    end
    println()

    run_case(final_args)
end

if abspath(PROGRAM_FILE) == abspath(@__FILE__) || isinteractive()
    run_user_case()
end

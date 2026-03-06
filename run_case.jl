#!/usr/bin/env julia

using Dates
using Printf

const DEFAULT_DYNA_EXE = raw"C:\LSDYNA\program\ls-dyna_smp_d_R11_1_0_winx64_ifort160.exe"
const DEFAULT_CASE_KEYS = ["plate_t", "punch_d", "die_d", "punch_disp_down"]
const MANIFEST_COLUMNS = [
    "created_at",
    "updated_at",
    "status",
    "case_name",
    "case_dir",
    "case_prefix",
    "case_version",
    "case_keys",
    "run_analysis",
    "title",
    "plate_lx",
    "plate_ly",
    "plate_t",
    "punch_d",
    "die_d",
    "punch_x",
    "die_x",
    "punch_gap",
    "die_gap",
    "plate_nx",
    "plate_ny",
    "plate_nz",
    "punch_ntheta",
    "punch_ny",
    "die_ntheta",
    "die_ny",
    "t_end",
    "punch_disp_down",
    "punch_down_ratio",
    "fs",
    "fd",
    "plate_rho",
    "plate_e",
    "plate_nu",
    "plate_sigy",
    "plate_etan",
    "plate_beta",
    "tool_rho",
    "tool_e",
    "tool_nu",
    "ncpu",
    "memory",
    "dyna_exe",
]
const DEFAULT_VALUES = Dict(
    "title" => "Quarter model edge bending with y-axis cylinder punch",
    "plate_lx" => "300",
    "plate_ly" => "300",
    "plate_t" => "15",
    "punch_d" => "45",
    "die_d" => "70",
    "punch_disp_down" => "-6",
    "punch_x" => "0",
    "die_x" => "70",
    "punch_gap" => "0.2",
    "die_gap" => "0.2",
    "t_end" => "0.01",
    "punch_down_ratio" => "0.5",
    "fs" => "0.10",
    "fd" => "0.08",
    "plate_nx" => "30",
    "plate_ny" => "30",
    "plate_nz" => "3",
    "punch_ntheta" => "24",
    "punch_ny" => "30",
    "die_ntheta" => "24",
    "die_ny" => "30",
    "plate_rho" => "7.85e-9",
    "plate_e" => "210000.0",
    "plate_nu" => "0.30",
    "plate_sigy" => "350.0",
    "plate_etan" => "1200.0",
    "plate_beta" => "0.0",
    "tool_rho" => "7.85e-9",
    "tool_e" => "2.10e8",
    "tool_nu" => "0.30",
)

function parse_kv_args(args::Vector{String})
    kv = Dict{String, String}()
    for arg in args
        occursin('=', arg) || error("All arguments must be key=value. Invalid: $arg")
        key, value = split(arg, "=", limit = 2)
        kv[strip(key)] = strip(value)
    end
    return kv
end

gets(kv::Dict{String, String}, key::String, default::String) = get(kv, key, default)

function getbool(kv::Dict{String, String}, key::String, default::Bool)
    raw = lowercase(strip(get(kv, key, default ? "true" : "false")))
    raw in ("1", "true", "yes", "y", "on") && return true
    raw in ("0", "false", "no", "n", "off") && return false
    error("$key must be one of true/false/1/0/yes/no. Got: $(get(kv, key, ""))")
end

function split_csv(value::String)
    items = String[]
    for item in split(value, ",")
        stripped = strip(item)
        isempty(stripped) || push!(items, stripped)
    end
    return items
end

function sanitize_case_name(value::String)
    cleaned = replace(strip(value), r"[<>:\"/\\|?*]" => "-")
    cleaned = replace(cleaned, r"\s+" => "-")
    return isempty(cleaned) ? "case" : cleaned
end

function csv_escape(value::String)
    escaped = replace(value, "\"" => "\"\"")
    if occursin(',', escaped) || occursin('"', escaped) || occursin('\n', escaped) || occursin('\r', escaped)
        return "\"$escaped\""
    end
    return escaped
end

function split_csv_line(line::String)
    values = String[]
    buffer = IOBuffer()
    in_quotes = false
    i = firstindex(line)

    while i <= lastindex(line)
        c = line[i]
        if in_quotes
            if c == '"'
                next_i = nextind(line, i)
                if next_i <= lastindex(line) && line[next_i] == '"'
                    write(buffer, '"')
                    i = next_i
                else
                    in_quotes = false
                end
            else
                write(buffer, c)
            end
        else
            if c == ','
                push!(values, String(take!(buffer)))
            elseif c == '"'
                in_quotes = true
            else
                write(buffer, c)
            end
        end
        i = nextind(line, i)
    end

    push!(values, String(take!(buffer)))
    return values
end

function normalize_value_string(value::String)
    stripped = strip(value)
    parsed_int = tryparse(Int, stripped)
    if parsed_int !== nothing
        return string(parsed_int)
    end

    parsed_float = tryparse(Float64, stripped)
    if parsed_float !== nothing
        return @sprintf("%.6g", parsed_float)
    end

    return sanitize_case_name(stripped)
end

function resolve_case_value(kv::Dict{String, String}, key::String)
    if key == "case_version" || key == "main_version"
        return sanitize_case_name(gets(kv, "case_version", gets(kv, "main_version", "v001")))
    end

    if haskey(kv, key)
        return normalize_value_string(kv[key])
    end

    if key == "die_d" && haskey(kv, "die_opening_r")
        return @sprintf("%.6g", 2.0 * parse(Float64, kv["die_opening_r"]))
    end

    return get(DEFAULT_VALUES, key, "na")
end

function resolve_manifest_value(kv::Dict{String, String}, key::String)
    if key == "case_prefix"
        return sanitize_case_name(gets(kv, "case_prefix", "bend"))
    elseif key == "case_version"
        return sanitize_case_name(gets(kv, "case_version", gets(kv, "main_version", "v001")))
    elseif key == "case_keys"
        return gets(kv, "case_keys", join(DEFAULT_CASE_KEYS, ","))
    elseif key == "run_analysis"
        return lowercase(gets(kv, "run", "true"))
    elseif key == "title"
        return gets(kv, "title", get(DEFAULT_VALUES, "title", ""))
    elseif key == "ncpu"
        return gets(kv, "ncpu", "8")
    elseif key == "memory"
        return gets(kv, "memory", "300m")
    elseif key == "dyna_exe"
        return gets(kv, "dyna_exe", DEFAULT_DYNA_EXE)
    end

    if haskey(kv, key)
        return normalize_value_string(kv[key])
    end

    return resolve_case_value(kv, key)
end

function build_case_name(kv::Dict{String, String})
    if haskey(kv, "case_name") && !isempty(strip(kv["case_name"]))
        return sanitize_case_name(kv["case_name"])
    end

    prefix = sanitize_case_name(gets(kv, "case_prefix", "bend"))
    version = sanitize_case_name(gets(kv, "case_version", gets(kv, "main_version", "v001")))
    case_keys = split_csv(gets(kv, "case_keys", join(DEFAULT_CASE_KEYS, ",")))
    values = [resolve_case_value(kv, key) for key in case_keys]

    if isempty(values)
        return "$(prefix)_$(version)"
    end

    return "$(prefix)_$(version)_$(join(values, ","))"
end

function resolve_cases_root(kv::Dict{String, String})
    root = gets(kv, "cases_root", "cases")
    return isabspath(root) ? root : normpath(joinpath(@__DIR__, root))
end

function resolve_manifest_path(kv::Dict{String, String}, cases_root::String)
    path = gets(kv, "manifest_path", joinpath(cases_root, "case_manifest.csv"))
    return isabspath(path) ? path : normpath(joinpath(@__DIR__, path))
end

function ensure_case_dir(case_dir::String, allow_existing::Bool)
    if isdir(case_dir)
        if allow_existing
            return
        end

        isempty(readdir(case_dir)) && return
        error("Case directory already exists and is not empty: $case_dir\nUse a different case_version/case_name or set allow_existing=true.")
    end

    mkpath(case_dir)
end

function build_generation_args(original_args::Vector{String}, case_dir::String)
    filtered = String[]
    for arg in original_args
        startswith(strip(arg), "outdir=") || push!(filtered, arg)
    end
    push!(filtered, "outdir=$case_dir")
    return filtered
end

function write_lsruncommand(path::String, dyna_exe::String, ncpu::Int, memory::String)
    open(path, "w") do io
        println(io, "@echo off")
        println(io, "setlocal")
        println(io, "set \"BASE=%~dp0\"")
        println(io, "pushd \"%BASE%\"")
        println(io, "\"$dyna_exe\" i=00_main.k ncpu=$ncpu memory=$memory 1>lsrun.out.txt 2>&1")
        println(io, "popd")
        println(io, "endlocal")
    end
end

function write_case_info(
    path::String,
    kv::Dict{String, String},
    case_name::String,
    case_dir::String,
    case_keys::Vector{String},
    run_analysis::Bool,
    dyna_exe::String,
    ncpu::Int,
    memory::String,
)
    created_at = Dates.format(now(), dateformat"yyyy-mm-dd HH:MM:SS")
    open(path, "w") do io
        println(io, "created_at=$created_at")
        println(io, "case_name=$case_name")
        println(io, "case_dir=$case_dir")
        println(io, "case_keys=" * join(case_keys, ","))
        println(io, "run_analysis=$run_analysis")
        println(io, "dyna_exe=$dyna_exe")
        println(io, "ncpu=$ncpu")
        println(io, "memory=$memory")
        println(io)
        println(io, "[resolved_case_values]")
        for key in case_keys
            println(io, "$key=$(resolve_case_value(kv, key))")
        end
        println(io)
        println(io, "[input_args]")
        for key in sort(collect(keys(kv)))
            println(io, "$key=$(kv[key])")
        end
    end
end

function read_manifest_rows(path::String)
    if !isfile(path)
        return Dict{String, String}[]
    end

    lines = readlines(path)
    isempty(lines) && return Dict{String, String}[]
    header = split_csv_line(first(lines))
    rows = Dict{String, String}[]

    for line in Iterators.drop(lines, 1)
        isempty(strip(line)) && continue
        values = split_csv_line(line)
        row = Dict{String, String}()
        for (idx, column) in enumerate(header)
            row[column] = idx <= length(values) ? values[idx] : ""
        end
        push!(rows, row)
    end

    return rows
end

function write_manifest(path::String, rows::Vector{Dict{String, String}})
    mkpath(dirname(path))
    open(path, "w") do io
        println(io, join(MANIFEST_COLUMNS, ","))
        for row in rows
            values = [csv_escape(get(row, column, "")) for column in MANIFEST_COLUMNS]
            println(io, join(values, ","))
        end
    end
end

function build_manifest_row(
    kv::Dict{String, String},
    case_name::String,
    case_dir::String,
    case_keys::Vector{String},
    status::String,
)
    row = Dict{String, String}()
    for column in MANIFEST_COLUMNS
        row[column] = resolve_manifest_value(kv, column)
    end

    row["created_at"] = Dates.format(now(), dateformat"yyyy-mm-dd HH:MM:SS")
    row["updated_at"] = row["created_at"]
    row["status"] = status
    row["case_name"] = case_name
    row["case_dir"] = case_dir
    row["case_keys"] = join(case_keys, ",")
    return row
end

function upsert_manifest(
    path::String,
    kv::Dict{String, String},
    case_name::String,
    case_dir::String,
    case_keys::Vector{String},
    status::String,
)
    rows = read_manifest_rows(path)
    timestamp = Dates.format(now(), dateformat"yyyy-mm-dd HH:MM:SS")
    replacement = build_manifest_row(kv, case_name, case_dir, case_keys, status)
    replacement["updated_at"] = timestamp

    replaced = false
    for row in rows
        if get(row, "case_name", "") == case_name
            replacement["created_at"] = get(row, "created_at", timestamp)
            empty!(row)
            merge!(row, replacement)
            replaced = true
            break
        end
    end

    if !replaced
        push!(rows, replacement)
    end

    write_manifest(path, rows)
end

function run_generator(script_name::String, args::Vector{String})
    script_path = joinpath(@__DIR__, script_name)
    cmd = `$(Base.julia_cmd()) $script_path $(args)`
    run(cmd)
end

function run_analysis_in_case_dir(case_dir::String)
    Sys.iswindows() || error("Automatic batch execution is currently implemented for Windows only.")
    cd(case_dir) do
        run(`cmd /c lsruncommand.bat`)
    end
end

function main()
    kv = parse_kv_args(ARGS)

    case_name = build_case_name(kv)
    case_keys = split_csv(gets(kv, "case_keys", join(DEFAULT_CASE_KEYS, ",")))
    cases_root = resolve_cases_root(kv)
    manifest_path = resolve_manifest_path(kv, cases_root)
    case_dir = normpath(joinpath(cases_root, case_name))

    allow_existing = getbool(kv, "allow_existing", false)
    run_analysis = getbool(kv, "run", true)
    ncpu = parse(Int, gets(kv, "ncpu", "8"))
    memory = gets(kv, "memory", "300m")
    dyna_exe = gets(kv, "dyna_exe", DEFAULT_DYNA_EXE)

    ensure_case_dir(case_dir, allow_existing)

    generation_args = build_generation_args(ARGS, case_dir)
    run_generator("generate_mesh_kfiles.jl", generation_args)
    run_generator("generate_main_kfile.jl", generation_args)

    write_lsruncommand(joinpath(case_dir, "lsruncommand.bat"), dyna_exe, ncpu, memory)
    write_case_info(
        joinpath(case_dir, "case_info.txt"),
        kv,
        case_name,
        case_dir,
        case_keys,
        run_analysis,
        dyna_exe,
        ncpu,
        memory,
    )
    upsert_manifest(manifest_path, kv, case_name, case_dir, case_keys, run_analysis ? "generated" : "generated_no_run")

    println("Case directory ready:")
    println("- $(abspath(case_dir))")
    println("Case manifest updated:")
    println("- $(abspath(manifest_path))")

    if run_analysis
        println("Running LS-DYNA in case directory...")
        run_analysis_in_case_dir(case_dir)
        upsert_manifest(manifest_path, kv, case_name, case_dir, case_keys, "finished")
        println("Analysis finished:")
        println("- $(abspath(case_dir))")
    else
        println("Analysis was skipped because run=false.")
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end

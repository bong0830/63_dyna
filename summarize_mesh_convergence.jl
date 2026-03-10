#!/usr/bin/env julia

include(joinpath(@__DIR__, "generate_study_cases.jl"))

const FINISHED_MARKERS = ["normal termination", "*** termination time reached ***"]
const LICENSE_MARKERS = ["license problem", "cannot find any servers"]
const ERROR_MARKERS = ["error termination", "fatal error", "input data failed"]

function detect_case_status(case_dir::String)
    output_path = joinpath(case_dir, "lsrun.out.txt")
    isfile(output_path) || return "missing"
    text = lowercase(read(output_path, String))
    any(marker -> occursin(marker, text), LICENSE_MARKERS) && return "license_failed"
    any(marker -> occursin(marker, text), ERROR_MARKERS) && return "failed"
    any(marker -> occursin(marker, text), FINISHED_MARKERS) && return "finished"
    return "interrupted"
end

function parse_rcforc_metrics(case_dir::String)
    rcforc_path = joinpath(case_dir, "rcforc")
    isfile(rcforc_path) || return (final_time = "", final_master1_z = "", max_abs_master1_z = "")

    final_time = nothing
    final_z = nothing
    max_abs_z = 0.0

    for line in eachline(rcforc_path)
        match_obj = match(r"master\s+1\s+time\s+(\S+)\s+x\s+(\S+)\s+y\s+(\S+)\s+z\s+(\S+)", line)
        match_obj === nothing && continue
        time_val = parse(Float64, match_obj.captures[1])
        z_val = parse(Float64, match_obj.captures[4])
        final_time = time_val
        final_z = z_val
        max_abs_z = max(max_abs_z, abs(z_val))
    end

    final_time === nothing && return (final_time = "", final_master1_z = "", max_abs_master1_z = "")
    return (
        final_time = fmt_num(final_time),
        final_master1_z = fmt_num(final_z),
        max_abs_master1_z = fmt_num(max_abs_z),
    )
end

function main()
    rows = Vector{Vector{String}}()

    for mesh in MESH_LEVELS
        case_no = fmt_case_no(mesh.case_no)
        case_name = "meshconv_" * case_no
        case_dir = joinpath(ROOT, "cases", case_name)
        status = detect_case_status(case_dir)
        metrics = parse_rcforc_metrics(case_dir)

        push!(rows, [
            case_no,
            case_name,
            mesh.tag,
            string(mesh.plate_nx),
            string(mesh.plate_ny),
            string(mesh.plate_nz),
            string(mesh.punch_ntheta),
            string(mesh.punch_ny),
            string(mesh.die_ntheta),
            string(mesh.die_ny),
            status,
            metrics.final_time,
            metrics.final_master1_z,
            metrics.max_abs_master1_z,
        ])
    end

    write_plan_csv(
        joinpath(PLAN_DIR, "mesh_convergence_results.csv"),
        ["case_no", "case_name", "mesh_tag", "plate_nx", "plate_ny", "plate_nz", "punch_ntheta", "punch_ny", "die_ntheta", "die_ny", "status", "final_time", "final_master1_z", "max_abs_master1_z"],
        rows,
    )

    println("Wrote convergence summary:")
    println("- " * joinpath(PLAN_DIR, "mesh_convergence_results.csv"))
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end

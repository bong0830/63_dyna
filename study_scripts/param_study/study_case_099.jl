#!/usr/bin/env julia

include(joinpath(@__DIR__, "..", "..", "user_make_case.jl"))

run_user_case([
    "run=false",
    "allow_existing=true",
    "cases_root=cases",
    "manifest_path=cases/case_manifest.csv",
    "punch_control_mode=disp",
    "punch_hold_time=0.2",
    "punch_press_time=0.0",
    "punch_release_time=0.0",
    "punch_release_speed=0.0",
    "punch_gap=0.2",
    "tool_shell_t=2.0",
    "mass_scaling_dt=0.0",
    "gravity_z=0.0",
    "case_name=study_099",
    "case_version=v099",
    "case_keys=die_gap,punch_disp_down,punch_press_speed",
    "die_gap=6",
    "punch_disp_down=-24",
    "punch_press_speed=4",
    "punch_final_disp=-24",
    "t_end=6.2",
    "plate_nx=24",
    "plate_ny=24",
    "plate_nz=2",
    "punch_ntheta=28",
    "punch_ny=28",
    "die_ntheta=28",
    "die_ny=28",
])

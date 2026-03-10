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
    "mass_scaling_dt=5e-06",
    "gravity_z=0.0",
    "case_name=meshconv_002",
    "case_version=v002",
    "case_keys=die_gap,punch_disp_down,punch_press_speed",
    "die_gap=0.2",
    "punch_disp_down=-12",
    "punch_press_speed=2",
    "punch_final_disp=-12",
    "t_end=6.2",
    "plate_nx=14",
    "plate_ny=14",
    "plate_nz=1",
    "punch_ntheta=20",
    "punch_ny=20",
    "die_ntheta=20",
    "die_ny=20",
])

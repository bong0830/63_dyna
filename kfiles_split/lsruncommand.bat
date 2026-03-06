@echo off
setlocal
set "BASE=%~dp0"
pushd "%BASE%"
"C:\LSDYNA\program\ls-dyna_smp_d_R11_1_0_winx64_ifort160.exe" i=00_main.k ncpu=8 memory=300m 1>lsrun.out.txt 2>&1
popd
endlocal

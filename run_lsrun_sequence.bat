@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem ==============================================================================
rem run_lsrun_sequence.bat
rem 
rem Description:
rem   Sequentially navigates into numbered case folders and executes lsruncommand.bat
rem 
rem Usage:
rem   run_lsrun_sequence.bat [prefix] [start_no] [end_no]
rem 
rem Example:
rem   run_lsrun_sequence.bat meshconv 7 11
rem   run_lsrun_sequence.bat study 1 120
rem ==============================================================================

set "ROOT=%~dp0"
set "CASES_DIR=%ROOT%cases"

set "PREFIX=%~1"
set "START_NO=%~2"
set "END_NO=%~3"
set "PAD_WIDTH=3"

if "%PREFIX%"=="" set "PREFIX=meshconv"
if "%START_NO%"=="" set "START_NO=7"
if "%END_NO%"=="" set "END_NO=11"

echo [INFO] Looking for cases in: %CASES_DIR%
echo [INFO] Folder Prefix: %PREFIX%
echo [INFO] Running Range: %START_NO% to %END_NO%
echo.

for /L %%N in (%START_NO%,1,%END_NO%) do (
    set "PADDED=000000%%N"
    set "CASE_NO=!PADDED:~-%PAD_WIDTH%!"
    set "CASE_DIR=%CASES_DIR%\%PREFIX%_!CASE_NO!"
    set "LSRUN_BAT=!CASE_DIR!\lsruncommand.bat"

    if exist "!LSRUN_BAT!" (
        echo =======================================================
        echo [RUN] Running !LSRUN_BAT!
        echo =======================================================
        pushd "!CASE_DIR!"
        call lsruncommand.bat
        popd
        echo.
    ) else (
        echo [SKIP] lsruncommand.bat not found in !CASE_DIR!
        echo.
    )
)

echo [DONE] Finished sequence.
exit /b 0

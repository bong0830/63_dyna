@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem Edit these defaults or pass start/end as arguments:
rem   run_user_case_range.bat 1 5
rem Script naming rule:
rem   user_make_case_001.jl
rem   user_make_case_002.jl
rem   ...

set "ROOT=%~dp0"
if not defined SCRIPT_ROOT set "SCRIPT_ROOT=%ROOT%"
if not defined JULIA_EXE set "JULIA_EXE=C:\Users\user\.julia\juliaup\julia-1.12.5+0.x64.w64.mingw32\bin\julia.exe"
if not defined SCRIPT_PREFIX set "SCRIPT_PREFIX=user_make_case_"
if not defined SCRIPT_SUFFIX set "SCRIPT_SUFFIX=.jl"
if not defined START_NO set "START_NO=1"
if not defined END_NO set "END_NO=3"
if not defined PAD_WIDTH set "PAD_WIDTH=3"
if not defined STOP_ON_MISSING set "STOP_ON_MISSING=1"
if not defined STOP_ON_ERROR set "STOP_ON_ERROR=1"

if not "%~1"=="" set "START_NO=%~1"
if not "%~2"=="" set "END_NO=%~2"

echo [INFO] Julia executable: %JULIA_EXE%
echo [INFO] Script root: %SCRIPT_ROOT%
echo [INFO] Script prefix: %SCRIPT_PREFIX%
echo [INFO] Range: %START_NO% to %END_NO%
echo.

for /L %%N in (%START_NO%,1,%END_NO%) do (
    set "PADDED=000000%%N"
    set "CASE_NO=!PADDED:~-%PAD_WIDTH%!"
    set "SCRIPT_PATH=%SCRIPT_ROOT%\!SCRIPT_PREFIX!!CASE_NO!!SCRIPT_SUFFIX!"

    if not exist "!SCRIPT_PATH!" (
        echo [ERROR] Script not found: !SCRIPT_PATH!
        if "!STOP_ON_MISSING!"=="1" (
            echo [STOP] Batch stopped because STOP_ON_MISSING=1
            exit /b 1
        ) else (
            echo [SKIP] Moving to next number.
            echo.
        )
    ) else (
        echo [RUN] !SCRIPT_PATH!
        call "%JULIA_EXE%" "!SCRIPT_PATH!"
        set "EXIT_CODE=!ERRORLEVEL!"
        if not "!EXIT_CODE!"=="0" (
            echo [ERROR] Script failed with exit code !EXIT_CODE!: !SCRIPT_PATH!
            if "!STOP_ON_ERROR!"=="1" (
                echo [STOP] Batch stopped because STOP_ON_ERROR=1
                exit /b !EXIT_CODE!
            )
        ) else (
            echo [DONE] !SCRIPT_PATH!
        )
        echo.
    )
)

echo [DONE] Finished requested range.
exit /b 0

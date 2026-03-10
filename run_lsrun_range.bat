@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem Sequentially run each case folder's lsruncommand.bat.
rem Example:
rem   run_lsrun_range.bat 1 5
rem Folder naming rule:
rem   cases\user_case_001
rem   cases\user_case_002
rem   ...

set "ROOT=%~dp0"
set "CASE_ROOT=%ROOT%cases"
set "CASE_PREFIX=user_case_"
set "CASE_SUFFIX="
set "START_NO=1"
set "END_NO=5"
set "PAD_WIDTH=3"
set "STOP_ON_MISSING=1"
set "STOP_ON_ERROR=1"
set "DRY_RUN=0"

if not "%~1"=="" set "START_NO=%~1"
if not "%~2"=="" set "END_NO=%~2"

echo [INFO] Case root: %CASE_ROOT%
echo [INFO] Case prefix: %CASE_PREFIX%
echo [INFO] Range: %START_NO% to %END_NO%
echo [INFO] Dry run: %DRY_RUN%
echo.

for /L %%N in (%START_NO%,1,%END_NO%) do (
    set "PADDED=000000%%N"
    set "CASE_NO=!PADDED:~-%PAD_WIDTH%!"
    set "CASE_DIR=%CASE_ROOT%\!CASE_PREFIX!!CASE_NO!!CASE_SUFFIX!"
    set "RUN_BAT=!CASE_DIR!\lsruncommand.bat"

    if not exist "!CASE_DIR!" (
        echo [ERROR] Case folder not found: !CASE_DIR!
        if "!STOP_ON_MISSING!"=="1" (
            echo [STOP] Batch stopped because STOP_ON_MISSING=1
            exit /b 1
        ) else (
            echo [SKIP] Moving to next number.
            echo.
        )
    ) else if not exist "!RUN_BAT!" (
        echo [ERROR] lsruncommand.bat not found: !RUN_BAT!
        if "!STOP_ON_MISSING!"=="1" (
            echo [STOP] Batch stopped because STOP_ON_MISSING=1
            exit /b 1
        ) else (
            echo [SKIP] Moving to next number.
            echo.
        )
    ) else (
        echo [RUN] !RUN_BAT!
        if "!DRY_RUN!"=="1" (
            echo [DRY] call "!RUN_BAT!"
            echo.
        ) else (
            call "!RUN_BAT!"
            set "EXIT_CODE=!ERRORLEVEL!"
            if not "!EXIT_CODE!"=="0" (
                echo [ERROR] Case failed with exit code !EXIT_CODE!: !CASE_DIR!
                if "!STOP_ON_ERROR!"=="1" (
                    echo [STOP] Batch stopped because STOP_ON_ERROR=1
                    exit /b !EXIT_CODE!
                )
            ) else (
                echo [DONE] !CASE_DIR!
            )
            echo.
        )
    )
)

echo [DONE] Finished requested range.
exit /b 0

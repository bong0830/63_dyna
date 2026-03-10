@echo off
setlocal EnableExtensions

echo [INFO] =======================================================
echo [INFO] 마스터 배치 실행 리스트를 시작합니다.
echo [INFO] 실행 대상 폴더 수: 162
echo [INFO] =======================================================

echo [RUN] Case: bend_disp_v331_diegap_6 시작
pushd "cases\bend_disp_v331_diegap_6"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_disp_v331_diegap_6 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_disp_v331_diegap_6 완료
echo.

echo [RUN] Case: bend_disp_v332_diegap_10 시작
pushd "cases\bend_disp_v332_diegap_10"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_disp_v332_diegap_10 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_disp_v332_diegap_10 완료
echo.

echo [RUN] Case: bend_disp_v333_diegap_15 시작
pushd "cases\bend_disp_v333_diegap_15"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_disp_v333_diegap_15 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_disp_v333_diegap_15 완료
echo.

echo [RUN] Case: bend_disp_v334_diegap_20 시작
pushd "cases\bend_disp_v334_diegap_20"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_disp_v334_diegap_20 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_disp_v334_diegap_20 완료
echo.

echo [RUN] Case: bend_disp_v335_diegap_30 시작
pushd "cases\bend_disp_v335_diegap_30"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_disp_v335_diegap_30 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_disp_v335_diegap_30 완료
echo.

echo [RUN] Case: bend_disp_v341_diegap_6_d20 시작
pushd "cases\bend_disp_v341_diegap_6_d20"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_disp_v341_diegap_6_d20 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_disp_v341_diegap_6_d20 완료
echo.

echo [RUN] Case: bend_disp_v342_diegap_10_d20 시작
pushd "cases\bend_disp_v342_diegap_10_d20"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_disp_v342_diegap_10_d20 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_disp_v342_diegap_10_d20 완료
echo.

echo [RUN] Case: bend_disp_v343_diegap_15_d20 시작
pushd "cases\bend_disp_v343_diegap_15_d20"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_disp_v343_diegap_15_d20 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_disp_v343_diegap_15_d20 완료
echo.

echo [RUN] Case: bend_disp_v344_diegap_20_d20 시작
pushd "cases\bend_disp_v344_diegap_20_d20"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_disp_v344_diegap_20_d20 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_disp_v344_diegap_20_d20 완료
echo.

echo [RUN] Case: bend_disp_v345_diegap_30_d20 시작
pushd "cases\bend_disp_v345_diegap_30_d20"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_disp_v345_diegap_30_d20 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_disp_v345_diegap_30_d20 완료
echo.

echo [RUN] Case: bend_force_v201_134p6tf_qtr_rhr_g 시작
pushd "cases\bend_force_v201_134p6tf_qtr_rhr_g"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v201_134p6tf_qtr_rhr_g 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v201_134p6tf_qtr_rhr_g 완료
echo.

echo [RUN] Case: bend_force_v202_134p6tf_qtr_rhr_nog 시작
pushd "cases\bend_force_v202_134p6tf_qtr_rhr_nog"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v202_134p6tf_qtr_rhr_nog 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v202_134p6tf_qtr_rhr_nog 완료
echo.

echo [RUN] Case: bend_force_v203_134p6tf_qtr_rhr_gneg 시작
pushd "cases\bend_force_v203_134p6tf_qtr_rhr_gneg"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v203_134p6tf_qtr_rhr_gneg 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v203_134p6tf_qtr_rhr_gneg 완료
echo.

echo [RUN] Case: bend_force_v301_punchflex_setup 시작
pushd "cases\bend_force_v301_punchflex_setup"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v301_punchflex_setup 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v301_punchflex_setup 완료
echo.

echo [RUN] Case: bend_force_v302_punchflex_slow_hold_up 시작
pushd "cases\bend_force_v302_punchflex_slow_hold_up"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v302_punchflex_slow_hold_up 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v302_punchflex_slow_hold_up 완료
echo.

echo [RUN] Case: bend_force_v311_diegap_0p5 시작
pushd "cases\bend_force_v311_diegap_0p5"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v311_diegap_0p5 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v311_diegap_0p5 완료
echo.

echo [RUN] Case: bend_force_v312_diegap_1p0 시작
pushd "cases\bend_force_v312_diegap_1p0"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v312_diegap_1p0 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v312_diegap_1p0 완료
echo.

echo [RUN] Case: bend_force_v313_diegap_1p5 시작
pushd "cases\bend_force_v313_diegap_1p5"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v313_diegap_1p5 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v313_diegap_1p5 완료
echo.

echo [RUN] Case: bend_force_v314_diegap_2p0 시작
pushd "cases\bend_force_v314_diegap_2p0"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v314_diegap_2p0 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v314_diegap_2p0 완료
echo.

echo [RUN] Case: bend_force_v315_diegap_3p0 시작
pushd "cases\bend_force_v315_diegap_3p0"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v315_diegap_3p0 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v315_diegap_3p0 완료
echo.

echo [RUN] Case: bend_force_v316_diegap_4p0 시작
pushd "cases\bend_force_v316_diegap_4p0"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v316_diegap_4p0 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v316_diegap_4p0 완료
echo.

echo [RUN] Case: bend_force_v321_diegap_6 시작
pushd "cases\bend_force_v321_diegap_6"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v321_diegap_6 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v321_diegap_6 완료
echo.

echo [RUN] Case: bend_force_v322_diegap_10 시작
pushd "cases\bend_force_v322_diegap_10"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v322_diegap_10 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v322_diegap_10 완료
echo.

echo [RUN] Case: bend_force_v323_diegap_15 시작
pushd "cases\bend_force_v323_diegap_15"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v323_diegap_15 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v323_diegap_15 완료
echo.

echo [RUN] Case: bend_force_v324_diegap_20 시작
pushd "cases\bend_force_v324_diegap_20"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v324_diegap_20 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v324_diegap_20 완료
echo.

echo [RUN] Case: bend_force_v325_diegap_30 시작
pushd "cases\bend_force_v325_diegap_30"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_force_v325_diegap_30 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_force_v325_diegap_30 완료
echo.

echo [RUN] Case: bend_forcecheck_134p6tf_qtr_0p8s 시작
pushd "cases\bend_forcecheck_134p6tf_qtr_0p8s"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_forcecheck_134p6tf_qtr_0p8s 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_forcecheck_134p6tf_qtr_0p8s 완료
echo.

echo [RUN] Case: bend_forcecheck_v001_short 시작
pushd "cases\bend_forcecheck_v001_short"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_forcecheck_v001_short 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_forcecheck_v001_short 완료
echo.

echo [RUN] Case: bend_forcecheck_v002_short_hi 시작
pushd "cases\bend_forcecheck_v002_short_hi"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_forcecheck_v002_short_hi 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_forcecheck_v002_short_hi 완료
echo.

echo [RUN] Case: bend_forcecheck_v003_short_hold50k 시작
pushd "cases\bend_forcecheck_v003_short_hold50k"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_forcecheck_v003_short_hold50k 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_forcecheck_v003_short_hold50k 완료
echo.

echo [RUN] Case: bend_forcecheck_v003_short_hold50k_fix 시작
pushd "cases\bend_forcecheck_v003_short_hold50k_fix"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_forcecheck_v003_short_hold50k_fix 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_forcecheck_v003_short_hold50k_fix 완료
echo.

echo [RUN] Case: bend_fullint_check_short 시작
pushd "cases\bend_fullint_check_short"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_fullint_check_short 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_fullint_check_short 완료
echo.

echo [RUN] Case: bend_speed_v101_d10_mesh12 시작
pushd "cases\bend_speed_v101_d10_mesh12"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_speed_v101_d10_mesh12 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_speed_v101_d10_mesh12 완료
echo.

echo [RUN] Case: bend_speed_v102_d15_mesh12 시작
pushd "cases\bend_speed_v102_d15_mesh12"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_speed_v102_d15_mesh12 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_speed_v102_d15_mesh12 완료
echo.

echo [RUN] Case: bend_speed_v103_d20_mesh12 시작
pushd "cases\bend_speed_v103_d20_mesh12"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_speed_v103_d20_mesh12 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_speed_v103_d20_mesh12 완료
echo.

echo [RUN] Case: bend_speed_v104_d25_mesh12 시작
pushd "cases\bend_speed_v104_d25_mesh12"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_speed_v104_d25_mesh12 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_speed_v104_d25_mesh12 완료
echo.

echo [RUN] Case: bend_speed_v105_d10_mesh16 시작
pushd "cases\bend_speed_v105_d10_mesh16"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_speed_v105_d10_mesh16 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_speed_v105_d10_mesh16 완료
echo.

echo [RUN] Case: bend_speed_v106_d10_mesh20 시작
pushd "cases\bend_speed_v106_d10_mesh20"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_speed_v106_d10_mesh20 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_speed_v106_d10_mesh20 완료
echo.

echo [RUN] Case: bend_v001_15,45,70,-6 시작
pushd "cases\bend_v001_15,45,70,-6"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_v001_15,45,70,-6 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_v001_15,45,70,-6 완료
echo.

echo [RUN] Case: bend_v002_rigid_ms_0p1s 시작
pushd "cases\bend_v002_rigid_ms_0p1s"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_v002_rigid_ms_0p1s 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_v002_rigid_ms_0p1s 완료
echo.

echo [RUN] Case: bend_v003_rigid_ms_1p0s 시작
pushd "cases\bend_v003_rigid_ms_1p0s"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_v003_rigid_ms_1p0s 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_v003_rigid_ms_1p0s 완료
echo.

echo [RUN] Case: bend_v004_hold_press_fine 시작
pushd "cases\bend_v004_hold_press_fine"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_v004_hold_press_fine 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_v004_hold_press_fine 완료
echo.

echo [RUN] Case: bend_v005_hold_press_fine_gapfix 시작
pushd "cases\bend_v005_hold_press_fine_gapfix"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_v005_hold_press_fine_gapfix 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_v005_hold_press_fine_gapfix 완료
echo.

echo [RUN] Case: bend_v006_slow_release_25 시작
pushd "cases\bend_v006_slow_release_25"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_v006_slow_release_25 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_v006_slow_release_25 완료
echo.

echo [RUN] Case: bend_v007_slow_release_25_24c30g 시작
pushd "cases\bend_v007_slow_release_25_24c30g"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] bend_v007_slow_release_25_24c30g 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: bend_v007_slow_release_25_24c30g 완료
echo.

echo [RUN] Case: histnode_sanity 시작
pushd "cases\histnode_sanity"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] histnode_sanity 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: histnode_sanity 완료
echo.

echo [RUN] Case: meshconv_001 시작
pushd "cases\meshconv_001"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] meshconv_001 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: meshconv_001 완료
echo.

echo [RUN] Case: meshconv_002 시작
pushd "cases\meshconv_002"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] meshconv_002 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: meshconv_002 완료
echo.

echo [RUN] Case: meshconv_003 시작
pushd "cases\meshconv_003"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] meshconv_003 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: meshconv_003 완료
echo.

echo [RUN] Case: meshconv_004 시작
pushd "cases\meshconv_004"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] meshconv_004 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: meshconv_004 완료
echo.

echo [RUN] Case: meshconv_005 시작
pushd "cases\meshconv_005"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] meshconv_005 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: meshconv_005 완료
echo.

echo [RUN] Case: meshconv_006 시작
pushd "cases\meshconv_006"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] meshconv_006 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: meshconv_006 완료
echo.

echo [RUN] Case: meshconv_007 시작
pushd "cases\meshconv_007"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] meshconv_007 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: meshconv_007 완료
echo.

echo [RUN] Case: meshconv_008 시작
pushd "cases\meshconv_008"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] meshconv_008 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: meshconv_008 완료
echo.

echo [RUN] Case: meshconv_009 시작
pushd "cases\meshconv_009"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] meshconv_009 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: meshconv_009 완료
echo.

echo [RUN] Case: meshconv_010 시작
pushd "cases\meshconv_010"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] meshconv_010 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: meshconv_010 완료
echo.

echo [RUN] Case: meshconv_011 시작
pushd "cases\meshconv_011"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] meshconv_011 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: meshconv_011 완료
echo.

echo [RUN] Case: study_001 시작
pushd "cases\study_001"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_001 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_001 완료
echo.

echo [RUN] Case: study_002 시작
pushd "cases\study_002"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_002 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_002 완료
echo.

echo [RUN] Case: study_003 시작
pushd "cases\study_003"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_003 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_003 완료
echo.

echo [RUN] Case: study_004 시작
pushd "cases\study_004"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_004 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_004 완료
echo.

echo [RUN] Case: study_005 시작
pushd "cases\study_005"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_005 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_005 완료
echo.

echo [RUN] Case: study_006 시작
pushd "cases\study_006"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_006 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_006 완료
echo.

echo [RUN] Case: study_007 시작
pushd "cases\study_007"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_007 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_007 완료
echo.

echo [RUN] Case: study_008 시작
pushd "cases\study_008"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_008 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_008 완료
echo.

echo [RUN] Case: study_009 시작
pushd "cases\study_009"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_009 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_009 완료
echo.

echo [RUN] Case: study_010 시작
pushd "cases\study_010"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_010 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_010 완료
echo.

echo [RUN] Case: study_011 시작
pushd "cases\study_011"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_011 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_011 완료
echo.

echo [RUN] Case: study_012 시작
pushd "cases\study_012"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_012 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_012 완료
echo.

echo [RUN] Case: study_013 시작
pushd "cases\study_013"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_013 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_013 완료
echo.

echo [RUN] Case: study_014 시작
pushd "cases\study_014"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_014 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_014 완료
echo.

echo [RUN] Case: study_015 시작
pushd "cases\study_015"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_015 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_015 완료
echo.

echo [RUN] Case: study_016 시작
pushd "cases\study_016"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_016 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_016 완료
echo.

echo [RUN] Case: study_017 시작
pushd "cases\study_017"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_017 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_017 완료
echo.

echo [RUN] Case: study_018 시작
pushd "cases\study_018"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_018 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_018 완료
echo.

echo [RUN] Case: study_019 시작
pushd "cases\study_019"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_019 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_019 완료
echo.

echo [RUN] Case: study_020 시작
pushd "cases\study_020"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_020 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_020 완료
echo.

echo [RUN] Case: study_021 시작
pushd "cases\study_021"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_021 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_021 완료
echo.

echo [RUN] Case: study_022 시작
pushd "cases\study_022"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_022 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_022 완료
echo.

echo [RUN] Case: study_023 시작
pushd "cases\study_023"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_023 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_023 완료
echo.

echo [RUN] Case: study_024 시작
pushd "cases\study_024"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_024 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_024 완료
echo.

echo [RUN] Case: study_025 시작
pushd "cases\study_025"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_025 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_025 완료
echo.

echo [RUN] Case: study_026 시작
pushd "cases\study_026"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_026 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_026 완료
echo.

echo [RUN] Case: study_027 시작
pushd "cases\study_027"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_027 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_027 완료
echo.

echo [RUN] Case: study_028 시작
pushd "cases\study_028"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_028 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_028 완료
echo.

echo [RUN] Case: study_029 시작
pushd "cases\study_029"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_029 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_029 완료
echo.

echo [RUN] Case: study_030 시작
pushd "cases\study_030"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_030 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_030 완료
echo.

echo [RUN] Case: study_031 시작
pushd "cases\study_031"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_031 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_031 완료
echo.

echo [RUN] Case: study_032 시작
pushd "cases\study_032"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_032 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_032 완료
echo.

echo [RUN] Case: study_033 시작
pushd "cases\study_033"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_033 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_033 완료
echo.

echo [RUN] Case: study_034 시작
pushd "cases\study_034"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_034 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_034 완료
echo.

echo [RUN] Case: study_035 시작
pushd "cases\study_035"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_035 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_035 완료
echo.

echo [RUN] Case: study_036 시작
pushd "cases\study_036"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_036 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_036 완료
echo.

echo [RUN] Case: study_037 시작
pushd "cases\study_037"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_037 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_037 완료
echo.

echo [RUN] Case: study_038 시작
pushd "cases\study_038"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_038 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_038 완료
echo.

echo [RUN] Case: study_039 시작
pushd "cases\study_039"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_039 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_039 완료
echo.

echo [RUN] Case: study_040 시작
pushd "cases\study_040"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_040 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_040 완료
echo.

echo [RUN] Case: study_041 시작
pushd "cases\study_041"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_041 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_041 완료
echo.

echo [RUN] Case: study_042 시작
pushd "cases\study_042"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_042 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_042 완료
echo.

echo [RUN] Case: study_043 시작
pushd "cases\study_043"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_043 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_043 완료
echo.

echo [RUN] Case: study_044 시작
pushd "cases\study_044"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_044 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_044 완료
echo.

echo [RUN] Case: study_045 시작
pushd "cases\study_045"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_045 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_045 완료
echo.

echo [RUN] Case: study_046 시작
pushd "cases\study_046"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_046 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_046 완료
echo.

echo [RUN] Case: study_047 시작
pushd "cases\study_047"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_047 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_047 완료
echo.

echo [RUN] Case: study_048 시작
pushd "cases\study_048"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_048 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_048 완료
echo.

echo [RUN] Case: study_049 시작
pushd "cases\study_049"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_049 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_049 완료
echo.

echo [RUN] Case: study_050 시작
pushd "cases\study_050"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_050 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_050 완료
echo.

echo [RUN] Case: study_051 시작
pushd "cases\study_051"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_051 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_051 완료
echo.

echo [RUN] Case: study_052 시작
pushd "cases\study_052"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_052 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_052 완료
echo.

echo [RUN] Case: study_053 시작
pushd "cases\study_053"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_053 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_053 완료
echo.

echo [RUN] Case: study_054 시작
pushd "cases\study_054"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_054 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_054 완료
echo.

echo [RUN] Case: study_055 시작
pushd "cases\study_055"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_055 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_055 완료
echo.

echo [RUN] Case: study_056 시작
pushd "cases\study_056"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_056 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_056 완료
echo.

echo [RUN] Case: study_057 시작
pushd "cases\study_057"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_057 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_057 완료
echo.

echo [RUN] Case: study_058 시작
pushd "cases\study_058"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_058 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_058 완료
echo.

echo [RUN] Case: study_059 시작
pushd "cases\study_059"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_059 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_059 완료
echo.

echo [RUN] Case: study_060 시작
pushd "cases\study_060"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_060 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_060 완료
echo.

echo [RUN] Case: study_061 시작
pushd "cases\study_061"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_061 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_061 완료
echo.

echo [RUN] Case: study_062 시작
pushd "cases\study_062"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_062 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_062 완료
echo.

echo [RUN] Case: study_063 시작
pushd "cases\study_063"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_063 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_063 완료
echo.

echo [RUN] Case: study_064 시작
pushd "cases\study_064"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_064 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_064 완료
echo.

echo [RUN] Case: study_065 시작
pushd "cases\study_065"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_065 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_065 완료
echo.

echo [RUN] Case: study_066 시작
pushd "cases\study_066"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_066 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_066 완료
echo.

echo [RUN] Case: study_067 시작
pushd "cases\study_067"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_067 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_067 완료
echo.

echo [RUN] Case: study_068 시작
pushd "cases\study_068"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_068 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_068 완료
echo.

echo [RUN] Case: study_069 시작
pushd "cases\study_069"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_069 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_069 완료
echo.

echo [RUN] Case: study_070 시작
pushd "cases\study_070"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_070 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_070 완료
echo.

echo [RUN] Case: study_071 시작
pushd "cases\study_071"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_071 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_071 완료
echo.

echo [RUN] Case: study_072 시작
pushd "cases\study_072"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_072 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_072 완료
echo.

echo [RUN] Case: study_073 시작
pushd "cases\study_073"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_073 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_073 완료
echo.

echo [RUN] Case: study_074 시작
pushd "cases\study_074"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_074 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_074 완료
echo.

echo [RUN] Case: study_075 시작
pushd "cases\study_075"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_075 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_075 완료
echo.

echo [RUN] Case: study_076 시작
pushd "cases\study_076"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_076 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_076 완료
echo.

echo [RUN] Case: study_077 시작
pushd "cases\study_077"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_077 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_077 완료
echo.

echo [RUN] Case: study_078 시작
pushd "cases\study_078"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_078 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_078 완료
echo.

echo [RUN] Case: study_079 시작
pushd "cases\study_079"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_079 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_079 완료
echo.

echo [RUN] Case: study_080 시작
pushd "cases\study_080"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_080 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_080 완료
echo.

echo [RUN] Case: study_081 시작
pushd "cases\study_081"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_081 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_081 완료
echo.

echo [RUN] Case: study_082 시작
pushd "cases\study_082"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_082 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_082 완료
echo.

echo [RUN] Case: study_083 시작
pushd "cases\study_083"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_083 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_083 완료
echo.

echo [RUN] Case: study_084 시작
pushd "cases\study_084"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_084 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_084 완료
echo.

echo [RUN] Case: study_085 시작
pushd "cases\study_085"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_085 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_085 완료
echo.

echo [RUN] Case: study_086 시작
pushd "cases\study_086"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_086 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_086 완료
echo.

echo [RUN] Case: study_087 시작
pushd "cases\study_087"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_087 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_087 완료
echo.

echo [RUN] Case: study_088 시작
pushd "cases\study_088"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_088 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_088 완료
echo.

echo [RUN] Case: study_089 시작
pushd "cases\study_089"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_089 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_089 완료
echo.

echo [RUN] Case: study_090 시작
pushd "cases\study_090"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_090 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_090 완료
echo.

echo [RUN] Case: study_091 시작
pushd "cases\study_091"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_091 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_091 완료
echo.

echo [RUN] Case: study_092 시작
pushd "cases\study_092"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_092 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_092 완료
echo.

echo [RUN] Case: study_093 시작
pushd "cases\study_093"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_093 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_093 완료
echo.

echo [RUN] Case: study_094 시작
pushd "cases\study_094"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_094 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_094 완료
echo.

echo [RUN] Case: study_095 시작
pushd "cases\study_095"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_095 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_095 완료
echo.

echo [RUN] Case: study_096 시작
pushd "cases\study_096"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_096 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_096 완료
echo.

echo [RUN] Case: study_097 시작
pushd "cases\study_097"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_097 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_097 완료
echo.

echo [RUN] Case: study_098 시작
pushd "cases\study_098"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_098 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_098 완료
echo.

echo [RUN] Case: study_099 시작
pushd "cases\study_099"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_099 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_099 완료
echo.

echo [RUN] Case: study_100 시작
pushd "cases\study_100"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] study_100 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: study_100 완료
echo.

echo [RUN] Case: tmp_run_case_gapx_check 시작
pushd "cases\tmp_run_case_gapx_check"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] tmp_run_case_gapx_check 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: tmp_run_case_gapx_check 완료
echo.

echo [RUN] Case: user_case_v001 시작
pushd "cases\user_case_v001"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] user_case_v001 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: user_case_v001 완료
echo.

echo [RUN] Case: user_make_case_v001 시작
pushd "cases\user_make_case_v001"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] user_make_case_v001 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: user_make_case_v001 완료
echo.

echo [RUN] Case: user_make_case_v002 시작
pushd "cases\user_make_case_v002"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] user_make_case_v002 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: user_make_case_v002 완료
echo.

echo [RUN] Case: user_make_case_v003 시작
pushd "cases\user_make_case_v003"
call lsruncommand.bat
popd
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] user_make_case_v003 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)
    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.
    pause
)
echo [DONE] Case: user_make_case_v003 완료
echo.

echo [FINISH] 모든 케이스의 순차 실행이 완료되었습니다.
pause

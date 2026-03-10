"""
generate_master_batch.jl

Description:
    'cases/' 디렉토리를 스캔하여 존재하는 모든 'lsruncommand.bat' 파일을 순차적으로 
    실행하는 'master_run.bat' 리스트 파일을 생성합니다.

Usage:
    julia generate_master_batch.jl
"""

using Printf

function generate_master_batch()
    root_dir = @__DIR__
    cases_dir = joinpath(root_dir, "cases")
    output_bat = joinpath(root_dir, "master_run.bat")

    if !isdir(cases_dir)
        println("[ERROR] 'cases/' 디렉토리를 찾을 수 없습니다: $cases_dir")
        return
    end

    # cases/ 폴더 내 하위 디렉토리 탐색
    all_items = readdir(cases_dir, join=true)
    folders = filter(isdir, all_items)

    # 폴더명으로 정렬 (순차 실행을 위함)
    sort!(folders)

    valid_runs = []
    for folder in folders
        lsrun_bat = joinpath(folder, "lsruncommand.bat")
        if isfile(lsrun_bat)
            push!(valid_runs, folder)
        end
    end

    if isempty(valid_runs)
        println("[WARN] 실행 가능한 'lsruncommand.bat' 파일을 가진 폴더가 없습니다.")
        return
    end

    # 배치 파일 작성
    open(output_bat, "w") do io
        write(io, "@echo off\n")
        write(io, "setlocal EnableExtensions\n\n")
        write(io, "echo [INFO] =======================================================\n")
        write(io, "echo [INFO] 마스터 배치 실행 리스트를 시작합니다.\n")
        write(io, "echo [INFO] 실행 대상 폴더 수: $(length(valid_runs))\n")
        write(io, "echo [INFO] =======================================================\n\n")

        for folder in valid_runs
            rel_folder = relpath(folder, root_dir)
            folder_name = basename(folder)

            write(io, "echo [RUN] Case: $folder_name 시작\n")
            write(io, "pushd \"$rel_folder\"\n")
            write(io, "call lsruncommand.bat\n")
            write(io, "popd\n")
            write(io, "if %ERRORLEVEL% NEQ 0 (\n")
            write(io, "    echo [ERROR] $folder_name 실행 중 오류 발생 (Exit Code: %ERRORLEVEL%)\n")
            write(io, "    echo [PAUSE] 오류 확인을 위해 일시 중지합니다. 계속하려면 아무 키나 누르세요.\n")
            write(io, "    pause\n")
            write(io, ")\n")
            write(io, "echo [DONE] Case: $folder_name 완료\n")
            write(io, "echo.\n\n")
        end

        write(io, "echo [FINISH] 모든 케이스의 순차 실행이 완료되었습니다.\n")
        write(io, "pause\n")
    end

    println("[SUCCESS] '$(basename(output_bat))' 파일이 생성되었습니다.")
    println("총 $(length(valid_runs))개의 케이스가 리스트에 등록되었습니다.")
end

generate_master_batch()

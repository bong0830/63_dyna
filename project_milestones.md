# Project Milestones & Update Log

## 2026-03-10
* **메쉬 수렴성 테스트 추가 및 컴퓨팅 사양 변경 (m07 ~ m11)**
  * `generate_study_cases.jl` 파일의 `BASE_OVERRIDES`에 컴퓨팅 리소스(`ncpu=30`, `memory=50g`) 추가.
  * 기존 m01~m06 케이스를 보존하면서 사용자가 요청한 5가지 새로운 메쉬 케이스(`m07` ~ `m11`)를 `MESH_LEVELS` 배열에 추가함.
    * m07: nz=2, nx=20, ny=20
    * m08: nz=3, nx=20, ny=20
    * m09: nz=3, nx=30, ny=30
    * m10: nz=4, nx=20, ny=20
    * m11: nz=4, nx=30, ny=30
  * `julia generate_study_cases.jl mode=mesh` 명령어를 실행하여 파라미터 연구용 스크립트 및 csv 플랜(`mesh_convergence_plan.csv`) 갱신 완료.
  * `run_lsrun_sequence.bat` 배치 파일 생성 - 이미 생성된 `.k` 폴더들을 순회하며 내부에 있는 `lsruncommand.bat`만 순차적으로 연속 실행하는 독립형 범용 스크립트 구축.

## 2026-03-11
* **단일 스크립트 기반 자원 할당량 수정**
  * `generate_study_cases.jl` 파일의 `BASE_OVERRIDES`에서 `memory` 값을 현재 PC 스펙에 맞게 `15000m`로 하향 조정 (`ncpu=30`은 유지).
* **마스터 배치 실행 리스트 생성 (master_run.bat)**
  * `cases/` 폴더 내의 모든 시뮬레이션 케이스를 스캔하여 `lsruncommand.bat`가 존재하는 162개 폴더에 대해 순차 실행을 수행하는 `master_run.bat` 파일 생성.
  * 실행 중 오류 발생 시 사용자 확인을 위해 일시 중지(pause)하는 안전 장치 포함.
  * 리스트 생성을 자동화하는 `generate_master_batch.jl` 스크립트 구축.

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

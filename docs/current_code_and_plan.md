# 현재 코드 정리 및 작업 계획

## 1. 프로젝트 목적

이 저장소의 현재 코드는 LS-DYNA용 밴딩 해석 입력 파일(`.k`)을 자동 생성하는 용도다.
현재 활성 모델은 다음으로 구성된 quarter model이다.

- solid plate
- cylindrical punch
- cylindrical die

가까운 작업 목표는 두 단계다.

1. 기본 밴딩 해석을 실행해서 모델이 정상적으로 굽어지는지 확인한다.
2. 기본 케이스가 정상임을 확인한 뒤, 파라미터를 바꿔가며 반복 해석한다.

## 2. 현재 코드 구조

### 2.1 핵심 스크립트

#### `run_case.jl`

케이스 실행용 상위 래퍼 스크립트다.

주요 역할:

- 케이스명 규칙에 따라 case folder를 자동 생성한다.
- case folder 안으로 `00_main.k`, mesh file, `lsruncommand.bat`, `case_info.txt`를 생성한다.
- `cases/case_manifest.csv`에 케이스별 파라미터와 해석 조건을 누적 또는 갱신한다.
- 내부적으로 `generate_mesh_kfiles.jl`과 `generate_main_kfile.jl`을 순서대로 호출한다.
- 옵션에 따라 생성 직후 LS-DYNA를 case folder 내부에서 바로 실행한다.

기본 폴더명 규칙:

- `bend_v001_15,45,70,-6`

의미:

- `bend`: case prefix
- `v001`: case version
- `15,45,70,-6`: 기본 `case_keys=plate_t,punch_d,die_d,punch_disp_down` 값

주요 옵션:

- `case_name=...`: 폴더명을 직접 지정
- `case_prefix=...`: 폴더명 prefix 지정
- `case_version=...`: 버전 지정
- `case_keys=plate_t,punch_d,...`: 폴더명에 반영할 파라미터 목록 지정
- `cases_root=cases`: 케이스 폴더 상위 경로 지정
- `manifest_path=...`: 케이스 관리 CSV 경로 지정
- `run=true|false`: 생성 후 해석 실행 여부
- `allow_existing=true|false`: 기존 폴더 재사용 허용 여부
- `ncpu=8`, `memory=300m`, `dyna_exe=...`: LS-DYNA 실행 옵션 지정
- `punch_hold_ratio=...`: 최대 변위 도달 후 유지 시간 비율
- `punch_final_disp=...`: 해석 종료 시 punch 최종 변위
- `tool_shell_t=...`: punch/die shell 두께
- `tool_rigid=true|false`: punch/die를 `*MAT_RIGID`로 생성할지 지정
- `mass_scaling_dt=...`: explicit mass scaling 목표 timestep 지정
- `d3plot_dt=...`: d3plot 저장 간격 지정

예시:

- `julia run_case.jl case_version=v002`
- `julia run_case.jl case_name=test01 run=false`
- `julia run_case.jl case_keys=plate_t,punch_d,die_d,punch_x,die_x`

케이스 관리 CSV:

- 기본 경로는 `cases/case_manifest.csv`
- 같은 `case_name`으로 다시 생성하면 해당 행을 갱신한다.
- 주요 geometry, mesh, material, loading, solver option이 한 줄에 기록된다.
- `status` 컬럼으로 `generated`, `generated_no_run`, `finished` 상태를 추적한다.

#### `generate_mesh_kfiles.jl`

메쉬 파일 생성 스크립트다.

주요 역할:

- `key=value` 형식으로 형상 및 메쉬 파라미터를 입력받는다.
- quarter model 조건에 맞는지 검증한다.
- plate를 solid mesh로 생성한다.
- punch와 die를 y축 방향 cylindrical shell mesh로 생성한다.
- 대칭 경계조건용 node set과 tool node group을 생성한다.
- 아래 메쉬 파일들을 출력한다.
  - `10_plate_mesh.k`
  - `20_punch_mesh.k`
  - `30_die_mesh.k`

주요 흐름:

- `parse_args`: 입력 파라미터 해석
- `validate`: 형상 및 quarter model 조건 검증
- `generate_plate_mesh`: plate solid mesh 생성
- `generate_cylinder_shell_y`: punch/die shell mesh 생성
- `write_plate_mesh`, `write_tool_mesh`: `.k` 파일 기록
- `generate_mesh_files`: 전체 메쉬 생성 실행

기본값 기준 모델:

- plate: `300 x 300 x 15`
- punch diameter: `45`
- die diameter: `70`
- plate mesh: `30 x 30 x 3`
- punch/die circumferential divisions: `24`
- y-direction divisions: `30`

#### `generate_main_kfile.jl`

메인 해석 deck 생성 스크립트다.

주요 역할:

- material card 작성
- section card 작성
- part card 작성
- mesh file include 작성
- part set 작성
- contact pair 작성
- boundary condition 작성
- punch displacement curve와 prescribed motion 작성
- termination time과 d3plot output control 작성
- `00_main.k` 출력

현재 기본 설정:

- end time: `0.01`
- punch downward displacement: `-6.0`
- downward motion end time: 전체 시간의 `50%`
- punch hold ratio: `0.0`
- punch final displacement: `0.0`
- d3plot interval: `1.0e-4`
- friction: `fs=0.10`, `fd=0.08`
- plate material: `*MAT_PLASTIC_KINEMATIC`
- tool material: `*MAT_ELASTIC`

explicit 가속용 옵션:

- `tool_rigid=true`이면 punch/die를 `*MAT_RIGID`로 기록할 수 있다.
- `tool_shell_t`는 tool shell section 두께와 초기 tool 중심선 위치 계산에 함께 사용된다.
- `mass_scaling_dt > 0`이면 `*CONTROL_TIMESTEP`가 추가된다.
- `d3plot_dt`로 장시간 해석 시 결과 저장 간격을 완화할 수 있다.
- `punch_hold_ratio`와 `punch_final_disp`로 `0 -> down -> hold -> final` 곡선을 만들 수 있다.

주의사항:

- 현재 punch motion curve는 `0 -> down -> 0` 형태다.
- 즉, `t_down`까지 하강한 뒤 `t_end`에서 다시 0 변위로 돌아온다.
- 실제 밴딩 확인 목적이라면 "하강 후 유지"가 맞는지, "하강 후 복귀"가 맞는지 해석 목적에 맞춰 다시 점검해야 한다.

### 2.2 생성 결과 폴더

#### `kfiles_split`

현재 스크립트가 직접 생성하는 실행용 출력 폴더다.

구성:

- `00_main.k`
- `10_plate_mesh.k`
- `20_punch_mesh.k`
- `30_die_mesh.k`
- `lsruncommand.bat`

특징:

- 현재 기준의 메인 workflow다.
- boundary condition, contact, analysis control의 상당 부분이 `00_main.k` 안에 직접 들어간다.
- `lsruncommand.bat`가 `00_main.k`를 기준으로 LS-DYNA를 실행한다.

#### `kfiles_out`

예전 template 기반 출력 구조로 보인다.

구성:

- `00_main.k`
- `10_parts_materials.k`
- `20_plate_mesh.k`
- `30_tools_mesh.k`
- `40_bc_template.k`
- `50_analysis_template.k`

특징:

- `00_main.k`가 여러 template file을 include 한다.
- `40_bc_template.k`는 node-by-node boundary definition을 길게 갖고 있다.
- `50_analysis_template.k`는 contact와 loading이 TODO 상태다.
- 현재 유지보수 기준으로는 `kfiles_out`보다 `kfiles_split`이 더 단순하다.

## 3. 현재 모델 개념

### 3.1 모델 형식

- plate: 3D solid
- punch: y-axis cylindrical shell
- die: y-axis cylindrical shell
- modeling approach: quarter model
- symmetry planes:
  - `x=0`
  - `y=0`

### 3.2 경계조건 개념

- die 전체 node는 고정
- punch 전체 node는 z 방향으로만 움직이도록 제한
- plate는 x symmetry plane과 y symmetry plane에 대해 symmetry constraint 적용

### 3.3 접촉 개념

현재 두 개의 contact pair가 정의돼 있다.

- plate vs punch
- plate vs die

두 경우 모두 `*CONTACT_AUTOMATIC_SURFACE_TO_SURFACE`를 사용한다.

## 4. 현재까지 확인한 내용

- mesh generation flow와 main deck generation flow는 올바르게 연결돼 있다.
- `kfiles_split`의 생성 파일은 현재 스크립트 로직과 일치한다.
- batch file은 `kfiles_split/00_main.k`를 기준으로 LS-DYNA를 실행하도록 설정돼 있다.
- 즉, 아래 기본 파이프라인은 이미 갖춰져 있다.

`mesh generation -> main deck generation -> LS-DYNA run`

## 5. 작업 계획

### 5.1 1단계: 기본 밴딩 해석 실행 및 정상성 확인

목적:

- 현재 기본 조건에서 해석이 안정적으로 도는지 확인
- plate가 실제로 의도대로 굽는지 확인

주요 확인 항목:

- LS-DYNA가 fatal error 없이 종료되는지
- severe contact problem, hourglass issue, negative volume 같은 큰 문제가 없는지
- punch가 plate를 눌러 실제 bending deformation이 발생하는지
- 초기 punch/die 위치와 gap이 적절한지
- punch motion curve가 해석 목적과 맞는지

우선 확인할 파일:

- `d3hsp`
- `messag`
- `lsrun.out.txt`
- `d3plot` 결과

정상 판단 기준:

- termination time까지 해석이 도달
- plate가 불안정한 발산 없이 bending deformation을 보임
- contact와 boundary behavior가 의도와 크게 어긋나지 않음

### 5.2 2단계: 파라미터 변경 반복 해석

기본 케이스가 정상임을 확인한 뒤, 아래 파라미터를 바꿔가며 반복 해석할 수 있다.

형상 및 배치 파라미터:

- `plate_t`
- `punch_d`
- `die_d`
- `punch_x`
- `die_x`
- `punch_gap`
- `die_gap`

메쉬 파라미터:

- `plate_nx`
- `plate_ny`
- `plate_nz`
- `punch_ntheta`
- `punch_ny`
- `die_ntheta`
- `die_ny`

해석 및 재료 파라미터:

- `punch_disp_down`
- `t_end`
- `punch_down_ratio`
- `fs`
- `fd`
- `plate_sigy`
- `plate_etan`

### 5.3 반복 해석 권장 순서

1. 기본 케이스 1개를 기준 케이스로 확정한다.
2. punch motion과 contact behavior를 먼저 확인한다.
3. mesh sensitivity를 확인한다.
4. geometry parameter를 변경한다.
5. material과 friction parameter를 변경한다.
6. 케이스별 결과를 표로 정리한다.

## 6. 바로 다음 작업 제안

1. 현재 `kfiles_split` 기준으로 LS-DYNA를 1회 실행한다.
2. `d3hsp`, `messag`, `lsrun.out.txt`를 확인한다.
3. `d3plot`에서 실제 bending이 발생했는지 확인한다.
4. 필요하면 punch motion curve 또는 boundary condition을 수정한다.
5. 기준 케이스를 확정한 뒤 parameter sweep 전략을 정한다.

## 7. 작업 메모

- 현재 worktree에는 이미 사용자 변경이 있으므로 기존 변경은 보존해야 한다.
- 현재 작업 기준 구조는 `kfiles_out`보다 `kfiles_split` 쪽으로 보는 것이 맞다.
- 이후 반복 해석을 자동화하려면 case별 output folder naming rule도 같이 정하는 것이 좋다.

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
- `die_gap=...`: die를 x 방향으로 추가 이동시키는 gap
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
  - `ro=7.85e-9`, `e=2.05e5`, `pr=0.28`, `sigy=245`, `etan=1500`, `beta=1.0`
  - `src=40.4`, `srp=5.0`, `fs=0`, `vp=0`
- tool material: `*MAT_ELASTIC`

explicit 가속용 옵션:

- `tool_rigid=true`이면 punch/die를 `*MAT_RIGID`로 기록할 수 있다.
- `tool_shell_t`는 tool shell section 두께와 초기 tool 중심선 위치 계산에 함께 사용된다.
- `die_gap`은 die의 z방향 이격이 아니라 x방향 추가 오프셋으로 해석한다.
- `mass_scaling_dt > 0`이면 `*CONTROL_TIMESTEP`가 추가된다.
- `d3plot_dt`로 장시간 해석 시 결과 저장 간격을 완화할 수 있다.
- `punch_hold_ratio`와 `punch_final_disp`로 `0 -> down -> hold -> final` 곡선을 만들 수 있다.
- 해석 제어 시간/곡선 값은 compact 숫자 포맷으로 기록해 LS-DYNA 카드 필드 overflow를 피한다.

주의사항:

- 실제 curve 형상은 `punch_hold_ratio`, `punch_final_disp`, `punch_press_time`, `punch_release_time`, `punch_press_speed`, `punch_release_speed` 조합에 따라 달라진다.
- 즉, 현재 코드는 단순 `0 -> down -> 0`만 지원하는 상태가 아니라 `press -> hold -> release` 스케줄도 구성할 수 있다.
- 문서나 해석 기록을 남길 때는 "현재 케이스가 어떤 schedule을 사용했는지"를 manifest와 함께 적어야 한다.

### 2.2 생성 결과 폴더

#### `cases/<case_name>`

현재 스크립트가 직접 생성하는 실제 실행용 출력 폴더다.

구성:

- `00_main.k`
- `10_plate_mesh.k`
- `20_punch_mesh.k`
- `30_die_mesh.k`
- `lsruncommand.bat`
- `case_info.txt`
- LS-DYNA 실행 결과 파일들 (`d3plot`, `d3hsp`, `messag`, `lsrun.out.txt` 등)

특징:

- 현재 기준의 메인 workflow다.
- `run_case.jl`이 케이스 폴더를 만들고 그 내부에 모든 입력/실행 파일을 생성한다.
- boundary condition, contact, analysis control의 상당 부분이 `00_main.k` 안에 직접 들어간다.
- `lsruncommand.bat`가 같은 케이스 폴더의 `00_main.k`를 기준으로 LS-DYNA를 실행한다.
- `cases/case_manifest.csv`가 각 케이스 폴더와 파라미터를 인덱싱한다.

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
- 현재 실제 생성 대상은 `kfiles_split` 고정 폴더가 아니라 `cases/<case_name>` 폴더다.
- batch file은 각 case 폴더의 `00_main.k`를 기준으로 LS-DYNA를 실행하도록 설정돼 있다.
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
- `plate_src`
- `plate_srp`

### 5.3 반복 해석 권장 순서

1. 기본 케이스 1개를 기준 케이스로 확정한다.
2. punch motion과 contact behavior를 먼저 확인한다.
3. mesh sensitivity를 확인한다.
4. geometry parameter를 변경한다.
5. material과 friction parameter를 변경한다.
6. 케이스별 결과를 표로 정리한다.

## 6. 바로 다음 작업 제안

1. 현재 `cases/<case_name>` 기준으로 LS-DYNA를 1회 실행한다.
2. `d3hsp`, `messag`, `lsrun.out.txt`를 확인한다.
3. `d3plot`에서 실제 bending이 발생했는지 확인한다.
4. 필요하면 punch motion curve 또는 boundary condition을 수정한다.
5. 기준 케이스를 확정한 뒤 parameter sweep 전략을 정한다.

## 7. 작업 메모

- 현재 worktree에는 이미 사용자 변경이 있으므로 기존 변경은 보존해야 한다.
- 현재 작업 기준 구조는 `kfiles_out` 같은 레거시 템플릿보다 `run_case.jl -> cases/<case_name>` 흐름으로 보는 것이 맞다.
- 이후 반복 해석을 자동화하려면 case별 output folder naming rule도 같이 정하는 것이 좋다.

## 8. 문서 동기화 규칙

- 코드 동작이 바뀌면 같은 작업에서 이 문서를 함께 갱신한다.
- 특히 아래 항목이 바뀌면 문서 갱신을 필수로 본다.
  - 실행 진입점과 기본 workflow
  - 입력 파라미터 이름, 기본값, 허용 모드
  - 생성 파일 구조와 산출물 위치
  - manifest 컬럼, 상태값, 케이스 네이밍 규칙
  - 해석 스케줄 규칙 (`disp`/`force`, hold/release, gravity, mass scaling 등)
- 문서 내용은 "예전 구조 설명"보다 "현재 코드가 실제로 하는 일"을 우선한다.
- `kfiles_out` 같은 레거시 자산은 유지 목적이 아니라면 현재 운영 경로로 오해되지 않게 명시한다.
- 문서를 갱신할 때는 가능하면 코드 확인 근거를 남긴다.
  - 예: 어떤 스크립트의 함수/인자/출력 파일을 기준으로 설명했는지

## 9. 커밋 규칙

- 코드 변경만 하지 말고, 그 변경이 사용자 동작이나 운영 규칙에 영향을 주면 관련 문서도 같은 커밋에 포함한다.
- 커밋 메시지와 변경 기록에는 한국어 요약을 반드시 포함한다.
- 커밋 메시지는 한 줄 제목만 끝내지 말고, 아래 내용을 추적 가능하게 남긴다.
  - 변경: 무엇을 바꿨는지
  - 이유: 왜 바꿨는지
  - 검증: 어떤 명령으로 확인했는지
  - 영향: 사용자/코드베이스 영향
- 위 네 항목은 커밋 본문에 넣거나, PR/작업 기록 문서에 같은 형식으로 남겨도 된다. 다만 한국어 요약은 반드시 포함한다.
- 문서만 수정한 커밋이어도 검증 항목은 비워두지 말고, 최소한 확인한 파일/명령을 적는다.

권장 커밋 메시지 형식:

```text
<type>: <짧은 제목>

한국어 요약: 한 줄 요약
변경: 무엇을 바꿨는지
이유: 왜 바꿨는지
검증: 어떤 명령으로 확인했는지
영향: 사용자/코드베이스 영향
```

예시:

```text
docs: sync current workflow and commit policy

한국어 요약: 현재 코드 기준으로 문서와 작업 규칙을 동기화
변경: cases 기반 실행 구조, 문서 동기화 규칙, 커밋 기록 규칙을 정리
이유: 실제 운영 흐름과 문서 설명의 차이를 줄이고 변경 추적 형식을 통일하기 위해
검증: Get-Content -Raw docs/current_code_and_plan.md
영향: 이후 코드 변경 시 문서 누락과 커밋 기록 누락 가능성이 줄어듦
```

## 10. 작업 완료 후 확인 규칙

- 모든 변경이 끝난 뒤에는 바로 작업을 종료하지 말고, 아래 두 선택지 중 무엇을 할지 사용자에게 먼저 확인한다.
1. 변경내용 정리 및 문서 동기화, 커밋, 푸쉬
2. 계속 진행
- 위 질문은 매 작업 완료 시점마다 반복한다.
- 1번을 선택하면 다음 순서로 진행한다.
  - 변경내용 정리
  - 관련 문서 동기화 확인
  - 커밋
  - 푸쉬
- 2번을 선택하면 커밋/푸쉬를 보류하고 다음 작업을 계속 진행한다.
- 사용자가 명시적으로 다른 지시를 주지 않은 이상, 작업 완료 후 마무리 단계에서 이 질문을 생략하지 않는다.

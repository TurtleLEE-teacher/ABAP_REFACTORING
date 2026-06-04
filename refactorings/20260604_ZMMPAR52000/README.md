# 20260604_ZMMPAR52000

ABAP 리팩토링 작업 폴더. 현재 **As-Is 원본만 확보**된 상태 (리팩토링 미실행).

| 항목 | 내용 |
| --- | --- |
| 프로그램 ID | `ZMMPAR52000` |
| 프로그램명 (한글) | (확인 필요) — 초기 재고(Initial Stock) 관련 |
| 모듈 | MM (추정, 확인 필요) |
| 입력 단위 | PROG 전체 (다중 INCLUDE) |
| 적용 모드 | **R + M** (성능 P 제외) |
| 작업일 | 2026-06-04 |
| 상태 | 🟢 진행중 — Phase 0/C5 완료, C1 파일럿 1건 ([REPORT.md](./REPORT.md)) |

## 구성

- [`as-is/zmmpar52000/`](./as-is/zmmpar52000/) — 업로드된 원본 소스 (HTML 내보내기, 원본 패키지 구조 그대로 보존)
- [`to-be/`](./to-be/) — 리팩토링 결과 (예정)
- [`REPORT.md`](./REPORT.md) — 진단/비교/사유표/체크리스트 (예정)

## As-Is 구성 요소 (다중 INCLUDE)

| 분류 | 파일 | 비고 |
| --- | --- | --- |
| Main | `zmmpar52000.html` | 메인 프로그램 |
| TOP | `zmmpar52000top.html` | 글로벌 선언부 |
| SCR | `zmmpar52000scr.html` | Selection Screen |
| CXX | `zmmpar52000c01.html` | Class 정의 |
| OXX | `zmmpar52000o01.html` | PBO 모듈 |
| IXX | `zmmpar52000i01.html` | PAI 모듈 |
| FXX | `zmmpar52000f01.html`, `zmmpar52000f02.html` | Subroutines (대용량: f01 ~216KB, f02 ~345KB) |
| Screens | `screens/screen_0100~0500.txt` | 화면 5개 |
| Dictionary | `dictionary/*.html` | CBO 테이블/구조 (zmmpat52000/52010, zpaspt0002 등) |
| Function | `zsppa_authority_check_bukrs/`, `zsppa_authority_check_werks/` | 권한 체크 FM (회사코드/플랜트) |
| 기타 | `zmmpa_initial_stock/` | 초기 재고 관련 오브젝트 |

## 다음 단계

> ⚠️ **다중 INCLUDE 프로그램** → 리팩토링 시 [스킬](../../skill/ABAP_REFACTORING_SKILL.md)의 **Phase 0(전체 스캔)** 선행 필수.
> 한 INCLUDE만 떼서 작업 금지 (글로벌 변수/구조체/매크로 횡단 의존성 보호).

1. 적용 **모드 지정** (R / M / P, P는 R·M과 결합)
2. Phase 0: 전체 코드 확보 확인 → 의존성 매트릭스 / 호출 그래프 / 변경 클러스터 작성
3. Phase 1~5: As-Is 진단 → To-Be 제안 → 셀프 크리틱 → 리포트
4. 결과를 `to-be/` + `REPORT.md`에 기록

> 근거 표기(FS §N)는 [`../../standards/ABAP_CODE_STANDARD.md`](../../standards/ABAP_CODE_STANDARD.md) 섹션 번호.

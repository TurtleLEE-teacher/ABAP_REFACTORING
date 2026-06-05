# to-be-modern/ — S/4 모던 ALV 리팩토링 (완전 세트, 드롭인 초안)

ZMMPAR52000의 **전체 INCLUDE 8개**(모던화 + 미변경 재사용 포함). 5벌→2벌 ALV, RTTI 필드카탈로그, 단일 이벤트클래스, 컨트롤 생명주기 적용.

> ⚠️ **SE38 검증 필요 초안**. 본 환경에서 ABAP 컴파일/실행 불가 → 정적 리뷰만 통과.
> 반영 전 [`REVIEW_REPORT.md`](./REVIEW_REPORT.md)의 HIGH/MID 항목과 [`ALV_MODERNIZATION_DESIGN.md`](./ALV_MODERNIZATION_DESIGN.md) §4 수작업 단계를 반드시 확인.
> 안전 버전이 필요하면 [`../to-be/`](../to-be/)(R+M, 즉시 배포 가능)를 사용.

## 파일 (복붙 대상)

| 파일 | 역할 | 모던화 |
|---|---|---|
| `zmmpar52000.abap` | 메인 프로그램 | = (INCLUDE명 동일, 미변경) |
| `zmmpar52000top.abap` | 글로벌 선언 | **모던** (ALV 인프라 5벌→2벌 MAIN/POP) |
| `zmmpar52000c01.abap` | 이벤트 클래스 | **모던** (6벌→단일, SY-DYNNR 분기) |
| `zmmpar52000scr.abap` | 셀렉션 스크린 | = (`to-be/`와 동일, 미변경) |
| `zmmpar52000o01.abap` | PBO 모듈 | **모던** (CREATE_ALV_100~500 → 단일 CREATE_ALV) |
| `zmmpar52000i01.abap` | PAI 모듈 | **모던** (USER_COMMAND_0100~0500 → 단일) |
| `zmmpar52000f01.abap` | 비즈니스 로직 | = (`to-be/`와 동일, 미변경) |
| `zmmpar52000f02.abap` | ALV 표시·셋업 | **모던** (4086→1531줄, RTTI 필드카탈로그 + 생명주기) |

## 메모
- **메인 진입 화면 = 0400** (`DISPLAY_DATA` → `CALL SCREEN 400`). 팝업 = 0200/0300/0500. (화면 0100 미사용)
- 화면(Dynpro)·텍스트 기호·PF-STATUS는 ABAP 소스 아님 → SE51/SE41/텍스트요소 관리.

## 반영 전 필수 (REVIEW_REPORT 요약)
- **H2**: 메인 0400 화면을 `CL_GUI_CONTAINER=>SCREEN0` 풀스크린으로 (원본 Docking) — Screen Painter 확인
- **M2**: 텍스트 기호(`TEXT-F51~F78`, `N04/N05`, `T01~T14`) 등록 확인
- **M3**: 화면 Flow Logic 모듈명 통일(PBO `CREATE_ALV`, PAI `USER_COMMAND`, `EXIT_COMMAND` AT EXIT-COMMAND)

## 검증 순서
TOP/C01/O01/I01/F02 교체(+ 메인·SCR·F01) → 활성화 → **0400 메인 → 팝업 0200/0300/0500 연속 오픈·닫기 → 집계** 가 `to-be/`와 동일한지 비교.

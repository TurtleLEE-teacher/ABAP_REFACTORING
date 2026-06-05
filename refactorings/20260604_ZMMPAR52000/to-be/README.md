# to-be/ — R+M 리팩토링 결과 (완전 세트, 드롭인)

ZMMPAR52000 프로그램의 **전체 INCLUDE 8개**. SE38에 그대로 복붙해서 쓰는 1차(R+M) 결과물.
**로직 무변경** — 가독성(컬럼 한글주석) + 유지보수(죽은 주석코드 정리)만 적용. 바로 배포 가능.

## 파일 (복붙 대상)

| 파일 | 역할 | SE38 INCLUDE 명 |
|---|---|---|
| `zmmpar52000.abap` | **메인 프로그램**(REPORT + INCLUDE 목록 + 이벤트) | ZMMPAR52000 (Main) |
| `zmmpar52000top.abap` | 글로벌 선언 | ZMMPAR52000TOP |
| `zmmpar52000c01.abap` | 로컬 이벤트 클래스 | ZMMPAR52000C01 |
| `zmmpar52000scr.abap` | 셀렉션 스크린 | ZMMPAR52000SCR |
| `zmmpar52000o01.abap` | PBO 모듈 | ZMMPAR52000O01 |
| `zmmpar52000i01.abap` | PAI 모듈 | ZMMPAR52000I01 |
| `zmmpar52000f01.abap` | 비즈니스 로직 | ZMMPAR52000F01 |
| `zmmpar52000f02.abap` | ALV 표시 | ZMMPAR52000F02 |

## 메모
- **메인 진입 화면 = 0400** (`DISPLAY_DATA` → `CALL SCREEN 400`). 팝업 = 0200/0300/0500. (화면 0100은 현재 흐름 미사용)
- 화면(Dynpro 0200~0500)·텍스트 기호·PF-STATUS·GUI Status는 **ABAP 소스가 아님** → SE51/SE41/텍스트요소에서 별도 관리(기존 그대로 사용).
- 외부 FM `ZSPPA_AUTHORITY_CHECK_BUKRS/WERKS`는 표준 객체(변경 안 함).

## 드롭인 방법
각 INCLUDE 소스를 SE38에서 해당 INCLUDE에 붙여넣기 → 활성화(SLIN 무경고 확인) → 기존과 동일 동작 확인.

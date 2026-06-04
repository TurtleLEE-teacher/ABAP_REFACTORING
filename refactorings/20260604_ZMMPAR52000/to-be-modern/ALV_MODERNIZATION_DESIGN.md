# 🖥️ ZMMPAR52000 ALV 모던화 설계 (v2)

> **목적**: 구식 ALV(5벌 중복 `_100~500`, 수동 필드카탈로그, `CREATE OBJECT`, 클래스 5~6벌)를
> [`standards/patterns/ALV_MODERN_PATTERN.md`](../../../standards/patterns/ALV_MODERN_PATTERN.md) 방향으로 현대화.
> **메타원칙**: 가독성/유지보수 우선([standards/README.md](../../../standards/README.md)). 비즈니스 로직(F01 데이터 조회/가공)은 **변경하지 않음** — ALV 표시 계층만 재구성.

> ⚠️ **상태 = SE38 반영용 초안(v2)**. 본 환경에서는 ABAP 컴파일·실행 검증 불가. 아래 "수작업 단계 + 사전 점검"을 SE38에서 반드시 수행한 뒤 활성화할 것. 안전한 1차 결과물은 [`../to-be/`](../to-be/)에 그대로 보존(배포 가능).

---

## 1. 화면 → 역할 매핑

| 화면 | 역할 | 호출 | 데이터 테이블 | 필드카탈로그(구) | PF-STATUS |
|---|---|---|---|---|---|
| 0100 | **MAIN**(풀스크린) | `CALL SCREEN 100` | `GT_DISP` | `BUILD_CATEGORY_100`(주석처리) | 0100 |
| 0400 | **MAIN**(풀스크린·배치) | `CALL SCREEN 400` | `GT_BATCH_0400` | `BUILD_CATEGORY_400`(주석처리) | 0400 |
| 0200 | **POP**(팝업) | `CALL SCREEN 0200 STARTING AT` | `GT_RAW_DISP` | `BUILD_CATEGORY_200` | 0200 |
| 0300 | **POP**(팝업) | `CALL SCREEN 0300 STARTING AT` | `GT_SIT_DISP` | `BUILD_CATEGORY_300` | 0300 |
| 0500 | **POP**(팝업) | `CALL SCREEN 0500 STARTING AT` | `GT_DISP_0500` | `BUILD_CATEGORY_500` | 0200 |

**핵심**: 풀스크린(0100/0400)과 팝업(0200/0300/0500)은 **동시에 하나만 활성**.
→ 그리드 인스턴스를 **역할별 2개**(`GCL_GRID_MAIN`, `GCL_GRID_POP`)로 두고 **화면 진입 시 재생성**(이전 것 FREE)하면 5벌 인프라가 2벌로 축약된다.

---

## 2. As-Is → To-Be 구조 변화

| 구분 | As-Is (구식) | To-Be (모던) |
|---|---|---|
| 그리드/컨테이너 | `GV_ALV_GRID_100~500` + `GV_DOCKING/CUST/SPLITTER_*` (35개 객체) | `GCL_GRID_MAIN`/`GCL_GRID_POP` + role별 splitter/docking (2벌) |
| 객체 생성 | `CREATE OBJECT ... EXPORTING` | `NEW #( )` + 메서드 체이닝 |
| 필드카탈로그 | `REUSE_ALV_FIELDCATALOG_MERGE`+`LVC_TRANSFER_FROM_SLIS`+수동 append | `CL_SALV_DATA_DESCR=>READ_STRUCTDESCR`(RTTI) + CASE 커스터마이징 + `_LMC_SET_TEXT` |
| 이벤트 클래스 | `LCL_EVENT_RECEIVER_100~500`+`110` (6개) | **단일 `LCL_EVENT_RECEIVER`** + `SY-DYNNR`/`SENDER` 분기 |
| 이벤트 등록 | 화면별 `SET HANDLER` 반복 | `CREATE_EVENT_RECEIVER USING po_grid` 공통화 |
| 표시 | `DISPLAY_ALV_100~500` (5벌) | `DISPLAY_ALV_MAIN`/`DISPLAY_ALV_POP` (2벌, 파라미터화) |
| 컨트롤 해제 | 불명확/덤프 위험 | 생명주기 철칙: 자식 FREE 금지(CLEAR만)·팝업 "열기 직전" 해제·FREE 후 `CL_GUI_CFW=>FLUSH` |
| 동적 테이블명 | `GV_INTTAB100~500` + `ASSIGN (name)` | 정적 itab 직접 바인딩(가능 시) |

**이벤트 분기 주의**: MAIN 그리드가 0100/0400에 재사용되므로 `SENDER`만으로 화면 구분 불가 → 핸들러 내부에서 **`SY-DYNNR` 기준 분기**(`HANDLE_DOUBLE_CLICK_100` vs `_400`). POP도 동일.

---

## 3. To-Be INCLUDE 구성 (to-be-modern/)

| 파일 | 내용 | 상태 |
|---|---|---|
| `zmmpar52000c01.abap` | 단일 `LCL_EVENT_RECEIVER`(SY-DYNNR 분기) | ✅ 완료 |
| `zmmpar52000top.abap` | 데이터 구조 유지 + ALV 인프라 2벌(MAIN/POP) 선언 | ✅ 완료 |
| `zmmpar52000f02.abap` | 모던 ALV 셋업 + **핸들러/비즈니스 FORM 합본**(컴파일 가능 초안). 4086→1422줄 | ✅ 합본 완료 |
| `zmmpar52000o01.abap` | 슬림 PBO: `STATUS_0100` + 단일 `CREATE_ALV` | ✅ 완료 |
| `zmmpar52000i01.abap` | 슬림 PAI: `EXIT_COMMAND` + 단일 `USER_COMMAND` | ✅ 완료 |

> F01(비즈니스 로직)·SCR(셀렉션)은 모던화 대상 아님 — 기존 [`../to-be/`](../to-be/) 버전 재사용.
>
> **합본 완료(2026-06-04)**: 핸들러/비즈니스 FORM(`HANDLE_DOUBLE_CLICK_100~500`, `HANDLE_USER_COMMAND_100/400`, `HANDLER_TOOLBAR(_0400)`, `TOP_OF_PAGE`, `ADD_TEXT`, `ALV_CLASS_REFRESH`, `BUFFER_CLEAR_PROC`)을 `to-be/f02`에서 이관(로직 무변경). 구 변수 재매핑(`GV_ALV_DOCUMENT→GCL_ALV_DOCUMENT`, `GV_ALV_GRID_100/400→GCL_GRID_MAIN`). `HTML_DISPLAY`는 모던판(화면별 컨테이너+`GCL_HTML_VIEWER` CLEAR)으로 교체. **모든 PERFORM 대상 해석 확인, FORM/ENDFORM 25/25.**
>
> **필드카탈로그 규칙 이관 완료(2026-06-04)**: `BUILD_FIELDCAT`에 화면별 컬럼 규칙(`FCAT_RULE_0200/0300/0500`)을 구 `BUILD_CATEGORY_200/300/500`에서 이관 — 숨김(NO_OUT)·col_pos·COLTEXT(`TEXT-Fxx`)·DO_SUM·CFIELDNAME/QFIELDNAME·`P_VAL` 조건부 금액컬럼·SIT 강조(C710) 포함. 레거시 `REUSE_ALV_FIELDCATALOG_MERGE` 완전 제거, RTTI(`CL_SALV_DATA_DESCR`)로 대체. 0100/0400은 구 BUILD_CATEGORY가 주석처리였으므로 RTTI 기본 유지.
>
> **SE38 잔여(필수)**: ① Screen Painter/PF-STATUS/**텍스트기호(`TEXT-F51~F78`, `N04/N05`)** 등록 확인(§4) ② 화면 Flow Logic을 단일 모듈명(`CREATE_ALV`/`USER_COMMAND`)으로 통일 ③ 활성화(SLIN)·5화면 테스트.

---

## 4. SE38 수작업 단계 (코드 반영 후 필수)

1. **Screen Painter(SE51)**: 0100/0400 풀스크린의 ALV 영역이 `CL_GUI_CONTAINER=>SCREEN0` 사용 → 커스텀 컨테이너 제거/조정. 0200/0300/0500 팝업은 docking이라 화면에 컨테이너 불필요.
2. **PF-STATUS(SE41)**: 0100/0200/0300/0400 상태 존재 확인. 없으면 기존 복사 생성.
3. **텍스트 기호(SE38)**: RTTI 필드카탈로그는 텍스트 기호 미등록 시 DDIC fallback → `_LMC_SET_TEXT`에 쓰는 모든 `TEXT-Fxx` 등록 확인.
4. **MESSAGE-ID**: `ZMCMM02` 유지(또는 `00`).

## 5. 사전 점검 체크리스트 (출력/활성화 전 — CBO_REVIEW_GUIDE §6)

- [ ] FORM 파라미터 타입 호출부 일치(`LVC_FNAME` 등)
- [ ] 풀스크린=`SCREEN0`·팝업=`DOCKING` 분리
- [ ] 팝업 컨트롤 "열기 직전" 해제, EXIT는 `LEAVE TO SCREEN 0`만
- [ ] HTML Viewer는 `CLEAR`만(FREE 금지), FREE 후 `CL_GUI_CFW=>FLUSH`
- [ ] 금액/수량 필드 `CFIELDNAME`/`QFIELDNAME` 지정(KRW ×100 방지)
- [ ] 텍스트 기호 빈값 없음 / PF-STATUS 존재
- [ ] PBO MODULE명 일치 / PAI USER_COMMAND·EXIT_COMMAND 등록

## 6. 검증(SE38)

- 활성화(SLIN 무경고) → 5개 화면(메인 0100/0400 + 팝업 0200/0300/0500) 표시·더블클릭·툴바·집계 동작을 **As-Is(`to-be/`)와 동일**한지 비교.
- 의미 보존: F01 로직 무변경이므로 데이터 결과는 동일해야 함. 표시 계층만 검증.

## 7. 리스크 & 롤백

- 리스크: 화면-컨테이너 바인딩(Screen Painter)·PF-STATUS·텍스트기호 누락 시 런타임 덤프. → 사전 점검으로 차단.
- 롤백: 안전 버전 [`../to-be/`](../to-be/) 그대로 사용 / `git revert`.

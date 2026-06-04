# 🔄 [ABAP 리팩토링] ZMMPAR52000 `[MM] 재고 수불부` — As-Is vs To-Be

| 항목 | 내용 |
| --- | --- |
| 프로그램 ID / 명 | `ZMMPAR52000` / `[MM] 재고 수불부` |
| 모듈 | MM |
| 입력 단위 | PROG 전체 (다중 INCLUDE) |
| 적용 모드 | **R + M** (성능 P 제외) |
| 대상 환경 | S/4 HANA (Release 755) |
| 작업일 | 2026-06-04 |
| 대소문자 정책 | **전부 대문자 유지** (alias A/B/C도 대문자, 연산자 EQ/NE 원본 유지) |
| 진행 순서 | **C5 → C1 → C4 → C3 → C2** |
| As-Is 소스 | [`as-is/zmmpar52000/`](./as-is/zmmpar52000/) |
| To-Be 소스 | [`to-be/`](./to-be/) (클러스터 완료 시 INCLUDE별 산출) |

> 근거 표기(FS §N)는 [`../../standards/ABAP_CODE_STANDARD.md`](../../standards/ABAP_CODE_STANDARD.md) 섹션.
> ⚠️ `zsppa_authority_check_bukrs/`·`werks/`(zspmaf0010 등)는 **외부 표준 FM/라이브러리 → 범위 외(참조 only)**.

---

## 0. 📋 Phase 0 — 전체 스캔

### 0-1. 구조 맵
| INCLUDE | 책임 | 규모 | 비고 |
|---|---|---|---|
| `…TOP` | 글로벌 선언 | GT_ 내부테이블 51개 + GS_/GV_ 다수, 매크로 2개(`__EXCLUDE`,`_MC_POPUP_CONFIRM`) | 중복 구조체 |
| `…C01` | 로컬 클래스 | `LCL_EVENT_RECEIVER_100~500`+`110` | 5벌 중복 |
| `…SCR` | 셀렉션 스크린 | RB_MM/RB_CO·P_SPMON·S_BUDAT | MM/CO 모드 분기 |
| `…O01` | PBO | `STATUS_0100`,`CREATE_ALV_100~500` | 5벌 중복 |
| `…I01` | PAI | `USER_COMMAND_0100~0500`,EXIT | 5벌 중복 |
| `…F01` | 비즈니스 로직 | FORM ~24개 (SELECT/가공/권한) | SQL 핵심 |
| `…F02` | ALV 표시 | FORM ~70개 | 100/200/300/400/500 5벌 중복 |

### 0-2. 호출/의존성 (핵심)
- **이벤트**: `START-OF-SELECTION` → `CHECK_INPUT` → `CHK_AUTH`(→외부 FM `ZSPPA_AUTHORITY_CHECK_BUKRS`/`WERKS`) → `CREATE_DYNAMIC_TABLE` → `SELECT_DATA` → `DISPLAY_DATA`
- `SELECT_DATA` → `PERIOD_SETTING`/`GET_GROUP_ZMMT0010`/`SHOW_BATCH_DATA` → `MATERIAL_DOC_BASIC_STOCK`(대형)
- **횡단 글로벌**: `GT_RAW_DISP`/`GT_DISP_0500`/`GT_BATCH_0400`(화면별 표시 구조, 필드 거의 동일), `GV_INTTAB100~500`, `GT_GROUP`/`GT_ZMMT0010`

### 0-3. 변경 클러스터
| ID | 내용 | 모드 | 영향 | 위험/동반 | 상태 |
|---|---|---|---|---|---|
| **C5** | BINARY SEARCH↔SORT 키 일치 / CLEAR 안전 점검 | 🔒S | F01·F02 | HIGH/점검우선 | ✅ **완료** |
| **C1** | SQL FORM 가독성(컬럼 한글주석·정렬·섹션주석) | 🔧R | F01 | 낮음/단독안전 | 🟡 진행예정 |
| **C4** | 섹션주석·스타일 표준화 전반 | 🔧R | 전체 | 낮음 | ⬜ |
| **C3** | 중복 구조체 → 공통 BASE 타입 추출 | 🛠M | TOP+사용처 | 중/동반필수 | ⬜ |
| **C2** | 5벌 중복 DRY 파라미터화 | 🛠M | F02·O01·I01·C01 | 높음/대형동반 | ⬜ |

---

## C5. 🔒 안전성 점검 결과 (완료)

### BINARY SEARCH ↔ SORT 키 일치 — 전수 16건 점검: **HIGH 위험 없음 ✅**

| READ 대상 | 키 | 선행 SORT | 판정 |
|---|---|---|---|
| PT_RAW (F01:1312) | MBLNR MJAHR ZEILE | 1300 | ✅ |
| LT_MARA (1728) | MATNR | 1634/1660 | ✅ |
| LT_RSEG (1844) | MATNR WERKS CHARG | 1824 | ✅ |
| GT_BATCH_0400 (2544) | MATNR WERKS LGORT CHARG LIFNR | 2526 | ✅ |
| LT_STO_DMBTR (2638·F02:5838/6428) | MJAHR MBLNR ZEILE MATNR WERKS LGORT CHARG | 2612/5814/6404 | ✅ |
| GT_GROUP (2656/2664·F02:5854/5936/6444) | BWART [GRUND] | 2616 (좌측접두) | ✅ |
| LT_ZZSTOCKCD (3002) | MATNR CHARG | 2858 | ✅ |
| ET_ITEM (3144) | WERKS MATNR LGORT LIFNR CHARG | 3120 | ✅ |
| LT_CO (3592) | MATNR BWKEY BWTAR | 3562 | ✅ |
| **LT_SUM2 (3018/3028)** | MATNR WERKS LGORT CHARG LIFNR | SQL `ORDER BY` 동일키 보장 | ⚠️ 안전/권고 |

- **권고(LOW)**: `LT_SUM2`는 명시 `SORT` 없이 SELECT `ORDER BY MATNR WERKS LGORT CHARG LIFNR`(+순서보존 DELETE)로 정렬 → 동작 안전. FS §6 철칙상 **명시적 `SORT LT_SUM2 BY MATNR WERKS LGORT CHARG LIFNR.` 1줄 추가** 권고(C1에서 반영).
- CLEAR 누락: READ 직전 `CLEAR LS_*` 패턴 다수 확인(예: 2654). 잔여 CLEAR 점검은 각 클러스터(C1/C3/C2) FORM 단위 리팩토링 시 동반 적용.

**C5 Exit Code: PASS(0)** — Silent Bug 유발 SORT/BINARY 불일치 없음.

---

## C1. 🔧 SQL FORM 가독성 — 파일럿: `GET_GROUP_ZMMT0010` (F01)

### As-Is
```abap
FORM GET_GROUP_ZMMT0010 .
  CLEAR : GV_GR_ETC, GV_GI_ETC.
  CLEAR : GT_ZMMT0010, GT_ZMMT0010[].
  CLEAR : GT_GROUP, GT_GROUP[].
  SELECT A~ZGROUP
         A~ZTEXT
         A~ZSEQ
  INTO CORRESPONDING FIELDS OF TABLE GT_ZMMT0010
  FROM ZMMPAT52000 AS A
  ORDER BY ZSEQ.
**********************************************************************
* ETC. 이동유형 없기에 주석처리..
* 추후 운영 시, ETC 추가될 시 적용 예정
**********************************************************************
*  LOOP AT GT_ZMMT0010 INTO DATA(LS_ZMMT0010).
*    ... (ETC 처리, 주석)
*  ENDLOOP.
* Movement Type Group TABLE
  SELECT A~ZGROUP A~ZTEXT
         B~BWART  B~GRUND
  INTO CORRESPONDING FIELDS OF TABLE GT_GROUP
  FROM ZMMPAT52000 AS A
  INNER JOIN ZMMPAT52010 AS B
                        ON A~ZGROUP EQ B~ZGROUP
  WHERE A~ZGROUP NE SPACE.
  SORT GT_GROUP BY BWART GRUND ZGROUP .
ENDFORM.
```

### To-Be
```abap
"=== 🔧[R] GET_GROUP_ZMMT0010 가독성 정비 =========================
" 변경: SELECT 컬럼 한글주석 부여(FS §4) + SQL 정렬/들여쓰기 표준화(FS §5)
"       + 섹션 구분 주석 표준화(FS §4). alias/대문자/연산자(EQ·NE) 원본 유지.
" 이유: 코드 표준(SSOT) 일치, 컬럼 의미 즉시 파악
" 근거: FS §4 / §5
" 리스크: 없음 (SELECT 결과·정렬·의미 100% 동일)
" Rollback: git revert
"================================================================
FORM GET_GROUP_ZMMT0010 .

  CLEAR : GV_GR_ETC, GV_GI_ETC.          " 🛠[M] 진입 시 잔존값 제거 (FS §7)
  CLEAR : GT_ZMMT0010, GT_ZMMT0010[].
  CLEAR : GT_GROUP, GT_GROUP[].

  "============================================================
  " 1) 이동유형 그룹 마스터 조회 (ZMMPAT52000 = [MM] 이동유형 그룹)
  "============================================================
  SELECT A~ZGROUP      " 이동유형 그룹 코드
         A~ZTEXT       " 그룹 내역(명)
         A~ZSEQ        " 정렬 순서
    INTO CORRESPONDING FIELDS OF TABLE GT_ZMMT0010
    FROM ZMMPAT52000 AS A
   ORDER BY A~ZSEQ.    " 🔧[R] alias 명시 (was: ORDER BY ZSEQ)

*  📌 의미 보존: 아래 ETC 이동유형 처리 블록은 "추후 운영 시 적용 예정"
*     주석과 함께 의도적으로 보존 (삭제 금지 / 한국어 주석 보존 원칙)
**********************************************************************
* ETC. 이동유형 없기에 주석처리..
* 추후 운영 시, ETC 추가될 시 적용 예정
**********************************************************************
*  LOOP AT GT_ZMMT0010 INTO DATA(LS_ZMMT0010).
*    ... (원본 그대로 유지)
*  ENDLOOP.

  "============================================================
  " 2) 이동유형 그룹 상세 조회 — 그룹 마스터(A) ⨝ 상세(B)
  "============================================================
  SELECT A~ZGROUP      " 이동유형 그룹 코드
         A~ZTEXT       " 그룹 내역(명)
         B~BWART       " 이동유형 (재고관리)
         B~GRUND       " 이동 사유
    INTO CORRESPONDING FIELDS OF TABLE GT_GROUP
    FROM ZMMPAT52000 AS A
   INNER JOIN ZMMPAT52010 AS B
      ON  A~ZGROUP EQ B~ZGROUP        " 🔧[R] 들여쓰기 정렬 (FS §5)
   WHERE A~ZGROUP NE SPACE.           " 그룹코드 공란 제외

  SORT GT_GROUP BY BWART GRUND ZGROUP.  " 📌 정렬 유지 (BINARY SEARCH 키 일치, FS §6)

ENDFORM.
```

### 변경 사유 표
| # | 변경 항목 | 의도 | 근거 | 리스크 | Rollback |
|---|---|---|---|---|---|
| 1 | SELECT 컬럼 한글 주석 추가 | 의미 즉시 파악 | FS §4 | 없음 | git revert |
| 2 | SQL 정렬·`ON` 들여쓰기·섹션주석 표준화 | 가독성 | FS §5/§4 | 없음(동일 결과) | git revert |
| 3 | `ORDER BY ZSEQ` → `ORDER BY A~ZSEQ` | alias 명시 | FS §1 | 없음 | git revert |
| 4 | ETC 미사용 블록 **보존**(📌) | 한국어 주석/의도 보존 | 의미보존 원칙 | — | — |

### 자가 점검
| 항목 | 결과 |
|---|---|
| 의미 보존 (SELECT 결과/정렬 동일) | ✅ |
| SY-SUBRC 흐름 (분기 없음) | ✅ |
| 한국어 주석 100% 보존 (ETC 포함) | ✅ |
| SAP 표준 위배 | ✅ 없음 |

**Exit Code: PASS(0)**

---

## ✅ 적용 체크리스트 + Rollback (공통)
- [ ] SE38 원본 백업(비활성 버전)
- [ ] 활성화 전 단위 테스트: As-Is와 결과 인터널테이블 건수/정렬/값 동일 비교
- [ ] 한국어 주석 100% 유지 확인
- [ ] **Rollback**: `git revert <commit>` 또는 `as-is/` 원본 복원

## C1 — F01 To-Be 산출물 (배치 1)
- 📄 **`to-be/zmmpar52000f01.abap`** 생성 (HTML 원본 → 클린 ABAP 추출 + 리팩토링 적용)
  - `GET_GROUP_ZMMT0010` R+M 반영 (위 파일럿과 동일)
  - `LT_SUM2` **명시 SORT 1줄 추가** (C5 권고 → 확정 적용, FS §6)
  - 무결성: FORM/ENDFORM 26/26, 비SQL 코드 원본 보존
- F01 SELECT 전수 19개 중 SQL 핵심 잔여(특히 `MATERIAL_DOC_BASIC_STOCK` 7개)는 **배치 2**에서 컬럼 한글주석 적용 예정.

## 📌 진행 현황
- [x] Phase 0 전체 스캔 + 클러스터 정의
- [x] C5 안전성 점검 (PASS)
- [x] C1 파일럿 (`GET_GROUP_ZMMT0010`)
- [x] C1 배치 1 — `to-be/zmmpar52000f01.abap` 생성 (파일럿 + LT_SUM2 SORT)
- [x] C1 배치 2 — `MATERIAL_DOC_BASIC_STOCK` 7 SELECT **컬럼 한글주석 67개** + 집계 CTE 설명 (alias 현행 유지 확정)
- [x] **M(정리) — F01 죽은 주석코드 231줄 제거** (주석처리된 PERFORM/DELETE/FIELDCAT 블록 등) → [`CLEANUP_LOG_f01.md`](./CLEANUP_LOG_f01.md)
- [ ] C1 배치 3 (선택) — 잔여 소형 SELECT(`CHECK_INPUT`/`SHOW_GROUP_RAW`/`CO_AMT` 등) 주석
- [ ] C4 (스타일 표준화) → ⏸️ 게이트 → C3 (구조체 통합) → C2 (5벌 DRY)

> **alias 정책 확정(2026-06-04)**: 다중 JOIN SQL은 **컬럼 한글주석만 적용, alias 현행 유지**(재정렬 미적용 — 변경폭/검증부담 회피, 의미보존 우선).
>
> **죽은 코드 정리 정책(2026-06-04)**: 주석처리된 *코드*는 제거(가독성/유지보수). 단 **보존**: ① 한국어 업무주석 ② 날짜 표기 변경이력(예: `"2026.04.28 주석`, `/ 24.08.19`) ③ `추후/예정/TODO` 의도주석 ④ 섹션 구분자. 제거분은 `as-is/`·git에 보존되어 100% 복구 가능, 제거 전량은 `CLEANUP_LOG_f01.md`에 기록.

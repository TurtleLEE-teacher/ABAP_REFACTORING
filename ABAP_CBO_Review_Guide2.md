# ABAP CBO 코드 리팩토링 - 리뷰 기준 가이드

## 1. 프로젝트 개요

- **목적:** 기존 ABAP CBO(Customer Bolt-On) 로직의 코드 가독성 및 유지보수성 개선
- **SAP 환경:** S/4HANA
- **리뷰 관점:** 가독성 / 유지보수성 최우선 (성능 최적화보다 가독성이 우선)

---

## 2. 리뷰 기준 체크리스트

### 2-1. 네이밍 (Naming)

- 변수명이 용도를 명확히 설명하는가? (예: `LV_CNT` → `LV_ITEM_COUNT`)
- 내부 테이블/구조체 네이밍이 일관된 접두사 규칙을 따르는가?
  - `LT_` : 로컬 내부 테이블
  - `LS_` : 로컬 구조체(Work Area)
  - `LV_` : 로컬 변수
  - `GT_` : 글로벌 내부 테이블
  - `GS_` : 글로벌 구조체
  - `GV_` : 글로벌 변수
  - `GCL_` : 글로벌 클래스 참조 (ALV Grid, Container 등)
  - `CT_/CS_/CV_` : Changing 파라미터
  - `IT_/IS_/IV_` : Importing 파라미터
  - `ET_/ES_/EV_` : Exporting 파라미터
- FORM/METHOD 이름이 동사+목적어 형태로 기능을 설명하는가?

### 2-2. 구조 및 모듈화 (Structure)

- 하나의 FORM/METHOD가 하나의 역할만 수행하는가? (단일 책임 원칙)
- FORM 내부 코드가 50줄을 초과하면 분리 검토 대상
- 중복 로직이 별도 FORM/METHOD로 분리되어 있는가?
- PERFORM 체인이 과도하게 깊지 않은가? (3단계 이상 주의)

### 2-3. 하드코딩 제거 (Hard-coding)

- 매직 넘버/문자열이 상수(CONSTANTS)로 선언되어 있는가?
- 조건 분기의 비교값이 하드코딩 되어 있지 않은가?
- 하드코딩 제거 시 대안: CONSTANTS, 커스텀 설정 테이블, 도메인 고정값(Fixed Values)

### 2-4. 주석 및 문서화 (Comments)

- 프로그램 상단에 목적, 작성자, 변경 이력이 기재되어 있는가?
- 복잡한 비즈니스 로직에 WHY(왜 이렇게 했는지) 주석이 있는가?
- 불필요한 주석 처리된 코드(dead code)가 남아 있지 않은가?
- 주석이 코드와 일치하는가? (오래된 주석 방치 여부)

### 2-5. 데이터 선언 (Data Declaration)

- 사용하지 않는 변수가 남아 있지 않은가?
- `TYPE`을 사용하여 DDIC 타입을 참조하고 있는가? (`LIKE` 대신 `TYPE` 사용)
- 인라인 선언(`DATA(lv_xxx)`)을 적절히 활용하고 있는가? (S/4HANA)
- 내부 테이블 선언 시 `STANDARD TABLE` / `SORTED TABLE` / `HASHED TABLE`을 용도에 맞게 구분했는가?

### 2-6. 제어문 및 조건 처리 (Control Flow)

- 중첩 IF가 3단계 이상 깊어지지 않는가? (Early Return 패턴 검토)
- CASE 문으로 대체 가능한 다중 IF-ELSEIF가 있는가?
- 예외 처리(TRY-CATCH 또는 SY-SUBRC 체크)가 누락되지 않았는가?

### 2-7. Z/Y CBO 오브젝트 처리 규칙 (Custom Objects)

- 코드 내 `Z*` 또는 `Y*`로 시작하는 오브젝트(테이블, 펑션모듈, 필드, 클래스 등)를 발견하면 아래 프로세스를 따른다:
  1. **1차 판단:** 해당 오브젝트의 네이밍이 용도를 충분히 설명하는지 평가한다
  2. **대체 제안:** 네이밍이 모호하거나 개선 여지가 있으면, 더 명확한 이름을 제안한다
  3. **사용자 확인:** "그대로 유지" 또는 "대체 반영" 중 사용자가 결정한다
  4. **반영:** 사용자 결정에 따라 최종 코드에 적용한다
- Z/Y 오브젝트는 실제 시스템 딕셔너리에 등록된 이름이므로, 이름 변경 시 영향도(Where-Used)를 반드시 언급한다
- 단순 리팩토링 범위를 넘어서는 경우(테이블명 변경 등), 별도 권고사항으로 분리하여 안내한다

### 2-8. S/4HANA 권장 문법 적용 (Modern ABAP)

**핵심 원칙: 성능보다 가독성/유지보수성이 우선이다.**
새로운 문법이라도 가독성이 떨어지면 기존 문법을 유지한다.

- **그대로 사용 가능 (가독성 우수):**
  - `READ TABLE ... WITH KEY ... BINARY SEARCH` — 직관적이고 의도가 명확함
  - `LOOP AT ... INTO` — 구조가 단순하고 읽기 쉬움
  - `MOVE-CORRESPONDING` — 필드 매핑 의도가 바로 보임
  - `APPEND`, `COLLECT` — 단순 추가/집계 시 충분히 명확함

- **상황에 따라 신규 문법 적용 검토:**
  - `SELECT ... INTO TABLE @DATA()` — 인라인 선언으로 선언부 간소화 시 유리할 때
  - `CORRESPONDING #()` — 복잡한 매핑에서 가독성이 더 나을 때
  - `VALUE #()`, `FILTER #()` — 코드가 오히려 간결해지는 경우에 한해
  - `FIELD-SYMBOL` — 대량 데이터 처리 등 성능이 병목일 때만 검토

- **판단 기준:** "이 코드를 6개월 뒤 다른 사람이 보았을 때 바로 이해할 수 있는가?"

---

## 3. ALV 리팩토링 패턴 가이드

> 이 섹션은 ZMMPAR52000(수불부) 리팩토링에서 확립된 모던 ALV 패턴을 정리한 것이다.
> 참조 프로그램: ZMMR3130 (Account Payable IV aggregation)

### 3-1. Include 구조 표준

```
ZMMPAR_XXXXTOP    " Data Declarations (TYPES, DATA, CONSTANTS)
ZMMPAR_XXXXCLS    " Event Handler Class (단일)
ZMMPAR_XXXXSCR    " Selection Screen
ZMMPAR_XXXXO01    " PBO Modules
ZMMPAR_XXXXI01    " PAI Modules
ZMMPAR_XXXXF01    " Business Logic (데이터 조회/가공)
ZMMPAR_XXXXF02    " ALV Setup & Event Handling
```

### 3-2. 필드카탈로그 자동 생성 (CL_SALV_DATA_DESCR)

**기존 (2단계):**
```abap
CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE' ...
CALL FUNCTION 'LVC_TRANSFER_FROM_SLIS' ...
```

**신규 (1줄):**
```abap
GT_FIELDCAT = CORRESPONDING #(
  CL_SALV_DATA_DESCR=>READ_STRUCTDESCR(
    CAST CL_ABAP_STRUCTDESCR(
      CAST CL_ABAP_TABLEDESCR(
        CL_ABAP_STRUCTDESCR=>DESCRIBE_BY_DATA( GT_LIST )
      )->GET_TABLE_LINE_TYPE( ) ) ) ).
```

**주의사항:**
- 텍스트 기호가 빈 값이면 DDIC 데이터 요소 설명이 fallback으로 표시된다
- 반드시 모든 텍스트 기호를 SE38 텍스트 요소에 등록해야 한다
- `_LMC_SET_TEXT` 매크로 패턴으로 6개 텍스트 필드를 일괄 설정한다

```abap
DEFINE _LMC_SET_TEXT.
  <LS_FCAT>-SCRTEXT_S = <LS_FCAT>-SCRTEXT_M = <LS_FCAT>-TOOLTIP =
  <LS_FCAT>-SCRTEXT_L = <LS_FCAT>-COLTEXT = <LS_FCAT>-REPTEXT = &1.
END-OF-DEFINITION.
```

### 3-3. 컨테이너 전략: SCREEN0 vs Docking

| 구분 | 풀스크린 (메인) | 팝업 (CALL SCREEN ... STARTING AT) |
|------|----------------|-------------------------------------|
| 컨테이너 | `CL_GUI_CONTAINER=>SCREEN0` | `CL_GUI_DOCKING_CONTAINER` |
| 사유 | SCREEN0은 풀스크린 전용 | 팝업에서 SCREEN0 바인딩 불가 |
| TOP_OF_PAGE | Splitter Row 1 | Docking → Splitter → Row 1 |

**풀스크린 패턴:**
```abap
GCL_SPLITTER = NEW CL_GUI_SPLITTER_CONTAINER(
  PARENT = CL_GUI_CONTAINER=>SCREEN0
  ROWS = 2  COLUMNS = 1 ).
```

**팝업 패턴:**
```abap
GCL_DOCKING = NEW CL_GUI_DOCKING_CONTAINER(
  DYNNR = SY-DYNNR  REPID = SY-REPID
  SIDE = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_TOP
  EXTENSION = 1500 ).

DATA(LCL_SPLIT) = NEW CL_GUI_SPLITTER_CONTAINER(
  PARENT = GCL_DOCKING  ROWS = 2  COLUMNS = 1 ).
```

### 3-4. 이벤트 핸들러 단일화

스크린별 개별 클래스 대신, **하나의 클래스**에서 `SENDER`로 분기한다:

```abap
CLASS LCL_EVENT_RECEIVER DEFINITION.
  PUBLIC SECTION.
    METHODS HANDLE_DOUBLE_CLICK
      FOR EVENT DOUBLE_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW E_COLUMN SENDER.  " ← SENDER 필수
ENDCLASS.

CLASS LCL_EVENT_RECEIVER IMPLEMENTATION.
  METHOD HANDLE_DOUBLE_CLICK.
    CASE SENDER.
      WHEN GCL_GRID_400.  PERFORM HANDLE_DOUBLE_CLICK_400 ...
      WHEN GCL_GRID_200.  PERFORM HANDLE_DOUBLE_CLICK_200 ...
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
```

**이벤트 등록 공통화:**
```abap
FORM CREATE_EVENT_RECEIVER USING PO_GRID TYPE REF TO CL_GUI_ALV_GRID.
  IF GCL_EVENT IS NOT BOUND. CREATE OBJECT GCL_EVENT. ENDIF.
  SET HANDLER GCL_EVENT->HANDLE_DOUBLE_CLICK  FOR PO_GRID.
  SET HANDLER GCL_EVENT->HANDLE_HOTSPOT_CLICK FOR PO_GRID.
  SET HANDLER GCL_EVENT->HANDLE_TOOLBAR       FOR PO_GRID.
  SET HANDLER GCL_EVENT->HANDLE_USER_COMMAND  FOR PO_GRID.
  SET HANDLER GCL_EVENT->ON_TOP_OF_PAGE       FOR PO_GRID.
ENDFORM.
```

### 3-5. GUI 컨트롤 생명주기 관리 (Known Pitfalls)

> 이 섹션은 실제 CNTL_ERROR 덤프를 디버깅하여 확립한 규칙이다.

**규칙 1: 자식 컨트롤은 FREE 하지 않는다 (CLEAR만)**

부모 컨테이너가 FREE되면 자식(Splitter, Grid, HTML Viewer 등)은 **자동 파괴**된다.
이미 파괴된 자식에 `FREE()`를 호출하면 **CNTL_ERROR 덤프**가 발생한다.

```abap
" ⛔ 잘못된 코드 - 덤프 발생
GCL_HTML_VIEWER->FREE( ).  " 부모가 이미 파괴했으므로 dangling reference

" ✅ 올바른 코드
CLEAR GCL_HTML_VIEWER.     " CLEAR만 하면 GC가 처리
```

**규칙 2: 팝업 컨트롤은 "열기 직전"에 해제한다**

팝업 스크린의 EXIT에서 FREE하면 비동기 해제 문제가 발생한다.
대신 팝업을 **재호출하기 직전에** 기존 컨트롤을 해제한다:

```abap
" ✅ CALL SCREEN 직전에 cleanup
PERFORM FREE_POPUP_CONTROLS USING '0200'.
CALL SCREEN 0200 STARTING AT 10 2 ENDING AT 150 30.

" ✅ EXIT_RTN에서 팝업은 LEAVE만
WHEN '0200' OR '0300' OR '0500'.
  LEAVE TO SCREEN 0.
```

**규칙 3: FREE 후 반드시 FLUSH**

```abap
GCL_GRID->FREE( ).  CLEAR GCL_GRID.
GCL_DOCKING->FREE( ).  CLEAR GCL_DOCKING.
CL_GUI_CFW=>FLUSH( ).   " ← 필수: GUI 프레임워크에 즉시 반영
```

**규칙 4: 외부 트랜잭션 호출(CALL TRANSACTION) 후 컨트롤 무효화 가능**

MM03, VA03 등 외부 트랜잭션 호출 후 돌아오면 GUI 컨트롤이 무효화될 수 있다.
HTML Viewer처럼 부모 종속적인 컨트롤은 특히 취약하다.
→ `ON_TOP_OF_PAGE`에서 HTML Viewer를 매번 **새로 생성**하는 패턴이 안전하다.

### 3-6. 필드카탈로그 통화/수량 참조 (CFIELDNAME / QFIELDNAME)

금액/수량 필드에 반드시 참조 필드를 지정해야 한다. 미지정 시 KRW 등 소수점 0 통화에서 ×100 환산이 안 된다.

```abap
" 수량 필드 → 단위 참조
<LS_FCAT>-QFIELDNAME = 'MEINS'.

" 금액 필드 → 통화 참조
<LS_FCAT>-CFIELDNAME = 'WAERS'.
```

**모든 스크린(메인 + 팝업)의 필드카탈로그에 빠짐없이 적용한다.**

### 3-7. 동적 테이블 → 정적 TYPES 전환 판단 기준

| 조건 | 판단 |
|------|------|
| 그룹/카테고리가 커스텀 테이블로 고정 (예: GR1~GR4, GI1~GI4) | 정적 전환 가능 |
| 사용자가 런타임에 컬럼을 추가/제거 가능 | 동적 유지 |
| FIELD-SYMBOLS + ASSIGN COMPONENT가 5건 이상 | 정적 전환 권장 |
| `CL_ALV_TABLE_CREATE=>CREATE_DYNAMIC_TABLE` 사용 중 | 정적 전환 시 제거 가능 |

### 3-8. MESSAGE-ID 처리

커스텀 메시지 클래스(ZMCMM02 등) 의존을 제거하려면:

```abap
" 표준 메시지 클래스 00 사용
REPORT ZMMPAR_XXXX MESSAGE-ID 00.

" 메시지 텍스트는 텍스트 기호로 관리
MESSAGE S000 WITH TEXT-M01 DISPLAY LIKE 'E'.
```

**주의:** `MESSAGE-ID`를 완전히 빼면(`REPORT ZMMPAR_XXXX.`) 모든 MESSAGE 문에 `(00)` 등을 명시해야 하므로, `MESSAGE-ID 00`을 쓰는 것이 편리하다.

### 3-9. CONCATENATE와 CHAR 타입 주의

```abap
" ⛔ RESPECTING BLANKS + CHAR 타입 = trailing 공백이 유지되어 뒤 문자열 잘림
CONCATENATE LS_GRP-ZTEXT IV_SUFFIX INTO LV_TEXT RESPECTING BLANKS.
" 'GR1구매입고                                          (수량)' → 30자리에서 절단

" ✅ 기본 CONCATENATE = trailing 공백 자동 제거
CONCATENATE LS_GRP-ZTEXT IV_SUFFIX INTO LV_TEXT.
" '구매입고(수량)' → 정상
```

### 3-10. FORM 파라미터 타입 매칭

ALV 이벤트에서 전달받는 구조체 필드를 FORM 파라미터로 넘길 때, **정확한 타입 매칭** 필수:

```abap
" ⛔ PS_COLUMN_ID-FIELDNAME은 TYPE LVC_FNAME (CHAR 30)
FORM SHOW_GROUP_RAW USING PV_FIELDNAME TYPE STRING.  " 타입 불일치

" ✅ 동일 타입 사용
FORM SHOW_GROUP_RAW USING PV_FIELDNAME TYPE LVC_FNAME.
```

### 3-11. GUI Status (PF-STATUS) 사전 확인

리팩토링으로 스크린별 MODULE을 분리하면, 각 스크린에서 호출하는 PF-STATUS가 실제로 존재하는지 확인 필수:

- SE41에서 프로그램의 GUI Status 목록 확인
- 없는 Status를 SET하면 `상태 XXXX이 누락되었습니다` 오류 발생
- 기존 Status를 복사(`SE41 → 복사`)하여 신규 생성하는 것이 가장 빠름

### 3-12. 텍스트 기호 등록 체크리스트

리팩토링 완료 후, 코드에서 사용하는 모든 텍스트 기호가 SE38 텍스트 요소에 등록되었는지 확인한다:

| 카테고리 | 접두사 | 등록 위치 |
|----------|--------|-----------|
| 필드카탈로그 컬럼명 | F, N | SE38 → 텍스트 요소 → 텍스트 기호 |
| 화면 타이틀/블록 | T, 001~999 | SE38 → 텍스트 요소 → 텍스트 기호 |
| Selection Screen 코멘트 | C | SE38 → 텍스트 요소 → 텍스트 기호 |
| 메시지 텍스트 | M | SE38 → 텍스트 요소 → 텍스트 기호 |
| 툴바 버튼 | B | SE38 → 텍스트 요소 → 텍스트 기호 |
| Selection Screen 라벨 | - | SE38 → 텍스트 요소 → 선택 텍스트 |

---

## 4. 리뷰 결과물 형태

각 CBO 코드에 대해 아래 형식으로 리뷰 결과를 제공한다:

```
[1] 진단 요약
    - 전체 코드 상태 평가 (가독성 점수: 상/중/하)
    - 주요 이슈 Top 3

[2] 상세 개선 포인트
    - 이슈 번호 | 분류(네이밍/구조/하드코딩 등) | 원본 코드 | 개선 코드 | 변경 사유

[3] 개선된 전체 코드
    - 최종 리팩토링 코드 전문 제공

[4] 추가 권고사항
    - 선택적 개선 제안 (당장 필수는 아니지만 향후 고려할 사항)
```

---

## 5. 대화 진행 규칙

1. 사용자가 CBO 코드를 붙여넣으면, 먼저 코드의 목적을 파악하여 확인한다 (백브리핑)
2. 본 가이드의 체크리스트 기준으로 진단한다
3. Z/Y 오브젝트가 있으면 네이밍 변경 제안 여부를 먼저 확인한다
4. 개선안을 위 결과물 형태로 제시한다
5. 사용자 확인 후 추가 조정이 필요하면 반영한다
6. 코드의 기능(로직)은 변경하지 않는다 — 리팩토링만 수행
7. 성능 최적화보다 가독성/유지보수성을 우선한다

---

## 6. 리팩토링 전 사전 확인 체크리스트

리팩토링 코드를 제공하기 **전에** 아래 항목을 자체 점검한다:

### 컴파일 레벨
- [ ] FORM 파라미터 타입이 호출부와 일치하는가? (STRING vs LVC_FNAME 등)
- [ ] TABLES 선언이 Selection Screen FOR 절에 필요한 것만 남았는가?
- [ ] MESSAGE-ID가 유효한가? (제거 시 명시적 메시지 클래스 필요)
- [ ] INCLUDE 순서가 의존성을 만족하는가? (TOP → CLS → SCR → O01 → I01 → F01 → F02)

### ALV / GUI 레벨
- [ ] 풀스크린 = SCREEN0, 팝업 = Docking Container 분리 적용했는가?
- [ ] 팝업 컨트롤 해제가 "호출 직전" 패턴인가? (EXIT에서 하면 덤프)
- [ ] HTML Viewer는 FREE 없이 CLEAR만 하는가?
- [ ] FREE 후 CL_GUI_CFW=>FLUSH() 호출하는가?
- [ ] 필드카탈로그에 CFIELDNAME/QFIELDNAME이 누락된 금액/수량 필드가 없는가?
- [ ] 텍스트 기호가 빈 값인 필드카탈로그가 없는가? (DDIC fallback 주의)
- [ ] 각 스크린에서 SET하는 PF-STATUS가 SE41에 존재하는가?

### Screen Flow Logic 레벨
- [ ] PBO MODULE 이름이 코드의 MODULE 선언과 일치하는가?
- [ ] PAI에 USER_COMMAND MODULE이 빠지지 않았는가?
- [ ] EXIT_COMMAND MODULE이 AT EXIT-COMMAND로 등록되었는가?

### 데이터 레벨
- [ ] CONCATENATE에서 RESPECTING BLANKS + CHAR 타입 조합이 없는가?
- [ ] 동적 테이블 → 정적 전환 시, 그룹 코드가 실제로 고정인지 확인했는가?
- [ ] MOVE-CORRESPONDING 대상 구조체 간 필드명이 매핑되는가?

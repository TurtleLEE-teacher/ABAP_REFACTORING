# ⚡ [SKILL] ABAP 코드 리팩토링

> **ABAP 코드 표준 SSOT**
> 본 스킬은 코드 표준을 자체 정의하지 않고 [`../standards/`](../standards/README.md)를 **위임 참조**한다:
> - [`standards/CBO_REVIEW_GUIDE.md`](../standards/CBO_REVIEW_GUIDE.md) — 리뷰 기준·판단 원칙·사전 점검 체크리스트 (정본)
> - [`standards/ABAP_CODE_STANDARD.md`](../standards/ABAP_CODE_STANDARD.md) — SQL/주석/SORT·CLEAR 세부 (FS §1~§8)
> - [`standards/patterns/ALV_MODERN_PATTERN.md`](../standards/patterns/ALV_MODERN_PATTERN.md) — 모던 ALV 코드 스켈레톤
>
> ⚖️ **메타원칙 = 가독성/유지보수 우선** (성능·모던화는 그 다음, 가독성 향상 시에만). 표준 충돌 시 [`standards/README.md`](../standards/README.md)의 우선순위를 따른다.
> 본 문서의 "근거(FS §N)"는 `ABAP_CODE_STANDARD.md`의 섹션 번호를 가리킨다.

---

## 🎯 개요

- **ABAP 소스코드(PROG / INCLUDE / FORM 단위)를 입력받아 3가지 모드로 리팩토링하는 작업 수행형 스킬**
- 3가지 모드: ① **가독성(READABILITY)** ② **유지보수(MAINTAINABILITY)** ③ **성능(PERFORMANCE, 옵션)**
- 출력 형식: **As-Is vs To-Be 비교** + **변경 사유 표** + **적용 체크리스트 & Rollback 포인트**
- 출력 위치: 채팅 기본 / 요청 시 `refactorings/<작업폴더>/`에 리포트로 저장

---

## 💡 TL;DR

- 입력: ABAP 코드 + 모드 지정 (1~3 중 택1, 복수 가능)
- 처리: SSOT의 ABAP 코드 표준 8개 섹션 기준으로 As-Is 진단 → To-Be 제안
- 출력: 코드 비교 블록 + 변경 사유 표 + 자가점검 결과 + Rollback 포인트
- **성능 모드는 명시 호출 시만 적용** (의미 변경 위험으로 기본 비활성, 단독 사용 금지)
- 의미 보존(SY-SUBRC 흐름, 부수 효과, 한국어 주석) **무조건 우선**

---

## ✅ 적용 범위

### 지원 입력 단위

| **단위** | **설명** | **비고** |
| --- | --- | --- |
| FORM 1개 | 단일 서브루틴 (10~200 LOC 권장) | 가장 안전한 단위. 기본 입력 권장 |
| INCLUDE 1개 | F01 / O01 / I01 등 단일 Include | FORM 다수 포함 시 우선순위 표 필요 |
| PROG 전체 | Main + Include 묶음 | 대분량 시 Section 단위 분할 진행 |
| METHOD 1개 | Class/Interface 메서드 | OO ABAP 한정 |

### 환경 전제

- **S/4 HANA** 기준 (ECC 호환 모드 시 별도 명시 필요)
- ABAP 신구문(Modern ABAP) 적극 적용
- 의미 보존: SY-SUBRC 흐름 / 부수 효과 / 한국어 주석 절대 유지

### 제외 범위

- DDIC 객체 변경 (Domain, Data Element, Table) — 별도 절차 필요
- Enhancement Spot 신규 생성 — Functional Spec 단계 필요
- 트랜잭션 코드/Screen Painter — 본 스킬 범위 외
- Workflow 객체 — 본 스킬 범위 외

---

## 📥 입력 (Input)

### 필수 입력

| **항목** | **설명** | **예시** |
| --- | --- | --- |
| ABAP 코드 | 리팩토링 대상 소스 (코드블록 또는 페이지 URL) | `FORM GET_DATA ... ENDFORM.` |
| 리팩토링 모드 | R(가독성) / M(유지보수) / P(성능) 중 택1 이상 | "R+M" 또는 "전체" |

### 선택 입력

| **항목** | **설명** | **기본값** |
| --- | --- | --- |
| 대상 환경 | S/4 HANA / ECC 호환 | S/4 HANA |
| 제약 사항 | 변경 금지 영역 (예: "공용 함수 시그니처 유지") | 없음 |
| 출력 저장 위치 | 채팅 / `refactorings/` | 채팅 |
| 비교 형태 | Side-by-side / 인라인 diff / 통합 To-Be 단독 | Side-by-side |

---

## 📤 출력 (Output)

### 출력 구조 (3종 세트)

| **#** | **섹션** | **형식** |
| --- | --- | --- |
| 1 | 📊 진단 요약 | 모드별 발견 이슈 N건 + 우선순위 (HIGH/MID/LOW) |
| 2 | 🔄 As-Is vs To-Be 비교 | ```abap 코드블록 2개 + **변경 주석 표준 적용**(아래 "📋 구조화 규칙" 참조) |
| 3 | 📋 변경 사유 표 | 변경 항목 / 의도 / 근거(FS 표준 섹션 #) / 리스크 / Rollback |
| 4 | ✅ 적용 체크리스트 | SE38 백업 → 활성화 전 단위 테스트 → SAT/ST05 비교(P 모드) → Production 이관 |
| 5 | 🔍 자가 점검 결과 | 의미 보존 / 부수 효과 / 주석 보존 / SAP 표준 위배 여부 |

---

## 📋 처리 대상 (모드별 점검 항목)

### 모드 R: 가독성 (Readability)

<aside>
📖 <b>원칙</b>: 의미·성능 변경 없이 <b>읽기 쉬움</b>만 향상. SQL 결과 동일 보장.
</aside>

- **JOIN Alias 규칙**: a/b/c 알파벳 순 (FS §1)
- **SELECT 절 한글 주석**: 모든 컬럼에 한글 의미 주석 부여 (FS §4)
- **들여쓰기 정렬**: SELECT/FROM/JOIN/ON/WHERE 좌측 정렬, `ON`/`AND` 2칸 들여쓰기 (FS §5)
- **섹션 구분 주석**: 처리 단계마다 `"========` 박스 주석 (FS §4)
- **CHAIN 정리**: `DATA: a, b, c` 형태 의미 단위 그룹핑
- **매직 넘버 → 의미 있는 상수**: `IF wemng > 0` → 의미 명시
- **변수 네이밍**: `LV_/LT_/LS_` 등 헝가리안 + 의미 단어 (gv_temp ❌ → gv_period_low ✅)

### 모드 M: 유지보수 (Maintainability)

<aside>
🔧 <b>원칙</b>: 코드 구조 개선으로 <b>변경 비용</b> 낮춤. 동작은 유지하되 구조는 변경 허용.
</aside>

- **FORM 분리**: 단일 책임 위반 시 FORM 분할 (>200 LOC 또는 >3 책임)
- **DRY 적용**: 반복 SELECT/LOOP/READ 블록을 FORM/METHOD로 추출
- **DEFINE 매크로 → FORM/METHOD**: 디버깅 곤란한 매크로 대체
- **하드코딩 → 커스텀 테이블/TVARV**: 환경별 변동 가능한 값 외부화
- **에러 메시지 → 메시지 클래스**: 인라인 문자열을 T100 메시지로 분리
- **TRY-CATCH 표준화**: CX_ROOT 캐치 금지, 구체 예외만 캐치
- **GLOBAL 변수 → LOCAL 변수**: 가능한 경우 로컬 스코프로 축소
- **FIELD-SYMBOL 일관 사용**: LOOP INTO + MODIFY 패턴 → ASSIGNING 패턴 — ⚖️ **가독성 향상 시에만**(메타원칙). 단순 LOOP INTO는 유지 허용 (FS §3 / CBO_REVIEW_GUIDE §2-8)
- **Z/Y CBO 오브젝트 네이밍**: 모호한 Z*/Y* 이름 발견 시 → 더 명확한 이름 **제안 → 사용자 확인 → 반영**. 딕셔너리 등록 객체는 **Where-Used 영향도 명시**, 범위 초과(테이블명 변경 등)는 별도 권고로 분리 (CBO_REVIEW_GUIDE §2-7)

#### 🖥️ S/4 모던 ALV 트랙 (M 모드 하위 — 고위험·옵션, 게이트 필요)

<aside>
🖥️ <b>구식 ALV(필드카탈로그/컨테이너/5벌 중복) 현대화.</b> To-Be 방향은 <a href="../standards/patterns/ALV_MODERN_PATTERN.md">patterns/ALV_MODERN_PATTERN.md</a> 스켈레톤을 그대로 따른다.
</aside>

- **5벌(_100~500) → 2벌(MAIN 풀스크린 / POP 팝업)**: 화면번호가 아닌 **역할 기준** 통합
- **필드카탈로그**: `REUSE_ALV_FIELDCATALOG_MERGE`+수동 append → **RTTI(`CL_SALV_DATA_DESCR=>READ_STRUCTDESCR`) 자동생성** + CASE 커스터마이징 + `_LMC_SET_TEXT` 매크로. 금액/수량은 **`CFIELDNAME`/`QFIELDNAME` 필수**
- **객체 생성/호출**: `CREATE OBJECT`→`NEW`, `CALL METHOD ... EXPORTING`→**메서드 체이닝**
- **이벤트**: 클래스 5~6벌 → **단일 `LCL_EVENT_RECEIVER` + `SENDER` 분기**, `CREATE_EVENT_RECEIVER` 공통 등록
- **컨테이너 생명주기 철칙**: 풀스크린=`SCREEN0`/팝업=`DOCKING`, 자식 컨트롤은 **FREE 금지(CLEAR만)**, 팝업은 **"열기 직전" 해제**, FREE 후 **`CL_GUI_CFW=>FLUSH`**
- **`LIKE`→`TYPE`**, 동적테이블(`ASSIGN (name)`)→고정 `TYPES` 전환 (그룹코드가 고정일 때)
- ⚠️ 화면 횡단·시그니처 변경 → **디렉터 게이트 + 전 화면 단위테스트 필수**

### 모드 P: 성능 (Performance) — 옵션

<aside>
⚠️ <b>원칙</b>: 명시 호출 시에만 적용. 의미 변경 위험 존재 → <b>단위 테스트 필수</b>. 성능 모드 단독 사용 금지. 반드시 R 또는 M과 함께 적용.
</aside>

- **메인 쿼리 우선 패턴**: Pre-load → Main First로 전환 (FS §2)
- **SELECT 단일화**: 동일 테이블 다중 SELECT를 JOIN/FOR ALL ENTRIES로 통합
- **FOR ALL ENTRIES + IS INITIAL 체크**: 빈 드라이버 테이블 가드 (FS §5)
- **READ TABLE BINARY SEARCH**: SORT 선행 보장 (FS §6)
- **LOOP INTO → ASSIGNING FIELD-SYMBOL**: 복사 비용 제거 (FS §3)
- **불필요 SORT 제거**: 이미 정렬 상태 또는 사용 안 되는 SORT 정리
- **INTO CORRESPONDING FIELDS 제거**: 명시적 필드 매핑으로 전환
- **SELECT SINGLE에 ORDER BY PRIMARY KEY 명시** (S/4 HANA 권장)
- **CDS View 활용 검토**: 복잡 JOIN을 CDS로 위임 (S/4 HANA)
- **AMDP 활용 검토**: 대량 집계는 AMDP로 위임 (S/4 HANA)

---

## 📋 프로세스 (6 Phase)

<aside>
💡 <b>핵심 원칙</b>: <b>전체 스캔 → 의존성 매핑</b> → 의미 보존 우선 → As-Is 진단 → 모드별 To-Be 제안 → 셀프 크리틱 → 디렉터 승인
</aside>

### Phase 0: 전체 스캔 (Multi-INCLUDE 사전 분석)

<aside>
🚨 <b>필수 조건</b>: 입력 단위가 <b>PROG 전체 / 다중 INCLUDE / 다중 FORM</b>인 경우 Phase 0 무조건 선행. 단일 FORM/METHOD 입력은 Phase 0 생략 가능(단 호출 관계만 1회 확인).
<b>금지</b>: 다중 INCLUDE 프로그램에서 한 INCLUDE만 떼서 리팩토링 — 글로벌 변수/구조체/매크로의 횡단 의존성을 깨뜨려 Silent Bug 유발.
</aside>

- **0-1. 전체 코드 확보**: 모든 INCLUDE(TOP/SCR/CXX/OXX/IXX/FXX 등)를 한 번에 로드. 누락 시 ⏸️ 추가 제공 요청 후 대기 (추정 진행 금지).
- **0-2. 의존성 매트릭스**: 선언→사용 매핑(GT_/GS_/GV_/CONSTANTS), 호출 그래프(PERFORM/MODULE/CALL METHOD/CALL FUNCTION), 매크로 사용처, DDIC 참조(dead reference 식별).
- **0-3. 변경 영향도 평가**: 이슈별 영향 INCLUDE 목록 산출. 경계 넘는 변경 "동반 변경 필수", 내부 갇힌 변경 "단독 안전" 표시.
- **0-4. 변경 순서 결정**: TOP → SCR → CXX → OXX → IXX → FXX. 같은 변경 클러스터는 한 묶음으로 동시 이관.
- **0-5. Phase 0 산출물**: 전체 구조 맵 / 글로벌 자원 사용 매트릭스 / 변경 클러스터 목록 + ⏸️ 디렉터 승인 게이트.

### Phase 1: 입력 검증 & 코드 파싱

- **1-1. 입력 점검**: ABAP 코드 입력 여부, 모드 지정(R/M/P/조합), 대상 단위, 의미 보존 제약 인지.
- **1-2. 코드 구조 파싱**: 진입점/종료점, 외부 의존성 매핑, 데이터 흐름 추적(Input→가공→Output), SY-SUBRC 분기 지점 표시.

### Phase 2: As-Is 진단

<aside>
🔄 <b>SSOT 8개 섹션을 체크리스트로 활용</b> — 각 항목별 ✅/❌/➖(N/A) 판정
</aside>

- **2-1. R 모드 진단**: JOIN alias a/b/c? 모든 SELECT 컬럼 한글 주석? 들여쓰기 일관? 섹션 구분 주석? CHAIN 가독성? 변수 네이밍 명확?
- **2-2. M 모드 진단**: FORM 길이/책임 적정? 반복 블록 추출? DEFINE 매크로? 하드코딩 값? 인라인 메시지 텍스트? CX_ROOT 광범위 캐치? GLOBAL 변수 남용?
- **2-3. P 모드 진단(옵션)**: 메인 쿼리 우선? 중복 SELECT? FOR ALL ENTRIES + IS INITIAL? BINARY SEARCH 전 SORT? LOOP INTO + MODIFY? INTO CORRESPONDING FIELDS? SELECT SINGLE ORDER BY 누락?

### Phase 3: To-Be 제안

- **3-1. 우선순위 부여**: HIGH(데이터 오염/Silent Bug: BINARY SEARCH SORT 누락, CLEAR 누락) / MID(유지보수 비용: FORM 분리, DRY 위반) / LOW(스타일: 네이밍, 들여쓰기, 주석).
- **3-2. 코드 재작성**: SSOT 8개 섹션 기계적 적용. 변경 단위마다 의미 보존 검증(SY-SUBRC 흐름 동일?). 한국어 주석 100% 유지(의미만 다듬기 허용, 삭제 금지).
- **3-3. 변경 사유 표**: 변경 항목 / 의도 / 근거(FS §N) / 리스크 / Rollback 5컬럼. 각 행은 원자적 변경 단위.

### Phase 4: 셀프 크리틱

<aside>
🔍 <b>의미 보존 검증</b>
</aside>

- **4-1. 의미 보존 점검**: 모든 SY-SUBRC 분기점 동일 동작? 부수 효과(외부 변수 변경, FM 호출) 동일? 한국어 주석 100% 유지? EXPORTING/CHANGING 시그니처 동일(M 모드 FORM 분리 시 예외)? 메시지 텍스트 동일(M 모드 메시지 클래스 분리 시 매핑 표)?
- **4-2. SAP 표준 위배 검증**: 의무 사용 FM 우회 없음? BUFFER/LOCK 정책 위반 없음? Customer 변경 금지 영역(SAP Note) 침범 없음?
- **4-3. P 모드 추가 검증(옵션)**: 데이터셋 크기 변화 시뮬레이션 가능? 인덱스 의존성 변화 없음? HINT 사용 시 근거 명시?

### Phase 5: 최종 리포트 출력

- **5-1. 출력 조립**: ① 진단 요약 ② As-Is vs To-Be 비교 ③ 변경 사유 표 ④ 적용 체크리스트 + Rollback ⑤ 자가 점검 결과(Exit Code: PASS/BLOCK/ERROR).
- **5-2. 저장 처리**: 채팅 기본 / 요청 시 `refactorings/YYYYMMDD_<프로그램명>/`에 저장.

---

## 📋 구조화 규칙

### As-Is vs To-Be 코드블록 표기

- ABAP 코드는 ```abap 언어 태그 필수
- 변경 라인은 코드 내 주석으로 마킹: `" 🔧 R: alias 변경 (k → a)`
- 삭제 라인은 As-Is 측에만 표시 + `" ❌ 삭제` 주석
- 추가 라인은 To-Be 측에만 표시 + `" ➕ 추가` 주석

### 변경 사유 표 표준 형식

```
| # | 변경 항목 | 의도 | 근거 | 리스크 | Rollback |
|---|----------|-----|-----|-------|---------|
| 1 | JOIN alias k → a | 가독성 / FS 표준 일치 | FS §1 | 없음 | git revert |
| 2 | LOOP INTO → ASSIGNING | 성능 (복사 제거) | FS §3 | FS 원본 CLEAR 금지 | 이전 LOOP 패턴 복원 |
```

### 모드 표기 컨벤션

- 🔧 **R**: 가독성 변경
- 🛠 **M**: 유지보수 변경
- ⚡ **P**: 성능 변경
- 🔒 **S**: 안전성 변경 (의미 보존 위협 차단)

### 변경 주석 표준 (To-Be 코드 내 필수 메타데이터)

<aside>
📝 <b>원칙</b>: To-Be 코드만 봐도 <b>변경점·근거·리스크를 코드 자체에서</b> 읽을 수 있어야 함. 주석은 "What" + "Why" + "근거" + "리스크" 4요소 필수.
</aside>

#### 1) 변경 블록 헤더 주석 (변경 단위 시작 시)

```abap
"=== 🔧[R][H1] LIKE → TYPE 전환 =================================
" 변경: LIKE MATDOC-BUDAT (DB 필드 참조) → TYPE budat (Data Element)
" 이유: S/4 HANA Modern ABAP 표준. Code Inspector "Obsolete Reference"
" 근거: FS §3 (S/4 신구문)
" 리스크: 없음 (의미 동일, 동일 타입)
" Rollback: git revert 또는 LIKE 패턴 일괄 치환
"================================================================
```

#### 2) 라인 단위 변경 주석 (인라인)

```abap
DATA lv_budat TYPE budat.   " 🔧[R] was: LIKE MATDOC-BUDAT
SORT lt_makt BY matnr.       " ⚡[P][HIGH] BINARY SEARCH 전 SORT 필수 (FS §6)
CLEAR: ls_result.            " 🛠[M] LOOP 시작 시 잔존값 제거 (FS §7)
```

#### 3) 삭제 라인 주석 (As-Is 측에만 표시)

```abap
" ❌[M] 삭제: 미사용 글로벌 변수 (Where-used: 0건)
" DATA GV_TEMP_TEXT(100).
```

#### 4) 신규 추가 주석 (To-Be 측에만 표시)

```abap
" ➕[M] 신규: 공통 BASE 타입 추출로 GT_RAW_DISP / GT_DISP_0500 / GT_BATCH_0400 통합
TYPES: BEGIN OF ty_stock_base,
         bukrs TYPE bukrs,
         ...
```

#### 5) 변경 주석 접두 코드 정의

| **접두** | **의미** | **예시** |
| --- | --- | --- |
| 🔧[R] | 가독성 변경 | `🔧[R][L2] CONSTANTS 의미 그룹 묶음` |
| 🛠[M] | 유지보수 변경 | `🛠[M][M1] 공통 BASE 타입 추출` |
| ⚡[P] | 성능 변경 | `⚡[P][HIGH] BINARY SEARCH 전 SORT` |
| 🔒[S] | 안전성 변경 | `🔒[S] SY-SUBRC 분기 추가` |
| ❌ | 삭제 | `❌[M] 삭제: dead code` |
| ➕ | 신규 추가 | `➕[M] 신규: TYPES BEGIN OF` |
| 📌 | 의미 보존 표시 | `📌 의미 보존: 한국어 주석 유지` |

#### 6) 변경 주석 자가 점검

- [ ] 모든 변경 단위마다 헤더 주석(4요소: What/Why/근거/리스크) 작성?
- [ ] 라인 단위 변경에 접두 코드(🔧/🛠/⚡/🔒) 부착?
- [ ] 삭제 라인은 `❌` + Where-used 결과 명시?
- [ ] 신규 추가는 `➕` + 의도 명시?
- [ ] 변경 사유 표(별도 출력)와 코드 내 주석이 일관?

---

## 🚨 예외 처리

| **오류** | **원인** | **해결책** |
| --- | --- | --- |
| 입력 코드가 미완성 (FORM 잘림 등) | 코드블록 truncation | 완전한 단위(FORM/INCLUDE) 재요청 |
| 모드 미지정 | 사용자 모드 누락 | R+M 기본 적용 안내 후 진행 (P는 명시 호출 시만) |
| 의미 보존 위협 감지 | SY-SUBRC 흐름 변경 / 부수 효과 변경 | 해당 변경 제외 + 사유 명시 + 디렉터 승인 요청 |
| 한국어 주석 손실 위험 | 코드 재작성 중 주석 누락 | 자가 점검 4-1에서 BLOCK → 주석 100% 복원 후 재출력 |
| 코드 분량 초과 (1000 LOC+) | PROG 전체 입력 | Section 단위 분할 + 우선순위 표 제시 후 단계별 진행 |
| DDIC 변경 필요 발견 | Custom Table/Domain 변경 필요 | 본 스킬 범위 외 → Functional Spec 작성 스킬로 위임 안내 |
| P 모드 단독 호출 | R/M 없이 P만 요청 | R 또는 M과 결합 필수 안내 후 재호출 유도 |
| 다중 INCLUDE인데 한 INCLUDE만 리팩토링 요청 | 사용자가 INCLUDE 단위로 끊어서 요청 | **Phase 0 강제 선행**. 전체 코드 확보 + 의존성 매트릭스 → 승인 → 클러스터 단위 진행 |
| 일부 INCLUDE 코드 누락 / truncation | 로드 결과 일부만 수신 | ⏸️ 즉시 중단 + 누락 부위 명시 + 추가 제공 요청. **추정 진행 금지** |

---

## 🔍 자가 점검

### 실행 전

```
🔍 실행 전 점검:
Q: ABAP 코드 표준 SSOT(standards/ABAP_CODE_STANDARD.md)를 참조 가능한가? A: ✅/❌
Q: ABAP 코드 입력이 완전한가? (FORM/INCLUDE 단위 닫힘) A: ✅/❌
Q: 다중 INCLUDE/PROG 입력인가? → 그렇다면 Phase 0 전체 스캔 선행 필수 A: ✅/❌
Q: 전체 코드가 누락 없이 확보되었는가? (truncation 없음) A: ✅/❌
Q: 리팩토링 모드가 지정되었는가? (R/M/P) A: ✅/❌
Q: 의미 보존 제약을 인지했는가? (SY-SUBRC/부수효과/한국어 주석) A: ✅/❌
Q: P 모드 단독 호출이 아닌가? (P는 R 또는 M과 결합 필수) A: ✅/❌
→ 전부 ✅ → Phase 0 또는 Phase 1 진행 → Exit Code: PASS(0)
→ ❌ 하나라도 → 입력 보완 또는 사용자 확인 → Exit Code: BLOCK(2)
```

### 최종 완료

```
🔍 최종 완료 점검:
Q: 📊 진단 요약이 작성되었는가? A: ✅/❌
Q: 🔄 As-Is vs To-Be 비교 코드블록이 ```abap 태그로 작성되었는가? A: ✅/❌
Q: 📋 변경 사유 표 5컬럼(항목/의도/근거/리스크/Rollback)이 모두 채워졌는가? A: ✅/❌
Q: ✅ 적용 체크리스트 + Rollback 포인트가 포함되었는가? A: ✅/❌
Q: 의미 보존(SY-SUBRC/부수효과/한국어 주석)이 검증되었는가? A: ✅/❌
Q: P 모드 적용 시 단위 테스트 가이드가 포함되었는가? A: ✅/❌
Q: (ALV/화면 변경 시) 아래 사전 점검 체크리스트를 통과했는가? A: ✅/❌/➖
→ 전부 ✅ → 완료 → Exit Code: PASS(0)
→ ❌ 하나라도 → 해당 섹션 보완 → Exit Code: BLOCK(2)
```

### 사전 점검 체크리스트 (ALV/화면 리팩토링 시 — 출력 전 자가점검)

> 출처: [`../standards/CBO_REVIEW_GUIDE.md`](../standards/CBO_REVIEW_GUIDE.md) §6. 컴파일 덤프·런타임 오류 사전 차단용.

- **컴파일**: FORM 파라미터 타입 호출부 일치(`STRING` vs `LVC_FNAME` 등) / `TABLES`는 SELECT-OPTIONS용만 / `MESSAGE-ID` 유효 / INCLUDE 순서(TOP→CLS→SCR→O01→I01→F01→F02)
- **ALV·GUI**: 풀스크린=`SCREEN0`·팝업=`DOCKING` / 팝업 컨트롤 "열기 직전" 해제 / HTML Viewer는 `CLEAR`만 / FREE 후 `CL_GUI_CFW=>FLUSH` / 금액·수량 필드 `CFIELDNAME`·`QFIELDNAME` / 텍스트 기호 빈값 없음 / `PF-STATUS` 존재(SE41)
- **Screen Flow**: PBO MODULE명 일치 / PAI `USER_COMMAND` 누락 없음 / `EXIT_COMMAND`는 `AT EXIT-COMMAND`
- **데이터**: `CONCATENATE`에 `RESPECTING BLANKS`+CHAR 조합 없음 / 동적→정적 전환 시 그룹코드 고정 확인 / `MOVE-CORRESPONDING` 필드 매핑 확인

---

## 🔗 연관 문서

- [`../standards/README.md`](../standards/README.md) — **표준 인덱스 + 우선순위(메타원칙)**
- [`../standards/CBO_REVIEW_GUIDE.md`](../standards/CBO_REVIEW_GUIDE.md) — 리뷰 기준·판단 원칙·사전 점검 체크리스트 (정본)
- [`../standards/ABAP_CODE_STANDARD.md`](../standards/ABAP_CODE_STANDARD.md) — SQL/주석/SORT·CLEAR 세부 SSOT (FS §1~§8)
- [`../standards/patterns/ALV_MODERN_PATTERN.md`](../standards/patterns/ALV_MODERN_PATTERN.md) — 모던 ALV 코드 스켈레톤
- [`../templates/REPORT_TEMPLATE.md`](../templates/REPORT_TEMPLATE.md) — 산출 리포트 3종 세트 템플릿
- [`../refactorings/README.md`](../refactorings/README.md) — 작업물 명명 규칙 + 인덱스

---

## 📝 변경 로그

- **v1.1** | 2026-05-11 | Phase 0(전체 스캔) 신설 + 변경 주석 표준 신설 + 다중 INCLUDE 운영 원칙 강화.
- **v1.0** | 2026-05-11 | 초안 — ABAP 코드 표준 8개 섹션을 SSOT로 위임 참조하는 작업 수행형 스킬 등록. 3가지 모드(R/M/P) + Phase 프로세스 + 의미 보존 우선 원칙 정의.

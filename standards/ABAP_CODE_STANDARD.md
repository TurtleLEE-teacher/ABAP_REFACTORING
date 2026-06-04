# 💻 ABAP 코드 작성 표준 (SSOT)

> **SSOT(Single Source of Truth)**
> 본 문서는 ABAP 리팩토링 스킬([`../skill/ABAP_REFACTORING_SKILL.md`](../skill/ABAP_REFACTORING_SKILL.md))이
> 위임 참조하는 **ABAP 코드 표준의 단일 출처**다.
> 원본은 Notion `[SKILL]_Functional_Spec_작성`의 **💻 ABAP 코드 표준** 탭이며,
> 원본이 갱신되면 **이 파일을 동기화**한다. 리팩토링의 모든 To-Be 판정 근거(FS §1~§8)는 본 문서의 섹션 번호를 가리킨다.

<aside>
🎯 <b>핵심 원칙</b>: 가독성이 최우선. ABAP 개발자가 코드를 읽고 즉시 의도를 파악할 수 있어야 함.
</aside>

---

## 환경 전제

- **S/4 HANA 기준** ABAP 신구문(Modern ABAP) 적극 활용
- 인라인 데이터 선언, ABAP SQL 신문법, FOR/REDUCE/COND 등 표현식 권장
- Open SQL의 호스트 변수는 `@` prefix 필수 (`@DATA(...)`, `@LT_EKPO` 등)

---

## §1. 테이블 Alias 규칙 (필수)

<aside>
⚠️ <b>JOIN 시 Alias는 알파벳 순으로 고정 부여</b>
<ul>
<li>첫 번째 테이블 → <code>a</code></li>
<li>두 번째 테이블 → <code>b</code></li>
<li>세 번째 테이블 → <code>c</code></li>
<li>이후 필요 시 d, e, f...</li>
</ul>
</aside>

#### ✅ 올바른 예시

```abap
SELECT a~ebeln,    " 구매오더 번호
       a~bukrs,    " 회사코드
       a~lifnr,    " 공급처
       b~ebelp,    " 구매오더 항목
       b~matnr,    " 자재번호
       b~werks,    " 플랜트
       b~menge,    " 발주수량
       c~maktx     " 자재내역 (한국어)
  FROM ekko AS a
  INNER JOIN ekpo AS b
    ON  b~ebeln = a~ebeln
  LEFT OUTER JOIN makt AS c
    ON  c~matnr = b~matnr
   AND c~spras = @sy-langu
  INTO TABLE @DATA(lt_main)
 WHERE a~bukrs IN @s_bukrs
   AND a~bsart = 'NB'.
```

#### ❌ 잘못된 예시

```abap
" ❌ 의미 없는 alias (t1, t2)
SELECT t1~ebeln, t2~ebelp FROM ekko AS t1 INNER JOIN ekpo AS t2 ...

" ❌ 첫 글자 alias (k, p)
SELECT k~ebeln, p~ebelp FROM ekko AS k INNER JOIN ekpo AS p ...

" ❌ Alias 없이 테이블명 그대로
SELECT ekko~ebeln, ekpo~ebelp FROM ekko INNER JOIN ekpo ...
```

---

## §2. 데이터 추출 전략: 메인 쿼리 우선

<aside>
💡 <b>권장 패턴</b>: ① 메인 쿼리로 핵심 데이터셋 확보 → ② 메인 결과의 Key를 활용해 보조 테이블 조회 → ③ READ TABLE/LOOP로 결합
</aside>

#### ✅ 권장 패턴 (Main First)

```abap
"============================================================
" 1) 메인 쿼리: 외주 임가공 발주 데이터 추출 (Header + Item)
"   - 대상: BSART='LB' (외주 임가공 발주)
"   - 제외: 취소된 Header / 삭제된 Item (LOEKZ='X')
"============================================================
SELECT a~ebeln,        " 구매오더 번호 (Header Key)
       a~bukrs,        " 회사코드
       a~lifnr,        " 공급처(외주업체)
       a~bsart,        " 발주유형
       b~ebelp,        " 구매오더 항목 (Item Key)
       b~matnr,        " 자재번호 (반제품)
       b~werks,        " 플랜트
       b~menge,        " 발주수량
       b~wemng,        " 입고수량 (신호등 판단용)
       b~meins         " 단위
  FROM ekko AS a
  INNER JOIN ekpo AS b
    ON  b~ebeln = a~ebeln
  INTO TABLE @DATA(lt_main)
 WHERE a~bukrs IN @s_bukrs
   AND a~bsart = 'LB'        " 외주 임가공 발주만
   AND a~loekz = ''          " 취소되지 않은 Header
   AND b~loekz = ''          " 삭제되지 않은 Item
   AND a~aedat IN @s_aedat.

" 메인 쿼리 결과가 없으면 즉시 종료 → 불필요한 보조 쿼리 방지
IF lt_main IS INITIAL.
  MESSAGE '조회된 데이터가 없습니다.' TYPE 'S' DISPLAY LIKE 'I'.
  RETURN.
ENDIF.

"============================================================
" 2) 보조 데이터 1: 자재 마스터 (메인 결과의 MATNR로만 조회)
"   - 메인 범위 밖 데이터를 미리 적재하지 않음 (성능 최적화)
"============================================================
SELECT a~matnr,        " 자재번호 (Key)
       a~maktx         " 자재내역 (한국어)
  FROM makt AS a
  FOR ALL ENTRIES IN @lt_main
 WHERE a~matnr = @lt_main-matnr
   AND a~spras = @sy-langu
  INTO TABLE @DATA(lt_makt).

" ⚠️ BINARY SEARCH 전 필수 SORT (READ TABLE Key 순서와 일치)
SORT lt_makt BY matnr.

"============================================================
" 3) 보조 데이터 2: 공급처 마스터 (메인 결과의 LIFNR로만 조회)
"============================================================
SELECT a~lifnr,        " 공급처 코드 (Key)
       a~name1         " 공급처명
  FROM lfa1 AS a
  FOR ALL ENTRIES IN @lt_main
 WHERE a~lifnr = @lt_main-lifnr
  INTO TABLE @DATA(lt_lfa1).

" ⚠️ BINARY SEARCH 전 필수 SORT
SORT lt_lfa1 BY lifnr.

"============================================================
" 4) 결합: 메인 결과에 보조 데이터를 LOOP로 매핑
"   - FIELD-SYMBOL ASSIGNING으로 복사 비용 최소화
"   - 위 단계 SORT 완료 후에만 BINARY SEARCH 사용 가능
"   - 다건 반복이므로 매 회차 임시 변수 CLEAR 필수
"============================================================
DATA: ls_makt TYPE makt,
      ls_lfa1 TYPE lfa1.

LOOP AT lt_main ASSIGNING FIELD-SYMBOL(<fs_main>).
  " ⚠️ 매 회차 시작 시 임시 변수 CLEAR (이전 회차 값 잔존 방지)
  CLEAR: ls_makt, ls_lfa1.

  " 자재내역 매핑
  READ TABLE lt_makt INTO ls_makt
    WITH KEY matnr = <fs_main>-matnr     " ← SORT BY matnr와 일치
    BINARY SEARCH.
  IF sy-subrc = 0.
    <fs_main>-maktx = ls_makt-maktx.
  ENDIF.

  " 공급처명 매핑
  READ TABLE lt_lfa1 INTO ls_lfa1
    WITH KEY lifnr = <fs_main>-lifnr     " ← SORT BY lifnr와 일치
    BINARY SEARCH.
  IF sy-subrc = 0.
    <fs_main>-name1 = ls_lfa1-name1.
  ENDIF.
ENDLOOP.
```

#### ⚠️ Pre-load 방식 (비권장)

<aside>
⚠️ <b>Pre-load 방식</b>(보조 마스터 전체를 먼저 적재 후 메인 결합)도 스펙 이해를 돕는 장점이 있으나, 다음 단점으로 비권장:
<ul>
<li>메인 쿼리 결과 범위 밖의 데이터까지 미리 조회 → 성능 저하</li>
<li>데이터 흐름이 비직관적 (어떤 게 메인인지 불분명)</li>
<li>메모리 낭비 가능성</li>
</ul>
<b>예외</b>: 보조 마스터가 매우 작고 자주 재사용되는 경우(예: 회사코드 마스터 T001) Pre-load 허용
</aside>

---

## §3. S/4 HANA 신구문(Modern ABAP) 활용

> ⚖️ **메타원칙 적용 (가독성 우선)**: 본 절의 신구문(인라인 `@DATA`, `VALUE/FOR/REDUCE/COND`, `FIELD-SYMBOL`)은
> [`CBO_REVIEW_GUIDE.md`](./CBO_REVIEW_GUIDE.md)의 메타원칙에 따라 **"가독성이 향상될 때만"** 적용한다.
> 기존 `LOOP AT ... INTO` / `MOVE-CORRESPONDING` / `READ ... BINARY SEARCH`가 더 읽기 쉬우면 **유지**한다.
> (우선순위: [`README.md`](./README.md))

#### 인라인 데이터 선언

```abap
" ✅ 권장: 인라인 @DATA(...)로 코드 간결화
SELECT * FROM ekpo INTO TABLE @DATA(lt_ekpo)
 WHERE werks = @p_werks.

" ❌ 비권장: 별도 DATA 선언 (S/4 신구문 미활용)
DATA: lt_ekpo TYPE STANDARD TABLE OF ekpo.
SELECT * FROM ekpo INTO TABLE lt_ekpo WHERE werks = p_werks.
```

#### 표현식 기반 (VALUE / FOR / REDUCE / COND)

```abap
" ✅ 권장: VALUE + FOR로 결과 테이블 구성
DATA(lt_report) = VALUE tt_report(
  FOR <ls> IN lt_main
  ( ebeln = <ls>-ebeln
    ebelp = <ls>-ebelp
    matnr = <ls>-matnr
    menge = <ls>-menge ) ).

" ✅ 권장: COND로 신호등(상태) 판단
DATA(lv_status) = COND char1(
  WHEN <fs_main>-wemng >= <fs_main>-menge THEN '1'   " 🟢 입고 완료
  WHEN <fs_main>-wemng > 0                THEN '2'   " 🟡 부분 입고
  ELSE                                         '3'   " 🔴 미입고
).

" ✅ 권장: REDUCE로 합계 산출
DATA(lv_total_qty) = REDUCE menge_d(
  INIT sum = 0
  FOR <ls> IN lt_main
  NEXT sum = sum + <ls>-menge ).
```

#### FIELD-SYMBOL 우선 (성능)

```abap
" ✅ 권장: FIELD-SYMBOL ASSIGNING (참조, 복사 없음)
LOOP AT lt_main ASSIGNING FIELD-SYMBOL(<fs_main>).
  <fs_main>-status = 'X'.
ENDLOOP.

" ❌ 비권장: INTO + MODIFY (불필요한 복사)
LOOP AT lt_main INTO DATA(ls_main).
  ls_main-status = 'X'.
  MODIFY lt_main FROM ls_main.
ENDLOOP.
```

---

## §4. 주석 작성 표준 (필수)

<aside>
📝 <b>원칙</b>: "What"이 아닌 <b>"Why"</b>를 기록. 코드를 읽으면 보이는 것은 생략, 비즈니스 의도와 예외 케이스에 집중.
</aside>

#### 주석 4유형

| **유형** | **용도** | **예시** |
| --- | --- | --- |
| **섹션 구분 주석** | 처리 단계 구분 (1단계 / 2단계 ...) | `"========================` / `" 1) 메인 쿼리: 외주 발주 추출` / `"========================` |
| **필드 설명 주석** | SELECT 절 컬럼별 한글 의미 | `a~ebeln,    " 구매오더 번호` |
| **비즈니스 로직 주석** | 업무 규칙·예외 케이스 설명 | `" BSART='LB' (외주 임가공)만 추출` / `" 취소된 발주(LOEKZ='X')는 제외` |
| **TODO/FIXME 주석** | 미정 사항·검토 필요 항목 | `" TODO: 신호등 임계값 디렉터 확인` |

---

## §5. SQL 작성 스타일

#### 정렬 규칙

- SELECT/FROM/INNER JOIN/ON/WHERE 등 키워드는 좌측 정렬
- SELECT 절의 각 필드는 한 줄에 하나씩 → 필드별 한글 주석 작성
- JOIN의 ON 조건은 `ON` 다음 2칸 들여쓰기 (`AND`도 동일 정렬)
- WHERE 조건은 `AND`/`OR` 좌측 정렬

#### Open SQL 신문법 체크리스트

- [ ] 호스트 변수에 `@` prefix 사용 (`@p_werks`, `@s_bukrs`)
- [ ] 인라인 `INTO TABLE @DATA(...)` 활용
- [ ] FOR ALL ENTRIES 사용 시 `IS INITIAL` 체크 필수
- [ ] CDS View / AMDP 활용 검토 (S/4 HANA 환경)
- [ ] CASE WHEN 등 가능한 한 SQL 단에서 처리 (ABAP LOOP 최소화)

---

## §6. BINARY SEARCH + SORT 규칙 (필수)

<aside>
🚨 <b>철칙</b>: SQL로 보조 인터널 테이블 적재 직후 <b>반드시 <code>SORT BY &lt;Key&gt;</code> 실행</b>. 이후 LOOP에서 <code>READ TABLE ... WITH KEY &lt;Key&gt; BINARY SEARCH</code> 시 <b>SORT Key 순서와 READ Key 순서가 정확히 일치</b>해야 함.
</aside>

#### Why (왜 필수인가)

- BINARY SEARCH는 **이진 탐색 알고리즘** → 테이블이 정렬되어 있어야 정상 동작
- SORT 누락 시: `sy-subrc = 4` 오작동, 잘못된 행 매핑 → **데이터 꼬임 (Silent Bug)**
- SORT Key ≠ READ Key: 일부 행만 매핑되거나 엉뚱한 행 반환 → 디버깅 매우 어려움

#### ✅ 올바른 패턴

```abap
"============================================================
" 보조 데이터: 자재 마스터 적재 + 정렬
"============================================================
SELECT a~matnr,        " 자재번호 (Key)
       a~maktx         " 자재내역
  FROM makt AS a
  FOR ALL ENTRIES IN @lt_main
 WHERE a~matnr = @lt_main-matnr
   AND a~spras = @sy-langu
  INTO TABLE @DATA(lt_makt).

" ⚠️ BINARY SEARCH 전 필수 SORT (READ TABLE Key와 동일 순서)
SORT lt_makt BY matnr.

"============================================================
" 메인 LOOP: BINARY SEARCH로 매핑
"============================================================
LOOP AT lt_main ASSIGNING FIELD-SYMBOL(<fs_main>).
  CLEAR: ls_makt.

  READ TABLE lt_makt INTO ls_makt
    WITH KEY matnr = <fs_main>-matnr   " ← SORT BY matnr와 일치
    BINARY SEARCH.
  IF sy-subrc = 0.
    <fs_main>-maktx = ls_makt-maktx.
  ENDIF.
ENDLOOP.
```

#### ❌ 잘못된 패턴 (SORT 누락)

```abap
" ❌ SORT 없이 BINARY SEARCH → 데이터 꼬임 발생
SELECT * FROM makt FOR ALL ENTRIES IN @lt_main
 WHERE matnr = @lt_main-matnr
  INTO TABLE @DATA(lt_makt).

" ⛔ SORT 누락! → 아래 BINARY SEARCH가 잘못된 행 반환
LOOP AT lt_main ASSIGNING FIELD-SYMBOL(<fs_main>).
  READ TABLE lt_makt WITH KEY matnr = <fs_main>-matnr BINARY SEARCH.
  ...
ENDLOOP.
```

#### 다중 Key SORT 패턴

```abap
" SORT Key 순서 = READ TABLE WITH KEY 순서와 정확히 동일
SORT lt_ekpo BY ebeln ebelp.

LOOP AT lt_main ASSIGNING FIELD-SYMBOL(<fs_main>).
  CLEAR: ls_ekpo.

  READ TABLE lt_ekpo INTO ls_ekpo
    WITH KEY ebeln = <fs_main>-ebeln    " 1st Key (SORT 1순위와 동일)
             ebelp = <fs_main>-ebelp    " 2nd Key (SORT 2순위와 동일)
    BINARY SEARCH.
  ...
ENDLOOP.
```

#### SORT 자가 점검

- [ ] SQL로 인터널 테이블에 적재한 직후 SORT 작성?
- [ ] SORT Key 순서 = READ TABLE WITH KEY 순서?
- [ ] 다중 Key의 경우 우선순위가 동일?
- [ ] BINARY SEARCH 사용 시 SORT 누락 없음?

---

## §7. CLEAR 처리 표준 (다건 반복)

<aside>
🚨 <b>철칙</b>: 단건이 아닌 <b>다건 반복 처리</b> 시, LOOP 내부 작업 변수(Work Area, 임시 결과)는 매 회 <b>반드시 CLEAR</b>. 누락 시 이전 회차 값이 잔존하여 <b>데이터 오염 (Silent Data Pollution)</b> 발생.
</aside>

#### CLEAR 위치 표준

| **위치** | **대상** | **시점** |
| --- | --- | --- |
| **LOOP 시작 직후** | Work Area, 임시 변수, 결과 구조체 | 매 반복마다 첫 줄 |
| **LOOP 종료 직후** | 다음 LOOP에서 재사용할 변수 | ENDLOOP 다음 줄 |
| **서브루틴 진입 시** | EXPORTING/CHANGING 파라미터 | FORM/METHOD 시작부 |
| **에러 분기 후 정상 흐름 진입 시** | 이전 에러 흐름 잔존 변수 | 분기 종료 후 |

#### ✅ 올바른 패턴 (LOOP 시작 시 CLEAR)

```abap
DATA: ls_result TYPE ty_result,
      ls_makt   TYPE makt,
      ls_lfa1   TYPE lfa1.

LOOP AT lt_main ASSIGNING FIELD-SYMBOL(<fs_main>).
  " ⚠️ 매 회차 시작 시 잔존 값 제거 필수
  CLEAR: ls_result, ls_makt, ls_lfa1.

  " 자재내역 조회
  READ TABLE lt_makt INTO ls_makt
    WITH KEY matnr = <fs_main>-matnr BINARY SEARCH.
  IF sy-subrc = 0.
    ls_result-maktx = ls_makt-maktx.
  ENDIF.

  " 공급처명 조회
  READ TABLE lt_lfa1 INTO ls_lfa1
    WITH KEY lifnr = <fs_main>-lifnr BINARY SEARCH.
  IF sy-subrc = 0.
    ls_result-name1 = ls_lfa1-name1.
  ENDIF.

  ls_result-ebeln = <fs_main>-ebeln.
  APPEND ls_result TO lt_result.
ENDLOOP.
```

#### ❌ 잘못된 패턴 (CLEAR 누락)

```abap
DATA: ls_result TYPE ty_result.

LOOP AT lt_main ASSIGNING FIELD-SYMBOL(<fs_main>).
  " ⛔ CLEAR 누락! → 이전 회차의 maktx, name1 값이 잔존
  READ TABLE lt_makt INTO DATA(ls_makt)
    WITH KEY matnr = <fs_main>-matnr BINARY SEARCH.
  IF sy-subrc = 0.
    ls_result-maktx = ls_makt-maktx.
  ENDIF.
  " ↑ sy-subrc = 4면 ls_result-maktx에 이전 회차 값 그대로 → 데이터 오염

  ls_result-ebeln = <fs_main>-ebeln.
  APPEND ls_result TO lt_result.
ENDLOOP.
```

#### FIELD-SYMBOL 사용 시 주의

```abap
" ⚠️ FIELD-SYMBOL ASSIGNING은 참조이므로 CLEAR 시 원본이 지워짐 → 사용 금지
" 대신 INTO 변수에 CLEAR 적용

LOOP AT lt_main ASSIGNING FIELD-SYMBOL(<fs_main>).
  CLEAR: ls_makt.   " ✅ ls_makt만 CLEAR
  " CLEAR <fs_main>. ❌ → 메인 테이블 원본 데이터 삭제됨!

  READ TABLE lt_makt INTO ls_makt
    WITH KEY matnr = <fs_main>-matnr BINARY SEARCH.
  ...
ENDLOOP.
```

#### 다중 LOOP 중첩 시 CLEAR 패턴

```abap
DATA: ls_outer TYPE ty_outer,
      ls_inner TYPE ty_inner.

LOOP AT lt_outer INTO ls_outer.
  CLEAR: ls_outer-result_field.   " 외부 LOOP 잔존 필드

  LOOP AT lt_inner INTO ls_inner WHERE key = ls_outer-key.
    CLEAR: ls_inner-temp_field.   " 내부 LOOP 임시 변수
    " 내부 처리
  ENDLOOP.
ENDLOOP.
```

#### CLEAR 자가 점검

- [ ] LOOP 시작 직후 Work Area / 임시 변수 CLEAR?
- [ ] READ TABLE 결과 구조체 CLEAR (sy-subrc=4 대비)?
- [ ] 서브루틴 진입 시 EXPORTING/CHANGING 파라미터 CLEAR?
- [ ] FIELD-SYMBOL 원본은 CLEAR하지 않음?
- [ ] 다중 LOOP 중첩 시 외부/내부 변수 분리 관리?

---

## §8. 코드 가독성 체크리스트

- [ ] JOIN alias가 a, b, c 순으로 부여됨
- [ ] 모든 SELECT 필드에 한글 주석 작성
- [ ] 메인 쿼리 → 보조 데이터 → 결합 순서로 작성
- [ ] 인라인 `@DATA(...)` 신구문 활용
- [ ] 처리 단계마다 섹션 구분 주석(`"========`) 작성
- [ ] WHERE 조건의 비즈니스 의도 주석 작성
- [ ] FIELD-SYMBOL ASSIGNING이 LOOP에 사용됨
- [ ] FOR ALL ENTRIES 앞에 `IS INITIAL` 체크 존재
- [ ] 신호등/상태 판단에 COND 표현식 활용
- [ ] **SQL 적재 직후 SORT 작성됨 (BINARY SEARCH Key와 일치)**
- [ ] **LOOP 시작 직후 Work Area / 결과 변수 CLEAR**
- [ ] **SORT Key 순서 = READ TABLE WITH KEY 순서**
- [ ] **FIELD-SYMBOL 원본은 CLEAR하지 않음**

---

## 📝 변경 로그 (원본 동기화 이력)

- **2026-06-04** | 로컬 SSOT 최초 등록 — Notion `[SKILL]_Functional_Spec_작성` v1.2의 💻 ABAP 코드 표준 탭(8개 섹션) 반영.

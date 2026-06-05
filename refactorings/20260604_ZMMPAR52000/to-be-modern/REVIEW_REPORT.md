# 🔍 ALV 모던화 v2 — 코드 리뷰 (SE38 반영 전)

> 기준: [`CBO_REVIEW_GUIDE`](../../../standards/CBO_REVIEW_GUIDE.md) §6 사전 점검 + [`ALV_MODERN_PATTERN`](../../../standards/patterns/ALV_MODERN_PATTERN.md) §5 생명주기.
> 범위: `to-be-modern/` 신규 인프라 코드 집중(핸들러/비즈니스는 로직 무변경 이관).
> 한계: 본 환경은 ABAP 컴파일/실행 불가 → **정적 리뷰**. 최종 활성화·동작은 SE38에서 검증.

## 판정: 🟢 정적 리뷰 통과 (단, 아래 HIGH/MID는 SE38 반영 시 필수)

- FORM/ENDFORM 균형, 미정의 PERFORM 0, 구 그리드변수 코드참조 0, 레거시 필드카탈로그 FM 0
- 의미 보존: F01 로직 무변경 / 핸들러 로직 무변경(변수 재매핑만) / 필드카탈로그 규칙 동일 / 이벤트 SY-DYNNR 라우팅 동일

---

## 🛑 H0 — 메인 화면 동적 테이블 (SE38 테스트로 발견 → 수정 완료)

**증상**: `ZMMPAR52000F01`의 `CREATE_DYNAMIC_TABLE`에서 `Field "GT_ALV_FIELDCAT_100" is unknown`.

**원인**: 이 프로그램의 메인 화면(0100/0400)은 **런타임 동적 테이블** 구조다. `CREATE_DYNAMIC_TABLE`(F01)이 `BUILD_CATEGORY_100/400`으로 필드카탈로그(`GT_ALV_FIELDCAT_100/400`)를 만들고 `CL_ALV_TABLE_CREATE`로 이동유형그룹(GR1~GR5/GI1~GI4) 런타임 컬럼 테이블 `<GT_BATCH>`/`<GT_TABLE>`을 생성한다. 초기 모던화가 이를 정적+RTTI로 잘못 가정해 해당 선언/폼을 제거 → F01 깨짐.

**수정**(패턴 §3-7 "그룹 런타임 컬럼은 동적 유지"):
1. 모던 TOP에 `GT_ALV_FIELDCAT`/`_100`/`_400` + `<FS_ALV_FIELDCAT>` + `GS_ALV_STABLE` 선언 복원
2. `BUILD_CATEGORY_100/400`(동적 카탈로그 빌더) 모던 F02로 이관
3. `ALV_DISPLAY_MAIN`을 **동적 테이블 바인딩**(`IT_OUTTAB = <GT_BATCH>`/`<GT_TABLE>`, `IT_FIELDCATALOG = GT_ALV_FIELDCAT_400/100`)으로 재배선 (원본 `DISPLAY_ALV_400`과 동일). 팝업(0200/0300/0500)은 정적 → RTTI 유지.

**정적 재검증**: 미선언 옛 ALV 전역 0, 미정의 PERFORM 0, FS 전부 선언, FORM/ENDFORM 균형. → F01 컴파일 오류 해소.

## 🔴 HIGH

| # | 항목 | 내용 / 조치 |
|---|---|---|
| H1 | 팝업 컨트롤 재오픈 안전 | `CREATE_INSTANCE_POP`에 **자가정리(self-healing)** 적용 완료 — 이전 팝업 그리드/도킹 잔존 시 `FREE_POPUP_CONTROLS` 후 재생성. F01 호출부 수정 없이 드롭인. **SE38에서 팝업 연속 오픈(0200→0300→0500) 1순위 검증.** |
| H2 | 컨테이너 전략(메인) | 원본은 메인(0100/0400)도 **Docking** 사용. 모던은 패턴대로 **`CL_GUI_CONTAINER=>SCREEN0`**. → SE38에서 0100/0400 dynpro를 **플레인 풀스크린**(커스텀 컨테이너 없음)으로 두고 동작 확인. 문제 시 대안: 메인도 Docking으로 회귀(패턴 이탈). |

## 🟡 MID

| # | 항목 | 내용 / 조치 |
|---|---|---|
| M1 | `SEL_MODE` | 원본 `'D'` 보존으로 수정 완료(모던 초안 `'A'` → `'D'`). |
| M2 | 텍스트 기호 | RTTI 필드카탈로그는 `COLTEXT` 등 미설정 시 DDIC fallback. **`TEXT-F51~F78`, `N04/N05`, `T01~T14`** SE38 등록 확인 필수. |
| M3 | Flow Logic | 화면 Flow Logic을 단일 모듈명 **`CREATE_ALV` / `USER_COMMAND`** 로 통일 + `EXIT_COMMAND`는 `AT EXIT-COMMAND` 등록. |

## 🟢 LOW (검토 완료 — 문제 없음/경미)

| # | 항목 | 결론 |
|---|---|---|
| L1 | `BUILD_LAYOUT`의 `CTAB_FNAME='COLINFO'`/`STYLEFNAME='CELLTAB'` 무조건 설정 | **5개 출력 구조체 모두 COLINFO/CELLTAB 보유 확인 → 덤프 없음.** (원본 0400만 미설정이었으나 필드 존재로 무해) |
| L2 | `GT_EXCLUDE_MAIN/POP` 미채움 | 툴바 표준버튼 제외 없음(원본 일부 제외) — 기능 영향 경미. 필요 시 채움. |
| L3 | `CREATE_EVENT_RECEIVER`에 `REGISTER_EDIT_EVENT` 없음 | 편집형 ALV 아님(원본도 `DATA_CHANGED` 핸들러 없음) → 무관. |
| L4 | 헤더 스테일 주석 | 정리 완료. |

---

## ✅ 사전 점검 체크리스트 대조 (CBO_REVIEW_GUIDE §6)

- [x] FORM 파라미터 타입 일치(`HANDLE_DOUBLE_CLICK_*`는 원본 시그니처 유지)
- [x] 풀스크린=`SCREEN0`·팝업=`DOCKING` 분리 적용
- [x] 팝업 컨트롤 해제 패턴(자가정리) / HTML Viewer `CLEAR`만 / FREE 후 `CL_GUI_CFW=>FLUSH`
- [x] 금액/수량 `CFIELDNAME`/`QFIELDNAME` 지정(공통 + 화면별)
- [ ] **(SE38) 텍스트 기호 등록 / PF-STATUS(SE41) 존재 / Flow Logic 모듈명 통일**
- [x] `MOVE-CORRESPONDING` 등 데이터 매핑 — 이관 로직 무변경

## ▶️ SE38 검증 순서(권장)
1. INCLUDE 교체(TOP/C01/O01/I01/F02) + F01·SCR는 `to-be/` 유지 → 활성화(SLIN)
2. 텍스트 기호/PF-STATUS/Flow Logic 모듈명 정리
3. **메인 0100 표시 → 팝업 0200/0300/0500 연속 오픈/닫기(H1) → 배치 0400** 순으로 동작·집계가 `to-be/`와 동일한지 비교
4. 이상 시 H2(컨테이너) 우선 점검

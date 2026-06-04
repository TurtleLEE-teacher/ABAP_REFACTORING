# 🔄 [ABAP 리팩토링] {프로그램명} — As-Is vs To-Be

> 빈 리포트 템플릿. 작성 가이드는 [`../../templates/REPORT_TEMPLATE.md`](../../templates/REPORT_TEMPLATE.md) 참고.
> 근거 표기(FS §N)는 [`../../standards/ABAP_CODE_STANDARD.md`](../../standards/ABAP_CODE_STANDARD.md) 섹션 번호.

| 항목 | 내용 |
| --- | --- |
| 프로그램 ID / 명 | `Z...` / {한글명} |
| 모듈 | MM / SD / PP / FI ... |
| 입력 단위 | FORM / INCLUDE / PROG / METHOD |
| 적용 모드 | R / M / P (P는 단독 금지) |
| 대상 환경 | S/4 HANA |
| 작업일 | YYYY-MM-DD |
| As-Is 소스 | [`as-is/`](./as-is/) |
| To-Be 소스 | [`to-be/`](./to-be/) |

---

## 1. 📊 진단 요약

| 모드 | 발견 이슈 | HIGH | MID | LOW |
| --- | --- | --- | --- | --- |
| 🔧 R (가독성) | - | - | - | - |
| 🛠 M (유지보수) | - | - | - | - |
| ⚡ P (성능, 옵션) | - | - | - | - |

---

## 2. 🔄 As-Is vs To-Be 비교

### As-Is

```abap
* 원본 코드
```

### To-Be

```abap
* 리팩토링 코드 (변경 주석 포함)
```

---

## 3. 📋 변경 사유 표

| # | 변경 항목 | 의도 | 근거 | 리스크 | Rollback |
|---|----------|-----|-----|-------|---------|
| 1 |  |  | FS §N |  |  |

---

## 4. ✅ 적용 체크리스트 + Rollback 포인트

- [ ] SE38/Eclipse 원본 백업
- [ ] 활성화 전 단위 테스트 (동일 입력 → 동일 출력)
- [ ] (P 모드) SAT/ST05 비교
- [ ] SY-SUBRC 분기 동작 동일 확인
- [ ] 한국어 주석 100% 유지 확인
- [ ] Production 이관 전 운영 데이터 샘플 검증

**Rollback 포인트**: `git revert <commit>` 또는 `as-is/` 원본으로 복원.

---

## 5. 🔍 자가 점검 결과

| 점검 항목 | 결과 |
| --- | --- |
| 의미 보존 (SY-SUBRC 흐름 동일) | ✅ / ❌ |
| 부수 효과 동일 | ✅ / ❌ |
| 한국어 주석 100% 보존 | ✅ / ❌ |
| SAP 표준 위배 없음 | ✅ / ❌ |
| (P 모드) 인덱스/데이터셋 영향 검토 | ✅ / ➖ |

**Exit Code**: `PASS(0)` / `BLOCK(2)` / `ERROR`

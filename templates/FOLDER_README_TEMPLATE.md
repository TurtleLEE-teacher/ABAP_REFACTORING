# {YYYYMMDD}_{프로그램명}

리팩토링 작업 폴더. 새 작업 시 `refactorings/_TEMPLATE_YYYYMMDD_ZPROGRAM/`를 복사해 시작한다.

| 항목 | 내용 |
| --- | --- |
| 프로그램 ID | `Z...` |
| 프로그램명 (한글) | {한글명} |
| 모듈 | MM / SD / PP / FI ... |
| 입력 단위 | FORM / INCLUDE / PROG / METHOD |
| 적용 모드 | R / M / P (P는 R 또는 M과 결합) |
| 작업일 | YYYY-MM-DD |
| 상태 | 진행중 / 완료 / 보류 |

## 구성

- [`as-is/`](./as-is/) — 원본 ABAP 소스 (`.abap`)
- [`to-be/`](./to-be/) — 리팩토링 소스 (변경 주석 포함 `.abap`)
- [`REPORT.md`](./REPORT.md) — 진단 요약 / As-Is vs To-Be 비교 / 변경 사유 표 / 체크리스트 / 자가 점검

## 비고

- 의미 보존(SY-SUBRC 흐름 / 부수 효과 / 한국어 주석) 최우선.
- 근거 표기는 [`../../standards/ABAP_CODE_STANDARD.md`](../../standards/ABAP_CODE_STANDARD.md)의 §N을 가리킨다.

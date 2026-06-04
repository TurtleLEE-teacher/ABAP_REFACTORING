# _TEMPLATE_YYYYMMDD_ZPROGRAM (복사용 빈 템플릿)

> 이 폴더는 **복사해서 쓰는 빈 시작 템플릿**이다. 직접 수정하지 말고 복사 후
> `YYYYMMDD_<프로그램명>`으로 이름을 바꿔 사용한다. (메타 항목은
> [`../../templates/FOLDER_README_TEMPLATE.md`](../../templates/FOLDER_README_TEMPLATE.md) 참고)

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

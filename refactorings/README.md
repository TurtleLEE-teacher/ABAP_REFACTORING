# 📂 리팩토링 작업물 (refactorings)

리팩토링 한 건마다 폴더 1개. As-Is 원본, To-Be 결과, 리포트를 함께 보관한다.

## 폴더 명명 규칙

```
YYYYMMDD_<프로그램명>
```

- 예: `20260604_ZMMPAR39010`, `20260604_ZSDR0010_FORM_GET_DATA`
- 같은 프로그램을 여러 단위로 나눠 진행하면 단위 식별자를 뒤에 붙인다 (예: `_FORM_GET_DATA`).

## 폴더 내부 구조

```
YYYYMMDD_<프로그램명>/
├── README.md      # 작업 메타 (templates/FOLDER_README_TEMPLATE.md 기반)
├── as-is/         # 원본 소스 (.abap)
├── to-be/         # 리팩토링 소스 (변경 주석 포함 .abap)
└── REPORT.md      # 리포트 (templates/REPORT_TEMPLATE.md 기반)
```

## 새 작업 시작 방법

1. `_TEMPLATE_YYYYMMDD_ZPROGRAM/` 폴더를 복사한다.
2. 폴더명을 `YYYYMMDD_<프로그램명>`으로 바꾼다.
3. `as-is/`에 원본 소스를 넣는다.
4. 모드(R/M/P)를 정해 리팩토링하고 `to-be/`에 결과를 넣는다. (P는 R 또는 M과 결합)
5. `REPORT.md`와 `README.md`를 채운다.
6. 아래 인덱스 표에 한 행 추가한다.

## 📑 작업 인덱스

| 날짜 | 프로그램 | 단위 | 모드 | 상태 | 링크 |
| --- | --- | --- | --- | --- | --- |
| 2026-06-04 | `ZMMPAR52000` | PROG (다중 INCLUDE) | 미정 | 🟡 As-Is 확보 | [폴더](./20260604_ZMMPAR52000/) |
| _(예시)_ | `_TEMPLATE_` | - | - | 템플릿 | [폴더](./_TEMPLATE_YYYYMMDD_ZPROGRAM/) |

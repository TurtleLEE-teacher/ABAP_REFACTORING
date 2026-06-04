# 🛠 ABAP_REFACTORING

ABAP 원소스(**As-Is**)를 받아 3가지 모드로 리팩토링(**To-Be**)하고, 그 결과를
**"As-Is vs To-Be 비교 + 변경 사유 표 + 적용 체크리스트 & Rollback"** 형식으로 관리하는 저장소.

운영 방식: **사용자가 ABAP 소스 제공 → Claude가 리팩토링 → 리포트 산출 → `refactorings/`에 누적**

---

## 📁 폴더 구조

```
ABAP_REFACTORING/
├── README.md                         # 이 문서 (저장소 전체 가이드)
├── standards/
│   └── ABAP_CODE_STANDARD.md         # ⭐ SSOT: ABAP 코드 표준 8개 섹션 (모든 판정 근거)
├── skill/
│   └── ABAP_REFACTORING_SKILL.md     # 리팩토링 스킬 정의서 (모드/프로세스/규칙)
├── templates/
│   ├── REPORT_TEMPLATE.md            # 산출 리포트 3종 세트 템플릿
│   └── FOLDER_README_TEMPLATE.md     # 작업 폴더 메타 README 틀
└── refactorings/
    ├── README.md                     # 작업물 명명 규칙 + 작업 인덱스
    └── _TEMPLATE_YYYYMMDD_ZPROGRAM/   # 복사해서 시작하는 빈 템플릿 폴더
        ├── as-is/                     # 원본 소스
        ├── to-be/                     # 리팩토링 소스
        └── REPORT.md                  # 리포트
```

---

## 🔄 운영 워크플로우

1. **입력**: ABAP 코드(FORM/INCLUDE/PROG/METHOD) + 모드 지정(R/M/P)
2. **처리 (6 Phase)**: 전체 스캔 → 입력 검증/파싱 → As-Is 진단 → To-Be 제안 → 셀프 크리틱 → 리포트 출력
   - 판정 근거는 [`standards/ABAP_CODE_STANDARD.md`](./standards/ABAP_CODE_STANDARD.md)의 §1~§8
   - 상세 절차는 [`skill/ABAP_REFACTORING_SKILL.md`](./skill/ABAP_REFACTORING_SKILL.md)
3. **산출**: As-Is vs To-Be 비교 + 변경 사유 표 + 적용 체크리스트 + 자가 점검 결과
4. **저장**: 채팅 기본 / 요청 시 `refactorings/YYYYMMDD_<프로그램명>/`에 보관

---

## 🧩 3가지 리팩토링 모드

| 모드 | 이름 | 원칙 | 비고 |
| --- | --- | --- | --- |
| 🔧 **R** | 가독성 (Readability) | 의미·성능 변경 없이 읽기 쉬움만 향상 | 기본 |
| 🛠 **M** | 유지보수 (Maintainability) | 구조 개선으로 변경 비용 절감 (동작 유지) | 기본 |
| ⚡ **P** | 성능 (Performance) | DB/런타임 최적화 | **옵션 · 단독 금지** (R 또는 M과 결합, 단위 테스트 필수) |

> 모드 미지정 시 **R+M** 기본 적용. P는 명시 호출 시에만.

---

## 🔒 핵심 원칙 — 의미 보존 최우선

리팩토링은 **동작을 바꾸지 않는다.** 아래 3가지는 무조건 유지한다.

- **SY-SUBRC 흐름**: 모든 분기점이 동일하게 동작
- **부수 효과**: 외부 변수 변경 / FM 호출 / 업데이트 동일
- **한국어 주석**: 100% 보존 (의미만 다듬기 허용, 삭제 금지)

위협이 감지되면 해당 변경을 제외하고 사유를 명시한다. (자세한 예외 처리: 스킬 문서 참조)

---

## ▶️ 새 리팩토링 시작 (Quick Start)

1. `refactorings/_TEMPLATE_YYYYMMDD_ZPROGRAM/` 폴더를 복사한다.
2. 폴더명을 `YYYYMMDD_<프로그램명>` (예: `20260604_ZMMPAR39010`)으로 바꾼다.
3. `as-is/`에 원본 소스를 넣고, 모드를 정해 채팅으로 리팩토링을 요청한다.
4. 결과를 `to-be/`에 넣고 `REPORT.md` · `README.md`를 채운다.
5. [`refactorings/README.md`](./refactorings/README.md)의 작업 인덱스에 한 행 추가한다.

---

## 🔗 핵심 문서

- ⭐ [`standards/ABAP_CODE_STANDARD.md`](./standards/ABAP_CODE_STANDARD.md) — ABAP 코드 표준 **SSOT**
- [`skill/ABAP_REFACTORING_SKILL.md`](./skill/ABAP_REFACTORING_SKILL.md) — 리팩토링 스킬 정의서
- [`templates/REPORT_TEMPLATE.md`](./templates/REPORT_TEMPLATE.md) — 리포트 템플릿
- [`refactorings/README.md`](./refactorings/README.md) — 작업물 명명 규칙 + 인덱스

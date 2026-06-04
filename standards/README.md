# 📚 ABAP 리팩토링 표준 (Standards)

ABAP 리팩토링의 **단일 출처(SSOT)** 문서 모음. 모든 리팩토링의 To-Be 판정 근거는 여기서 나온다.

## 🧭 메타원칙 (최상위)

> **가독성 / 유지보수 우선.** 성능·모던화는 그 다음이다.
> 새 문법이라도 **가독성이 떨어지면 기존 문법을 유지**한다.
> 판단 기준: *"이 코드를 6개월 뒤 다른 사람이 보았을 때 바로 이해할 수 있는가?"*

이 메타원칙은 [`CBO_REVIEW_GUIDE.md`](./CBO_REVIEW_GUIDE.md)에서 정의되며, 문서 간 충돌 시 **항상 우선**한다.

## 📄 문서 구성 & 적용 순서

| 순위 | 문서 | 역할 |
| --- | --- | --- |
| ① | [`CBO_REVIEW_GUIDE.md`](./CBO_REVIEW_GUIDE.md) | **리뷰 기준 · 판단 원칙 · 사전 점검 체크리스트** (정본). 네이밍/구조/하드코딩/주석/데이터선언/제어문/Z·Y 오브젝트 처리/모던문법 판단 + ALV 패턴 가이드 + 컴파일·GUI·ScreenFlow·데이터 사전점검 |
| ② | [`ABAP_CODE_STANDARD.md`](./ABAP_CODE_STANDARD.md) | **SQL/주석/정렬 세부 SSOT** (FS 표준 §1~§8). JOIN alias·메인쿼리우선·BINARY SEARCH+SORT 철칙·CLEAR 표준 등 |
| ③ | [`patterns/ALV_MODERN_PATTERN.md`](./patterns/ALV_MODERN_PATTERN.md) | **모던 ALV 코드 스켈레톤** (복붙용). 5벌→2벌·RTTI 필드카탈로그·단일 이벤트클래스·컨트롤 생명주기 |

## ⚖️ 충돌 시 우선순위

- **메타원칙(가독성 우선) > 세부 규칙.**
- 구체적으로, `ABAP_CODE_STANDARD §3`(FIELD-SYMBOL/인라인 신구문 적극 권장)은 메타원칙에 따라 **"가독성이 향상될 때만"** 적용한다. `LOOP AT ... INTO`, `MOVE-CORRESPONDING`, `READ ... BINARY SEARCH`는 가독성이 좋으면 **그대로 유지**해도 된다.
- ALV 구조/생명주기 등 화면 관련은 `patterns/ALV_MODERN_PATTERN.md`를 우선한다.

## 🔗 관련
- 작업 수행 스킬: [`../skill/ABAP_REFACTORING_SKILL.md`](../skill/ABAP_REFACTORING_SKILL.md)
- 산출 템플릿: [`../templates/`](../templates/)

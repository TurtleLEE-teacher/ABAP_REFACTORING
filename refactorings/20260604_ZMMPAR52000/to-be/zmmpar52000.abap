*&-------------------------------------------------------------------*
* Program ID   : ZMMPAR52000
* T-code       : ZMMPAR52000
* Title        : [MM] 재고 수불부
* Created By   : PABLJWA
* Created On   : 2025.09.08
* Description  : [MM] 재고 수불부
*&-------------------------------------------------------------------*
* (To-Be / 리팩토링: R+M) — 메인 프로그램. 로직 무변경, 죽은주석 정리.
* 메인 진입 화면 = 0400 (DISPLAY_DATA → CALL SCREEN 400)
*&-------------------------------------------------------------------*
*  #No   |Date        |Developer |Description (Reason) |HelpDesk No.
*&-------------------------------------------------------------------*
*   N    |2025.09.08              신규생성              |
*&-------------------------------------------------------------------*
REPORT ZMMPAR52000 MESSAGE-ID ZMCMM02.

INCLUDE ZMMPAR52000TOP.   " 글로벌 선언
INCLUDE ZMMPAR52000C01.   " 로컬 이벤트 클래스
INCLUDE ZMMPAR52000SCR.   " 셀렉션 스크린
INCLUDE ZMMPAR52000O01.   " PBO 모듈
INCLUDE ZMMPAR52000I01.   " PAI 모듈
INCLUDE ZMMPAR52000F01.   " 비즈니스 로직
INCLUDE ZMMPAR52000F02.   " ALV 표시

*----------------------------------------------------------------------*
* INITIALIZATION
*----------------------------------------------------------------------*
INITIALIZATION.
  PERFORM INITIALIZE.

AT SELECTION-SCREEN OUTPUT.
  PERFORM SCREEN_OUTPUT.
  PERFORM FIELD_DATE_SET.

*----------------------------------------------------------------------*
* START-OF-SELECTION
*----------------------------------------------------------------------*
START-OF-SELECTION.
  PERFORM CHECK_INPUT.
  PERFORM CHK_AUTH.
  PERFORM PROGRAM_LOG(ZCOXF001) USING SY-CPROG '' 'MM' 'P'
                                      SY-TITLE+0(70) SY-TCODE. "프로그램 실행 이력
  PERFORM CREATE_DYNAMIC_TABLE.   "Main/Batch 동적 테이블 필드카탈로그
  PERFORM SELECT_DATA.
  PERFORM DISPLAY_DATA.           "→ CALL SCREEN 400 (메인 결과 화면)

*----------------------------------------------------------------------*
* END-OF-SELECTION
*----------------------------------------------------------------------*
END-OF-SELECTION.

*&-------------------------------------------------------------------*
* 참고: 텍스트 요소(Text Symbols) — SE38에서 별도 관리 (Goto > Text Elements)
*   화면/블록 타이틀: 001 기본선택 / 002 저장위치·배치선택 / 003 금액선택
*                     004 사급선택 / 005 수불부선택 / 100·400 개요 / 110·410 상세 / 500 상세
*   라디오:           R01 저장위치재고 / R02 배치재고 / R03 기간별수불부(금액X) / R04 월별수불부(금액O)
*   필드(F5x~F9x):    F50 회사코드 / F51 자재코드 / F52 자재명 / F58 플랜트 / F59 사급업체 / F60 업체명
*                     F64 자재문서연도 / F65 전기일 / F66 자재문서 / F67 저장위치 / F68 배치 / F69 수량
*                     F70 금액 / F71 이동유형 / F72 유형명칭 / F73 특별재고 / F74 차변(D)/대변(C)
*                     F75 단위 / F76 통화 / F77 문서항번 / F78 Production Order
*   In-Transit:       N04 Stock In Transit Q'ty / N05 Stock In Transit Value
*   셀렉션 텍스트:    P_SPMON 기준년월 / P_VAL 금액포함 / P_VAL9 사급자재포함
*                     S_BUDAT 전기일 / S_CHARG 배치 / S_LGORT 저장위치 / S_MATNR 자재코드 / S_WERKS 플랜트
*   메시지:           00/055 필수입력 안내 / ZMCMM02: 000 & / 010 데이터없음 / 080 SiT없음 / 082 No data
*&-------------------------------------------------------------------*

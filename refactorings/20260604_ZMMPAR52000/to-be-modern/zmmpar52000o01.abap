*&---------------------------------------------------------------------*
*& INCLUDE ZMMPAR52000O01  (To-Be / ALV 모던화 v2 — PBO)
*& 표준: standards/patterns/ALV_MODERN_PATTERN.md
*&   구: CREATE_ALV_100~500 (5벌) → 신: 단일 CREATE_ALV (역할별 공통 폼 호출)
*& ⚠️ SE38: 각 화면(0100/0200/0300/0400/0500) Flow Logic의 PBO를
*&         `MODULE STATUS_0100.` + `MODULE CREATE_ALV.` 로 통일할 것.
*&---------------------------------------------------------------------*

*&--------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT  — PF-STATUS / TITLEBAR (화면별)
*&--------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.

  DATA LT_FCODE TYPE TABLE OF SY-UCOMM.
  REFRESH LT_FCODE.

  CASE SY-DYNNR.
    WHEN '0100'.                              " 메인
      SET PF-STATUS '0100' EXCLUDING LT_FCODE.
      SET TITLEBAR  '0100' WITH TEXT-T01.
    WHEN '0200'.                              " 그룹 데이터(팝업)
      SET PF-STATUS '0200' EXCLUDING LT_FCODE.
      CASE GS_DISP_SCR-DYNNR.
        WHEN '0400'. SET TITLEBAR '0100' WITH TEXT-T02 TEXT-T14.
        WHEN OTHERS. SET TITLEBAR '0100' WITH TEXT-T02.
      ENDCASE.
    WHEN '0300'.                              " SIT(팝업)
      SET PF-STATUS '0300' EXCLUDING LT_FCODE.
      SET TITLEBAR  '0100' WITH TEXT-T03.
    WHEN '0400'.                              " 배치(풀스크린)
      SET PF-STATUS '0400' EXCLUDING LT_FCODE.
      SET TITLEBAR  '0100' WITH TEXT-T01.
    WHEN '0500'.                              " 자재문서(팝업)
      SET PF-STATUS '0200' EXCLUDING LT_FCODE.
      SET TITLEBAR  '0100' WITH TEXT-T05.
  ENDCASE.

ENDMODULE.

*&--------------------------------------------------------------------*
*& Module CREATE_ALV OUTPUT  — ALV 생성 (역할별 공통 폼, 최초 1회)
*&--------------------------------------------------------------------*
MODULE CREATE_ALV OUTPUT.

  CASE SY-DYNNR.
    WHEN '0100' OR '0400'.                    " 풀스크린 → MAIN
      IF GCL_GRID_MAIN IS NOT BOUND.
        PERFORM ALV_DISPLAY_MAIN USING SY-DYNNR.
      ENDIF.
    WHEN '0200' OR '0300' OR '0500'.          " 팝업 → POP
      IF GCL_GRID_POP IS NOT BOUND.
        PERFORM ALV_DISPLAY_POP USING SY-DYNNR.
      ENDIF.
  ENDCASE.

ENDMODULE.

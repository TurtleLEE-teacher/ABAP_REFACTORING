*&---------------------------------------------------------------------*
*& INCLUDE ZMMPAR52000I01  (To-Be / ALV 모던화 v2 — PAI)
*& 표준: standards/patterns/ALV_MODERN_PATTERN.md
*&   구: USER_COMMAND_0100~0500 (5벌, 그리드만 상이) → 신: 단일 USER_COMMAND
*& ⚠️ SE38: 각 화면 Flow Logic PAI를 `MODULE EXIT_COMMAND AT EXIT-COMMAND.` +
*&         `MODULE USER_COMMAND.` 로 통일할 것.
*&---------------------------------------------------------------------*

*&--------------------------------------------------------------------*
*& Module EXIT_COMMAND INPUT  (AT EXIT-COMMAND)
*&--------------------------------------------------------------------*
MODULE EXIT_COMMAND INPUT.
  PERFORM EXIT_RTN.
ENDMODULE.

*&--------------------------------------------------------------------*
*& Module USER_COMMAND INPUT  — 화면 공통 (그리드는 역할별 분기)
*&--------------------------------------------------------------------*
MODULE USER_COMMAND INPUT.

  " 활성 화면의 그리드 변경분 반영 (MAIN/POP)
  DATA(LCL_GRID) = COND #( WHEN SY-DYNNR = '0100' OR SY-DYNNR = '0400'
                           THEN GCL_GRID_MAIN ELSE GCL_GRID_POP ).
  IF LCL_GRID IS BOUND.
    LCL_GRID->CHECK_CHANGED_DATA( ).
  ENDIF.
  CL_GUI_CFW=>FLUSH( ).

  CLEAR: GV_SAVE_OKCODE, GV_ERR.
  GV_SAVE_OKCODE = SY-UCOMM.
  CLEAR SY-UCOMM.

  CASE GV_SAVE_OKCODE.
    WHEN 'BACK' OR 'EXIT' OR 'CANC' OR 'OKAY'.
      PERFORM EXIT_RTN.
  ENDCASE.

ENDMODULE.

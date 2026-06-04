*&---------------------------------------------------------------------*
*& INCLUDE ZMMPAR52000I01  (To-Be / 리팩토링: R+M)  — PAI 모듈
*& 표준: standards/ABAP_CODE_STANDARD.md | 죽은 주석코드 정리 적용
*&---------------------------------------------------------------------*

Code listing for: ZMMPAR52000I01 Description: Include ZMMMAM36100I01

*&---------------------------------------------------------------------*
*& Include          YMMR0010I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE EXIT_COMMAND INPUT.

*     exit

  PERFORM EXIT_RTN.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE USER_COMMAND_0100 INPUT.

  CALL METHOD GV_ALV_GRID_100->CHECK_CHANGED_DATA.
  CALL METHOD CL_GUI_CFW=>FLUSH.

  CLEAR: GV_SAVE_OKCODE,
         GV_ERR.

  GV_SAVE_OKCODE = SY-UCOMM.
  CLEAR SY-UCOMM.
  CASE GV_SAVE_OKCODE.

*>  Exit logic

    WHEN 'BACK' OR 'EXIT'.

*     exit

      PERFORM EXIT_RTN.

  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE USER_COMMAND_0200 INPUT.

  CALL METHOD GV_ALV_GRID_200->CHECK_CHANGED_DATA.
  CALL METHOD CL_GUI_CFW=>FLUSH.

  CLEAR: GV_SAVE_OKCODE,
         GV_ERR.

  GV_SAVE_OKCODE = SY-UCOMM.
  CLEAR SY-UCOMM.
  CASE GV_SAVE_OKCODE.

*>  Exit logic

    WHEN 'BACK' OR 'EXIT' OR 'CANC' OR 'OKAY'.

*     exit

      PERFORM EXIT_RTN.

  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE USER_COMMAND_0300 INPUT.

  CALL METHOD GV_ALV_GRID_300->CHECK_CHANGED_DATA.
  CALL METHOD CL_GUI_CFW=>FLUSH.

  CLEAR: GV_SAVE_OKCODE,
         GV_ERR.

  GV_SAVE_OKCODE = SY-UCOMM.
  CLEAR SY-UCOMM.
  CASE GV_SAVE_OKCODE.

*>  Exit logic

    WHEN 'BACK' OR 'EXIT' OR 'CANC' OR 'OKAY'.

*     exit

      PERFORM EXIT_RTN.

  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0400  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE USER_COMMAND_0400 INPUT.

  CALL METHOD GV_ALV_GRID_400->CHECK_CHANGED_DATA.
  CALL METHOD CL_GUI_CFW=>FLUSH.

  CLEAR: GV_SAVE_OKCODE,
         GV_ERR.

  GV_SAVE_OKCODE = SY-UCOMM.
  CLEAR SY-UCOMM.
  CASE GV_SAVE_OKCODE.

*>  Exit logic

    WHEN 'BACK' OR 'EXIT' OR 'CANC' OR 'OKAY'.

*     exit

      PERFORM EXIT_RTN.

  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0500  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE USER_COMMAND_0500 INPUT.

  CALL METHOD GV_ALV_GRID_500->CHECK_CHANGED_DATA.
  CALL METHOD CL_GUI_CFW=>FLUSH.

  CLEAR: GV_SAVE_OKCODE,
         GV_ERR.

  GV_SAVE_OKCODE = SY-UCOMM.
  CLEAR SY-UCOMM.
  CASE GV_SAVE_OKCODE.

*>  Exit logic

    WHEN 'BACK' OR 'EXIT' OR 'CANC' OR 'OKAY'.

*     exit

      PERFORM EXIT_RTN.

  ENDCASE.

ENDMODULE.

Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2026. Sap Release 755

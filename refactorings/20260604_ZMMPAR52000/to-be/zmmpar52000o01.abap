*&---------------------------------------------------------------------*
*& INCLUDE ZMMPAR52000O01  (To-Be / 리팩토링: R+M)  — PBO 모듈
*& 표준: standards/ABAP_CODE_STANDARD.md | 죽은 주석코드 정리 적용
*&---------------------------------------------------------------------*

Code listing for: ZMMPAR52000O01 Description: Include ZMMMAM36100O01

*&---------------------------------------------------------------------*
*& Include          YMMR0010O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE STATUS_0100 OUTPUT.

  DATA: LT_FCODE TYPE TABLE OF SY-UCOMM,
        LV_FCODE TYPE SY-UCOMM.

  REFRESH LT_FCODE.

  SET PF-STATUS '0100' EXCLUDING LT_FCODE.

  CASE SY-DYNNR.
    WHEN '0100'. "main
      SET TITLEBAR '0100' WITH TEXT-T01.

    WHEN '0200'. "Group data
      SET PF-STATUS '0200' EXCLUDING LT_FCODE.
      CASE GS_DISP_SCR-DYNNR.
        WHEN '0400'.
          SET TITLEBAR '0100' WITH TEXT-T02 TEXT-T14.
        WHEN OTHERS.
          SET TITLEBAR '0100' WITH TEXT-T02.
      ENDCASE.

    WHEN '0300'. "[Stock In Transit Report # Purchase Order Item Level]
      SET TITLEBAR '0100' WITH TEXT-T03.
      SET PF-STATUS '0300' EXCLUDING LT_FCODE.

    WHEN '0400'. "Batch data
      SET PF-STATUS '0400' EXCLUDING LT_FCODE.

      SET TITLEBAR '0100' WITH TEXT-T01.

    WHEN '0500'. "[Stock In Transit Report # Material Doc. Level]
      SET PF-STATUS '0200' EXCLUDING LT_FCODE.
      SET TITLEBAR '0100' WITH TEXT-T05.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  CREATE_ALV_100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE CREATE_ALV_100 OUTPUT.

  CHECK GV_DOCKING_CONTAINER_100 IS INITIAL.
  PERFORM ALV_CLEAR_VARIABLE_100.

* Main data

  PERFORM CREATE_GRID_OBJECT_100.

  PERFORM EXCLUDE_FUNCTIONKEY USING 'GT_ALV_EXTAB_100'.    "Tool Bar
  PERFORM BUILD_LAYOUT_100 CHANGING GS_ALV_LAYOUT_100.     "Grid Layout

  PERFORM BUILD_SORT_100.                                  "Sort
  PERFORM BUILD_COLOR_STYLE_100.                           "Color/Style
  PERFORM BUILD_EVENT_100.                                 "Event
  PERFORM DISPLAY_ALV_100.                                 "Display ALV

** New data

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  CREATE_ALV_200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE CREATE_ALV_200 OUTPUT.

  CHECK GV_DOCKING_CONTAINER_200 IS INITIAL.
  PERFORM ALV_CLEAR_VARIABLE_200.

* Old data

  PERFORM CREATE_GRID_OBJECT_200.

  PERFORM EXCLUDE_FUNCTIONKEY USING 'GT_ALV_EXTAB_200'.    "Tool Bar
  PERFORM BUILD_LAYOUT_200 CHANGING GS_ALV_LAYOUT_200.     "Grid Layout
  PERFORM BUILD_CATEGORY_200 CHANGING GT_ALV_FIELDCAT_200. "Field Cat.
  PERFORM BUILD_SORT_200.                                  "Sort
  PERFORM BUILD_COLOR_STYLE_200.                           "Color/Style
  PERFORM BUILD_EVENT_200.                                 "Event
  PERFORM DISPLAY_ALV_200.                                 "Display ALV

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  CREATE_ALV_300  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE CREATE_ALV_300 OUTPUT.

  CHECK GV_DOCKING_CONTAINER_300 IS INITIAL.
  PERFORM ALV_CLEAR_VARIABLE_300.

* Old data

  PERFORM CREATE_GRID_OBJECT_300.

  PERFORM EXCLUDE_FUNCTIONKEY USING 'GT_ALV_EXTAB_300'.    "Tool Bar
  PERFORM BUILD_LAYOUT_300 CHANGING GS_ALV_LAYOUT_300.     "Grid Layout
  PERFORM BUILD_CATEGORY_300 CHANGING GT_ALV_FIELDCAT_300. "Field Cat.
  PERFORM BUILD_SORT_300.                                  "Sort
  PERFORM BUILD_COLOR_STYLE_300.                           "Color/Style
  PERFORM BUILD_EVENT_300.                                 "Event
  PERFORM DISPLAY_ALV_300.                                 "Display ALV

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  CREATE_ALV_400  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE CREATE_ALV_400 OUTPUT.

  CHECK GV_DOCKING_CONTAINER_400 IS INITIAL.
  PERFORM ALV_CLEAR_VARIABLE_400.

* Old data

  PERFORM CREATE_GRID_OBJECT_400.

  PERFORM EXCLUDE_FUNCTIONKEY USING 'GT_ALV_EXTAB_400'.    "Tool Bar
  PERFORM BUILD_LAYOUT_400 CHANGING GS_ALV_LAYOUT_400.     "Grid Layout

  PERFORM BUILD_SORT_400.                                  "Sort
  PERFORM BUILD_COLOR_STYLE_400.                           "Color/Style
  PERFORM BUILD_EVENT_400.                                 "Event
  PERFORM DISPLAY_ALV_400.                                 "Display ALV

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  CREATE_ALV_500  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE CREATE_ALV_500 OUTPUT.

  CHECK GV_DOCKING_CONTAINER_500 IS INITIAL.
  PERFORM ALV_CLEAR_VARIABLE_500.

* Old data

  PERFORM CREATE_GRID_OBJECT_500.

  PERFORM EXCLUDE_FUNCTIONKEY USING 'GT_ALV_EXTAB_500'.    "Tool Bar
  PERFORM BUILD_LAYOUT_500 CHANGING GS_ALV_LAYOUT_500.     "Grid Layout
  PERFORM BUILD_CATEGORY_500 CHANGING GT_ALV_FIELDCAT_500. "Field Cat.
  PERFORM BUILD_SORT_500.                                  "Sort
  PERFORM BUILD_COLOR_STYLE_500.                           "Color/Style
  PERFORM BUILD_EVENT_500.                                 "Event
  PERFORM DISPLAY_ALV_500.                                 "Display ALV

ENDMODULE.

Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2026. Sap Release 755

*&---------------------------------------------------------------------*
*& INCLUDE ZMMPAR52000C01  (To-Be / 리팩토링: R+M)  — 로컬 클래스(이벤트 리시버)
*& 표준: standards/ABAP_CODE_STANDARD.md | 죽은 주석코드 정리 적용
*&---------------------------------------------------------------------*

Code listing for: ZMMPAR52000C01 Description: Include ZMMMAM36100C01

*&---------------------------------------------------------------------*
*& Include          YMMR0010C01
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
* Include
*----------------------------------------------------------------------*

TYPE-POOLS : SLIS.
INCLUDE <CL_ALV_CONTROL>.

*---------------------------------------------------------------------*
* Internal tables
*---------------------------------------------------------------------*

DATA: GT_ALV_FIELDCAT     TYPE LVC_T_FCAT,              "Field Catalog
      GT_ALV_FIELDCAT_100 TYPE LVC_T_FCAT,          "Field Catalog
      GT_ALV_FIELDCAT_110 TYPE LVC_T_FCAT,          "Field Catalog
      GT_ALV_FIELDCAT_200 TYPE LVC_T_FCAT,          "Field Catalog
      GT_ALV_FIELDCAT_300 TYPE LVC_T_FCAT,          "Field Catalog
      GT_ALV_FIELDCAT_400 TYPE LVC_T_FCAT,          "Field Catalog
      GT_ALV_FIELDCAT_500 TYPE LVC_T_FCAT,          "Field Catalog

      GT_ALV_SORT         TYPE LVC_T_SORT,          "Sort Field
      GT_ALV_SORT_100     TYPE LVC_T_SORT,          "Sort Field
      GT_ALV_SORT_110     TYPE LVC_T_SORT,          "Sort Field
      GT_ALV_SORT_200     TYPE LVC_T_SORT,          "Sort Field
      GT_ALV_SORT_300     TYPE LVC_T_SORT,          "Sort Field
      GT_ALV_SORT_400     TYPE LVC_T_SORT,          "Sort Field
      GT_ALV_SORT_500     TYPE LVC_T_SORT,          "Sort Field

      GT_ALV_COLOR        TYPE LVC_T_SCOL WITH HEADER LINE,
      GT_ALV_CELLTAB      TYPE LVC_T_STYL,

      GT_ALV_EXTAB        TYPE UI_FUNCTIONS,        "Exclude Menu
      GT_ALV_EXTAB_100    TYPE UI_FUNCTIONS,        "Exclude Menu
      GT_ALV_EXTAB_110    TYPE UI_FUNCTIONS,        "Exclude Menu
      GT_ALV_EXTAB_200    TYPE UI_FUNCTIONS,        "Exclude Menu
      GT_ALV_EXTAB_300    TYPE UI_FUNCTIONS,        "Exclude Menu
      GT_ALV_EXTAB_400    TYPE UI_FUNCTIONS,        "Exclude Menu
      GT_ALV_EXTAB_500    TYPE UI_FUNCTIONS,        "Exclude Menu

      GT_ALV_HEADER       TYPE SLIS_T_LISTHEADER,   "ALV Header
      GT_ALV_HEADER_100   TYPE SLIS_T_LISTHEADER,   "ALV Header
      GT_ALV_HEADER_110   TYPE SLIS_T_LISTHEADER,   "ALV Header
      GT_ALV_HEADER_200   TYPE SLIS_T_LISTHEADER,   "ALV Header
      GT_ALV_HEADER_300   TYPE SLIS_T_LISTHEADER,   "ALV Header
      GT_ALV_HEADER_400   TYPE SLIS_T_LISTHEADER,   "ALV Header
      GT_ALV_HEADER_500   TYPE SLIS_T_LISTHEADER,   "ALV Header

      GT_ALV_EVENT        TYPE SLIS_T_EVENT,        "Events
      GT_ALV_EVENT_100    TYPE SLIS_T_EVENT,        "Events
      GT_ALV_EVENT_110    TYPE SLIS_T_EVENT,        "Events
      GT_ALV_EVENT_200    TYPE SLIS_T_EVENT,        "Events
      GT_ALV_EVENT_300    TYPE SLIS_T_EVENT,        "Events
      GT_ALV_EVENT_400    TYPE SLIS_T_EVENT,        "Events
      GT_ALV_EVENT_500    TYPE SLIS_T_EVENT,        "Events

      GT_ALV_F4           TYPE LVC_T_F4,            "F4
      GT_DROPDOWN         TYPE LVC_T_DROP.

DATA: GT_ALV_ROWS TYPE LVC_T_ROW,
      GS_ALV_ROWS TYPE LVC_S_ROW,
      GT_ALV_COLS TYPE LVC_T_COL,
      GS_ALV_COLS TYPE LVC_S_COL.

*---------------------------------------------------------------------*
* Structure                                                           *
*---------------------------------------------------------------------*

DATA: GS_ALV_FIELDCAT     TYPE LVC_S_FCAT, "Field Catolog
      GS_ALV_SORT         TYPE LVC_S_SORT,          "Sort Field
      GS_ALV_EVENT        TYPE SLIS_ALV_EVENT,      "Events
      GS_ALV_LAYOUT       TYPE LVC_S_LAYO,          "Layout
      GS_ALV_LAYOUT_100   TYPE LVC_S_LAYO,          "Layout
      GS_ALV_LAYOUT_110   TYPE LVC_S_LAYO,          "Layout
      GS_ALV_LAYOUT_200   TYPE LVC_S_LAYO,          "Layout
      GS_ALV_LAYOUT_300   TYPE LVC_S_LAYO,          "Layout
      GS_ALV_LAYOUT_400   TYPE LVC_S_LAYO,          "Layout
      GS_ALV_LAYOUT_500   TYPE LVC_S_LAYO,          "Layout

      GS_ALV_VARIANT      LIKE DISVARIANT,
      GS_ALV_VARIANT_100  LIKE DISVARIANT,
      GS_ALV_VARIANT_110  LIKE DISVARIANT,
      GS_ALV_VARIANT_200  LIKE DISVARIANT,
      GS_ALV_VARIANT_300  LIKE DISVARIANT,
      GS_ALV_VARIANT_400  LIKE DISVARIANT,
      GS_ALV_VARIANT_500  LIKE DISVARIANT,

      GS_ALV_CELLTAB      TYPE LVC_S_STYL,

      GS_ALV_SELFIELD     TYPE SLIS_SELFIELD,
      GS_ALV_STABLE       TYPE LVC_S_STBL,
      GS_ALV_F4           TYPE LVC_S_F4,            " F4
      GS_DROPDOWN         TYPE LVC_S_DROP,

      GV_ALV_STATUS_FORM  TYPE SLIS_FORMNAME VALUE 'ALV_PF_STATUS',
      GV_ALV_COMMAND_FORM TYPE SLIS_FORMNAME VALUE 'USER_COMMAND',

      GV_ALV_TITLE        TYPE LVC_TITLE,
      GV_ALV_TITLE_100    TYPE LVC_TITLE,

      GV_ALV_REPID        LIKE SY-REPID,
      GV_ALV_SAVE         VALUE 'A',
      GV_ALV_COLOR(4),
      GV_ALV_POS          TYPE I VALUE 1,
      GV_MODE_TEXT(100).

*---------------------------------------------------------------------*
*" Variable                                                           *
*---------------------------------------------------------------------*

DATA : GV_CUST_CONTAINER         TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
       GV_CUST_CONTAINER_100     TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
       GV_CUST_CONTAINER_110     TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
       GV_CUST_CONTAINER_200     TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
       GV_CUST_CONTAINER_300     TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
       GV_CUST_CONTAINER_400     TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
       GV_CUST_CONTAINER_500     TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

       GV_DOCKING_CONTAINER_100  TYPE REF TO CL_GUI_DOCKING_CONTAINER,
       GV_DOCKING_CONTAINER_200  TYPE REF TO CL_GUI_DOCKING_CONTAINER,
       GV_DOCKING_CONTAINER_300  TYPE REF TO CL_GUI_DOCKING_CONTAINER,
       GV_DOCKING_CONTAINER_400  TYPE REF TO CL_GUI_DOCKING_CONTAINER,
       GV_DOCKING_CONTAINER_500  TYPE REF TO CL_GUI_DOCKING_CONTAINER,
       GV_SPLITTER_CONTAINER_100 TYPE REF TO
       CL_GUI_EASY_SPLITTER_CONTAINER,
       GV_SPLITTER_TOP           TYPE REF TO CL_GUI_CONTAINER,
       GV_SPLITTER_BOTTOM        TYPE REF TO CL_GUI_CONTAINER,
       GV_SPLITTER_LEFT          TYPE REF TO CL_GUI_CONTAINER,
       GV_SPLITTER_RIGHT         TYPE REF TO CL_GUI_CONTAINER,
       GV_SPLITTER               TYPE REF TO CL_GUI_CONTAINER,

       GV_HTML_TOP_OF_LIST       TYPE REF TO CL_GUI_HTML_VIEWER,
       GV_ALV_SPLITTER           TYPE REF TO
       CL_GUI_SPLITTER_CONTAINER,
       GV_ALV_CONTAINER          TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

       GV_TOP_OF_LIST            TYPE REF TO CL_GUI_CONTAINER,
       GV_ALV_GRID               TYPE REF TO CL_GUI_ALV_GRID,
       GV_ALV_GRID_100           TYPE REF TO CL_GUI_ALV_GRID,
       GV_ALV_GRID_110           TYPE REF TO CL_GUI_ALV_GRID,
       GV_ALV_GRID_200           TYPE REF TO CL_GUI_ALV_GRID,
       GV_ALV_GRID_300           TYPE REF TO CL_GUI_ALV_GRID,
       GV_ALV_GRID_400           TYPE REF TO CL_GUI_ALV_GRID,
       GV_ALV_GRID_500           TYPE REF TO CL_GUI_ALV_GRID,

       GV_ALV_DOCUMENT           TYPE REF TO CL_DD_DOCUMENT,
       GV_REPID                  LIKE SY-REPID,
       GV_DYNNR                  LIKE SY-DYNNR.

FIELD-SYMBOLS: <FS_ALV_FIELDCAT> LIKE LINE OF GT_ALV_FIELDCAT,
               <FS_ALV_CELLTAB>  LIKE LINE OF GT_ALV_CELLTAB.

*---------------------------------------------------------------------*
* Receiver_100 LOCAL CLASSES: Definition
*---------------------------------------------------------------------*

CLASS LCL_EVENT_RECEIVER_100 DEFINITION.

  PUBLIC SECTION.
    METHODS : HANDLE_TOOLBAR
      FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
      IMPORTING E_OBJECT E_INTERACTIVE.

    METHODS : HANDLE_USER_COMMAND
      FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID
      IMPORTING E_UCOMM       " SY-UCOMM
                SENDER.

    METHODS: ON_TOOLBAR
      FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
      IMPORTING E_OBJECT
                E_INTERACTIVE
                SENDER.

    METHODS : HANDLE_DATA_CHANGED
      FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID
      IMPORTING ER_DATA_CHANGED.

    METHODS : HANDLE_DATA_CHANGED_FINISHED
      FOR EVENT DATA_CHANGED_FINISHED OF CL_GUI_ALV_GRID
      IMPORTING E_MODIFIED ET_GOOD_CELLS.

    METHODS : HANDLE_HOTSPOT_CLICK
      FOR EVENT HOTSPOT_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW_ID
                E_COLUMN_ID.

    METHODS : HANDLE_DOUBLE_CLICK
      FOR EVENT DOUBLE_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW
                E_COLUMN.

    METHODS : HANDLE_ONF4
      FOR EVENT ONF4 OF CL_GUI_ALV_GRID
      IMPORTING SENDER
                E_FIELDNAME
                E_FIELDVALUE
                ES_ROW_NO
                ER_EVENT_DATA
                ET_BAD_CELLS
                E_DISPLAY.

    METHODS :  ON_TOP_OF_PAGE
      FOR EVENT TOP_OF_PAGE OF CL_GUI_ALV_GRID
      IMPORTING E_DYNDOC_ID.
ENDCLASS. "(LCL_EVENT_RECEIVER_100 DEFINITION)

*---------------------------------------------------------------------*
* Receiver_100 LOCAL CLASSES: Implementation
*---------------------------------------------------------------------*

CLASS LCL_EVENT_RECEIVER_100 IMPLEMENTATION.

  METHOD HANDLE_TOOLBAR.

*    perform handle_toolbar_100   using e_object e_interactive.

  ENDMETHOD.                     "handle_toolbar

  METHOD HANDLE_USER_COMMAND.     " Detail 버튼 로직
    PERFORM HANDLE_USER_COMMAND_100  USING E_UCOMM
                                            SENDER.
  ENDMETHOD.                         "handle_user_command

  METHOD HANDLE_DATA_CHANGED.

*    perform handle_changed_100  using er_data_changed.

  ENDMETHOD.                         "handle_data_changed

  METHOD HANDLE_DATA_CHANGED_FINISHED.

*perform handle_changed_finished_100  using e_modified et_good_cells.

  ENDMETHOD.                             "HANDLE_DATA_CHANGED_FINISHED

  METHOD HANDLE_HOTSPOT_CLICK.    " 더블클릭 로직
    PERFORM HANDLE_DOUBLE_CLICK_100  USING E_ROW_ID E_COLUMN_ID.
  ENDMETHOD.                    "handle_hotspot_click

  METHOD HANDLE_DOUBLE_CLICK.     " 더블클릭 로직
    PERFORM HANDLE_DOUBLE_CLICK_100   USING E_ROW E_COLUMN.
  ENDMETHOD.                          "handle_double_click

  METHOD HANDLE_ONF4.

*    perform handle_on_f4_100   using sender
*                                     e_fieldname
*                                     e_fieldvalue
*                                     es_row_no
*                                     er_event_data
*                                     e_display.

  ENDMETHOD.                    "handle_onf4

  METHOD ON_TOP_OF_PAGE.
    PERFORM TOP_OF_PAGE USING E_DYNDOC_ID .
  ENDMETHOD.

  METHOD ON_TOOLBAR.              " Top of Page 로직
    PERFORM HANDLER_TOOLBAR USING E_OBJECT
                                  SENDER.
  ENDMETHOD.

ENDCLASS. "LCL_EVENT_RECEIVER_100 IMPLEMENTATION

*---------------------------------------------------------------------*
* Receiver_200 LOCAL CLASSES: Definition
*---------------------------------------------------------------------*

CLASS LCL_EVENT_RECEIVER_200 DEFINITION.

  PUBLIC SECTION.
    METHODS : HANDLE_TOOLBAR
      FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
      IMPORTING E_OBJECT E_INTERACTIVE.

    METHODS : HANDLE_USER_COMMAND
      FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID
      IMPORTING E_UCOMM.

    METHODS : HANDLE_DATA_CHANGED
      FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID
      IMPORTING ER_DATA_CHANGED.

    METHODS : HANDLE_DATA_CHANGED_FINISHED
      FOR EVENT DATA_CHANGED_FINISHED OF CL_GUI_ALV_GRID
      IMPORTING E_MODIFIED ET_GOOD_CELLS.

    METHODS : HANDLE_HOTSPOT_CLICK
      FOR EVENT HOTSPOT_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW_ID
                E_COLUMN_ID.

    METHODS : HANDLE_DOUBLE_CLICK
      FOR EVENT DOUBLE_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW
                E_COLUMN.

    METHODS : HANDLE_ONF4
      FOR EVENT ONF4 OF CL_GUI_ALV_GRID
      IMPORTING SENDER
                E_FIELDNAME
                E_FIELDVALUE
                ES_ROW_NO
                ER_EVENT_DATA
                ET_BAD_CELLS
                E_DISPLAY.

    METHODS :  ON_TOP_OF_PAGE
      FOR EVENT TOP_OF_PAGE OF CL_GUI_ALV_GRID
      IMPORTING E_DYNDOC_ID.
ENDCLASS. "(LCL_EVENT_RECEIVER_200 DEFINITION)

*---------------------------------------------------------------------*
* Receiver_200 LOCAL CLASSES: Implementation
*---------------------------------------------------------------------*

CLASS LCL_EVENT_RECEIVER_200 IMPLEMENTATION.

  METHOD HANDLE_TOOLBAR.

*    perform handle_toolbar_200   using e_object e_interactive.

  ENDMETHOD.                     "handle_toolbar

  METHOD HANDLE_USER_COMMAND.

*    perform handle_user_command_200  using e_ucomm.

  ENDMETHOD.                         "handle_user_command

  METHOD HANDLE_DATA_CHANGED.

*    perform handle_changed_200  using er_data_changed.

  ENDMETHOD.                         "handle_data_changed

  METHOD HANDLE_DATA_CHANGED_FINISHED.

*perform handle_changed_finished_200  using e_modified et_good_cells.

  ENDMETHOD.                             "HANDLE_DATA_CHANGED_FINISHED

  METHOD HANDLE_HOTSPOT_CLICK. " 더블 클릭 로직
    PERFORM HANDLE_DOUBLE_CLICK_200  USING E_ROW_ID E_COLUMN_ID.
  ENDMETHOD.                    "handle_hotspot_click

  METHOD HANDLE_DOUBLE_CLICK.  " 더블 클릭 로직
    PERFORM HANDLE_DOUBLE_CLICK_200   USING E_ROW E_COLUMN.
  ENDMETHOD.                          "handle_double_click

  METHOD HANDLE_ONF4.

*    perform handle_on_f4_200   using sender
*                                     e_fieldname
*                                     e_fieldvalue
*                                     es_row_no
*                                     er_event_data
*                                     e_display.

  ENDMETHOD.                    "handle_onf4

  METHOD ON_TOP_OF_PAGE.
    PERFORM TOP_OF_PAGE USING E_DYNDOC_ID .
  ENDMETHOD.

ENDCLASS. "LCL_EVENT_RECEIVER_200 IMPLEMENTATION

*---------------------------------------------------------------------*
* Receiver_300 LOCAL CLASSES: Definition
*---------------------------------------------------------------------*

CLASS LCL_EVENT_RECEIVER_300 DEFINITION.

  PUBLIC SECTION.
    METHODS : HANDLE_TOOLBAR
      FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
      IMPORTING E_OBJECT E_INTERACTIVE.

    METHODS : HANDLE_USER_COMMAND
      FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID
      IMPORTING E_UCOMM.

    METHODS : HANDLE_DATA_CHANGED
      FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID
      IMPORTING ER_DATA_CHANGED.

    METHODS : HANDLE_DATA_CHANGED_FINISHED
      FOR EVENT DATA_CHANGED_FINISHED OF CL_GUI_ALV_GRID
      IMPORTING E_MODIFIED ET_GOOD_CELLS.

    METHODS : HANDLE_HOTSPOT_CLICK
      FOR EVENT HOTSPOT_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW_ID
                E_COLUMN_ID.

    METHODS : HANDLE_DOUBLE_CLICK
      FOR EVENT DOUBLE_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW
                E_COLUMN.

    METHODS : HANDLE_ONF4
      FOR EVENT ONF4 OF CL_GUI_ALV_GRID
      IMPORTING SENDER
                E_FIELDNAME
                E_FIELDVALUE
                ES_ROW_NO
                ER_EVENT_DATA
                ET_BAD_CELLS
                E_DISPLAY.

    METHODS :  ON_TOP_OF_PAGE
      FOR EVENT TOP_OF_PAGE OF CL_GUI_ALV_GRID
      IMPORTING E_DYNDOC_ID.
ENDCLASS. "(LCL_EVENT_RECEIVER_300 DEFINITION)

*---------------------------------------------------------------------*
* Receiver_300 LOCAL CLASSES: Implementation
*---------------------------------------------------------------------*

CLASS LCL_EVENT_RECEIVER_300 IMPLEMENTATION.

  METHOD HANDLE_TOOLBAR.

*    perform handle_toolbar_300   using e_object e_interactive.

  ENDMETHOD.                     "handle_toolbar

  METHOD HANDLE_USER_COMMAND.

*    perform handle_user_command_300  using e_ucomm.

  ENDMETHOD.                         "handle_user_command

  METHOD HANDLE_DATA_CHANGED.

*    perform handle_changed_300  using er_data_changed.

  ENDMETHOD.                         "handle_data_changed

  METHOD HANDLE_DATA_CHANGED_FINISHED.

*perform handle_changed_finished_300  using e_modified et_good_cells.

  ENDMETHOD.                             "HANDLE_DATA_CHANGED_FINISHED

  METHOD HANDLE_HOTSPOT_CLICK.
    PERFORM HANDLE_DOUBLE_CLICK_300  USING E_ROW_ID E_COLUMN_ID.
  ENDMETHOD.                    "handle_hotspot_click

  METHOD HANDLE_DOUBLE_CLICK.
    PERFORM HANDLE_DOUBLE_CLICK_300   USING E_ROW E_COLUMN.
  ENDMETHOD.                          "handle_double_click

  METHOD HANDLE_ONF4.

*    perform handle_on_f4_300   using sender
*                                     e_fieldname
*                                     e_fieldvalue
*                                     es_row_no
*                                     er_event_data
*                                     e_display.

  ENDMETHOD.                    "handle_onf4

  METHOD ON_TOP_OF_PAGE.
    PERFORM TOP_OF_PAGE USING E_DYNDOC_ID .
  ENDMETHOD.

ENDCLASS. "LCL_EVENT_RECEIVER_300 IMPLEMENTATION

*---------------------------------------------------------------------*
* Receiver_400 LOCAL CLASSES: Definition
*---------------------------------------------------------------------*

CLASS LCL_EVENT_RECEIVER_400 DEFINITION.

  PUBLIC SECTION.
    METHODS : HANDLE_TOOLBAR
      FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
      IMPORTING E_OBJECT E_INTERACTIVE.

    METHODS : HANDLE_USER_COMMAND
      FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID
      IMPORTING E_UCOMM       " SY-UCOMM
                SENDER.

    METHODS : HANDLE_DATA_CHANGED
      FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID
      IMPORTING ER_DATA_CHANGED.

    METHODS : HANDLE_DATA_CHANGED_FINISHED
      FOR EVENT DATA_CHANGED_FINISHED OF CL_GUI_ALV_GRID
      IMPORTING E_MODIFIED ET_GOOD_CELLS.

    METHODS : HANDLE_HOTSPOT_CLICK
      FOR EVENT HOTSPOT_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW_ID
                E_COLUMN_ID.

    METHODS : HANDLE_DOUBLE_CLICK
      FOR EVENT DOUBLE_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW
                E_COLUMN.

    METHODS : HANDLE_ONF4
      FOR EVENT ONF4 OF CL_GUI_ALV_GRID
      IMPORTING SENDER
                E_FIELDNAME
                E_FIELDVALUE
                ES_ROW_NO
                ER_EVENT_DATA
                ET_BAD_CELLS
                E_DISPLAY.

    METHODS :  ON_TOP_OF_PAGE
      FOR EVENT TOP_OF_PAGE OF CL_GUI_ALV_GRID
      IMPORTING E_DYNDOC_ID.

    METHODS: ON_TOOLBAR
      FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
      IMPORTING E_OBJECT
                E_INTERACTIVE
                SENDER.

ENDCLASS. "(LCL_EVENT_RECEIVER_400 DEFINITION)

*---------------------------------------------------------------------*
* Receiver_400 LOCAL CLASSES: Implementation
*---------------------------------------------------------------------*

CLASS LCL_EVENT_RECEIVER_400 IMPLEMENTATION.

  METHOD HANDLE_TOOLBAR.

*    perform handle_toolbar_400   using e_object e_interactive.

  ENDMETHOD.                     "handle_toolbar

  METHOD HANDLE_USER_COMMAND.   " Detail 버튼 로직
    PERFORM HANDLE_USER_COMMAND_400  USING E_UCOMM
                                            SENDER.
  ENDMETHOD.                         "handle_user_command

  METHOD HANDLE_DATA_CHANGED.

*    perform handle_changed_400  using er_data_changed.

  ENDMETHOD.                         "handle_data_changed

  METHOD HANDLE_DATA_CHANGED_FINISHED.

*perform handle_changed_finished_400  using e_modified et_good_cells.

  ENDMETHOD.                             "HANDLE_DATA_CHANGED_FINISHED

  METHOD HANDLE_HOTSPOT_CLICK.  " 더블클릭 버튼 로직
    PERFORM HANDLE_DOUBLE_CLICK_400  USING E_ROW_ID E_COLUMN_ID.
  ENDMETHOD.                    "handle_hotspot_click

  METHOD HANDLE_DOUBLE_CLICK.   " 더블클릭 버튼 로직
    PERFORM HANDLE_DOUBLE_CLICK_400   USING E_ROW E_COLUMN.
  ENDMETHOD.                          "handle_double_click

  METHOD HANDLE_ONF4.

*    perform handle_on_f4_400   using sender
*                                     e_fieldname
*                                     e_fieldvalue
*                                     es_row_no
*                                     er_event_data
*                                     e_display.

  ENDMETHOD.                    "handle_onf4

  METHOD ON_TOP_OF_PAGE.
    PERFORM TOP_OF_PAGE USING E_DYNDOC_ID .
  ENDMETHOD.

  METHOD ON_TOOLBAR.
    PERFORM HANDLER_TOOLBAR_0400 USING E_OBJECT
                                  SENDER.
  ENDMETHOD.

ENDCLASS. "LCL_EVENT_RECEIVER_400 IMPLEMENTATION

*---------------------------------------------------------------------*
* Receiver_500 LOCAL CLASSES: Definition
*---------------------------------------------------------------------*

CLASS LCL_EVENT_RECEIVER_500 DEFINITION.

  PUBLIC SECTION.
    METHODS : HANDLE_TOOLBAR
      FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
      IMPORTING E_OBJECT E_INTERACTIVE.

    METHODS : HANDLE_USER_COMMAND
      FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID
      IMPORTING E_UCOMM.

    METHODS : HANDLE_DATA_CHANGED
      FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID
      IMPORTING ER_DATA_CHANGED.

    METHODS : HANDLE_DATA_CHANGED_FINISHED
      FOR EVENT DATA_CHANGED_FINISHED OF CL_GUI_ALV_GRID
      IMPORTING E_MODIFIED ET_GOOD_CELLS.

    METHODS : HANDLE_HOTSPOT_CLICK
      FOR EVENT HOTSPOT_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW_ID
                E_COLUMN_ID.

    METHODS : HANDLE_DOUBLE_CLICK
      FOR EVENT DOUBLE_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW
                E_COLUMN.

    METHODS : HANDLE_ONF4
      FOR EVENT ONF4 OF CL_GUI_ALV_GRID
      IMPORTING SENDER
                E_FIELDNAME
                E_FIELDVALUE
                ES_ROW_NO
                ER_EVENT_DATA
                ET_BAD_CELLS
                E_DISPLAY.

    METHODS :  ON_TOP_OF_PAGE
      FOR EVENT TOP_OF_PAGE OF CL_GUI_ALV_GRID
      IMPORTING E_DYNDOC_ID.
ENDCLASS. "(LCL_EVENT_RECEIVER_500 DEFINITION)

*---------------------------------------------------------------------*
* Receiver_500 LOCAL CLASSES: Implementation
*---------------------------------------------------------------------*

CLASS LCL_EVENT_RECEIVER_500 IMPLEMENTATION.

  METHOD HANDLE_TOOLBAR.

*    perform handle_toolbar_500   using e_object e_interactive.

  ENDMETHOD.                     "handle_toolbar

  METHOD HANDLE_USER_COMMAND.

*    perform handle_user_command_500  using e_ucomm.

  ENDMETHOD.                         "handle_user_command

  METHOD HANDLE_DATA_CHANGED.

*    perform handle_changed_500  using er_data_changed.

  ENDMETHOD.                         "handle_data_changed

  METHOD HANDLE_DATA_CHANGED_FINISHED.

*perform handle_changed_finished_500  using e_modified et_good_cells.

  ENDMETHOD.                             "HANDLE_DATA_CHANGED_FINISHED

  METHOD HANDLE_HOTSPOT_CLICK.

  ENDMETHOD.                    "handle_hotspot_click

  METHOD HANDLE_DOUBLE_CLICK.
    PERFORM HANDLE_DOUBLE_CLICK_500   USING E_ROW E_COLUMN.
  ENDMETHOD.                          "handle_double_click

  METHOD HANDLE_ONF4.

*    perform handle_on_f4_500   using sender
*                                     e_fieldname
*                                     e_fieldvalue
*                                     es_row_no
*                                     er_event_data
*                                     e_display.

  ENDMETHOD.                    "handle_onf4

  METHOD ON_TOP_OF_PAGE.
    PERFORM TOP_OF_PAGE USING E_DYNDOC_ID .
  ENDMETHOD.

ENDCLASS. "LCL_EVENT_RECEIVER_500 IMPLEMENTATION

*---------------------------------------------------------------------*
*  For Class
*---------------------------------------------------------------------*

DATA: G_ALV_EVENT_100 TYPE REF TO LCL_EVENT_RECEIVER_100.
DATA: G_ALV_EVENT_200 TYPE REF TO LCL_EVENT_RECEIVER_200.
DATA: G_ALV_EVENT_300 TYPE REF TO LCL_EVENT_RECEIVER_300.
DATA: G_ALV_EVENT_400 TYPE REF TO LCL_EVENT_RECEIVER_400.
DATA: G_ALV_EVENT_500 TYPE REF TO LCL_EVENT_RECEIVER_500.

*---------------------------------------------------------------------*
* Receiver_110 LOCAL CLASSES: Definition
*---------------------------------------------------------------------*

CLASS LCL_EVENT_RECEIVER_110 DEFINITION.
  PUBLIC SECTION.

    METHODS : HANDLE_DOUBLE_CLICK
      FOR EVENT DOUBLE_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW
                E_COLUMN.

ENDCLASS. "(LCL_EVENT_RECEIVER_110 DEFINITION)

*---------------------------------------------------------------------*
* Receiver_110 LOCAL CLASSES: Implementation
*---------------------------------------------------------------------*

CLASS LCL_EVENT_RECEIVER_110 IMPLEMENTATION.

  METHOD HANDLE_DOUBLE_CLICK.

  ENDMETHOD.                          "handle_double_click

ENDCLASS. "LCL_EVENT_RECEIVER_110 IMPLEMENTATION

*---------------------------------------------------------------------*
*  For Class
*---------------------------------------------------------------------*

DATA: G_ALV_EVENT_110 TYPE REF TO LCL_EVENT_RECEIVER_110.

Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2026. Sap Release 755

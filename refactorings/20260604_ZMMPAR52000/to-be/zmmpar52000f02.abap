*&---------------------------------------------------------------------*
*& INCLUDE ZMMPAR52000F02  (To-Be / 리팩토링: R+M)  — ALV 표시 로직
*& 표준: standards/ABAP_CODE_STANDARD.md | 죽은 주석코드 정리 적용
*&---------------------------------------------------------------------*

Code listing for: ZMMPAR52000F02 Description: Include ZMMMAM36100F02

*&---------------------------------------------------------------------*
*& Include          YMMR0010F02
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  ALV_CLEAR_VARIABLE_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM ALV_CLEAR_VARIABLE_100 .

  CLEAR: "gt_alv_fieldcat_100[],
         "gt_alv_fieldcat_110[],
         GS_ALV_FIELDCAT,
         GT_ALV_SORT_100[],  GT_ALV_SORT_110[], GS_ALV_SORT,
         GT_ALV_EXTAB_100[], GT_ALV_EXTAB_110[],
         GT_ALV_SORT_100[],  GT_ALV_SORT_110[],
         GS_ALV_LAYOUT_100,  GS_ALV_LAYOUT_110,
         GS_ALV_VARIANT_100, GS_ALV_VARIANT_110,
         GT_ALV_F4[], GS_ALV_F4,
         GS_ALV_EVENT,
         GS_ALV_SELFIELD,
         GV_ALV_TITLE,
         GV_ALV_REPID,
         GV_ALV_POS.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ALV_CLEAR_VARIABLE_200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM ALV_CLEAR_VARIABLE_200 .

  CLEAR: GT_ALV_FIELDCAT_200[], GS_ALV_FIELDCAT,
         GT_ALV_SORT_200[], GS_ALV_SORT,
         GT_ALV_EXTAB_200[],
         GT_ALV_SORT_200[],
         GS_ALV_LAYOUT_200,
         GS_ALV_VARIANT_200,
         GT_ALV_F4[], GS_ALV_F4,
         GS_ALV_EVENT,
         GS_ALV_SELFIELD,
         GV_ALV_TITLE,
         GV_ALV_REPID,
         GV_ALV_POS.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ALV_CLEAR_VARIABLE_300
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM ALV_CLEAR_VARIABLE_300 .

  CLEAR: GT_ALV_FIELDCAT_300[], GS_ALV_FIELDCAT,
         GT_ALV_SORT_300[], GS_ALV_SORT,
         GT_ALV_EXTAB_300[],
         GT_ALV_SORT_300[],
         GS_ALV_LAYOUT_300,
         GS_ALV_VARIANT_300,
         GT_ALV_F4[], GS_ALV_F4,
         GS_ALV_EVENT,
         GS_ALV_SELFIELD,
         GV_ALV_TITLE,
         GV_ALV_REPID,
         GV_ALV_POS.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ALV_CLEAR_VARIABLE_400
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM ALV_CLEAR_VARIABLE_400 .

  CLEAR: "GT_ALV_FIELDCAT_400[],
         GS_ALV_FIELDCAT,
         GT_ALV_SORT_400[], GS_ALV_SORT,
         GT_ALV_EXTAB_400[],
         GT_ALV_SORT_400[],
         GS_ALV_LAYOUT_400,
         GS_ALV_VARIANT_400,
         GT_ALV_F4[], GS_ALV_F4,
         GS_ALV_EVENT,
         GS_ALV_SELFIELD,
         GV_ALV_TITLE,
         GV_ALV_REPID,
         GV_ALV_POS.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ALV_CLEAR_VARIABLE_500
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM ALV_CLEAR_VARIABLE_500 .

  CLEAR: GT_ALV_FIELDCAT_500[], GS_ALV_FIELDCAT,
         GT_ALV_SORT_500[], GS_ALV_SORT,
         GT_ALV_EXTAB_500[],
         GT_ALV_SORT_500[],
         GS_ALV_LAYOUT_500,
         GS_ALV_VARIANT_500,
         GT_ALV_F4[], GS_ALV_F4,
         GS_ALV_EVENT,
         GS_ALV_SELFIELD,
         GV_ALV_TITLE,
         GV_ALV_REPID,
         GV_ALV_POS.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  CREATE_GRID_OBJECT_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM CREATE_GRID_OBJECT_100 .

*"create container for TOP OF PAGE

  CREATE OBJECT GV_DOCKING_CONTAINER_100
    EXPORTING
      DYNNR     = SY-DYNNR
      REPID     = SY-REPID
      SIDE      = GV_DOCKING_CONTAINER_100->DOCK_AT_TOP
      EXTENSION = 1500.

* SPLIT Control

  CREATE OBJECT GV_ALV_SPLITTER
    EXPORTING
      PARENT            = GV_DOCKING_CONTAINER_100
      ROWS              = 2
      COLUMNS           = 1
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC = 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->SET_ROW_MODE
    EXPORTING
      MODE              = CL_GUI_SPLITTER_CONTAINER=>MODE_RELATIVE
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->SET_ROW_HEIGHT
    EXPORTING
      ID                = 1
      HEIGHT            = 10
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 1
      COLUMN    = 1
    RECEIVING
      CONTAINER = GV_TOP_OF_LIST.

  CALL METHOD GV_ALV_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 2
      COLUMN    = 1
    RECEIVING
      CONTAINER = GV_SPLITTER_TOP.

*    EXPORTING
*    RECEIVING

  CREATE OBJECT GV_ALV_GRID_100
    EXPORTING
      I_PARENT = GV_SPLITTER_TOP.

*  CREATE OBJECT gv_alv_grid_110
*    EXPORTING

** SPLIT Control
*  CREATE OBJECT gv_splitter_container_100
*    EXPORTING
*
** Create an Instance of ALV Control Header
*  CREATE OBJECT gv_alv_grid_100
*    EXPORTING
*
** Create an Instance of ALV Control Item
*  CREATE OBJECT gv_alv_grid_110
*    EXPORTING

ENDFORM.                    " CREATE_GRID_OBJECT_100

*&---------------------------------------------------------------------*
*&      Form  CREATE_GRID_OBJECT_200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM CREATE_GRID_OBJECT_200 .

*"create container for TOP OF PAGE

  CREATE OBJECT GV_DOCKING_CONTAINER_200
    EXPORTING
      DYNNR     = SY-DYNNR
      REPID     = SY-REPID
      SIDE      = GV_DOCKING_CONTAINER_200->DOCK_AT_TOP
      EXTENSION = 1500.

* SPLIT Control

  CREATE OBJECT GV_ALV_SPLITTER
    EXPORTING
      PARENT            = GV_DOCKING_CONTAINER_200
      ROWS              = 2
      COLUMNS           = 1
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC = 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->SET_ROW_MODE
    EXPORTING
      MODE              = CL_GUI_SPLITTER_CONTAINER=>MODE_RELATIVE
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->SET_ROW_HEIGHT
    EXPORTING
      ID                = 1
      HEIGHT            = 20
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 1
      COLUMN    = 1
    RECEIVING
      CONTAINER = GV_TOP_OF_LIST.

  CALL METHOD GV_ALV_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 2
      COLUMN    = 1
    RECEIVING
      CONTAINER = GV_SPLITTER_TOP.

  CREATE OBJECT GV_ALV_GRID_200
    EXPORTING
      I_PARENT = GV_SPLITTER_TOP.

ENDFORM.                    " CREATE_GRID_OBJECT_200

*&---------------------------------------------------------------------*
*&      Form  CREATE_GRID_OBJECT_300
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM CREATE_GRID_OBJECT_300 .

*"create container for TOP OF PAGE

  CREATE OBJECT GV_DOCKING_CONTAINER_300
    EXPORTING
      DYNNR     = SY-DYNNR
      REPID     = SY-REPID
      SIDE      = GV_DOCKING_CONTAINER_300->DOCK_AT_TOP
      EXTENSION = 1500.

* SPLIT Control

  CREATE OBJECT GV_ALV_SPLITTER
    EXPORTING
      PARENT            = GV_DOCKING_CONTAINER_300
      ROWS              = 2
      COLUMNS           = 1
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC = 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->SET_ROW_MODE
    EXPORTING
      MODE              = CL_GUI_SPLITTER_CONTAINER=>MODE_RELATIVE
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->SET_ROW_HEIGHT
    EXPORTING
      ID                = 1
      HEIGHT            = 10
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 1
      COLUMN    = 1
    RECEIVING
      CONTAINER = GV_TOP_OF_LIST.

  CALL METHOD GV_ALV_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 2
      COLUMN    = 1
    RECEIVING
      CONTAINER = GV_SPLITTER_TOP.

  CREATE OBJECT GV_ALV_GRID_300
    EXPORTING
      I_PARENT = GV_SPLITTER_TOP.

ENDFORM.                    " CREATE_GRID_OBJECT_300

*&---------------------------------------------------------------------*
*&      Form  CREATE_GRID_OBJECT_400
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM CREATE_GRID_OBJECT_400 .

*"create container for TOP OF PAGE

  CREATE OBJECT GV_DOCKING_CONTAINER_400
    EXPORTING
      DYNNR     = SY-DYNNR
      REPID     = SY-REPID
      SIDE      = GV_DOCKING_CONTAINER_400->DOCK_AT_TOP
      EXTENSION = 1500.

* SPLIT Control

  CREATE OBJECT GV_ALV_SPLITTER
    EXPORTING
      PARENT            = GV_DOCKING_CONTAINER_400
      ROWS              = 2
      COLUMNS           = 1
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC = 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->SET_ROW_MODE
    EXPORTING
      MODE              = CL_GUI_SPLITTER_CONTAINER=>MODE_RELATIVE
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->SET_ROW_HEIGHT
    EXPORTING
      ID                = 1
      HEIGHT            = 10
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 1
      COLUMN    = 1
    RECEIVING
      CONTAINER = GV_TOP_OF_LIST.

  CALL METHOD GV_ALV_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 2
      COLUMN    = 1
    RECEIVING
      CONTAINER = GV_SPLITTER_TOP.

  CREATE OBJECT GV_ALV_GRID_400
    EXPORTING
      I_PARENT = GV_SPLITTER_TOP.

ENDFORM.                    " CREATE_GRID_OBJECT_400

*&---------------------------------------------------------------------*
*&      Form  CREATE_GRID_OBJECT_500
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM CREATE_GRID_OBJECT_500 .

*"create container for TOP OF PAGE

  CREATE OBJECT GV_DOCKING_CONTAINER_500
    EXPORTING
      DYNNR     = SY-DYNNR
      REPID     = SY-REPID
      SIDE      = GV_DOCKING_CONTAINER_500->DOCK_AT_TOP
      EXTENSION = 1500.

* SPLIT Control

  CREATE OBJECT GV_ALV_SPLITTER
    EXPORTING
      PARENT            = GV_DOCKING_CONTAINER_500
      ROWS              = 2
      COLUMNS           = 1
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC = 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->SET_ROW_MODE
    EXPORTING
      MODE              = CL_GUI_SPLITTER_CONTAINER=>MODE_RELATIVE
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->SET_ROW_HEIGHT
    EXPORTING
      ID                = 1
      HEIGHT            = 10
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      OTHERS            = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  CALL METHOD GV_ALV_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 1
      COLUMN    = 1
    RECEIVING
      CONTAINER = GV_TOP_OF_LIST.

  CALL METHOD GV_ALV_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 2
      COLUMN    = 1
    RECEIVING
      CONTAINER = GV_SPLITTER_TOP.

  CREATE OBJECT GV_ALV_GRID_500
    EXPORTING
      I_PARENT = GV_SPLITTER_TOP.

ENDFORM.                    " CREATE_GRID_OBJECT_500

*&---------------------------------------------------------------------*
*&      Form  EXCLUDE_FUNCTIONKEY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0031   text
*----------------------------------------------------------------------*

FORM EXCLUDE_FUNCTIONKEY  USING  P_TABNAME.

*" Inactive toolbar function key

  FIELD-SYMBOLS : <FS> TYPE UI_FUNCTIONS.

  DATA : LS_EXCLUDE   TYPE UI_FUNC,
         L_TABLE_NAME LIKE FELD-NAME.

  CONCATENATE P_TABNAME '[]' INTO L_TABLE_NAME.
  ASSIGN  (L_TABLE_NAME)  TO <FS>.

  PERFORM ALV_APPEND_EXCLUDE_FCODE
        TABLES <FS>
        USING: CL_GUI_ALV_GRID=>MC_FC_LOC_UNDO, " ####
               CL_GUI_ALV_GRID=>MC_FC_AUF,      " #### &AUF
               CL_GUI_ALV_GRID=>MC_FC_AVERAGE,  " &AVERAGE
               CL_GUI_ALV_GRID=>MC_FC_BACK_CLASSIC,
               CL_GUI_ALV_GRID=>MC_FC_CALL_ABC, " &ABC
               CL_GUI_ALV_GRID=>MC_FC_CALL_CHAIN,
               CL_GUI_ALV_GRID=>MC_FC_CALL_CRBATCH,
               CL_GUI_ALV_GRID=>MC_FC_CALL_CRWEB,
               CL_GUI_ALV_GRID=>MC_FC_CALL_LINEITEMS,
               CL_GUI_ALV_GRID=>MC_FC_CALL_MASTER_DATA,
               CL_GUI_ALV_GRID=>MC_FC_CALL_MORE,
               CL_GUI_ALV_GRID=>MC_FC_CALL_REPORT,
               CL_GUI_ALV_GRID=>MC_FC_CALL_XINT,

               CL_GUI_ALV_GRID=>MC_FC_EXPCRDATA,
               CL_GUI_ALV_GRID=>MC_FC_EXPCRDESIG,
               CL_GUI_ALV_GRID=>MC_FC_EXPCRTEMPL,
               CL_GUI_ALV_GRID=>MC_FC_EXPMDB,
               CL_GUI_ALV_GRID=>MC_FC_EXTEND,
               CL_GUI_ALV_GRID=>MC_FC_F4,

               CL_GUI_ALV_GRID=>MC_FC_GRAPH,
               CL_GUI_ALV_GRID=>MC_FC_HELP,
               CL_GUI_ALV_GRID=>MC_FC_INFO,

               CL_GUI_ALV_GRID=>MC_FC_LOC_COPY_ROW,
               CL_GUI_ALV_GRID=>MC_FC_LOC_CUT,
               CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW,
               CL_GUI_ALV_GRID=>MC_FC_LOC_INSERT_ROW,

               CL_GUI_ALV_GRID=>MC_FC_LOC_APPEND_ROW,
               CL_GUI_ALV_GRID=>MC_FC_LOC_PASTE,
               CL_GUI_ALV_GRID=>MC_FC_LOC_PASTE_NEW_ROW,

               CL_GUI_ALV_GRID=>MC_FC_REFRESH,

               CL_GUI_ALV_GRID=>MC_FC_WORD_PROCESSOR.

ENDFORM.                    " EXCLUDE_FUNCTIONKEY

*&---------------------------------------------------------------------*
*&      Form  BUILD_LAYOUT_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GS_ALV_LAYOUT_100  text
*----------------------------------------------------------------------*

FORM BUILD_LAYOUT_100  CHANGING PS_LVC_LAYO TYPE LVC_S_LAYO.

  CLEAR PS_LVC_LAYO.

  PS_LVC_LAYO-BOX_FNAME  = 'MARK'.
  PS_LVC_LAYO-SEL_MODE   = 'D'.

  PS_LVC_LAYO-ZEBRA      = 'X'.

  PS_LVC_LAYO-CTAB_FNAME = 'COLINFO'.
  PS_LVC_LAYO-INFO_FNAME = 'INFO'.      "Row color
  PS_LVC_LAYO-STYLEFNAME = 'CELLTAB'.   "Input control

ENDFORM.                    " BUILD_LAYOUT_100

*&---------------------------------------------------------------------*
*&      Form  BUILD_LAYOUT_200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GS_ALV_LAYOUT_100  text
*----------------------------------------------------------------------*

FORM BUILD_LAYOUT_200  CHANGING PS_LVC_LAYO TYPE LVC_S_LAYO.

  CLEAR PS_LVC_LAYO.

  PS_LVC_LAYO-BOX_FNAME  = 'MARK'.
  PS_LVC_LAYO-SEL_MODE   = 'D'.

  PS_LVC_LAYO-NO_ROWMARK = 'X'.

  PS_LVC_LAYO-ZEBRA      = 'X'.
  PS_LVC_LAYO-CWIDTH_OPT = 'X'.
  PS_LVC_LAYO-COL_OPT    = 'X'.
  PS_LVC_LAYO-CTAB_FNAME = 'COLINFO'.
  PS_LVC_LAYO-INFO_FNAME = 'INFO'.      "Row color
  PS_LVC_LAYO-STYLEFNAME = 'CELLTAB'.   "Input control

ENDFORM.                    " BUILD_LAYOUT_200

*&---------------------------------------------------------------------*
*&      Form  BUILD_LAYOUT_300
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GS_ALV_LAYOUT_300  text
*----------------------------------------------------------------------*

FORM BUILD_LAYOUT_300  CHANGING PS_LVC_LAYO TYPE LVC_S_LAYO.

  CLEAR PS_LVC_LAYO.

  PS_LVC_LAYO-BOX_FNAME  = 'MARK'.
  PS_LVC_LAYO-SEL_MODE   = 'D'.

  PS_LVC_LAYO-NO_ROWMARK = 'X'.

  PS_LVC_LAYO-ZEBRA      = 'X'.
  PS_LVC_LAYO-CWIDTH_OPT = 'X'.
  PS_LVC_LAYO-COL_OPT    = 'X'.
  PS_LVC_LAYO-CTAB_FNAME = 'COLINFO'.
  PS_LVC_LAYO-INFO_FNAME = 'INFO'.      "Row color
  PS_LVC_LAYO-STYLEFNAME = 'CELLTAB'.   "Input control

ENDFORM.                    " BUILD_LAYOUT_300

*&---------------------------------------------------------------------*
*&      Form  BUILD_LAYOUT_400
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GS_ALV_LAYOUT_400  text
*----------------------------------------------------------------------*

FORM BUILD_LAYOUT_400  CHANGING PS_LVC_LAYO TYPE LVC_S_LAYO.

  CLEAR PS_LVC_LAYO.

  PS_LVC_LAYO-SEL_MODE   = 'D'.

  PS_LVC_LAYO-ZEBRA      = 'X'.

  PS_LVC_LAYO-COL_OPT    = 'X'.

ENDFORM.                    " BUILD_LAYOUT_400

*&---------------------------------------------------------------------*
*&      Form  BUILD_LAYOUT_500
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GS_ALV_LAYOUT_500  text
*----------------------------------------------------------------------*

FORM BUILD_LAYOUT_500  CHANGING PS_LVC_LAYO TYPE LVC_S_LAYO.

  CLEAR PS_LVC_LAYO.

  PS_LVC_LAYO-BOX_FNAME  = 'MARK'.
  PS_LVC_LAYO-SEL_MODE   = 'D'.

  PS_LVC_LAYO-NO_ROWMARK = 'X'.

  PS_LVC_LAYO-CWIDTH_OPT = 'X'.
  PS_LVC_LAYO-COL_OPT    = 'X'.
  PS_LVC_LAYO-CTAB_FNAME = 'COLINFO'.
  PS_LVC_LAYO-INFO_FNAME = 'INFO'.      "Row color
  PS_LVC_LAYO-STYLEFNAME = 'CELLTAB'.   "Input control

ENDFORM.                    " BUILD_LAYOUT_500

*&---------------------------------------------------------------------*
*&      Form  BUILD_CATEGORY_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GT_ALV_FIELDCAT_100  text
*----------------------------------------------------------------------*

FORM BUILD_CATEGORY_100  CHANGING PT_ALV_FIELDCAT TYPE LVC_T_FCAT.

  DATA: L_TEXT(30),
        L_COL_POS TYPE I.

  DATA : LT_FCAT TYPE SLIS_T_FIELDCAT_ALV,
         LS_FCAT TYPE LVC_S_FCAT.

  DATA : LT_FCAT_TMP TYPE LVC_T_FCAT,
         LV_FDNAME   TYPE FIELDNAME.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      I_PROGRAM_NAME         = SY-REPID
      I_INTERNAL_TABNAME     = GV_INTTAB100
      I_INCLNAME             = SY-REPID
    CHANGING
      CT_FIELDCAT            = LT_FCAT
    EXCEPTIONS
      INCONSISTENT_INTERFACE = 1
      PROGRAM_ERROR          = 2
      OTHERS                 = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  DATA : LV_TABNM         LIKE FELD-NAME.
  FIELD-SYMBOLS: <FS_TAB> TYPE STANDARD TABLE.
  CONCATENATE GV_INTTAB100 '[]' INTO LV_TABNM.
  ASSIGN (LV_TABNM) TO <FS_TAB>.

  CALL FUNCTION 'LVC_TRANSFER_FROM_SLIS'
    EXPORTING
      IT_FIELDCAT_ALV = LT_FCAT
    IMPORTING
      ET_FIELDCAT_LVC = PT_ALV_FIELDCAT
    TABLES
      IT_DATA         = <FS_TAB>.

  DATA : PS_FCAT_MENGE TYPE LVC_S_FCAT,
         PS_FCAT_DMBTR TYPE LVC_S_FCAT,
         PS_FCAT_SLLAB TYPE LVC_S_FCAT,
         PS_FCAT_DMAVG TYPE LVC_S_FCAT,
         LV_COLPOS     TYPE LVC_COLPOS.

  CLEAR: PS_FCAT_MENGE, PS_FCAT_DMBTR.

* )Qty/Amt)참조 필드 READ

  READ TABLE PT_ALV_FIELDCAT INTO PS_FCAT_MENGE
                             WITH KEY FIELDNAME = 'MENGE'.
  IF SY-SUBRC EQ 0.
    PS_FCAT_MENGE-NO_ZERO = C_X.
    LV_COLPOS = PS_FCAT_MENGE-COL_POS + 5.

  ENDIF.

  READ TABLE PT_ALV_FIELDCAT INTO PS_FCAT_DMBTR
                             WITH KEY FIELDNAME = 'DMBTR'.
  IF SY-SUBRC EQ 0.
    PS_FCAT_DMBTR-NO_ZERO = C_X.

  ENDIF.

  READ TABLE PT_ALV_FIELDCAT INTO PS_FCAT_DMAVG
                             WITH KEY FIELDNAME = 'DMAVG'.
  IF SY-SUBRC EQ 0.
    PS_FCAT_DMAVG-NO_ZERO = C_X.

  ENDIF.

**----
* Opening Stock(Q'ty / Value) = 기초재고

  CLEAR : LS_FCAT.
  MOVE-CORRESPONDING PS_FCAT_MENGE TO LS_FCAT.
  LS_FCAT-COL_POS = LV_COLPOS.
  CONCATENATE PS_FCAT_MENGE-FIELDNAME '_BI' INTO LS_FCAT-FIELDNAME.
  LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT = TEXT-F01.
  LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L.
  LS_FCAT-EMPHASIZE = 'C300'.
  APPEND LS_FCAT TO PT_ALV_FIELDCAT.

  ADD 1 TO LV_COLPOS.
  CLEAR : LS_FCAT.
  MOVE-CORRESPONDING PS_FCAT_DMBTR TO LS_FCAT.
  LS_FCAT-COL_POS = LV_COLPOS.
  CONCATENATE PS_FCAT_DMBTR-FIELDNAME '_BI' INTO LS_FCAT-FIELDNAME.
  LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT = TEXT-F02.
  LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L.
  LS_FCAT-EMPHASIZE = 'C300'.
  APPEND LS_FCAT TO PT_ALV_FIELDCAT.

  ADD 1 TO LV_COLPOS.
  CLEAR : LS_FCAT.
  MOVE-CORRESPONDING PS_FCAT_DMAVG TO LS_FCAT.
  LS_FCAT-COL_POS = LV_COLPOS.
  CONCATENATE PS_FCAT_DMAVG-FIELDNAME '_BI' INTO LS_FCAT-FIELDNAME.
  LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT = TEXT-F81.
  LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L.
  LS_FCAT-EMPHASIZE = 'C300'.
  APPEND LS_FCAT TO PT_ALV_FIELDCAT.

**----
* Group code

  IF GT_ZMMT0010[] IS INITIAL.
    PERFORM GET_GROUP_ZMMT0010.
  ENDIF.

  LOOP AT GT_ZMMT0010 INTO DATA(LS_ZMMT0010).

    ADD 1 TO LV_COLPOS.
    CLEAR : LS_FCAT.
    MOVE-CORRESPONDING PS_FCAT_MENGE TO LS_FCAT.
    LS_FCAT-COL_POS = LV_COLPOS.
    CONCATENATE PS_FCAT_MENGE-FIELDNAME '_' LS_ZMMT0010-ZGROUP
           INTO LS_FCAT-FIELDNAME.
    CONCATENATE LS_ZMMT0010-ZTEXT TEXT-F91 INTO  LS_FCAT-REPTEXT.
    LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT.
    IF LS_FCAT-FIELDNAME+6(2) = 'GR'.
      LS_FCAT-EMPHASIZE = 'C100'.
    ELSE.
      LS_FCAT-EMPHASIZE = 'C700'.
    ENDIF.
    APPEND LS_FCAT TO PT_ALV_FIELDCAT.

    ADD 1 TO LV_COLPOS.
    CLEAR : LS_FCAT.
    MOVE-CORRESPONDING PS_FCAT_DMBTR TO LS_FCAT.
    LS_FCAT-COL_POS = LV_COLPOS.
    CONCATENATE PS_FCAT_DMBTR-FIELDNAME '_' LS_ZMMT0010-ZGROUP
           INTO LS_FCAT-FIELDNAME.
    CONCATENATE LS_ZMMT0010-ZTEXT TEXT-F92 INTO  LS_FCAT-REPTEXT.
    LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT.
    IF LS_FCAT-FIELDNAME+6(2) = 'GR'.
      LS_FCAT-EMPHASIZE = 'C100'.
    ELSE.
      LS_FCAT-EMPHASIZE = 'C700'.
    ENDIF.
    APPEND LS_FCAT TO PT_ALV_FIELDCAT.

    ADD 1 TO LV_COLPOS.
    CLEAR : LS_FCAT.
    MOVE-CORRESPONDING PS_FCAT_DMAVG TO LS_FCAT.
    LS_FCAT-COL_POS = LV_COLPOS.
    CONCATENATE PS_FCAT_DMAVG-FIELDNAME '_' LS_ZMMT0010-ZGROUP
           INTO LS_FCAT-FIELDNAME.
    CONCATENATE LS_ZMMT0010-ZTEXT TEXT-F93 INTO  LS_FCAT-REPTEXT.
    LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT.
    IF LS_FCAT-FIELDNAME+6(2) = 'GR'.
      LS_FCAT-EMPHASIZE = 'C100'.
    ELSE.
      LS_FCAT-EMPHASIZE = 'C700'.
    ENDIF.
    APPEND LS_FCAT TO PT_ALV_FIELDCAT.

  ENDLOOP.

**----
* Stock In Transit(QTY/AMT) / PO를 통한 재고 => 미사용
*  LS_FCAT-NO_OUT = C_X.               " 숨김처리 / 24.08.20

*  LS_FCAT-NO_OUT = C_X.               " 숨김처리 / 24.08.20

**----
* Closing Stock(Q'ty / Value) = 기말재고

  ADD 1 TO LV_COLPOS.
  CLEAR : LS_FCAT.
  MOVE-CORRESPONDING PS_FCAT_MENGE TO LS_FCAT.
  LS_FCAT-COL_POS = LV_COLPOS.
  CONCATENATE PS_FCAT_MENGE-FIELDNAME '_EI' INTO LS_FCAT-FIELDNAME.
  LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT = TEXT-F03.
  LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L.
  LS_FCAT-EMPHASIZE = 'C300'.
  APPEND LS_FCAT TO PT_ALV_FIELDCAT.

  ADD 1 TO LV_COLPOS.
  CLEAR : LS_FCAT.
  MOVE-CORRESPONDING PS_FCAT_DMBTR TO LS_FCAT.
  LS_FCAT-COL_POS = LV_COLPOS.
  CONCATENATE PS_FCAT_DMBTR-FIELDNAME '_EI' INTO LS_FCAT-FIELDNAME.
  LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT = TEXT-F04.
  LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L.
  LS_FCAT-EMPHASIZE = 'C300'.
  APPEND LS_FCAT TO PT_ALV_FIELDCAT.

  ADD 1 TO LV_COLPOS.
  CLEAR : LS_FCAT.
  MOVE-CORRESPONDING PS_FCAT_DMAVG TO LS_FCAT.
  LS_FCAT-COL_POS = LV_COLPOS.
  CONCATENATE PS_FCAT_DMAVG-FIELDNAME '_EI' INTO LS_FCAT-FIELDNAME.
  LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT = TEXT-F82.
  LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L.
  LS_FCAT-EMPHASIZE = 'C300'.
  APPEND LS_FCAT TO PT_ALV_FIELDCAT.

**--
*

  ADD 1 TO LV_COLPOS.
  CLEAR : LS_FCAT.
  MOVE-CORRESPONDING PS_FCAT_MENGE TO LS_FCAT.
  LS_FCAT-COL_POS = LV_COLPOS.
  CONCATENATE PS_FCAT_MENGE-FIELDNAME '_SG_EI' INTO LS_FCAT-FIELDNAME.
  LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT = TEXT-F05.
  LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L.
  LS_FCAT-EMPHASIZE = 'C300'.
  APPEND LS_FCAT TO PT_ALV_FIELDCAT.

  ADD 1 TO LV_COLPOS.
  CLEAR : LS_FCAT.
  MOVE-CORRESPONDING PS_FCAT_DMBTR TO LS_FCAT.
  LS_FCAT-COL_POS = LV_COLPOS.
  CONCATENATE PS_FCAT_DMBTR-FIELDNAME '_SG_EI' INTO LS_FCAT-FIELDNAME.
  LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT = TEXT-F06.
  LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L.
  LS_FCAT-EMPHASIZE = 'C300'.

*  LS_FCAT-NO_OUT = C_X.               " 숨김처리 / 24.08.20

  APPEND LS_FCAT TO PT_ALV_FIELDCAT.

  ADD 1 TO LV_COLPOS.
  CLEAR : LS_FCAT.
  MOVE-CORRESPONDING PS_FCAT_DMAVG TO LS_FCAT.
  LS_FCAT-COL_POS = LV_COLPOS.
  CONCATENATE PS_FCAT_DMAVG-FIELDNAME '_SG_EI' INTO LS_FCAT-FIELDNAME.
  LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT = TEXT-F83.
  LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L.
  LS_FCAT-EMPHASIZE = 'C300'.
  APPEND LS_FCAT TO PT_ALV_FIELDCAT.

*--------------------------------------------------------------------*
* 참조 필드 삭제

  DELETE PT_ALV_FIELDCAT WHERE FIELDNAME EQ 'MENGE'
                            OR FIELDNAME EQ 'DMBTR'
                            OR FIELDNAME EQ 'DMAVG' .
  SORT PT_ALV_FIELDCAT BY COL_POS.

  LOOP AT PT_ALV_FIELDCAT ASSIGNING <FS_ALV_FIELDCAT>.
    CLEAR <FS_ALV_FIELDCAT>-KEY.

    CASE <FS_ALV_FIELDCAT>-FIELDNAME.
      WHEN 'BUKRS'. " 회사코드
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F50.
        <FS_ALV_FIELDCAT>-KEY = C_X.
        <FS_ALV_FIELDCAT>-COL_OPT = 'X'.
      WHEN 'MATNR'. " 자재
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F51.
        <FS_ALV_FIELDCAT>-KEY = C_X.
        <FS_ALV_FIELDCAT>-COL_OPT = 'X'.

*      WHEN 'MAKTX'. " 자재명
*      WHEN 'MAT_DESC'. " 자재명

      WHEN 'WERKS'. " 플랜트
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F58.
        <FS_ALV_FIELDCAT>-COL_OPT = 'X'.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'LIFNR'. " 벤더
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F59.
        <FS_ALV_FIELDCAT>-COL_OPT = 'X'.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'LIFNR_TX'. " 벤더명
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F60.
        <FS_ALV_FIELDCAT>-COL_OPT = 'X'.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'LGORT'.
        <FS_ALV_FIELDCAT>-KEY = C_X.
        <FS_ALV_FIELDCAT>-COL_OPT = 'X'.
      WHEN 'LGOBE'.
        <FS_ALV_FIELDCAT>-KEY = C_X.
        <FS_ALV_FIELDCAT>-COL_OPT = 'X'.
      WHEN 'CHARG'.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'CLABS'. " 현재고
        <FS_ALV_FIELDCAT>-EMPHASIZE  = 'C500'.
        <FS_ALV_FIELDCAT>-COLTEXT    = TEXT-F62.
        <FS_ALV_FIELDCAT>-QFIELDNAME = 'MEINS'.
        <FS_ALV_FIELDCAT>-COL_OPT    = 'X'.
      WHEN 'VERPR'. " 현재고 자산
        <FS_ALV_FIELDCAT>-EMPHASIZE  = 'C500'.
        <FS_ALV_FIELDCAT>-COLTEXT    = TEXT-F99.
        <FS_ALV_FIELDCAT>-CFIELDNAME = 'WAERS'.
        <FS_ALV_FIELDCAT>-COL_OPT    = 'X'.
        <FS_ALV_FIELDCAT>-NO_ZERO    = 'X'.

* batch key Start - screen 0400

      WHEN 'SQR'.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'SOBKZ'.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'PARTNER'.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'NAME_ORG1'.
        <FS_ALV_FIELDCAT>-KEY = C_X.
        <FS_ALV_FIELDCAT>-REPTEXT = TEXT-F51.

* batch key end

      WHEN 'MEINS'.

      WHEN 'WAERS'.

      WHEN 'INFO'.
        <FS_ALV_FIELDCAT>-COL_POS = 998.
      WHEN 'MARK'.
        <FS_ALV_FIELDCAT>-COL_POS = 999.

      WHEN 'XXXX'.
        <FS_ALV_FIELDCAT>-NO_OUT = C_X.
    ENDCASE.

  ENDLOOP.

  SORT PT_ALV_FIELDCAT BY COL_POS.

ENDFORM.                    " BUILD_CATEGORY_100

*&---------------------------------------------------------------------*
*&      Form  BUILD_CATEGORY_200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GT_ALV_FIELDCAT_200  text
*----------------------------------------------------------------------*

FORM BUILD_CATEGORY_200  CHANGING PT_ALV_FIELDCAT TYPE LVC_T_FCAT.

  DATA: L_TEXT(30),
        L_COL_POS TYPE I.

  DATA : LT_FCAT TYPE SLIS_T_FIELDCAT_ALV,
         LS_FCAT TYPE LVC_S_FCAT.

  DATA : LT_FCAT_TMP TYPE LVC_T_FCAT,
         LV_FDNAME   TYPE FIELDNAME.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      I_PROGRAM_NAME         = SY-REPID
      I_INTERNAL_TABNAME     = GV_INTTAB200
      I_INCLNAME             = SY-REPID
    CHANGING
      CT_FIELDCAT            = LT_FCAT
    EXCEPTIONS
      INCONSISTENT_INTERFACE = 1
      PROGRAM_ERROR          = 2
      OTHERS                 = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  DATA : LV_TABNM         LIKE FELD-NAME.
  FIELD-SYMBOLS: <FS_TAB> TYPE STANDARD TABLE.
  CONCATENATE GV_INTTAB200 '[]' INTO LV_TABNM.
  ASSIGN (LV_TABNM) TO <FS_TAB>.

  CALL FUNCTION 'LVC_TRANSFER_FROM_SLIS'
    EXPORTING
      IT_FIELDCAT_ALV = LT_FCAT
    IMPORTING
      ET_FIELDCAT_LVC = PT_ALV_FIELDCAT
    TABLES
      IT_DATA         = <FS_TAB>.

  DELETE PT_ALV_FIELDCAT     WHERE FIELDNAME EQ 'BUKRS'

                                OR FIELDNAME EQ 'KUNNR'
                                OR FIELDNAME EQ 'KUNNR_TX'
                                OR FIELDNAME EQ 'LIFNR'
                                OR FIELDNAME EQ 'LIFNR_TX'

                                OR FIELDNAME EQ 'ZGROUP'

                                OR FIELDNAME EQ 'GRUND'

                                OR FIELDNAME EQ 'VGART'
                                OR FIELDNAME EQ 'BELNR'
                                OR FIELDNAME EQ 'GJAHR'
                                OR FIELDNAME EQ 'BUZEI'
                                OR FIELDNAME EQ 'ZIV_CHK'
                                OR FIELDNAME EQ 'ZSP_CHK'
                                OR FIELDNAME EQ 'CELLTAB'
                                OR FIELDNAME EQ 'COLINFO'
                                OR FIELDNAME EQ 'INFO'
                                OR FIELDNAME EQ 'MTART'
                                OR FIELDNAME EQ 'SLLAB'
                                OR FIELDNAME EQ 'CLABS'
                                OR FIELDNAME EQ 'SALK3'
                                OR FIELDNAME EQ 'LBKUM'
                                OR FIELDNAME EQ 'LABST'
                                OR FIELDNAME EQ 'STPRS'.

  IF P_VAL EQ ABAP_OFF.
    DELETE PT_ALV_FIELDCAT     WHERE FIELDNAME EQ 'WAERS'
                                  OR FIELDNAME EQ 'DMBTR'.
  ENDIF.

  IF P_VAL EQ ABAP_OFF.

    LOOP AT PT_ALV_FIELDCAT ASSIGNING <FS_ALV_FIELDCAT>.
      CLEAR <FS_ALV_FIELDCAT>-KEY.

      CASE <FS_ALV_FIELDCAT>-FIELDNAME.
        WHEN 'MJAHR'.
          <FS_ALV_FIELDCAT>-COL_POS = 0.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F64.
          <FS_ALV_FIELDCAT>-JUST = 'C'.
        WHEN 'BUDAT'. " 전기일 (추가)
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F65.
          <FS_ALV_FIELDCAT>-COL_POS = 1.
        WHEN 'MBLNR'.
          <FS_ALV_FIELDCAT>-COL_POS = 2.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F66.
        WHEN 'ZEILE'.
          <FS_ALV_FIELDCAT>-COL_POS = 3.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F77.
        WHEN 'ZZLOGINO'.
          <FS_ALV_FIELDCAT>-COL_POS = 4.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F78.
        WHEN 'MATNR'.
          <FS_ALV_FIELDCAT>-COL_POS = 5.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F51.
        WHEN 'MAKTX'.
          <FS_ALV_FIELDCAT>-COL_POS = 6.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F52.
        WHEN 'WERKS'.
          <FS_ALV_FIELDCAT>-COL_POS = 7.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F58.
        WHEN 'LGORT'.
          <FS_ALV_FIELDCAT>-COL_POS = 8.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F67.
        WHEN 'CHARG'.
          <FS_ALV_FIELDCAT>-COL_POS = 9.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F68.
        WHEN 'MENGE'.
          <FS_ALV_FIELDCAT>-COL_POS = 10.
          <FS_ALV_FIELDCAT>-DO_SUM = C_X.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F69.

        WHEN 'BWART'.
          <FS_ALV_FIELDCAT>-COL_POS = 12.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F71.
        WHEN 'BTEXT'.
          <FS_ALV_FIELDCAT>-COL_POS = 13.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F72.
        WHEN 'SOBKZ'.
          <FS_ALV_FIELDCAT>-COL_POS = 14.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F73.
          <FS_ALV_FIELDCAT>-JUST = 'C'.
        WHEN 'SHKZG'.
          <FS_ALV_FIELDCAT>-COL_POS = 15.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F74.
          <FS_ALV_FIELDCAT>-JUST = 'C'.
        WHEN 'MEINS'.
          <FS_ALV_FIELDCAT>-COL_POS = 17.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F75.

      ENDCASE.
    ENDLOOP.

  ELSE.

    LOOP AT PT_ALV_FIELDCAT ASSIGNING <FS_ALV_FIELDCAT>.
      CLEAR <FS_ALV_FIELDCAT>-KEY.

      CASE <FS_ALV_FIELDCAT>-FIELDNAME.
        WHEN 'MJAHR'.
          <FS_ALV_FIELDCAT>-COL_POS = 0.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F64.
          <FS_ALV_FIELDCAT>-JUST = 'C'.
        WHEN 'BUDAT'. " 전기일 (추가)
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F65.
          <FS_ALV_FIELDCAT>-COL_POS = 1.
        WHEN 'MBLNR'.
          <FS_ALV_FIELDCAT>-COL_POS = 2.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F66.
        WHEN 'ZEILE'.
          <FS_ALV_FIELDCAT>-COL_POS = 3.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F77.
        WHEN 'ZZLOGINO'.
          <FS_ALV_FIELDCAT>-COL_POS = 4.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F78.
        WHEN 'MATNR'.
          <FS_ALV_FIELDCAT>-COL_POS = 5.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F51.
        WHEN 'MAKTX'.
          <FS_ALV_FIELDCAT>-COL_POS = 6.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F52.
        WHEN 'WERKS'.
          <FS_ALV_FIELDCAT>-COL_POS = 7.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F58.
        WHEN 'LGORT'.
          <FS_ALV_FIELDCAT>-COL_POS = 8.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F67.
        WHEN 'CHARG'.
          <FS_ALV_FIELDCAT>-COL_POS = 9.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F68.
        WHEN 'MENGE'.
          <FS_ALV_FIELDCAT>-COL_POS = 10.
          <FS_ALV_FIELDCAT>-DO_SUM = C_X.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F69.
        WHEN 'DMBTR'.
          <FS_ALV_FIELDCAT>-COL_POS = 11.
          <FS_ALV_FIELDCAT>-DO_SUM = C_X.
          <FS_ALV_FIELDCAT>-CFIELDNAME = 'WAERS'.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F70.
        WHEN 'BWART'.
          <FS_ALV_FIELDCAT>-COL_POS = 12.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F71.
        WHEN 'BTEXT'.
          <FS_ALV_FIELDCAT>-COL_POS = 13.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F72.
        WHEN 'SOBKZ'.
          <FS_ALV_FIELDCAT>-COL_POS = 14.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F73.
          <FS_ALV_FIELDCAT>-JUST = 'C'.
        WHEN 'SHKZG'.
          <FS_ALV_FIELDCAT>-COL_POS = 15.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F74.
          <FS_ALV_FIELDCAT>-JUST = 'C'.

        WHEN 'MEINS'.
          <FS_ALV_FIELDCAT>-COL_POS = 17.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F75.
        WHEN 'WAERS'.
          <FS_ALV_FIELDCAT>-COL_POS = 18.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F76.
      ENDCASE.
    ENDLOOP.

  ENDIF.

ENDFORM.                    " BUILD_CATEGORY_200

*&---------------------------------------------------------------------*
*&      Form  BUILD_CATEGORY_300
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GT_ALV_FIELDCAT_300  text
*----------------------------------------------------------------------*

FORM BUILD_CATEGORY_300  CHANGING PT_ALV_FIELDCAT TYPE LVC_T_FCAT.

  DATA: L_TEXT(30),
        L_COL_POS TYPE I.

  DATA : LT_FCAT TYPE SLIS_T_FIELDCAT_ALV,
         LS_FCAT TYPE LVC_S_FCAT.

  DATA : LT_FCAT_TMP TYPE LVC_T_FCAT,
         LV_FDNAME   TYPE FIELDNAME.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      I_PROGRAM_NAME         = SY-REPID
      I_INTERNAL_TABNAME     = GV_INTTAB300
      I_INCLNAME             = SY-REPID
    CHANGING
      CT_FIELDCAT            = LT_FCAT
    EXCEPTIONS
      INCONSISTENT_INTERFACE = 1
      PROGRAM_ERROR          = 2
      OTHERS                 = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  DATA : LV_TABNM         LIKE FELD-NAME.
  FIELD-SYMBOLS: <FS_TAB> TYPE STANDARD TABLE.
  CONCATENATE GV_INTTAB300 '[]' INTO LV_TABNM.
  ASSIGN (LV_TABNM) TO <FS_TAB>.

  CALL FUNCTION 'LVC_TRANSFER_FROM_SLIS'
    EXPORTING
      IT_FIELDCAT_ALV = LT_FCAT
    IMPORTING
      ET_FIELDCAT_LVC = PT_ALV_FIELDCAT
    TABLES
      IT_DATA         = <FS_TAB>.

  LOOP AT PT_ALV_FIELDCAT ASSIGNING <FS_ALV_FIELDCAT>.
    CLEAR <FS_ALV_FIELDCAT>-KEY.

    CASE <FS_ALV_FIELDCAT>-FIELDNAME.
      WHEN 'EBELN' OR 'EBELP'.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'MENGE'.

        <FS_ALV_FIELDCAT>-DO_SUM = C_X.
      WHEN 'WEMNG'.

        <FS_ALV_FIELDCAT>-DO_SUM = C_X.
      WHEN 'NETWR'.

        <FS_ALV_FIELDCAT>-DO_SUM = C_X.
      WHEN 'SITQTY'.  "In Transit(QTY)
        <FS_ALV_FIELDCAT>-SCRTEXT_L = <FS_ALV_FIELDCAT>-REPTEXT = TEXT-N04.
        <FS_ALV_FIELDCAT>-SCRTEXT_S = <FS_ALV_FIELDCAT>-SCRTEXT_M = <FS_ALV_FIELDCAT>-SCRTEXT_L.
        <FS_ALV_FIELDCAT>-EMPHASIZE = 'C710'.
        <FS_ALV_FIELDCAT>-DO_SUM = C_X.
      WHEN 'SITAMT'.  "In Transit(AMT)
        <FS_ALV_FIELDCAT>-SCRTEXT_L = <FS_ALV_FIELDCAT>-REPTEXT = TEXT-N05.
        <FS_ALV_FIELDCAT>-SCRTEXT_S = <FS_ALV_FIELDCAT>-SCRTEXT_M = <FS_ALV_FIELDCAT>-SCRTEXT_L.
        <FS_ALV_FIELDCAT>-EMPHASIZE = 'C710'.
        <FS_ALV_FIELDCAT>-DO_SUM = C_X.
      WHEN OTHERS.
    ENDCASE.

  ENDLOOP.

ENDFORM.                    " BUILD_CATEGORY_300

*&---------------------------------------------------------------------*
*&      Form  BUILD_CATEGORY_500
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GT_ALV_FIELDCAT_500  text
*----------------------------------------------------------------------*

FORM BUILD_CATEGORY_500  CHANGING PT_ALV_FIELDCAT TYPE LVC_T_FCAT.

  DATA: L_TEXT(30),
         L_COL_POS TYPE I.

  DATA : LT_FCAT TYPE SLIS_T_FIELDCAT_ALV,
         LS_FCAT TYPE LVC_S_FCAT.

  DATA : LT_FCAT_TMP TYPE LVC_T_FCAT,
         LV_FDNAME   TYPE FIELDNAME.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      I_PROGRAM_NAME         = SY-REPID
      I_INTERNAL_TABNAME     = GV_INTTAB500
      I_INCLNAME             = SY-REPID
    CHANGING
      CT_FIELDCAT            = LT_FCAT
    EXCEPTIONS
      INCONSISTENT_INTERFACE = 1
      PROGRAM_ERROR          = 2
      OTHERS                 = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  DATA : LV_TABNM         LIKE FELD-NAME.
  FIELD-SYMBOLS: <FS_TAB> TYPE STANDARD TABLE.
  CONCATENATE GV_INTTAB500 '[]' INTO LV_TABNM.
  ASSIGN (LV_TABNM) TO <FS_TAB>.

  CALL FUNCTION 'LVC_TRANSFER_FROM_SLIS'
    EXPORTING
      IT_FIELDCAT_ALV = LT_FCAT
    IMPORTING
      ET_FIELDCAT_LVC = PT_ALV_FIELDCAT
    TABLES
      IT_DATA         = <FS_TAB>.

  DELETE PT_ALV_FIELDCAT     WHERE FIELDNAME EQ 'BUKRS'

                                OR FIELDNAME EQ 'KUNNR'
                                OR FIELDNAME EQ 'KUNNR_TX'

                                OR FIELDNAME EQ 'ZGROUP'

                                OR FIELDNAME EQ 'GRUND'

                                OR FIELDNAME EQ 'VGART'
                                OR FIELDNAME EQ 'BELNR'
                                OR FIELDNAME EQ 'GJAHR'
                                OR FIELDNAME EQ 'BUZEI'
                                OR FIELDNAME EQ 'ZIV_CHK'
                                OR FIELDNAME EQ 'ZSP_CHK'
                                OR FIELDNAME EQ 'CELLTAB'
                                OR FIELDNAME EQ 'COLINFO'
                                OR FIELDNAME EQ 'INFO'
                                OR FIELDNAME EQ 'MTART'
                                OR FIELDNAME EQ 'SALK3'
                                OR FIELDNAME EQ 'LBKUM'
                                OR FIELDNAME EQ 'STPRS'
                                OR FIELDNAME EQ 'LABST'.

  IF P_VAL EQ ABAP_OFF.
    DELETE PT_ALV_FIELDCAT     WHERE FIELDNAME EQ 'WAERS'
                                  OR FIELDNAME EQ 'DMBTR'.
  ENDIF.

  IF P_VAL EQ ABAP_OFF.
    LOOP AT PT_ALV_FIELDCAT ASSIGNING <FS_ALV_FIELDCAT>.
      CLEAR <FS_ALV_FIELDCAT>-KEY.

      CASE <FS_ALV_FIELDCAT>-FIELDNAME.
        WHEN 'MJAHR'.
          <FS_ALV_FIELDCAT>-COL_POS = 0.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F64.
          <FS_ALV_FIELDCAT>-JUST = 'C'.
        WHEN 'BUDAT'. " 전기일 (추가)
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F65.
          <FS_ALV_FIELDCAT>-COL_POS = 1.
        WHEN 'MBLNR'.
          <FS_ALV_FIELDCAT>-COL_POS = 2.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F66.
        WHEN 'ZEILE'.
          <FS_ALV_FIELDCAT>-COL_POS = 3.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F77.
        WHEN 'ZZLOGINO'.
          <FS_ALV_FIELDCAT>-COL_POS = 4.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F78.
        WHEN 'WERKS'.
          <FS_ALV_FIELDCAT>-COL_POS = 5.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F58.
        WHEN 'LGORT'.
          <FS_ALV_FIELDCAT>-COL_POS = 6.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F67.
        WHEN 'LIFNR'.
          <FS_ALV_FIELDCAT>-COL_POS = 7.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F59.
        WHEN 'LIFNR_TX'.
          <FS_ALV_FIELDCAT>-COL_POS = 8.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F60.
        WHEN 'MATNR'.
          <FS_ALV_FIELDCAT>-COL_POS = 9.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F51.
        WHEN 'MAKTX'.
          <FS_ALV_FIELDCAT>-COL_POS = 10.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F52.
        WHEN 'CHARG'.
          <FS_ALV_FIELDCAT>-COL_POS = 11.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F68.
        WHEN 'MENGE'.
          <FS_ALV_FIELDCAT>-COL_POS = 12.
          <FS_ALV_FIELDCAT>-DO_SUM = C_X.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F69.
        WHEN 'BWART'.
          <FS_ALV_FIELDCAT>-COL_POS = 14.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F71.
        WHEN 'BTEXT'.
          <FS_ALV_FIELDCAT>-COL_POS = 15.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F72.
        WHEN 'SOBKZ'.
          <FS_ALV_FIELDCAT>-COL_POS = 16.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F73.
          <FS_ALV_FIELDCAT>-JUST = 'C'.
        WHEN 'SHKZG'.
          <FS_ALV_FIELDCAT>-COL_POS = 17.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F74.
          <FS_ALV_FIELDCAT>-JUST = 'C'.

        WHEN 'MEINS'.
          <FS_ALV_FIELDCAT>-COL_POS = 19.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F75.
      ENDCASE.
    ENDLOOP.

  ELSE.

    LOOP AT PT_ALV_FIELDCAT ASSIGNING <FS_ALV_FIELDCAT>.
      CLEAR <FS_ALV_FIELDCAT>-KEY.

      CASE <FS_ALV_FIELDCAT>-FIELDNAME.
        WHEN 'MJAHR'.
          <FS_ALV_FIELDCAT>-COL_POS = 0.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F64.
          <FS_ALV_FIELDCAT>-JUST = 'C'.
        WHEN 'BUDAT'. " 전기일 (추가)
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F65.
          <FS_ALV_FIELDCAT>-COL_POS = 1.
        WHEN 'MBLNR'.
          <FS_ALV_FIELDCAT>-COL_POS = 2.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F66.
        WHEN 'ZEILE'.
          <FS_ALV_FIELDCAT>-COL_POS = 3.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F77.
        WHEN 'ZZLOGINO'.
          <FS_ALV_FIELDCAT>-COL_POS = 4.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F78.
        WHEN 'WERKS'.
          <FS_ALV_FIELDCAT>-COL_POS = 5.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F58.
        WHEN 'LGORT'.
          <FS_ALV_FIELDCAT>-COL_POS = 6.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F67.
        WHEN 'LIFNR'.
          <FS_ALV_FIELDCAT>-COL_POS = 7.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F59.
        WHEN 'LIFNR_TX'.
          <FS_ALV_FIELDCAT>-COL_POS = 8.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F60.
        WHEN 'MATNR'.
          <FS_ALV_FIELDCAT>-COL_POS = 9.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F51.
        WHEN 'MAKTX'.
          <FS_ALV_FIELDCAT>-COL_POS = 10.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F52.
        WHEN 'CHARG'.
          <FS_ALV_FIELDCAT>-COL_POS = 11.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F68.
        WHEN 'MENGE'.
          <FS_ALV_FIELDCAT>-COL_POS = 12.
          <FS_ALV_FIELDCAT>-DO_SUM = C_X.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F69.
        WHEN 'DMBTR'.
          <FS_ALV_FIELDCAT>-COL_POS = 13.
          <FS_ALV_FIELDCAT>-DO_SUM = C_X.
          <FS_ALV_FIELDCAT>-CFIELDNAME = 'WAERS'.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F70.
        WHEN 'BWART'.
          <FS_ALV_FIELDCAT>-COL_POS = 14.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F71.
        WHEN 'BTEXT'.
          <FS_ALV_FIELDCAT>-COL_POS = 15.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F72.
        WHEN 'SOBKZ'.
          <FS_ALV_FIELDCAT>-COL_POS = 16.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F73.
          <FS_ALV_FIELDCAT>-JUST = 'C'.
        WHEN 'SHKZG'.
          <FS_ALV_FIELDCAT>-COL_POS = 17.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F74.
          <FS_ALV_FIELDCAT>-JUST = 'C'.
        WHEN 'MEINS'.
          <FS_ALV_FIELDCAT>-COL_POS = 18.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F75.
        WHEN 'WAERS'.
          <FS_ALV_FIELDCAT>-COL_POS = 19.
          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F76.

      ENDCASE.
    ENDLOOP.
  ENDIF.

ENDFORM.                    " BUILD_CATEGORY_500

*&---------------------------------------------------------------------*
*&      Form  BUILD_SORT_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_SORT_100 .

  CLEAR: GT_ALV_SORT, GT_ALV_SORT[].

  GT_ALV_SORT_100[] = GT_ALV_SORT[].

ENDFORM.                    " BUILD_SORT_100

*&---------------------------------------------------------------------*
*&      Form  BUILD_SORT_200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_SORT_200 .

  CLEAR: GT_ALV_SORT, GT_ALV_SORT[].

  GT_ALV_SORT_200[] = GT_ALV_SORT[].

ENDFORM.                    " BUILD_SORT_200

*&---------------------------------------------------------------------*
*&      Form  BUILD_SORT_300
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_SORT_300 .

  CLEAR: GT_ALV_SORT, GT_ALV_SORT[].

  GT_ALV_SORT_300[] = GT_ALV_SORT[].

ENDFORM.                    " BUILD_SORT_300

*&---------------------------------------------------------------------*
*&      Form  BUILD_SORT_400
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_SORT_400 .

  CLEAR: GT_ALV_SORT, GT_ALV_SORT[].

  GT_ALV_SORT_400[] = GT_ALV_SORT[].

ENDFORM.                    " BUILD_SORT_400

*&---------------------------------------------------------------------*
*&      Form  BUILD_SORT_500
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_SORT_500 .

  CLEAR: GT_ALV_SORT, GT_ALV_SORT[].

  GT_ALV_SORT_500[] = GT_ALV_SORT[].

ENDFORM.                    " BUILD_SORT_500

*&---------------------------------------------------------------------*
*&      Form  BUILD_COLOR_STYLE_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_COLOR_STYLE_100 .

*  loop at gt_disp_100 assigning <gs_disp_100>.
**   Field Color
*    perform fill_color_100  using    <gs_disp_100>
*                            changing <gs_disp_100>-colinfo.
**   Field Style
*    perform fill_celltab_100 using    <gs_disp_100>
*                             changing <gs_disp_100>-celltab.
*  endloop.

ENDFORM.                    " BUILD_COLOR_STYLE_100

*&---------------------------------------------------------------------*
*&      Form  BUILD_COLOR_STYLE_200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_COLOR_STYLE_200 .

  LOOP AT GT_RAW ASSIGNING FIELD-SYMBOL(<GS_RAW_0200>).

*   Field Color

    IF <GS_RAW_0200>-MENGE < 0.
      <GS_RAW_0200>-INFO = 'C600'.
    ELSE.
      <GS_RAW_0200>-INFO = 'C100'.
    ENDIF.
  ENDLOOP.

ENDFORM.                    " BUILD_COLOR_STYLE_200

*&---------------------------------------------------------------------*
*&      Form  BUILD_COLOR_STYLE_300
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_COLOR_STYLE_300 .

*  loop at gt_disp_100 assigning <gs_disp_100>.
**   Field Color
*    perform fill_color_100  using    <gs_disp_100>
*                            changing <gs_disp_100>-colinfo.
**   Field Style
*    perform fill_celltab_100 using    <gs_disp_100>
*                             changing <gs_disp_100>-celltab.
*  endloop.

ENDFORM.                    " BUILD_COLOR_STYLE_300

*&---------------------------------------------------------------------*
*&      Form  BUILD_COLOR_STYLE_400
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_COLOR_STYLE_400 .

*  loop at gt_disp_100 assigning <gs_disp_100>.
**   Field Color
*    perform fill_color_100  using    <gs_disp_100>
*                            changing <gs_disp_100>-colinfo.
**   Field Style
*    perform fill_celltab_100 using    <gs_disp_100>
*                             changing <gs_disp_100>-celltab.
*  endloop.

ENDFORM.                    " BUILD_COLOR_STYLE_400

*&---------------------------------------------------------------------*
*&      Form  BUILD_COLOR_STYLE_500
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_COLOR_STYLE_500 .

*  loop at GT_DISP_0500 ASSIGNING FIELD-SYMBOL(<GS_DISP_0500>).
**   Field Color
*
*  endloop.

ENDFORM.                    " BUILD_COLOR_STYLE_500

*&---------------------------------------------------------------------*
*&      Form  BUILD_EVENT_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_EVENT_100 .

  IF SY-BATCH IS INITIAL.
    CALL METHOD GV_ALV_GRID_100->REGISTER_EDIT_EVENT
      EXPORTING
        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

    CALL METHOD GV_ALV_GRID_100->REGISTER_EDIT_EVENT
      EXPORTING
        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.
  ENDIF.

* Event

  CREATE OBJECT G_ALV_EVENT_100.
  SET HANDLER G_ALV_EVENT_100->HANDLE_DOUBLE_CLICK  FOR GV_ALV_GRID_100.
  SET HANDLER G_ALV_EVENT_100->ON_TOP_OF_PAGE       FOR GV_ALV_GRID_100.
  SET HANDLER G_ALV_EVENT_100->ON_TOOLBAR           FOR GV_ALV_GRID_100.
  SET HANDLER G_ALV_EVENT_100->HANDLE_USER_COMMAND  FOR GV_ALV_GRID_100.

ENDFORM.                    " BUILD_EVENT_100

*&---------------------------------------------------------------------*
*&      Form  BUILD_EVENT_200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_EVENT_200 .

  IF SY-BATCH IS INITIAL.
    CALL METHOD GV_ALV_GRID_200->REGISTER_EDIT_EVENT
      EXPORTING
        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

    CALL METHOD GV_ALV_GRID_200->REGISTER_EDIT_EVENT
      EXPORTING
        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.
  ENDIF.

* Event

  CREATE OBJECT G_ALV_EVENT_200.
  SET HANDLER G_ALV_EVENT_200->HANDLE_DOUBLE_CLICK  FOR GV_ALV_GRID_200.
  SET HANDLER G_ALV_EVENT_200->ON_TOP_OF_PAGE      FOR GV_ALV_GRID_200.

ENDFORM.                    " BUILD_EVENT_200

*&---------------------------------------------------------------------*
*&      Form  BUILD_EVENT_300
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_EVENT_300 .

  IF SY-BATCH IS INITIAL.
    CALL METHOD GV_ALV_GRID_300->REGISTER_EDIT_EVENT
      EXPORTING
        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

    CALL METHOD GV_ALV_GRID_300->REGISTER_EDIT_EVENT
      EXPORTING
        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.
  ENDIF.

* Event

  CREATE OBJECT G_ALV_EVENT_300.
  SET HANDLER G_ALV_EVENT_300->HANDLE_DOUBLE_CLICK  FOR GV_ALV_GRID_300.
  SET HANDLER G_ALV_EVENT_300->ON_TOP_OF_PAGE      FOR GV_ALV_GRID_300.

ENDFORM.                    " BUILD_EVENT_300

*&---------------------------------------------------------------------*
*&      Form  BUILD_EVENT_400
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_EVENT_400 .

  IF SY-BATCH IS INITIAL.
    CALL METHOD GV_ALV_GRID_400->REGISTER_EDIT_EVENT
      EXPORTING
        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

    CALL METHOD GV_ALV_GRID_400->REGISTER_EDIT_EVENT
      EXPORTING
        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.
  ENDIF.

* Event

  CREATE OBJECT G_ALV_EVENT_400.
  SET HANDLER G_ALV_EVENT_400->HANDLE_DOUBLE_CLICK  FOR GV_ALV_GRID_400.
  SET HANDLER G_ALV_EVENT_400->ON_TOP_OF_PAGE       FOR GV_ALV_GRID_400.
  SET HANDLER G_ALV_EVENT_400->ON_TOOLBAR           FOR GV_ALV_GRID_400.
  SET HANDLER G_ALV_EVENT_400->HANDLE_USER_COMMAND  FOR GV_ALV_GRID_400.

ENDFORM.                    " BUILD_EVENT_400

*&---------------------------------------------------------------------*
*&      Form  BUILD_EVENT_500
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_EVENT_500 .

  IF SY-BATCH IS INITIAL.
    CALL METHOD GV_ALV_GRID_500->REGISTER_EDIT_EVENT
      EXPORTING
        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

    CALL METHOD GV_ALV_GRID_500->REGISTER_EDIT_EVENT
      EXPORTING
        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.
  ENDIF.

* Event

  CREATE OBJECT G_ALV_EVENT_500.
  SET HANDLER G_ALV_EVENT_500->HANDLE_DOUBLE_CLICK  FOR GV_ALV_GRID_500.
  SET HANDLER G_ALV_EVENT_500->ON_TOP_OF_PAGE      FOR GV_ALV_GRID_500.

ENDFORM.                    " BUILD_EVENT_500

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM DISPLAY_ALV_100 .

  GS_ALV_VARIANT_100-REPORT = SY-REPID.

*  FIELD-SYMBOLS: <fs_tab> TYPE STANDARD TABLE.

  CREATE OBJECT GV_ALV_DOCUMENT
    EXPORTING
      STYLE = 'ALV_GRID'.

  CALL METHOD GV_ALV_DOCUMENT->INITIALIZE_DOCUMENT.

  CALL METHOD GV_ALV_GRID_100->LIST_PROCESSING_EVENTS
    EXPORTING
      I_EVENT_NAME = 'TOP_OF_PAGE'
      I_DYNDOC_ID  = GV_ALV_DOCUMENT.

  CALL METHOD GV_ALV_GRID_100->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_LAYOUT            = GS_ALV_LAYOUT_100
      IS_VARIANT           = GS_ALV_VARIANT_100
      IT_TOOLBAR_EXCLUDING = GT_ALV_EXTAB_100
      I_SAVE               = GV_ALV_SAVE
    CHANGING
      IT_OUTTAB            = <GT_TABLE>
      IT_FIELDCATALOG      = GT_ALV_FIELDCAT_100[]
      IT_SORT              = GT_ALV_SORT_100.

ENDFORM.                    " DISPLAY_ALV_100

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV_200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM DISPLAY_ALV_200 .

  GS_ALV_VARIANT_200-REPORT = SY-REPID.

  DATA : LV_TABNM         LIKE FELD-NAME.
  FIELD-SYMBOLS: <FS_TAB> TYPE STANDARD TABLE.
  CONCATENATE GV_INTTAB200 '[]' INTO LV_TABNM.
  ASSIGN (LV_TABNM) TO <FS_TAB>.

  CREATE OBJECT GV_ALV_DOCUMENT
    EXPORTING
      STYLE = 'ALV_GRID'.

  CALL METHOD GV_ALV_DOCUMENT->INITIALIZE_DOCUMENT.

  CALL METHOD GV_ALV_GRID_200->LIST_PROCESSING_EVENTS
    EXPORTING
      I_EVENT_NAME = 'TOP_OF_PAGE'
      I_DYNDOC_ID  = GV_ALV_DOCUMENT.

  CALL METHOD GV_ALV_GRID_200->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_LAYOUT            = GS_ALV_LAYOUT_200
      IS_VARIANT           = GS_ALV_VARIANT_200
      IT_TOOLBAR_EXCLUDING = GT_ALV_EXTAB_200
      I_SAVE               = GV_ALV_SAVE
    CHANGING
      IT_OUTTAB            = <FS_TAB>
      IT_FIELDCATALOG      = GT_ALV_FIELDCAT_200[]
      IT_SORT              = GT_ALV_SORT_200.

ENDFORM.                    " DISPLAY_ALV_200

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV_300
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM DISPLAY_ALV_300 .

  GS_ALV_VARIANT_300-REPORT = SY-REPID.

  DATA : LV_TABNM         LIKE FELD-NAME.
  FIELD-SYMBOLS: <FS_TAB> TYPE STANDARD TABLE.
  CONCATENATE GV_INTTAB300 '[]' INTO LV_TABNM.
  ASSIGN (LV_TABNM) TO <FS_TAB>.

  CREATE OBJECT GV_ALV_DOCUMENT
    EXPORTING
      STYLE = 'ALV_GRID'.

  CALL METHOD GV_ALV_DOCUMENT->INITIALIZE_DOCUMENT.

  CALL METHOD GV_ALV_GRID_300->LIST_PROCESSING_EVENTS
    EXPORTING
      I_EVENT_NAME = 'TOP_OF_PAGE'
      I_DYNDOC_ID  = GV_ALV_DOCUMENT.

  CALL METHOD GV_ALV_GRID_300->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_LAYOUT            = GS_ALV_LAYOUT_300
      IS_VARIANT           = GS_ALV_VARIANT_300
      IT_TOOLBAR_EXCLUDING = GT_ALV_EXTAB_300
      I_SAVE               = GV_ALV_SAVE
    CHANGING
      IT_OUTTAB            = <FS_TAB>
      IT_FIELDCATALOG      = GT_ALV_FIELDCAT_300[]
      IT_SORT              = GT_ALV_SORT_300.

ENDFORM.                    " DISPLAY_ALV_300

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV_400
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM DISPLAY_ALV_400 .

  GS_ALV_VARIANT_400-REPORT = SY-REPID.

*  FIELD-SYMBOLS: <FS_TAB> TYPE STANDARD TABLE.

  CREATE OBJECT GV_ALV_DOCUMENT
    EXPORTING
      STYLE = 'ALV_GRID'.

  CALL METHOD GV_ALV_DOCUMENT->INITIALIZE_DOCUMENT.

  CALL METHOD GV_ALV_GRID_400->LIST_PROCESSING_EVENTS
    EXPORTING
      I_EVENT_NAME = 'TOP_OF_PAGE'
      I_DYNDOC_ID  = GV_ALV_DOCUMENT.

  CALL METHOD GV_ALV_GRID_400->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_LAYOUT            = GS_ALV_LAYOUT_400
      IS_VARIANT           = GS_ALV_VARIANT_400
      IT_TOOLBAR_EXCLUDING = GT_ALV_EXTAB_400
      I_SAVE               = GV_ALV_SAVE
    CHANGING
      IT_OUTTAB            = <GT_BATCH>
      IT_FIELDCATALOG      = GT_ALV_FIELDCAT_400[]
      IT_SORT              = GT_ALV_SORT_400.

ENDFORM.                    " DISPLAY_ALV_400

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV_500
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM DISPLAY_ALV_500 .

  GS_ALV_VARIANT_500-REPORT = SY-REPID.

  DATA : LV_TABNM         LIKE FELD-NAME.
  FIELD-SYMBOLS: <FS_TAB> TYPE STANDARD TABLE.
  CONCATENATE GV_INTTAB500 '[]' INTO LV_TABNM.
  ASSIGN (LV_TABNM) TO <FS_TAB>.

  CREATE OBJECT GV_ALV_DOCUMENT
    EXPORTING
      STYLE = 'ALV_GRID'.

  CALL METHOD GV_ALV_DOCUMENT->INITIALIZE_DOCUMENT.

  CALL METHOD GV_ALV_GRID_500->LIST_PROCESSING_EVENTS
    EXPORTING
      I_EVENT_NAME = 'TOP_OF_PAGE'
      I_DYNDOC_ID  = GV_ALV_DOCUMENT.

  CALL METHOD GV_ALV_GRID_500->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_LAYOUT            = GS_ALV_LAYOUT_500
      IS_VARIANT           = GS_ALV_VARIANT_500
      IT_TOOLBAR_EXCLUDING = GT_ALV_EXTAB_500
      I_SAVE               = GV_ALV_SAVE
    CHANGING
      IT_OUTTAB            = <FS_TAB>
      IT_FIELDCATALOG      = GT_ALV_FIELDCAT_500[]
      IT_SORT              = GT_ALV_SORT_500.

ENDFORM.                    " DISPLAY_ALV_500

*&---------------------------------------------------------------------*
*&      Form  BUILD_LAYOUT_110
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GS_ALV_LAYOUT_110  text
*----------------------------------------------------------------------*

FORM BUILD_LAYOUT_110  CHANGING PS_LVC_LAYO TYPE LVC_S_LAYO.

  CLEAR PS_LVC_LAYO.

  PS_LVC_LAYO-ZEBRA      = 'X'.
  PS_LVC_LAYO-CWIDTH_OPT = 'X'.
  PS_LVC_LAYO-COL_OPT    = 'X'.
  PS_LVC_LAYO-CTAB_FNAME = 'COLINFO'.
  PS_LVC_LAYO-INFO_FNAME = 'INFO'.      "Row color
  PS_LVC_LAYO-STYLEFNAME = 'CELLTAB'.   "Input control

ENDFORM.                    " BUILD_LAYOUT_110

*&---------------------------------------------------------------------*
*&      Form  BUILD_CATEGORY_110
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GT_ALV_FIELDCAT_110  text
*----------------------------------------------------------------------*

FORM BUILD_CATEGORY_110  CHANGING PT_ALV_FIELDCAT TYPE LVC_T_FCAT.

  DATA: L_TEXT(30),
        L_COL_POS TYPE I.

  DATA : LT_FCAT TYPE SLIS_T_FIELDCAT_ALV,
         LS_FCAT TYPE LVC_S_FCAT.

  DATA : LT_FCAT_TMP TYPE LVC_T_FCAT,
         LV_FDNAME   TYPE FIELDNAME.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      I_PROGRAM_NAME         = SY-REPID
      I_INTERNAL_TABNAME     = GV_INTTAB110
      I_INCLNAME             = SY-REPID
    CHANGING
      CT_FIELDCAT            = LT_FCAT
    EXCEPTIONS
      INCONSISTENT_INTERFACE = 1
      PROGRAM_ERROR          = 2
      OTHERS                 = 3.
  IF SY-SUBRC <> 0.
  ENDIF.

  DATA : LV_TABNM         LIKE FELD-NAME.
  FIELD-SYMBOLS: <FS_TAB2> TYPE STANDARD TABLE.
  CONCATENATE GV_INTTAB110 '[]' INTO LV_TABNM.
  ASSIGN (LV_TABNM) TO <FS_TAB2>.

  CALL FUNCTION 'LVC_TRANSFER_FROM_SLIS'
    EXPORTING
      IT_FIELDCAT_ALV = LT_FCAT
    IMPORTING
      ET_FIELDCAT_LVC = PT_ALV_FIELDCAT
    TABLES
      IT_DATA         = <FS_TAB2>.

  LOOP AT PT_ALV_FIELDCAT ASSIGNING <FS_ALV_FIELDCAT>.
    CLEAR <FS_ALV_FIELDCAT>-KEY.

    CASE <FS_ALV_FIELDCAT>-FIELDNAME.
      WHEN 'REQNO'.
        <FS_ALV_FIELDCAT>-KEY = C_X.

    ENDCASE.
  ENDLOOP.

  LT_FCAT_TMP[] = PT_ALV_FIELDCAT[].
  SORT LT_FCAT_TMP BY FIELDNAME.
  SORT PT_ALV_FIELDCAT BY FIELDNAME.

  LOOP AT LT_FCAT_TMP INTO LS_FCAT.

    FIND C_UN IN LS_FCAT-FIELDNAME.
    CHECK SY-SUBRC NE 0.

    CLEAR LV_FDNAME.
    CONCATENATE LS_FCAT-FIELDNAME C_UN INTO LV_FDNAME.
    CONDENSE LV_FDNAME.

    READ TABLE PT_ALV_FIELDCAT ASSIGNING <FS_ALV_FIELDCAT> WITH KEY FIELDNAME = LV_FDNAME.
    IF SY-SUBRC EQ 0 AND <FS_ALV_FIELDCAT>-COLTEXT IS INITIAL.
      IF LS_FCAT-COLTEXT IS NOT INITIAL.
        <FS_ALV_FIELDCAT>-COLTEXT = LS_FCAT-COLTEXT.
      ELSE.
        <FS_ALV_FIELDCAT>-COLTEXT = LS_FCAT-SCRTEXT_M.
      ENDIF.
    ENDIF.

  ENDLOOP.
ENDFORM.                    " BUILD_CATEGORY_110

*&---------------------------------------------------------------------*
*&      Form  BUILD_SORT_110
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_SORT_110 .

  CLEAR: GT_ALV_SORT, GT_ALV_SORT[].

  GT_ALV_SORT_110[] = GT_ALV_SORT[].

ENDFORM.                    " BUILD_SORT_110

*&---------------------------------------------------------------------*
*&      Form  BUILD_COLOR_STYLE_110
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_COLOR_STYLE_110 .

*  loop at gt_disp_110 assigning <gs_disp_110>.
**   Field Color
*    perform fill_color_110  using    <gs_disp_110>
*                            changing <gs_disp_110>-colinfo.
**   Field Style
*    perform fill_celltab_110 using    <gs_disp_110>
*                             changing <gs_disp_110>-celltab.
*  endloop.

ENDFORM.                    " BUILD_COLOR_STYLE_110

*&---------------------------------------------------------------------*
*&      Form  BUILD_EVENT_110
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM BUILD_EVENT_110 .

  CREATE OBJECT G_ALV_EVENT_110.
  SET HANDLER G_ALV_EVENT_110->HANDLE_DOUBLE_CLICK  FOR GV_ALV_GRID_110.

ENDFORM.                    " BUILD_EVENT_110

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV_110
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM DISPLAY_ALV_110 .

  GS_ALV_VARIANT_110-REPORT = SY-REPID.
  GS_ALV_VARIANT_110-HANDLE = '110'.

  DATA : LV_TABNM         LIKE FELD-NAME.
  FIELD-SYMBOLS: <FS_TAB2> TYPE STANDARD TABLE.
  CONCATENATE GV_INTTAB110 '[]' INTO LV_TABNM.
  ASSIGN (LV_TABNM) TO <FS_TAB2>.

  CALL METHOD GV_ALV_GRID_110->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_LAYOUT            = GS_ALV_LAYOUT_110
      IS_VARIANT           = GS_ALV_VARIANT_110
      IT_TOOLBAR_EXCLUDING = GT_ALV_EXTAB_110
      I_SAVE               = GV_ALV_SAVE
    CHANGING
      IT_OUTTAB            = <FS_TAB2>
      IT_FIELDCATALOG      = GT_ALV_FIELDCAT_110[]
      IT_SORT              = GT_ALV_SORT_110.

ENDFORM.                    " DISPLAY_ALV_110

*&---------------------------------------------------------------------*
*&      Form  ALV_APPEND_EXCLUDE_FCODE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_<FS>  text
*      -->P_CL_GUI_ALV_GRID=>MC_FC_LOC_UND  text
*----------------------------------------------------------------------*

FORM ALV_APPEND_EXCLUDE_FCODE  TABLES P_TABLE
                              USING  P_VALUE.

  DATA LS_EXCLUDE TYPE UI_FUNC.

  LS_EXCLUDE = P_VALUE.

  APPEND LS_EXCLUDE TO P_TABLE.

ENDFORM.                    " ALV_APPEND_EXCLUDE_FCODE

*&---------------------------------------------------------------------*
*&      Form  ALV_APPEND_SORT_FIELD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0495   text
*      -->P_0496   text
*      -->P_0497   text
*      -->P_0498   text
*----------------------------------------------------------------------*

FORM ALV_APPEND_SORT_FIELD  USING VALUE(P_FNAME)
                                  VALUE(P_UP)
                                  VALUE(P_DOWN)
                                  VALUE(P_SUBTOT).

  GV_ALV_POS                  = GV_ALV_POS + 1.
  GS_ALV_SORT-FIELDNAME       = P_FNAME.            "Sort Field
  GS_ALV_SORT-SPOS            = GV_ALV_POS.         "Sort Field ##
  GS_ALV_SORT-UP              = P_UP.               "Ascending:X
  GS_ALV_SORT-DOWN            = P_DOWN.             "Descending:X
  GS_ALV_SORT-SUBTOT          = P_SUBTOT.           "Sub Total:X

  APPEND GS_ALV_SORT TO GT_ALV_SORT.  CLEAR : GS_ALV_SORT.

ENDFORM.                    " ALV_APPEND_SORT_FIELD

*&---------------------------------------------------------------------*
*&      Form  EXIT_RTN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM EXIT_RTN .

  CASE SY-DYNNR.

*   Screen #100

    WHEN '0100'.
      CALL METHOD GV_DOCKING_CONTAINER_100->FREE.
      CLEAR GV_DOCKING_CONTAINER_100.
      LEAVE TO SCREEN 0.

*   Screen #200

    WHEN '0200'.
      CALL METHOD GV_DOCKING_CONTAINER_200->FREE.
      CLEAR GV_DOCKING_CONTAINER_200.
      LEAVE TO SCREEN 0.

*   Screen #300

    WHEN '0300'.
      CALL METHOD GV_DOCKING_CONTAINER_300->FREE.
      CLEAR GV_DOCKING_CONTAINER_300.
      LEAVE TO SCREEN 0.

    WHEN '0400'.
      CALL METHOD GV_DOCKING_CONTAINER_400->FREE.
      CLEAR GV_DOCKING_CONTAINER_400.
      LEAVE TO SCREEN 0.

*   Screen #500

    WHEN '0500'.
      CALL METHOD GV_DOCKING_CONTAINER_500->FREE.
      CLEAR GV_DOCKING_CONTAINER_500.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
      LEAVE TO SCREEN 0.

  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ADD_TEXT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_LV_TEXT  text
*----------------------------------------------------------------------*

FORM ADD_TEXT  USING PV_TEXT TYPE SDYDO_TEXT_ELEMENT.

  CALL METHOD GV_ALV_DOCUMENT->ADD_TEXT
    EXPORTING
      TEXT          = PV_TEXT
      SAP_FONTSTYLE = CL_DD_DOCUMENT=>SANS_SERIF
      SAP_EMPHASIS  = CL_DD_DOCUMENT=>EMPHASIS.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  HTML_DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM HTML_DISPLAY .
  DATA : LV_LENGTH TYPE I,
         LV_ID     TYPE SDYDO_KEY VALUE SPACE.

  IF GV_HTML_TOP_OF_LIST IS INITIAL.
    CREATE OBJECT GV_HTML_TOP_OF_LIST
      EXPORTING
        PARENT = GV_TOP_OF_LIST.
  ELSE.
    FREE GV_HTML_TOP_OF_LIST.
    CREATE OBJECT GV_HTML_TOP_OF_LIST
      EXPORTING
        PARENT = GV_TOP_OF_LIST.
  ENDIF.

  CALL FUNCTION 'REUSE_ALV_GRID_COMMENTARY_SET'
    EXPORTING
      DOCUMENT = GV_ALV_DOCUMENT
      BOTTOM   = SPACE
    IMPORTING
      LENGTH   = LV_LENGTH.

  CALL METHOD GV_ALV_DOCUMENT->MERGE_DOCUMENT.

  CALL METHOD GV_ALV_DOCUMENT->SET_DOCUMENT_BACKGROUND
    EXPORTING
      PICTURE_ID = LV_ID.

  GV_ALV_DOCUMENT->HTML_CONTROL = GV_HTML_TOP_OF_LIST.

  CALL METHOD GV_ALV_DOCUMENT->DISPLAY_DOCUMENT
    EXPORTING
      REUSE_CONTROL      = C_X
      PARENT             = GV_TOP_OF_LIST
    EXCEPTIONS
      HTML_DISPLAY_ERROR = 1.
  IF SY-SUBRC NE 0.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  HANDLE_DOUBLE_CLICK_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_E_ROW  text
*      -->P_E_COLUMN  text
*----------------------------------------------------------------------*

FORM HANDLE_DOUBLE_CLICK_100  USING PS_ROW_ID STRUCTURE LVC_S_ROW
                                    PS_COLUMN_ID STRUCTURE LVC_S_COL.

  DATA: LT_TABLE TYPE REF TO DATA,
        LS_TABLE TYPE REF TO DATA.

  FIELD-SYMBOLS: <LS_TABLE> TYPE ANY,
                 <FS_BUKRS> TYPE ANY,
                 <FS_WERKS> TYPE ANY,
                 <FS_MATNR> TYPE ANY,
                 <LS_DISP>  TYPE ANY,
                 <FS_LIFNR> TYPE ANY.

  CREATE DATA LS_TABLE LIKE LINE OF <GT_TABLE>.
  ASSIGN LS_TABLE->* TO <LS_DISP>.

  CHECK PS_ROW_ID-ROWTYPE IS INITIAL.
  READ TABLE <GT_TABLE> ASSIGNING <LS_DISP>
                        INDEX PS_ROW_ID-INDEX.

  ASSIGN COMPONENT: 'WERKS' OF STRUCTURE <LS_DISP> TO <FS_WERKS>,
                    'MATNR' OF STRUCTURE <LS_DISP> TO <FS_MATNR>,
                    'lifnr' OF STRUCTURE <LS_DISP> TO <FS_LIFNR>.

  CHECK SY-SUBRC = 0.

  CASE PS_COLUMN_ID-FIELDNAME.
    WHEN 'MATNR' OR 'MAKTX'.
      IF <FS_MATNR> IS INITIAL.
        MESSAGE S000 WITH 'There is no Material' DISPLAY LIKE 'E'.
      ELSE.
        SET PARAMETER ID 'MAT' FIELD <FS_MATNR>.
        SET PARAMETER ID 'WRK' FIELD <FS_WERKS>.
        SET PARAMETER ID 'MXX' FIELD 'K'.
        CALL TRANSACTION 'MM03' AND SKIP FIRST SCREEN.
      ENDIF.
    WHEN 'LIFNR' OR 'LIFNR_TX'.
      DATA: KDY_VAL(8) VALUE '/110'.
      SET PARAMETER ID 'LIF' FIELD <FS_LIFNR>.   " Pass the vendor
      SET PARAMETER ID 'KDY' FIELD KDY_VAL.
      CALL TRANSACTION 'XK03' AND SKIP FIRST SCREEN.

    WHEN OTHERS.
      CASE PS_COLUMN_ID-FIELDNAME+0(6).
        WHEN 'MENGE_' OR 'DMBTR_' OR 'DMAVG_'.
          IF PS_COLUMN_ID-FIELDNAME EQ 'MENGE_SIT' OR
             PS_COLUMN_ID-FIELDNAME EQ 'DMBTR_SIT' OR
             PS_COLUMN_ID-FIELDNAME EQ 'DMAVG_SIT'.  "미착품

            PERFORM SHOW_SIT_DATA CHANGING <LS_DISP>.

          ELSE.

            PERFORM SHOW_GROUP_RAW USING PS_COLUMN_ID-FIELDNAME
                                         '0100'
                                   CHANGING <LS_DISP>.

          ENDIF.
        WHEN OTHERS.
      ENDCASE.

  ENDCASE.

*    EXPORTING

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  HANDLE_DOUBLE_CLICK_400
*&---------------------------------------------------------------------*

FORM HANDLE_DOUBLE_CLICK_400  USING PS_ROW_ID STRUCTURE LVC_S_ROW
                                    PS_COLUMN_ID STRUCTURE LVC_S_COL.

  DATA: LT_TABLE TYPE REF TO DATA,
        LS_TABLE TYPE REF TO DATA.

  FIELD-SYMBOLS: <LS_TABLE> TYPE ANY,
                 <FS_BUKRS> TYPE ANY,
                 <FS_WERKS> TYPE ANY,
                 <FS_MATNR> TYPE ANY,
                 <FS_CHARG> TYPE ANY,
                 <LS_DISP>  TYPE ANY,
                 <FS_LIFNR> TYPE ANY.

  CREATE DATA LS_TABLE LIKE LINE OF <GT_BATCH>.
  ASSIGN LS_TABLE->* TO <LS_DISP>.

  CHECK PS_ROW_ID-ROWTYPE IS INITIAL.
  READ TABLE <GT_BATCH> ASSIGNING <LS_DISP>
                        INDEX PS_ROW_ID-INDEX.

  ASSIGN COMPONENT: 'WERKS' OF STRUCTURE <LS_DISP> TO <FS_WERKS>,
                    'MATNR' OF STRUCTURE <LS_DISP> TO <FS_MATNR>,
                    'CHARG' OF STRUCTURE <LS_DISP> TO <FS_CHARG>,
                    'LIFNR' OF STRUCTURE <LS_DISP> TO <FS_LIFNR>.

  CHECK SY-SUBRC = 0.

  CASE PS_COLUMN_ID-FIELDNAME.
    WHEN 'MATNR' OR 'MAKTX'.
      IF <FS_MATNR> IS INITIAL.
        MESSAGE S000 WITH 'There is no Material' DISPLAY LIKE 'E'.
      ELSE.
        SET PARAMETER ID 'MAT' FIELD <FS_MATNR>.
        SET PARAMETER ID 'WRK' FIELD <FS_WERKS>.
        SET PARAMETER ID 'MXX' FIELD 'K'.
        CALL TRANSACTION 'MM03' AND SKIP FIRST SCREEN.
      ENDIF.

    WHEN 'CHARG'.
      SET PARAMETER ID 'MAT' FIELD <FS_MATNR>.
      SET PARAMETER ID 'WRK' FIELD <FS_WERKS>.
      SET PARAMETER ID 'CHA' FIELD <FS_CHARG>.
      CALL TRANSACTION 'MSC3N' AND SKIP FIRST SCREEN.

    WHEN 'LIFNR' OR 'LIFNR_TX'.
      DATA: KDY_VAL(8) VALUE '/110'.
      SET PARAMETER ID 'LIF' FIELD <FS_LIFNR>.   " Pass the vendor
      SET PARAMETER ID 'KDY' FIELD KDY_VAL.
      CALL TRANSACTION 'XK03' AND SKIP FIRST SCREEN.

    WHEN OTHERS.

      CASE PS_COLUMN_ID-FIELDNAME+0(6).
        WHEN 'MENGE_' OR 'DMBTR_'.
          IF PS_COLUMN_ID-FIELDNAME EQ 'MENGE_BI' OR
             PS_COLUMN_ID-FIELDNAME EQ 'MENGE_EI' OR
             PS_COLUMN_ID-FIELDNAME EQ 'MENGE_SG_EI'.

          ELSEIF PS_COLUMN_ID-FIELDNAME EQ 'MENGE_SIT'.

            PERFORM SHOW_SIT_DATA_BATCH CHANGING <LS_DISP>.

          ELSE.

            PERFORM SHOW_GROUP_RAW USING PS_COLUMN_ID-FIELDNAME
                                         '0400'
                                   CHANGING <LS_DISP>.

          ENDIF.
        WHEN OTHERS.
      ENDCASE.

  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form HANDLE_DOUBLE_CLICK_500
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW
*&      --> E_COLUMN
*&---------------------------------------------------------------------*

FORM HANDLE_DOUBLE_CLICK_500  USING PS_ROW_ID STRUCTURE LVC_S_ROW
                                    PS_COLUMN_ID STRUCTURE LVC_S_COL.

  CHECK PS_ROW_ID-ROWTYPE IS INITIAL.
  READ TABLE GT_DISP_0500 ASSIGNING FIELD-SYMBOL(<FS_RAW>)
                        INDEX PS_ROW_ID-INDEX.

  CHECK SY-SUBRC = 0.

  CASE PS_COLUMN_ID-FIELDNAME.
    WHEN 'MATNR' OR 'MAKTX'.
      IF <FS_RAW>-MATNR IS INITIAL.
        MESSAGE S000 WITH 'There is no Material' DISPLAY LIKE 'E'.
      ELSE.
        SET PARAMETER ID 'MAT' FIELD <FS_RAW>-MATNR.
        SET PARAMETER ID 'WRK' FIELD <FS_RAW>-WERKS.
        SET PARAMETER ID 'MXX' FIELD 'K'.
        CALL TRANSACTION 'MM03' AND SKIP FIRST SCREEN.
      ENDIF.

    WHEN 'CHARG'.
      SET PARAMETER ID 'MAT' FIELD <FS_RAW>-MATNR.
      SET PARAMETER ID 'WRK' FIELD <FS_RAW>-WERKS.
      SET PARAMETER ID 'CHA' FIELD <FS_RAW>-CHARG.
      CALL TRANSACTION 'MSC3N' AND SKIP FIRST SCREEN.

    WHEN 'BELNR' OR 'GJAHR' OR 'BUZEI'.
      IF <FS_RAW>-BELNR IS NOT INITIAL.
        IF <FS_RAW>-ZSP_CHK EQ C_X.
          SET PARAMETER ID 'MLN' FIELD <FS_RAW>-BELNR.
          SET PARAMETER ID 'MLJ' FIELD <FS_RAW>-GJAHR.
          CALL TRANSACTION 'CKMB' AND SKIP FIRST SCREEN.
        ELSE.
          SET PARAMETER ID 'RBN' FIELD <FS_RAW>-BELNR.
          SET PARAMETER ID 'GJR' FIELD <FS_RAW>-GJAHR.
          CALL TRANSACTION 'MIR4' AND SKIP FIRST SCREEN.
        ENDIF.
      ENDIF.

    WHEN OTHERS.
      IF <FS_RAW>-MBLNR IS NOT INITIAL.
        IF <FS_RAW>-ZSP_CHK EQ C_X.

          SET PARAMETER ID 'BLN' FIELD <FS_RAW>-MBLNR.
          SET PARAMETER ID 'BUK' FIELD <FS_RAW>-BUKRS.
          SET PARAMETER ID 'GJR' FIELD <FS_RAW>-MJAHR.
          CALL TRANSACTION 'FB03' AND SKIP FIRST SCREEN.

        ELSE.
          CALL FUNCTION 'MIGO_DIALOG'
            EXPORTING
              I_ACTION            = 'A04'
              I_REFDOC            = 'R02'
              I_MBLNR             = <FS_RAW>-MBLNR
              I_MJAHR             = <FS_RAW>-MJAHR
            EXCEPTIONS
              ILLEGAL_COMBINATION = 1
              OTHERS              = 2.
          IF SY-SUBRC <> 0.

* Implement suitable error handling here

          ENDIF.
        ENDIF.
      ENDIF.
  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  HANDLE_DOUBLE_CLICK_200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_E_ROW  text
*      -->P_E_COLUMN  text
*----------------------------------------------------------------------*

FORM HANDLE_DOUBLE_CLICK_200  USING PS_ROW_ID STRUCTURE LVC_S_ROW
                                    PS_COLUMN_ID STRUCTURE LVC_S_COL.

  CHECK PS_ROW_ID-ROWTYPE IS INITIAL.
  READ TABLE GT_RAW_DISP ASSIGNING FIELD-SYMBOL(<FS_RAW>)
                        INDEX PS_ROW_ID-INDEX.

  CHECK SY-SUBRC = 0.

  CASE PS_COLUMN_ID-FIELDNAME.
    WHEN 'MATNR' OR 'MAKTX'.
      IF <FS_RAW>-MATNR IS INITIAL.
        MESSAGE S000 WITH 'There is no Material' DISPLAY LIKE 'E'.
      ELSE.
        SET PARAMETER ID 'MAT' FIELD <FS_RAW>-MATNR.
        SET PARAMETER ID 'WRK' FIELD <FS_RAW>-WERKS.
        SET PARAMETER ID 'MXX' FIELD 'K'.
        CALL TRANSACTION 'MM03' AND SKIP FIRST SCREEN.
      ENDIF.

    WHEN 'CHARG'.
      SET PARAMETER ID 'MAT' FIELD <FS_RAW>-MATNR.
      SET PARAMETER ID 'WRK' FIELD <FS_RAW>-WERKS.
      SET PARAMETER ID 'CHA' FIELD <FS_RAW>-CHARG.
      CALL TRANSACTION 'MSC3N' AND SKIP FIRST SCREEN.

    WHEN 'BELNR' OR 'GJAHR' OR 'BUZEI'.
      IF <FS_RAW>-BELNR IS NOT INITIAL.
        IF <FS_RAW>-ZSP_CHK EQ C_X.
          SET PARAMETER ID 'MLN' FIELD <FS_RAW>-BELNR.
          SET PARAMETER ID 'MLJ' FIELD <FS_RAW>-GJAHR.
          CALL TRANSACTION 'CKMB' AND SKIP FIRST SCREEN.
        ELSE.
          SET PARAMETER ID 'RBN' FIELD <FS_RAW>-BELNR.
          SET PARAMETER ID 'GJR' FIELD <FS_RAW>-GJAHR.
          CALL TRANSACTION 'MIR4' AND SKIP FIRST SCREEN.
        ENDIF.
      ENDIF.

    WHEN OTHERS.
      IF <FS_RAW>-MBLNR IS NOT INITIAL.
        IF <FS_RAW>-ZSP_CHK EQ C_X.

          SET PARAMETER ID 'BLN' FIELD <FS_RAW>-MBLNR.
          SET PARAMETER ID 'BUK' FIELD <FS_RAW>-BUKRS.
          SET PARAMETER ID 'GJR' FIELD <FS_RAW>-MJAHR.
          CALL TRANSACTION 'FB03' AND SKIP FIRST SCREEN.

        ELSE.
          CALL FUNCTION 'MIGO_DIALOG'
            EXPORTING
              I_ACTION            = 'A04'
              I_REFDOC            = 'R02'
              I_MBLNR             = <FS_RAW>-MBLNR
              I_MJAHR             = <FS_RAW>-MJAHR
            EXCEPTIONS
              ILLEGAL_COMBINATION = 1
              OTHERS              = 2.
          IF SY-SUBRC <> 0.

* Implement suitable error handling here

          ENDIF.
        ENDIF.
      ENDIF.
  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  HANDLE_DOUBLE_CLICK_300
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_E_ROW  text
*      -->P_E_COLUMN  text
*----------------------------------------------------------------------*

FORM HANDLE_DOUBLE_CLICK_300  USING PS_ROW_ID STRUCTURE LVC_S_ROW
                                    PS_COLUMN_ID STRUCTURE LVC_S_COL.

  CHECK PS_ROW_ID-ROWTYPE IS INITIAL.
  READ TABLE GT_SIT_DISP ASSIGNING FIELD-SYMBOL(<FS_SIT>)
                        INDEX PS_ROW_ID-INDEX.

  CHECK SY-SUBRC = 0.

  PERFORM SHOW_GRLIST_DATA CHANGING <FS_SIT>.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ALV_CLASS_REFRESH
*&---------------------------------------------------------------------*

FORM ALV_CLASS_REFRESH  USING P_GRID.

  DATA L_GRID TYPE REF TO CL_GUI_ALV_GRID.
  L_GRID = P_GRID.

* Refresh

  CLEAR GS_ALV_STABLE.
  GS_ALV_STABLE-ROW = 'X'.
  GS_ALV_STABLE-COL = 'X'.

  CALL METHOD L_GRID->REFRESH_TABLE_DISPLAY
    EXPORTING
      IS_STABLE      = GS_ALV_STABLE
      I_SOFT_REFRESH = ''.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  TOP_OF_PAGE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_E_DYNDOC_ID  text
*----------------------------------------------------------------------*

FORM TOP_OF_PAGE  USING   PV_DYNDOC_ID TYPE REF TO CL_DD_DOCUMENT.

  DATA : LV_TEXT(255) TYPE C,
         LV_VTEXT     LIKE TVKOT-VTEXT.

  DATA : LV_SDATE_TX(20),
         LV_EDATE_TX(20).

  CASE SY-DYNNR.
    WHEN '0100'.  "Main data

* Header

      CLEAR : LV_TEXT.
      LV_TEXT = TEXT-100. "[ Valuated Stock Report - Overview  ]
      CALL METHOD GV_ALV_DOCUMENT->ADD_TEXT
        EXPORTING
          TEXT         = LV_TEXT
          SAP_FONTSIZE = CL_DD_DOCUMENT=>LARGE
          SAP_EMPHASIS = CL_DD_AREA=>STRONG.
      CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.

* Period

      CLEAR : LV_TEXT.
      CONCATENATE S_BUDAT-LOW '~' S_BUDAT-HIGH INTO LV_TEXT.
      CONCATENATE 'Period :' LV_TEXT INTO LV_TEXT SEPARATED BY SPACE.
      PERFORM ADD_TEXT USING LV_TEXT.
      CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.

    WHEN '0200'.  "Group doc. data

* Header

      CLEAR : LV_TEXT.
      CASE GS_DISP_SCR-DYNNR.
        WHEN '0100'.
          LV_TEXT = TEXT-110. "[ Valuated Stock Report - Detail ]
        WHEN '0400'.
          LV_TEXT = TEXT-410. "[ Storage Loc./Batch Stock Report - Detail ]
      ENDCASE.
      CALL METHOD GV_ALV_DOCUMENT->ADD_TEXT
        EXPORTING
          TEXT         = LV_TEXT
          SAP_FONTSIZE = CL_DD_DOCUMENT=>LARGE
          SAP_EMPHASIS = CL_DD_AREA=>STRONG.
      CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.

      CLEAR : LV_TEXT.
      CALL FUNCTION 'CONVERSION_EXIT_MATN1_OUTPUT'
        EXPORTING
          INPUT  = GS_DISP_SCR-MATNR
        IMPORTING
          OUTPUT = GS_DISP_SCR-MATNR.
      CONCATENATE 'Material :' GS_DISP_SCR-MATNR '('GS_DISP_SCR-MAKTX')'
                   INTO LV_TEXT SEPARATED BY SPACE.
      PERFORM ADD_TEXT USING LV_TEXT.
      CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.

      SELECT SINGLE NAME1
      INTO @DATA(LV_NAME1)
      FROM T001W
      WHERE WERKS EQ @GS_DISP_SCR-WERKS.

      CLEAR : LV_TEXT.
      CONCATENATE 'Plant :' GS_DISP_SCR-WERKS '('LV_NAME1')'
                   INTO LV_TEXT SEPARATED BY SPACE.
      PERFORM ADD_TEXT USING LV_TEXT.
      CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.

      CASE GS_DISP_SCR-DYNNR.
        WHEN '0400'.

          SELECT SINGLE LGOBE
          INTO @DATA(LV_LGOBE)
          FROM T001L
          WHERE WERKS EQ @GS_DISP_SCR-WERKS
            AND LGORT EQ @GS_DISP_SCR-LGORT.

          CLEAR : LV_TEXT.
          CONCATENATE 'Storage Location :' GS_DISP_SCR-LGORT '('LV_LGOBE')'
                       INTO LV_TEXT SEPARATED BY SPACE.
          PERFORM ADD_TEXT USING LV_TEXT.
          CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.

          CLEAR : LV_TEXT.
          CONCATENATE 'Batch :' GS_DISP_SCR-CHARG
                       INTO LV_TEXT SEPARATED BY SPACE.
          PERFORM ADD_TEXT USING LV_TEXT.
          CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.
      ENDCASE.

      CLEAR : LV_TEXT.
      LV_TEXT = GV_TITLE_200.
      PERFORM ADD_TEXT USING LV_TEXT.
      CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.

    WHEN '0300'.  "Sit data

      CLEAR : LV_TEXT.
      CALL FUNCTION 'CONVERSION_EXIT_MATN1_OUTPUT'
        EXPORTING
          INPUT  = GS_DISP_SCR-MATNR
        IMPORTING
          OUTPUT = GS_DISP_SCR-MATNR.
      CONCATENATE 'Material :' GS_DISP_SCR-MATNR '('GS_DISP_SCR-MAKTX')'
                   INTO LV_TEXT SEPARATED BY SPACE.
      PERFORM ADD_TEXT USING LV_TEXT.
      CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.

      CLEAR : LV_TEXT.
      CONCATENATE 'Plant :' GS_DISP_SCR-WERKS
                   INTO LV_TEXT SEPARATED BY SPACE.
      PERFORM ADD_TEXT USING LV_TEXT.
      CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.

* Period

      WRITE GV_SDATE_PO TO LV_SDATE_TX.
      CONDENSE LV_SDATE_TX NO-GAPS.
      WRITE GV_EDATE_PO TO LV_EDATE_TX.
      CONDENSE LV_EDATE_TX NO-GAPS.

      CLEAR : LV_TEXT.
      CONCATENATE 'Period :' LV_SDATE_TX '~' LV_EDATE_TX
                   INTO LV_TEXT SEPARATED BY SPACE.
      PERFORM ADD_TEXT USING LV_TEXT.
      CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.

    WHEN '0400'.  "Batch data

* Header

      CLEAR : LV_TEXT.
      LV_TEXT = TEXT-400. "[ Storage Loc./Batch Stock Report - Overview ]
      CALL METHOD GV_ALV_DOCUMENT->ADD_TEXT
        EXPORTING
          TEXT         = LV_TEXT
          SAP_FONTSIZE = CL_DD_DOCUMENT=>LARGE
          SAP_EMPHASIS = CL_DD_AREA=>STRONG.
      CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.

* Period

      CLEAR : LV_TEXT.
      CONCATENATE S_BUDAT-LOW '~' S_BUDAT-HIGH INTO LV_TEXT.
      CONCATENATE 'Period :' LV_TEXT INTO LV_TEXT SEPARATED BY SPACE.
      PERFORM ADD_TEXT USING LV_TEXT.
      CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.

*      " Amount

    WHEN '0500'.  "Sit data

* Header

      CLEAR : LV_TEXT.
      LV_TEXT = TEXT-500. "[ detail view ]
      CALL METHOD GV_ALV_DOCUMENT->ADD_TEXT
        EXPORTING
          TEXT         = LV_TEXT
          SAP_FONTSIZE = CL_DD_DOCUMENT=>LARGE
          SAP_EMPHASIS = CL_DD_AREA=>STRONG.
      CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.

* Period

      WRITE GV_SDATE_PO TO LV_SDATE_TX.
      CONDENSE LV_SDATE_TX NO-GAPS.
      WRITE GV_EDATE_PO TO LV_EDATE_TX.
      CONDENSE LV_EDATE_TX NO-GAPS.

      CLEAR : LV_TEXT.
      CONCATENATE 'Period :' S_BUDAT-LOW '~' S_BUDAT-HIGH
                   INTO LV_TEXT SEPARATED BY SPACE.
      PERFORM ADD_TEXT USING LV_TEXT.
      CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.
  ENDCASE.

  PERFORM HTML_DISPLAY .

ENDFORM.

*&---------------------------------------------------------------------*
*& Form BUFFER_CLEAR_PROC
*&---------------------------------------------------------------------*
*& BUFFER CLEAR
*&---------------------------------------------------------------------*

FORM BUFFER_CLEAR_PROC  USING    PV_REPID
                                 PV_ITNAM.
  DATA: L_MEMORY_ID_CLEAR TYPE STRING,                      "Y7AK023435
        L_MEMORY_ID_HASH  TYPE HASH160.

  CONCATENATE PV_REPID PV_ITNAM INTO L_MEMORY_ID_CLEAR.

  CALL FUNCTION 'CALCULATE_HASH_FOR_CHAR'
    EXPORTING
      DATA   = L_MEMORY_ID_CLEAR                            "RULE 이 Pgm명 + I/T 명
    IMPORTING
      HASH   = L_MEMORY_ID_HASH                             "버퍼 ID : 동적인 내용 이겠쥐~
    EXCEPTIONS
      OTHERS = 4.

  IF SY-SUBRC = 0.
    FREE MEMORY ID L_MEMORY_ID_HASH.                        "Y7AK023435
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form BUILD_CATEGORY_400
*&---------------------------------------------------------------------*
*& 400 Screen Field Cat.
*&---------------------------------------------------------------------*

FORM BUILD_CATEGORY_400  CHANGING PT_ALV_FIELDCAT TYPE LVC_T_FCAT.

  LOOP AT PT_ALV_FIELDCAT ASSIGNING <FS_ALV_FIELDCAT>.
    CLEAR <FS_ALV_FIELDCAT>-KEY.

    CASE <FS_ALV_FIELDCAT>-FIELDNAME.
      WHEN 'BUKRS'. " 회사코드
        <FS_ALV_FIELDCAT>-COL_POS = 1.
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F50.
        <FS_ALV_FIELDCAT>-KEY = C_X.

*      WHEN 'MAT_DESC'. " 자재명

      WHEN 'MATNR'. " 자재
        <FS_ALV_FIELDCAT>-COL_POS = 2.
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F51.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'WERKS'. " 플랜트
        <FS_ALV_FIELDCAT>-COL_POS = 3.
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F58.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'LGORT'.
        <FS_ALV_FIELDCAT>-COL_POS = 4.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'LGOBE'.
        <FS_ALV_FIELDCAT>-COL_POS = 5.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'LIFNR'. " 임가공업체
        <FS_ALV_FIELDCAT>-COL_POS = 6.
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F59.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'LIFNR_TX'. " 업체명
        <FS_ALV_FIELDCAT>-COL_POS = 7.
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F60.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'CHARG'.
        <FS_ALV_FIELDCAT>-COL_POS = 8.
        <FS_ALV_FIELDCAT>-KEY = C_X.

      WHEN 'ZZPOR'.
        <FS_ALV_FIELDCAT>-COL_POS = 9.
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F81.

      WHEN 'ZZSTOCKCD_TX'.
        <FS_ALV_FIELDCAT>-COL_POS = 10.
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F82.

      WHEN 'MATKL'.
        <FS_ALV_FIELDCAT>-COL_POS = 11.
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F83.

      WHEN 'MAKTX'. " 자재명
        <FS_ALV_FIELDCAT>-COL_POS = 12.
        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F52.
        <FS_ALV_FIELDCAT>-NO_OUT = C_X.

      WHEN 'CLABS'. " 현재고
        <FS_ALV_FIELDCAT>-EMPHASIZE  = 'C500'.
        <FS_ALV_FIELDCAT>-COLTEXT    = TEXT-F62.
        <FS_ALV_FIELDCAT>-QFIELDNAME = 'MEINS'.

* batch key Start - screen 0400

      WHEN 'SQR'.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'SOBKZ'.
        <FS_ALV_FIELDCAT>-KEY = C_X.
      WHEN 'PARTNER'.

      WHEN 'NAME_ORG1'.

        <FS_ALV_FIELDCAT>-REPTEXT = TEXT-F63.

* batch key end

      WHEN 'MEINS'.

      WHEN 'WAERS'.

      WHEN 'INFO'.
        <FS_ALV_FIELDCAT>-COL_POS = 998.
      WHEN 'MARK'.
        <FS_ALV_FIELDCAT>-COL_POS = 999.

      WHEN 'XXXX'.
        <FS_ALV_FIELDCAT>-NO_OUT = C_X.
    ENDCASE.

  ENDLOOP.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form HANDLER_TOOLBAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*

FORM HANDLER_TOOLBAR USING PO_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET
                           PO_SENDER TYPE REF TO CL_GUI_ALV_GRID.

  " Internal Table PO_OBJECT->MT_TOOLBAR 를 위한 작업공간
  " PO_OBJECT->MT_TOOLBAR >>> 클래스의 Attribute ( Public , Instance )
  DATA LS_TOOLBAR LIKE LINE OF PO_OBJECT->MT_TOOLBAR.

  DATA : LV_INVOICE TYPE I,
         LV_OK      TYPE I,
         LV_ING     TYPE I,
         LV_NO      TYPE I.

  CASE PO_SENDER.
    WHEN GV_ALV_GRID_100.

* 구분자 =>> |

      CLEAR LS_TOOLBAR.
      LS_TOOLBAR-BUTN_TYPE = 3. " 구분자
      APPEND LS_TOOLBAR TO PO_OBJECT->MT_TOOLBAR.

* 버튼 추가 =>> 전체조회

      CLEAR LS_TOOLBAR.
      LS_TOOLBAR-BUTN_TYPE = 0. " 사용가능 배치번호 O/X
      LS_TOOLBAR-FUNCTION = GC_INVOICE.
      LS_TOOLBAR-ICON = ICON_SELECT_DETAIL.
      LS_TOOLBAR-TEXT = TEXT-B11.
      APPEND LS_TOOLBAR TO PO_OBJECT->MT_TOOLBAR.

  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form HANDLE_USER_COMMAND_100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*

FORM HANDLE_USER_COMMAND_100  USING PV_UCOMM   TYPE SY-UCOMM
                                    PO_SENDER  TYPE REF TO CL_GUI_ALV_GRID.

  DATA LT_INDEX_ROWS TYPE LVC_T_ROW.
  DATA LS_INDEX_ROW  LIKE LINE OF LT_INDEX_ROWS.
  DATA LS_MATDOC     LIKE LINE OF GT_DISP_0500.
  DATA LS_GROUP      LIKE LINE OF GT_GROUP.
  DATA: LT_TABLE TYPE REF TO DATA,
        LS_TABLE TYPE REF TO DATA.

  FIELD-SYMBOLS: <LS_TABLE> TYPE ANY,
                 <FS_BUKRS> TYPE ANY,
                 <FS_WERKS> TYPE ANY,
                 <FS_MATNR> TYPE ANY,
                 <LS_DISP>  TYPE ANY,
                 <FS_LIFNR> TYPE ANY.

  CREATE DATA LS_TABLE LIKE LINE OF <GT_TABLE>.
  ASSIGN LS_TABLE->* TO <LS_DISP>.

  CASE PO_SENDER.
    WHEN GV_ALV_GRID_100.

      CASE PV_UCOMM.
        WHEN GC_INVOICE.

          CALL METHOD GV_ALV_GRID_100->GET_SELECTED_ROWS
            IMPORTING
              ET_INDEX_ROWS = LT_INDEX_ROWS.     " Indexes of Selected Rows

          IF LT_INDEX_ROWS[] IS INITIAL.
            " Select line to display detail item.
            MESSAGE S081 DISPLAY LIKE 'E'.
          ELSE.

            CLEAR: GT_MATDOC[], GT_DISP_0500[].

            LOOP AT LT_INDEX_ROWS INTO LS_INDEX_ROW WHERE ROWTYPE IS INITIAL.

*             <GS_TABLE>.

              READ TABLE <GT_TABLE> INTO <LS_DISP> INDEX LS_INDEX_ROW-INDEX.

              ASSIGN COMPONENT: 'BUKRS' OF STRUCTURE <LS_DISP> TO <FS_BUKRS>,
                                'WERKS' OF STRUCTURE <LS_DISP> TO <FS_WERKS>,
                                'MATNR' OF STRUCTURE <LS_DISP> TO <FS_MATNR>,
                                'LIFNR' OF STRUCTURE <LS_DISP> TO <FS_LIFNR>.

* Read Matdoc

              SELECT A~BUKRS          " 회사코드
                     A~MJAHR          " 자재문서연도
                     A~MBLNR          " 자재문서번호
                     A~MATNR          " 자재번호
                     B~MAKTX          " 자재내역(명)
                     A~WERKS          " 플랜트
                     A~LGORT          " 저장위치
                     A~CHARG          " 배치(Batch)
                     A~SOBKZ          " 특별재고지시자
                     A~EMLIF     AS LIFNR
                     D~NAME_ORG1 AS LIFNR_TX " 공급처명
                     A~MENGE          " 수량
                     A~DMBTR          " 금액(현지통화)
                     A~WAERS          " 통화
                     A~BWART          " 이동유형

*                     H~BEIKZ           " MPI 추가

                     A~GRUND          " 이동사유
                     A~SHKZG          " 차변/대변 지시자
                     A~MEINS          " 기본단위
                     A~WAERS          " 통화
                     A~ZEILE          " 자재문서항목
                     E~MTART          " 자재유형
                     A~VGART            "CHECK
                     A~BUDAT            " 전기일 추가
                     A~SALK3          " 총평가액
                     A~LBKUM          " 총평가재고수량

                INTO CORRESPONDING FIELDS OF TABLE GT_DISP_0500
                FROM MATDOC AS A
                LEFT OUTER JOIN MAKT AS B
                  ON B~MATNR EQ A~MATNR
                 AND B~SPRAS EQ SY-LANGU
                LEFT OUTER JOIN BUT000 AS D
                  ON D~PARTNER EQ A~EMLIF
                LEFT OUTER JOIN MARA AS E
                  ON E~MATNR EQ A~MATNR
                JOIN ZMMPAT52010 AS H
                  ON H~BWART EQ A~BWART
               WHERE A~RECORD_TYPE EQ 'MDOC'
                 AND A~BUDAT BETWEEN S_BUDAT-LOW AND S_BUDAT-HIGH
                 AND A~MATNR EQ <FS_MATNR>
                 AND A~WERKS EQ <FS_WERKS>
                 AND A~EMLIF EQ <FS_LIFNR>
                 AND A~CHARG IN GR_CHARG
                 AND A~SOBKZ EQ 'O'.

              APPEND LINES OF GT_DISP_0500 TO GT_MATDOC[].
              CLEAR GT_DISP_0500[].
            ENDLOOP.

            IF GT_MATDOC[] IS INITIAL.
              " No data found
              MESSAGE S082 DISPLAY LIKE 'E'.
              EXIT.
            ENDIF.

*--STO 금액 변환

            DATA(LT_STO) = GT_MATDOC[].
            DELETE LT_STO WHERE DMBTR NE 0.
            DELETE LT_STO WHERE BWART NE '101'.

            SELECT A~MJAHR,           " 자재문서연도
                   A~MBLNR,           " 자재문서번호
                   A~ZEILE,           " 자재문서항목
                   A~MATNR,           " 자재번호
                   A~WERKS,           " 플랜트
                   A~LGORT_CID AS LGORT, " 저장위치
                   A~CHARG_CID AS CHARG, " 배치(Batch)
                   A~DMBTR            " 금액(현지통화)
              FROM MATDOC AS A JOIN @LT_STO AS B
                                 ON A~MJAHR     = B~MJAHR
                                AND A~MBLNR     = B~MBLNR
                                AND A~ZEILE     = B~ZEILE
                                AND A~MATNR     = B~MATNR
                                AND A~WERKS     = B~WERKS
                                AND A~LGORT_CID = B~LGORT
                                AND A~CHARG_CID = B~CHARG
             WHERE A~RECORD_TYPE = 'MDOC_CP'
               AND A~LBBSA_SID   = '06'
               AND A~DMBTR NE 0
              INTO TABLE @DATA(LT_STO_DMBTR).
            SORT LT_STO_DMBTR BY MJAHR MBLNR ZEILE MATNR WERKS LGORT CHARG.

*-- Group 및 차/대 반영

            LOOP AT GT_MATDOC[] INTO LS_MATDOC.

*--STO 금액 변환

              IF LS_MATDOC-BWART = '101' AND LS_MATDOC-DMBTR = 0.
                READ TABLE LT_STO_DMBTR INTO DATA(LS_STO_DMBTR) WITH KEY MJAHR = LS_MATDOC-MJAHR
                                                                         MBLNR = LS_MATDOC-MBLNR
                                                                         ZEILE = LS_MATDOC-ZEILE
                                                                         MATNR = LS_MATDOC-MATNR
                                                                         WERKS = LS_MATDOC-WERKS
                                                                         LGORT = LS_MATDOC-LGORT
                                                                         CHARG = LS_MATDOC-CHARG
                                                                         BINARY SEARCH.
                IF SY-SUBRC = 0.
                  LS_MATDOC-DMBTR = LS_STO_DMBTR-DMBTR.
                ENDIF.
              ENDIF.
              CLEAR LS_STO_DMBTR.

              READ TABLE GT_GROUP INTO LS_GROUP
                                  WITH KEY BWART = LS_MATDOC-BWART
                                  BINARY SEARCH.
              IF SY-SUBRC NE 0.
                CASE LS_MATDOC-SHKZG.
                  WHEN 'H'.
                    LS_MATDOC-ZGROUP = GV_GI_ETC.
                  WHEN 'S'.
                    LS_MATDOC-ZGROUP = GV_GR_ETC.
                ENDCASE.
              ELSE.
                LS_MATDOC-ZGROUP = LS_GROUP-ZGROUP.
              ENDIF.

              IF ( LS_MATDOC-ZGROUP(2) = 'GR' AND LS_MATDOC-SHKZG = 'H' ) OR
                 ( LS_MATDOC-ZGROUP(2) = 'GI' AND LS_MATDOC-SHKZG = 'H' ).
                LS_MATDOC-MENGE = LS_MATDOC-MENGE * -1.
                LS_MATDOC-DMBTR = LS_MATDOC-DMBTR * -1.
              ELSE.

*              <FS_RAW>-MENGE.
*              <FS_RAW>-DMBTR.

              ENDIF.

              CASE LS_MATDOC-BWART.
                WHEN '541'.
                  LS_MATDOC-SALK3 = LS_MATDOC-SALK3 / LS_MATDOC-LBKUM.
                  LS_MATDOC-DMBTR = LS_MATDOC-MENGE * LS_MATDOC-SALK3.

                WHEN '542'.
                  LS_MATDOC-SALK3 = LS_MATDOC-SALK3 / LS_MATDOC-LBKUM.
                  LS_MATDOC-DMBTR = LS_MATDOC-MENGE * LS_MATDOC-SALK3.

              ENDCASE.

*-- Mvt.Text 추가

              SELECT SINGLE BTEXT
                     INTO @DATA(LV_BTEXT)
                     FROM T156T
                     WHERE BWART EQ @LS_MATDOC-BWART
                       AND SPRAS EQ @SY-LANGU.

              LS_MATDOC-BTEXT = LV_BTEXT.

              APPEND LS_MATDOC TO GT_DISP_0500.
            ENDLOOP.

*-- 정의된 Mvt에 포함되지 않은 값은 Delete

            LOOP AT GT_DISP_0500 ASSIGNING FIELD-SYMBOL(<FS_DISP_0500>).

              READ TABLE GT_GROUP WITH KEY BWART = <FS_DISP_0500>-BWART
                                  TRANSPORTING NO FIELDS
                                  BINARY SEARCH.

              IF SY-SUBRC <> 0.
                DELETE TABLE GT_DISP_0500 FROM <FS_DISP_0500>.

              ENDIF.

              IF <FS_DISP_0500>-MENGE < 0.
                <FS_DISP_0500>-INFO = 'C600'.
              ELSE.
                <FS_DISP_0500>-INFO = 'C100'.
              ENDIF.

            ENDLOOP.

            SORT GT_DISP_0500 BY BUDAT LIFNR MATNR CHARG.

            CALL SCREEN 0500 STARTING AT 10 2
            ENDING AT 170 30.

          ENDIF.
      ENDCASE.
  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form HANDLER_TOOLBAR_0400
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_OBJECT
*&      --> SENDER
*&---------------------------------------------------------------------*

FORM HANDLER_TOOLBAR_0400 USING PO_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET
                                PO_SENDER TYPE REF TO CL_GUI_ALV_GRID.

  " Internal Table PO_OBJECT->MT_TOOLBAR 를 위한 작업공간
  " PO_OBJECT->MT_TOOLBAR >>> 클래스의 Attribute ( Public , Instance )
  DATA LS_TOOLBAR LIKE LINE OF PO_OBJECT->MT_TOOLBAR.

  DATA : LV_INVOICE TYPE I,
         LV_OK      TYPE I,
         LV_ING     TYPE I,
         LV_NO      TYPE I.

  CASE PO_SENDER.
    WHEN GV_ALV_GRID_400.

* 구분자 =>> |

      CLEAR LS_TOOLBAR.
      LS_TOOLBAR-BUTN_TYPE = 3. " 구분자
      APPEND LS_TOOLBAR TO PO_OBJECT->MT_TOOLBAR.

* 버튼 추가 =>> 전체조회

      CLEAR LS_TOOLBAR.
      LS_TOOLBAR-BUTN_TYPE = 0. " 사용가능 배치번호 O/X
      LS_TOOLBAR-FUNCTION = GC_INVOICE.
      LS_TOOLBAR-ICON = ICON_SELECT_DETAIL.
      LS_TOOLBAR-TEXT = TEXT-B11.
      APPEND LS_TOOLBAR TO PO_OBJECT->MT_TOOLBAR.

  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form HANDLE_USER_COMMAND_400
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_UCOMM
*&      --> SENDER
*&---------------------------------------------------------------------*

FORM HANDLE_USER_COMMAND_400  USING PV_UCOMM   TYPE SY-UCOMM
                                    PO_SENDER  TYPE REF TO CL_GUI_ALV_GRID.

  DATA LT_INDEX_ROWS TYPE LVC_T_ROW.
  DATA LS_INDEX_ROW  LIKE LINE OF LT_INDEX_ROWS.
  DATA LS_MATDOC     LIKE LINE OF GT_DISP_0500.
  DATA LS_GROUP      LIKE LINE OF GT_GROUP.
  DATA: LT_TABLE TYPE REF TO DATA,
        LS_TABLE TYPE REF TO DATA.

  FIELD-SYMBOLS: <LS_TABLE> TYPE ANY,
                 <FS_BUKRS> TYPE ANY,
                 <FS_WERKS> TYPE ANY,
                 <FS_LGORT> TYPE ANY,
                 <FS_MATNR> TYPE ANY,
                 <LS_DISP>  TYPE ANY,
                 <FS_LIFNR> TYPE ANY,
                 <FS_CHARG> TYPE ANY.

  CREATE DATA LS_TABLE LIKE LINE OF <GT_BATCH>.
  ASSIGN LS_TABLE->* TO <LS_DISP>.

  CASE PO_SENDER.
    WHEN GV_ALV_GRID_400.

      CASE PV_UCOMM.
        WHEN GC_INVOICE.

          CALL METHOD GV_ALV_GRID_400->GET_SELECTED_ROWS
            IMPORTING
              ET_INDEX_ROWS = LT_INDEX_ROWS.     " Indexes of Selected Rows

          IF LT_INDEX_ROWS[] IS INITIAL.
            " Select line to display detail item.
            MESSAGE S081 DISPLAY LIKE 'E'.
          ELSE.

            CLEAR: GT_MATDOC[], GT_DISP_0500[].

            LOOP AT LT_INDEX_ROWS INTO LS_INDEX_ROW WHERE ROWTYPE IS INITIAL.

*             <GS_TABLE>.

              READ TABLE <GT_BATCH> INTO <LS_DISP> INDEX LS_INDEX_ROW-INDEX.

              ASSIGN COMPONENT: 'BUKRS' OF STRUCTURE <LS_DISP> TO <FS_BUKRS>,
                                'WERKS' OF STRUCTURE <LS_DISP> TO <FS_WERKS>,
                                'LGORT' OF STRUCTURE <LS_DISP> TO <FS_LGORT>,
                                'MATNR' OF STRUCTURE <LS_DISP> TO <FS_MATNR>,
                                'LIFNR' OF STRUCTURE <LS_DISP> TO <FS_LIFNR>,
                                'CHARG' OF STRUCTURE <LS_DISP> TO <FS_CHARG>.

* Read Matdoc
* 사급업체 없으면 일반 케이스 라인

              IF <FS_LIFNR> IS INITIAL.
                SELECT A~BUKRS        " 회사코드
                       A~MJAHR        " 자재문서연도
                       A~MBLNR        " 자재문서번호
                       A~MATNR        " 자재번호
                       B~MAKTX        " 자재내역(명)
                       A~WERKS        " 플랜트
                       A~LGORT        " 저장위치
                       A~CHARG        " 배치(Batch)
                       A~SOBKZ        " 특별재고지시자
                       A~EMLIF     AS LIFNR
                       D~NAME_ORG1 AS LIFNR_TX " 공급처명
                       A~MENGE        " 수량
                       A~DMBTR        " 금액(현지통화)
                       A~WAERS        " 통화
                       A~BWART        " 이동유형

*                     H~BEIKZ           " MPI 추가

                       A~GRUND        " 이동사유
                       A~SHKZG        " 차변/대변 지시자
                       A~MEINS        " 기본단위
                       A~WAERS        " 통화
                       A~ZEILE        " 자재문서항목
                       E~MTART        " 자재유형
                       A~VGART            "CHECK
                       A~BUDAT            " 전기일 추가
                       A~SALK3        " 총평가액
                       A~LBKUM        " 총평가재고수량

                  INTO CORRESPONDING FIELDS OF TABLE GT_DISP_0500
                  FROM MATDOC AS A
                  LEFT OUTER JOIN MAKT AS B
                    ON B~MATNR EQ A~MATNR
                   AND B~SPRAS EQ SY-LANGU
                  LEFT OUTER JOIN BUT000 AS D
                    ON D~PARTNER EQ A~EMLIF
                  LEFT OUTER JOIN MARA AS E
                    ON E~MATNR EQ A~MATNR
                  JOIN ZMMPAT52010 AS H
                    ON H~BWART EQ A~BWART
                 WHERE A~RECORD_TYPE EQ 'MDOC'
                   AND A~BUDAT BETWEEN S_BUDAT-LOW AND S_BUDAT-HIGH
                   AND A~MATNR EQ <FS_MATNR>
                   AND A~WERKS EQ <FS_WERKS>
                   AND A~LGORT EQ <FS_LGORT>

                   AND A~CHARG EQ <FS_CHARG>

*                   AND A~BWART NOT IN ('541', '542', '543', '544'). " 사급 mvt 제외

                 AND A~SOBKZ NE 'O'. " 사급 제외

                APPEND LINES OF GT_DISP_0500 TO GT_MATDOC[].
                CLEAR GT_DISP_0500[].

              ELSE.

* 사급업체 있으면 사급 케이스 라인
*541, 542, 543, 544만

                SELECT A~BUKRS        " 회사코드
                       A~MJAHR        " 자재문서연도
                       A~MBLNR        " 자재문서번호
                       A~MATNR        " 자재번호
                       B~MAKTX        " 자재내역(명)
                       A~WERKS        " 플랜트
                       A~LGORT        " 저장위치
                       A~CHARG        " 배치(Batch)
                       A~SOBKZ        " 특별재고지시자
                       A~EMLIF     AS LIFNR
                       D~NAME_ORG1 AS LIFNR_TX " 공급처명
                       A~MENGE        " 수량
                       A~DMBTR        " 금액(현지통화)
                       A~WAERS        " 통화
                       A~BWART        " 이동유형

*                     H~BEIKZ           " MPI 추가

                       A~GRUND        " 이동사유
                       A~SHKZG        " 차변/대변 지시자
                       A~MEINS        " 기본단위
                       A~WAERS        " 통화
                       A~ZEILE        " 자재문서항목
                       E~MTART        " 자재유형
                       A~VGART            "CHECK
                       A~BUDAT            " 전기일 추가
                       A~SALK3        " 총평가액
                       A~LBKUM        " 총평가재고수량

                  INTO CORRESPONDING FIELDS OF TABLE GT_DISP_0500
                  FROM MATDOC AS A
                  LEFT OUTER JOIN MAKT AS B
                    ON B~MATNR EQ A~MATNR
                   AND B~SPRAS EQ SY-LANGU
                  LEFT OUTER JOIN BUT000 AS D
                    ON D~PARTNER EQ A~EMLIF
                  LEFT OUTER JOIN MARA AS E
                    ON E~MATNR EQ A~MATNR
                  JOIN ZMMPAT52010 AS H
                    ON H~BWART EQ A~BWART
                 WHERE A~RECORD_TYPE EQ 'MDOC'
                   AND A~BUDAT BETWEEN S_BUDAT-LOW AND S_BUDAT-HIGH
                   AND A~MATNR EQ <FS_MATNR>
                   AND A~WERKS EQ <FS_WERKS>
                   AND A~LGORT EQ <FS_LGORT>
                   AND A~EMLIF EQ <FS_LIFNR>
                   AND A~CHARG EQ <FS_CHARG>

*                   AND A~BWART IN ('541', '542', '543', '544'). " 사급 mvt만

                 AND A~SOBKZ EQ 'O'. " 사급재고만

                APPEND LINES OF GT_DISP_0500 TO GT_MATDOC[].
                CLEAR GT_DISP_0500[].
              ENDIF.
            ENDLOOP.

            IF GT_MATDOC[] IS INITIAL.
              " No data found
              MESSAGE S082 DISPLAY LIKE 'E'.
              EXIT.
            ENDIF.

*--STO 금액 변환

            DATA(LT_STO) = GT_MATDOC[].
            DELETE LT_STO WHERE DMBTR NE 0.
            DELETE LT_STO WHERE BWART NE '101'.

            SELECT A~MJAHR,           " 자재문서연도
                   A~MBLNR,           " 자재문서번호
                   A~ZEILE,           " 자재문서항목
                   A~MATNR,           " 자재번호
                   A~WERKS,           " 플랜트
                   A~LGORT_CID AS LGORT, " 저장위치
                   A~CHARG_CID AS CHARG, " 배치(Batch)
                   A~DMBTR            " 금액(현지통화)
              FROM MATDOC AS A JOIN @LT_STO AS B
                                 ON A~MJAHR     = B~MJAHR
                                AND A~MBLNR     = B~MBLNR
                                AND A~ZEILE     = B~ZEILE
                                AND A~MATNR     = B~MATNR
                                AND A~WERKS     = B~WERKS
                                AND A~LGORT_CID = B~LGORT
                                AND A~CHARG_CID = B~CHARG
             WHERE A~RECORD_TYPE = 'MDOC_CP'
               AND A~LBBSA_SID   = '06'
               AND A~DMBTR NE 0
              INTO TABLE @DATA(LT_STO_DMBTR).
            SORT LT_STO_DMBTR BY MJAHR MBLNR ZEILE MATNR WERKS LGORT CHARG.

*-- Group 및 차/대 반영

            LOOP AT GT_MATDOC[] INTO LS_MATDOC.

*--STO 금액 변환

              IF LS_MATDOC-BWART = '101' AND LS_MATDOC-DMBTR = 0.
                READ TABLE LT_STO_DMBTR INTO DATA(LS_STO_DMBTR) WITH KEY MJAHR = LS_MATDOC-MJAHR
                                                                         MBLNR = LS_MATDOC-MBLNR
                                                                         ZEILE = LS_MATDOC-ZEILE
                                                                         MATNR = LS_MATDOC-MATNR
                                                                         WERKS = LS_MATDOC-WERKS
                                                                         LGORT = LS_MATDOC-LGORT
                                                                         CHARG = LS_MATDOC-CHARG
                                                                         BINARY SEARCH.
                IF SY-SUBRC = 0.
                  LS_MATDOC-DMBTR = LS_STO_DMBTR-DMBTR.
                ENDIF.
              ENDIF.
              CLEAR LS_STO_DMBTR.

              READ TABLE GT_GROUP INTO LS_GROUP
                                  WITH KEY BWART = LS_MATDOC-BWART
                                  BINARY SEARCH.
              IF SY-SUBRC NE 0.
                CASE LS_MATDOC-SHKZG.
                  WHEN 'H'.
                    LS_MATDOC-ZGROUP = GV_GI_ETC.
                  WHEN 'S'.
                    LS_MATDOC-ZGROUP = GV_GR_ETC.
                ENDCASE.
              ELSE.
                LS_MATDOC-ZGROUP = LS_GROUP-ZGROUP.
              ENDIF.

              IF ( LS_MATDOC-ZGROUP(2) = 'GR' AND LS_MATDOC-SHKZG = 'H' ) OR
                 ( LS_MATDOC-ZGROUP(2) = 'GI' AND LS_MATDOC-SHKZG = 'H' ).
                LS_MATDOC-MENGE = LS_MATDOC-MENGE * -1.
                LS_MATDOC-DMBTR = LS_MATDOC-DMBTR * -1.
              ELSE.

*              <FS_RAW>-MENGE.
*              <FS_RAW>-DMBTR.

              ENDIF.

*

*-- Mvt.Text 추가

              SELECT SINGLE BTEXT
                     INTO @DATA(LV_BTEXT)
                     FROM T156T
                     WHERE BWART EQ @LS_MATDOC-BWART
                       AND SPRAS EQ @SY-LANGU.

              LS_MATDOC-BTEXT = LV_BTEXT.

**-- 생산오더 Number select
*                  INTO CORRESPONDING FIELDS OF LS_MATDOC

              APPEND LS_MATDOC TO GT_DISP_0500.
            ENDLOOP.

*-- 정의된 Mvt에 포함되지 않은 값은 Delete

            LOOP AT GT_DISP_0500 ASSIGNING FIELD-SYMBOL(<FS_DISP_0500>).

              READ TABLE GT_GROUP WITH KEY BWART = <FS_DISP_0500>-BWART TRANSPORTING NO FIELDS.

              IF SY-SUBRC <> 0.
                DELETE TABLE GT_DISP_0500 FROM <FS_DISP_0500>.

              ENDIF.

              IF <FS_DISP_0500>-MENGE < 0.
                <FS_DISP_0500>-INFO = 'C600'.
              ELSE.
                <FS_DISP_0500>-INFO = 'C100'.
              ENDIF.

            ENDLOOP.

            SORT GT_DISP_0500 BY WERKS LIFNR MATNR BUDAT.

            CALL SCREEN 0500 STARTING AT 10 2
            ENDING AT 170 30.

          ENDIF.
      ENDCASE.
  ENDCASE.

ENDFORM.

Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2026. Sap Release 755

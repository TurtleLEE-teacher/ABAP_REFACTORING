# 🧹 죽은 주석코드 정리 로그 (F02 + 소형 INCLUDE)

## zmmpar52000f02  — 제거 252줄, 컬럼주석 82개
<details><summary>제거 라인</summary>

```
*  CALL METHOD gv_alv_splitter->get_container
*      row       = 3
*      column    = 1
*      container = gv_splitter_bottom.
*      i_parent = gv_splitter_bottom.
*      link_dynnr    = sy-dynnr
*      link_repid    = sy-repid
*      metric        = cntl_metric_dynpro
*      parent        = gv_docking_container_100
*      orientation   = 0
*      sash_position = 60
*      with_border   = '1'.
**     name          = 'CC_0100'.
*  gv_splitter_top    = gv_splitter_container_100->top_left_container.
*  gv_splitter_bottom = gv_splitter_container_100->bottom_right_container.
*      i_parent = gv_splitter_top.
*      i_parent = gv_splitter_bottom.
*              cl_gui_alv_grid=>mc_fc_call_xxl,
*              cl_gui_alv_grid=>mc_fc_col_invisible,
*              cl_gui_alv_grid=>mc_fc_col_optimize,
*              cl_gui_alv_grid=>mc_fc_current_variant,
*              cl_gui_alv_grid=>mc_fc_data_save,
*              cl_gui_alv_grid=>mc_fc_delete_filter,
*              cl_gui_alv_grid=>mc_fc_deselect_all,
*               cl_gui_alv_grid=>mc_fc_detail,
*              cl_gui_alv_grid=>mc_fc_filter,
*              cl_gui_alv_grid=>mc_fc_find,
*              cl_gui_alv_grid=>mc_fc_fix_columns,
*              cl_gui_alv_grid=>mc_fc_load_variant,
*              cl_gui_alv_grid=>mc_fc_loc_copy,
*              cl_gui_alv_grid=>mc_fc_html,
*              cl_gui_alv_grid=>mc_fc_loc_move_row,
*              cl_gui_alv_grid=>mc_fc_maintain_variant,
*              cl_gui_alv_grid=>mc_fc_maximum,
*              cl_gui_alv_grid=>mc_fc_minimum,
*              cl_gui_alv_grid=>mc_fc_pc_file,
*              cl_gui_alv_grid=>mc_fc_print,
*              cl_gui_alv_grid=>mc_fc_print_back,
*              cl_gui_alv_grid=>mc_fc_print_prev,
*              cl_gui_alv_grid=>mc_fc_reprep,
*              cl_gui_alv_grid=>mc_fc_save_variant,
*              cl_gui_alv_grid=>mc_fc_select_all,
*              cl_gui_alv_grid=>mc_fc_send,
*              cl_gui_alv_grid=>mc_fc_separator,
*              cl_gui_alv_grid=>mc_fc_sort,
*              cl_gui_alv_grid=>mc_fc_sort_asc,
*              cl_gui_alv_grid=>mc_fc_sort_dsc,
*              cl_gui_alv_grid=>mc_fc_subtot,
*              cl_gui_alv_grid=>mc_mb_sum,
*              cl_gui_alv_grid=>mc_fc_sum,
*              cl_gui_alv_grid=>mc_fc_to_office,
*              cl_gui_alv_grid=>mc_fc_to_rep_tree,
*              cl_gui_alv_grid=>mc_fc_unfix_columns,
*              cl_gui_alv_grid=>mc_fc_views,
*              cl_gui_alv_grid=>mc_fc_view_crystal,
*              cl_gui_alv_grid=>mc_fc_view_excel,
*              cl_gui_alv_grid=>mc_fc_view_grid,
* PS_LVC_LAYO-SMALLTITLE = 'X'.
* PS_LVC_LAYO-GRID_TITLE = .
* PS_LVC_LAYO-NO_ROWMARK = 'X'.
*  PS_LVC_LAYO-CWIDTH_OPT = 'X'.
*  PS_LVC_LAYO-COL_OPT    = 'X'.
* PS_LVC_LAYO-SMALLTITLE = 'X'.
* PS_LVC_LAYO-GRID_TITLE = .
* PS_LVC_LAYO-SMALLTITLE = 'X'.
* PS_LVC_LAYO-GRID_TITLE = .
* PS_LVC_LAYO-SMALLTITLE = 'X'.
* PS_LVC_LAYO-GRID_TITLE = .
*  PS_LVC_LAYO-BOX_FNAME  = 'MARK'.
*  PS_LVC_LAYO-NO_ROWMARK = 'X'.
*  PS_LVC_LAYO-CWIDTH_OPT = 'A'.
*  PS_LVC_LAYO-CTAB_FNAME = 'COLINFO'.
*  PS_LVC_LAYO-INFO_FNAME = 'INFO'.      "Row color
*  PS_LVC_LAYO-STYLEFNAME = 'CELLTAB'.   "Input control
* PS_LVC_LAYO-SMALLTITLE = 'X'.
* PS_LVC_LAYO-GRID_TITLE = .
*  PS_LVC_LAYO-ZEBRA      = 'X'.
*    CLEAR : PS_FCAT_MENGE-QFIELDNAME.
*    CLEAR : PS_FCAT_DMBTR-CFIELDNAME.
*    CLEAR : PS_FCAT_DMAVG-CFIELDNAME.
*  ADD 1 TO LV_COLPOS.
*  CLEAR : LS_FCAT.
*  MOVE-CORRESPONDING PS_FCAT_MENGE TO LS_FCAT.
*  LS_FCAT-COL_POS = LV_COLPOS.
*  CONCATENATE PS_FCAT_MENGE-FIELDNAME '_SIT' INTO LS_FCAT-FIELDNAME.
*  LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT = TEXT-F07.
*  LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L.
*  LS_FCAT-EMPHASIZE = 'C710'.
*  APPEND LS_FCAT TO PT_ALV_FIELDCAT.
*  ADD 1 TO LV_COLPOS.
*  CLEAR : LS_FCAT.
*  MOVE-CORRESPONDING PS_FCAT_DMBTR TO LS_FCAT.
*  LS_FCAT-COL_POS = LV_COLPOS.
*  CONCATENATE PS_FCAT_DMBTR-FIELDNAME '_SIT' INTO LS_FCAT-FIELDNAME.
*  LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT = TEXT-F08.
*  LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L.
*  LS_FCAT-EMPHASIZE = 'C710'.
*  APPEND LS_FCAT TO PT_ALV_FIELDCAT.
*  ADD 1 TO LV_COLPOS.
*  CLEAR : LS_FCAT.
*  MOVE-CORRESPONDING PS_FCAT_DMAVG TO LS_FCAT.
*  LS_FCAT-COL_POS = LV_COLPOS.
*  CONCATENATE PS_FCAT_DMAVG-FIELDNAME '_SIT' INTO LS_FCAT-FIELDNAME.
*  LS_FCAT-SCRTEXT_L = LS_FCAT-REPTEXT = TEXT-F84.
*  LS_FCAT-SCRTEXT_S = LS_FCAT-SCRTEXT_M = LS_FCAT-SCRTEXT_L.
*  LS_FCAT-EMPHASIZE = 'C710'.
*  APPEND LS_FCAT TO PT_ALV_FIELDCAT.
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F52.
*        <FS_ALV_FIELDCAT>-KEY = C_X.
*        <FS_ALV_FIELDCAT>-COL_OPT = 'X'.
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F53.
*        <FS_ALV_FIELDCAT>-KEY = C_X.
*        <FS_ALV_FIELDCAT>-COL_OPT = 'X'.
*      WHEN 'MAKTX2'. "Material Description2 MAKT-MAKTX+0(18)
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F54.
*        <FS_ALV_FIELDCAT>-COL_OPT = 'X'.
*      WHEN 'MAGRV'. "Packing Material
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F55.
*        <FS_ALV_FIELDCAT>-COL_OPT = 'X'.
*      WHEN 'SPART'. "Division
*        <FS_ALV_FIELDCAT>-NO_OUT = C_X.
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F56.
*        <FS_ALV_FIELDCAT>-COL_OPT = 'X'.
*      WHEN 'SPART_TX'. "Division Desc.
*        <FS_ALV_FIELDCAT>-NO_OUT = C_X.
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F57.
*        <FS_ALV_FIELDCAT>-COL_OPT = 'X'.
*        CLEAR <FS_ALV_FIELDCAT>-
*        <fs_alv_fieldcat>-col_pos = 996.
*        <fs_alv_fieldcat>-col_pos = 997.
*                                OR FIELDNAME EQ 'CHARG'
*                                OR FIELDNAME EQ 'SOBKZ'
*                                OR FIELDNAME EQ 'BWART'
*                                OR FIELDNAME EQ 'SHKZG'
*                                OR FIELDNAME EQ 'ZEILE'
*                                OR FIELDNAME EQ 'STPRS2'.
*                                OR FIELDNAME EQ 'DMBTR'
*                                OR FIELDNAME EQ 'WAERS'.
*      WHEN 'DMBTR'.
*        <FS_ALV_FIELDCAT>-COL_POS = 11.
*        <FS_ALV_FIELDCAT>-DO_SUM = C_X.
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F70.
*        WHEN 'BEIKZ '.
*          <FS_ALV_FIELDCAT>-COL_POS = 16.
*          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F79.
*          <FS_ALV_FIELDCAT>-JUST = 'C'.
*      WHEN 'WAERS'.
*        <FS_ALV_FIELDCAT>-COL_POS = 17.
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F76.
*        WHEN 'BEIKZ '.
*          <FS_ALV_FIELDCAT>-COL_POS = 16.
*          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F79.
*          <FS_ALV_FIELDCAT>-JUST = 'C'.
*        <FS_ALV_FIELDCAT>-SCRTEXT_L = <FS_ALV_FIELDCAT>-REPTEXT = TEXT-N01.
*        <FS_ALV_FIELDCAT>-SCRTEXT_S = <FS_ALV_FIELDCAT>-SCRTEXT_M = <FS_ALV_FIELDCAT>-SCRTEXT_L.
*        <FS_ALV_FIELDCAT>-SCRTEXT_L = <FS_ALV_FIELDCAT>-REPTEXT = TEXT-N02.
*        <FS_ALV_FIELDCAT>-SCRTEXT_S = <FS_ALV_FIELDCAT>-SCRTEXT_M = <FS_ALV_FIELDCAT>-SCRTEXT_L.
*        <FS_ALV_FIELDCAT>-SCRTEXT_L = <FS_ALV_FIELDCAT>-REPTEXT = TEXT-N03.
*        <FS_ALV_FIELDCAT>-SCRTEXT_S = <FS_ALV_FIELDCAT>-SCRTEXT_M = <FS_ALV_FIELDCAT>-SCRTEXT_L.
*                                OR FIELDNAME EQ 'CHARG'
*                                OR FIELDNAME EQ 'LIFNR'
*                                OR FIELDNAME EQ 'LIFNR_TX'
*                                OR FIELDNAME EQ 'SOBKZ'
*                                OR FIELDNAME EQ 'BWART'
*                                OR FIELDNAME EQ 'SHKZG'
*                                OR FIELDNAME EQ 'ZEILE'
*        WHEN 'BEIKZ '.
*          <FS_ALV_FIELDCAT>-COL_POS = 18.
*          <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F79.
*          <FS_ALV_FIELDCAT>-JUST = 'C'.
*    IF <GS_DISP_0500>-MENGE < 0.
*    <GS_DISP_0500>-INFO = 'C100'.
*    ENDIF.
*  DATA : lv_tabnm         LIKE feld-name.
*  CONCATENATE gv_inttab100 '[]' INTO lv_tabnm.
*  ASSIGN (lv_tabnm) TO <fs_tab>.
*  DATA : LV_TABNM         LIKE FELD-NAME.
*  CONCATENATE GV_INTTAB300 '[]' INTO LV_TABNM.
*  ASSIGN (LV_TABNM) TO <FS_TAB>.
* PS_LVC_LAYO-SMALLTITLE = 'X'.
* PS_LVC_LAYO-GRID_TITLE = .
*  ps_lvc_layo-box_fname  = 'MARK'.
*  ps_lvc_layo-sel_mode   = 'D'.
* PS_LVC_LAYO-NO_ROWMARK = 'X'.
*      SET PARAMETER ID 'AUN' FIELD ls_head-vbeln.
*      CALL TRANSACTION 'VA03' AND SKIP FIRST SCREEN.
*  CALL METHOD gv_alv_grid_110->set_frontend_layout
*      is_layout = gs_alv_layout_110.
*  PERFORM alv_class_refresh USING gv_alv_grid_100.
*  PERFORM alv_class_refresh USING gv_alv_grid_110.
*  PERFORM alv_class_refresh USING gv_alv_grid_400.
*      IF P_VAL EQ C_X.
*        CLEAR : LV_TEXT.
*        LV_TEXT = 'Amount : O'.
*        PERFORM ADD_TEXT USING LV_TEXT.
*        CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.
*      ELSE.
*        CLEAR : LV_TEXT.
*        LV_TEXT = 'Amount : X'.
*        PERFORM ADD_TEXT USING LV_TEXT.
*        CALL METHOD GV_ALV_DOCUMENT->NEW_LINE.
*      ENDIF.
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F53.
*        <FS_ALV_FIELDCAT>-KEY = C_X.
*      WHEN 'MAKTX2'. "Material Description2 MAKT-MAKTX+0(18)
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F54.
*      WHEN 'MAGRV'. "Packing Material
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F55.
*      WHEN 'SPART'. "Division
*        <FS_ALV_FIELDCAT>-NO_OUT = C_X.
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F56.
*      WHEN 'SPART_TX'. "Division Desc.
*        <FS_ALV_FIELDCAT>-NO_OUT = C_X.
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F57.
*     WHEN 'ZZSTOCKCD'.
*        <FS_ALV_FIELDCAT>-COL_POS = 8.
*        <FS_ALV_FIELDCAT>-COLTEXT = TEXT-F82.
*        <FS_ALV_FIELDCAT>-KEY = C_X.
*        <FS_ALV_FIELDCAT>-KEY = C_X.
*        <FS_ALV_FIELDCAT>-KEY = C_X.
*        <fs_alv_fieldcat>-col_pos = 996.
*        <fs_alv_fieldcat>-col_pos = 997.
*        ET_ROW_NO     =                  " Numeric IDs of Selected Rows
*           CLEAR:
*          READ TABLE <GT_TABLE> INTO <GS_TABLE> INDEX LS_INDEX_ROW-INDEX.
*                     G~ZZLOGINO
*                       AND SOBKZ EQ 'O'.
*        ET_ROW_NO     =                  " Numeric IDs of Selected Rows
*           CLEAR:
*          READ TABLE <GT_TABLE> INTO <GS_TABLE> INDEX LS_INDEX_ROW-INDEX.
*                     G~ZZLOGINO
*                 AND A~EMLIF EQ <FS_LIFNR>
*                     G~ZZLOGINO
*              CASE LS_MATDOC-BWART.
*                WHEN '541'.
*                  LS_MATDOC-SALK3 = LS_MATDOC-SALK3 / LS_MATDOC-LBKUM.
*                  LS_MATDOC-DMBTR = LS_MATDOC-MENGE * LS_MATDOC-SALK3.
*                WHEN '542'.
*                  LS_MATDOC-SALK3 = LS_MATDOC-SALK3 / LS_MATDOC-LBKUM.
*                  LS_MATDOC-DMBTR = LS_MATDOC-MENGE * LS_MATDOC-SALK3.
*              ENDCASE.
*                       AND SOBKZ EQ 'O'.
*              IF LS_MATDOC-ZZLOGINO IS INITIAL.
*                SELECT SINGLE B~ZZLOGINO
*                  FROM MATDOC AS A
*                  JOIN EKPO   AS B
*                    ON B~EBELN EQ A~EBELN
*                   AND B~EBELP EQ A~EBELP
*                 WHERE A~MBLNR EQ LS_MATDOC-MBLNR
*                   AND A~ZEILE EQ LS_MATDOC-ZEILE
*                   AND A~MATNR EQ LS_MATDOC-MATNR.
*              ENDIF.
```
</details>

## zmmpar52000top  — 제거 7줄, 컬럼주석 0개
<details><summary>제거 라인</summary>

```
*         ZZLOGINO LIKE ZMMMAT0002-ZZLOGINO,
*         ZZLOGINO LIKE ZMMMAT0002-ZZLOGINO,
*         CLABS    LIKE MCHB-CLABS,
*         STPRS2   LIKE MBEW-STPRS,
*         LGORT     LIKE  MARD-LGORT,
*DATA : GT_ZCOS0050 LIKE ZCOS0050 OCCURS 0 WITH HEADER LINE.
*      DISPLAY_CANCEL_BUTTON = ''
```
</details>

## zmmpar52000c01  — 제거 2줄, 컬럼주석 0개
<details><summary>제거 라인</summary>

```
*    PERFORM handle_double_click_500  USING e_row_id e_column_id.
*    PERFORM handle_double_click_110   USING e_row e_column.
```
</details>

## zmmpar52000scr  — 제거 1줄, 컬럼주석 0개
<details><summary>제거 라인</summary>

```
*                   S_LIFNR FOR MATDOC-LIFNR ,
```
</details>

## zmmpar52000o01  — 제거 14줄, 컬럼주석 0개
<details><summary>제거 라인</summary>

```
*      CASE C_X.
*        WHEN RA_R1.
*          SET TITLEBAR '0100' WITH TEXT-T04.
*        WHEN RA_R2.
*      ENDCASE.
*  PERFORM build_category_100 CHANGING gt_alv_fieldcat_100. "Field Cat.
*  PERFORM exclude_functionkey USING 'GT_ALV_EXTAB_110'.    "Tool Bar
*  PERFORM build_layout_110 CHANGING gs_alv_layout_110.     "Grid Layout
*  PERFORM build_category_110 CHANGING gt_alv_fieldcat_110. "Field Cat.
*  PERFORM build_sort_110.                                  "Sort
*  PERFORM build_color_style_110.                           "Color/Style
*  PERFORM build_event_110.                                 "Event
*  PERFORM display_alv_110.
*  PERFORM build_category_400 CHANGING gt_alv_fieldcat_400. "Field Cat.
```
</details>

## zmmpar52000i01  — 제거 0줄, 컬럼주석 0개
<details><summary>제거 라인</summary>

```
```
</details>


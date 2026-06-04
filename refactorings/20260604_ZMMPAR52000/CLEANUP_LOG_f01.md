# 🧹 F01 죽은 주석코드 정리 로그 (2026-06-04)

- 제거 라인: **185건** (주석처리된 코드, 한글/날짜/마커 없음)
- 보존: 한국어 업무주석·날짜 변경이력·`추후/예정` 의도주석·섹션 구분자·신규 변경마커
- 원본 복구: `as-is/` 또는 `git revert`

<details><summary>제거 라인 전체</summary>
```abap
*  PERFORM GET_GROUP_ZMMT0010.
**     FIELD DELETE
*      DELETE GT_ALV_FIELDCAT_100 WHERE FIELDNAME EQ 'SQR'
*                                    OR FIELDNAME EQ 'BUDAT'
**                                    OR FIELDNAME EQ 'LGORT'
*                                    OR FIELDNAME EQ 'CHARG'
*                                    OR FIELDNAME EQ 'SOBKZ'
*                                    OR FIELDNAME EQ 'PARTNER'
*                                    OR FIELDNAME EQ 'NAME_ORG1'
*                                    OR FIELDNAME EQ 'MAGRV'
**                                    OR FIELDNAME EQ 'WAERS'
*                                    OR FIELDNAME EQ 'DMBTR_SG_EI'
*                                    OR FIELDNAME EQ 'MENGE_SG_EI'
*                                    OR FIELDNAME EQ 'INFO'
*                                    OR FIELDNAME EQ 'MARK'
*                                    OR FIELDNAME+0(5) EQ 'DMAVG'
*                                    OR FIELDNAME EQ 'CLABS'.
*      SORT GT_ALV_FIELDCAT_100 BY COL_POS.
*                                    OR FIELDNAME EQ 'LGORT'
*                                    OR FIELDNAME EQ 'WAERS'
**     FIELD DELETE
*      DELETE GT_ALV_FIELDCAT_100 WHERE FIELDNAME EQ 'SQR'
*                                    OR FIELDNAME EQ 'BUDAT'
**                                    OR FIELDNAME EQ 'LGORT'
*                                    OR FIELDNAME EQ 'CHARG'
*                                    OR FIELDNAME EQ 'SOBKZ'
*                                    OR FIELDNAME EQ 'PARTNER'
*                                    OR FIELDNAME EQ 'NAME_ORG1'
*                                    OR FIELDNAME EQ 'MAGRV'
*                                    OR FIELDNAME EQ 'STPRS'
*                                    OR FIELDNAME EQ 'WAERS'
*                                    OR FIELDNAME EQ 'DMBTR_SG_EI'
*                                    OR FIELDNAME EQ 'MENGE_SG_EI'
*                                    OR FIELDNAME EQ 'INFO'
*                                    OR FIELDNAME EQ 'MARK'
*                                    OR FIELDNAME+0(5) EQ 'DMAVG'
*                                    OR FIELDNAME EQ 'CLABS'.
*      SORT GT_ALV_FIELDCAT_100 BY COL_POS.
*                                    OR FIELDNAME EQ 'LGORT'
*                                    OR FIELDNAME EQ 'WAERS'
*    CASE C_X.
*      WHEN RA_R1.
*        IF SCREEN-GROUP1 EQ 'CHG'.
*          SCREEN-ACTIVE = 0.
*        ENDIF.
*      WHEN RA_R2.
*    ENDCASE.
*    IF PV_VALUE+6(2) EQ 'GI'.
*      <FS_FIELD_SUM> = <FS_FIELD_SUM> - <FS_FIELD>.
*    ELSE.
*      <FS_FIELD_SUM> = <FS_FIELD_SUM> + <FS_FIELD>.
*    ENDIF.
*          IF GT_RAW-VGART IS INITIAL. "DMBTR EQ '0'.  "Amount Value check
*                   AND SOBKZ EQ 'O'.
*  LOOP AT GT_ZMMT0010 INTO DATA(LS_ZMMT0010).
*    TRANSLATE LS_ZMMT0010-ZTEXT TO UPPER CASE.
*    IF SY-SUBRC EQ 0.
*      CASE LS_ZMMT0010-ZGROUP+0(2).
*        WHEN 'GR'.
*          GV_GR_ETC = LS_ZMMT0010-ZGROUP.
*        WHEN 'GI'.
*          GV_GI_ETC = LS_ZMMT0010-ZGROUP.
*      ENDCASE.
*    ENDIF.
*  ENDLOOP.
* 3) DELETE DUMMY VALUE
*  CONCATENATE P_LFGJA P_LFMON '01' INTO GV_SDATE. "begin
*      DAY_IN            = GV_SDATE
*      LAST_DAY_OF_MONTH = GV_EDATE
*      DAY_IN_NO_DATE    = 1
*      OTHERS            = 2.
*  GV_EDATE_PO = GV_EDATE.
*  CONCATENATE GV_EDATE_PO+0(6) '01' INTO LV_DATE.
*  LV_BACKMONTHS = '2'.
*      CURRDATE   = LV_DATE
*      BACKMONTHS = LV_BACKMONTHS
*      NEWDATE    = GV_SDATE_PO.
*      AND b~bsart EQ 'ZRPK'. "Repacking
*  DATA : BEGIN OF LT_MTART OCCURS 0,
*           SPRAS LIKE T134T-SPRAS,
*           MTART LIKE T134T-MTART,
*           MTBEZ LIKE T134T-MTBEZ,
*  DATA: LT_RETURN LIKE TABLE OF DDSHRETVAL WITH HEADER LINE.
*  SELECT SPRAS,
*         MTART,
*    FROM T134T
*   WHERE SPRAS  = @SY-LANGU
*      RETFIELD        = 'MTART'
*      VALUE_ORG       = 'S'
*      VALUE_TAB       = LT_MTART
*      RETURN_TAB      = LT_RETURN
*      PARAMETER_ERROR = 1
*      NO_VALUES_FOUND = 2
*      OTHERS          = 3.
*  IF SY-SUBRC = 0.
*    READ TABLE LT_RETURN INDEX 1.
*    PI_MTART = LT_RETURN-FIELDVAL.
*  ENDIF.
*  DATA : BEGIN OF LT_LIFNR OCCURS 0,
**          WERKS      LIKE MDLL-WERKS,
*           PARTNER   LIKE BUT000-PARTNER,
*           NAME_ORG1 LIKE BUT000-NAME_ORG1,
**  DATA : BEGIN OF LT_CHECK OCCURS 0,
**          WERKS      LIKE MDLL-WERKS,
**          LBEAR      LIKE MDLL-LBEAR,
*  DATA: LT_RETURN TYPE DDSHRETVAL OCCURS 0.
*  SELECT FROM BUT000 AS A
*   INNER JOIN MDLL   AS B
*           ON B~LBEAR EQ A~PARTNER
*        WHERE A~PARTNER IN @S_LIFNR
*          AND A~TYPE EQ '2'
**          AND A~NAMCOUNTRY EQ @SY-LANGU
*  SORT LT_LIFNR BY PARTNER.
*      RETFIELD        = 'PARTNER'
*      DYNPPROG        = SY-REPID
*      DYNPNR          = SY-DYNNR
*      DYNPROFIELD     = 'S_LIFNR-LOW'
*      WINDOW_TITLE    = 'OEM Vendor'
*      VALUE_ORG       = 'S'
*      VALUE_TAB       = LT_LIFNR
*      RETURN_TAB      = LT_RETURN[]
*      PARAMETER_ERROR = 1
*      NO_VALUES_FOUND = 2
*      OTHERS          = 3.
*      FUNCTIONCODE           = 'ENTE'
*      FUNCTION_NOT_SUPPORTED = 1
*      OTHERS                 = 2.
* Material Unit/Desc. READ
*         SUM( A~STOCK_POSTING ) AS PRD_AMT,
*                 <FS_MENGE_GI5> TYPE ANY,
*                      'MENGE_GI5' OF STRUCTURE <LS_DISP> TO <FS_MENGE_GI5>,
*  CHECK GT_DISP_SCR[] IS NOT INITIAL.
*  SORT GT_DISP_SCR BY MATNR WERKS LGORT CHARG.
*         A~SOBKZ,
*         A~LIFNR,
*         C~NAME_ORG1 AS LIFNR_TX,
*        LEFT OUTER JOIN BUT000 AS C
*          ON C~PARTNER EQ A~LIFNR
*          AND A~LIFNR IN @S_LIFNR
*          AND F~MTART IN @S_MTART
*          AND A~SOBKZ EQ 'O'
*         A~SOBKZ,
*         ' ' AS LGORT,
*         ' ' AS LGOBE,
*            AND A~LIFNR IN @S_LIFNR
*            AND F~MTART IN @S_MTART
*  IF LT_RAW_0400[] IS NOT INITIAL.
*    LOOP AT LT_MCHB INTO DATA(LS_MCHB).
*      READ TABLE LT_RAW_0400 INTO LS_RAW_0400 WITH KEY BUKRS = LS_MCHB-BUKRS
*                                                       WERKS = LS_MCHB-WERKS
*                                                       MATNR = LS_MCHB-MATNR
*                                                       LIFNR = LS_MCHB-LIFNR
*                                                       CHARG = LS_MCHB-CHARG
*      IF SY-SUBRC EQ 0.
*        LV_INDEX = SY-TABIX.
*        LS_RAW_0400-CLABS  = LS_MCHB-CLABS.
*        LS_RAW_0400-STPRS2 = LS_MCHB-STPRS2.
*        MODIFY LT_RAW_0400 FROM LS_RAW_0400 INDEX LV_INDEX.
*        CLEAR : LS_MCHB.
*      ELSE.
*        CLEAR LS_RAW_0400.
*        MOVE-CORRESPONDING LS_MCHB TO LS_RAW_0400.
*        APPEND LS_RAW_0400 TO LT_RAW_0400.
*        CLEAR: LS_MCHB.
*      ENDIF.
*    ENDLOOP.
*  ELSE.
*    LOOP AT LT_MCHB ASSIGNING FIELD-SYMBOL(<FS_MCHB>).
*      CLEAR: LT_RAW_0400[], LS_RAW_0400.
*      MOVE-CORRESPONDING <FS_MCHB> TO LS_RAW_0400.
*      APPEND LS_RAW_0400 TO LT_RAW_0400.
*    ENDLOOP.
*  ENDIF.
*         H~BEIKZ
*        AND A~XAUTO EQ SPACE
*        AND A~MJAHR EQ P_LFGJA
*        AND A~LGORT IN S_LGORT
*      AND A~SOBKZ EQ 'O'.
*                                      SOBKZ = LS_RAW_0400-SOBKZ
*          IF GT_RAW-VGART IS INITIAL. "DMBTR EQ '0'.  "Amount Value check
*                   AND SOBKZ EQ 'O'.
*  SELECT JAHRPER, MATNR, BWKEY, BWTAR, PRICE
*    FROM ZCOPAV40011_CDS
*   WHERE JAHRPER EQ @LV_JAHRPER
*    INTO TABLE @DATA(LT_CO).
```
</details>

## 2차: 고아 단편 정리
- 제거 4건 (제거된 죽은 블록의 끊긴 설명/`BINARY SEARCH.` 잔재)
```
*                                                       BINARY SEARCH.
**   사급자재 Stock 존재하는 경우 -> LT_RAW_0400에 modify
**   사급자재 Stock 존재하지 않는 경우 -> LT_RAW_0400에 add
*   ITAB에 값 존재하지 않는 경우  LT_RAW_0400에 Append
```

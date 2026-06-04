*&---------------------------------------------------------------------*
*& INCLUDE ZMMPAR52000F01  (To-Be / 리팩토링: R+M)
*& 표준 근거: standards/ABAP_CODE_STANDARD.md  (FS §1~§8)
*& 적용: C1(SQL 가독성, 진행중) + C5(안전성) 반영
*&   - GET_GROUP_ZMMT0010 : 컬럼 한글주석 / 정렬 (FS §4·§5)
*&   - LT_SUM2            : BINARY SEARCH 전 명시 SORT 추가 (FS §6)
*& WIP: 잔여 SQL FORM(MATERIAL_DOC_BASIC_STOCK 등) 컬럼주석 배치 예정
*&---------------------------------------------------------------------*
Code listing for: ZMMPAR52000F01 Description: Include ZMMMAM36100F01

*&---------------------------------------------------------------------*
*& Include          YMMR0010F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  INITIALIZE
*&---------------------------------------------------------------------*
*       INITIALIZE
*----------------------------------------------------------------------*

FORM INITIALIZE .

  DATA: LV_DATUM_LOW  TYPE SY-DATUM,
        LV_DATUM_HIGH TYPE SY-DATUM.

  " 실행되는 날로 지정"
  LV_DATUM_HIGH = SY-DATLO.

  "달 마지막일 구하기 "
  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'
    EXPORTING
      DAY_IN            = LV_DATUM_HIGH
    IMPORTING
      LAST_DAY_OF_MONTH = LV_DATUM_HIGH.

  "달 첫날 일 구하기 "
  LV_DATUM_LOW = LV_DATUM_HIGH+0(6) && '01'.

  S_BUDAT-SIGN = 'I'.
  S_BUDAT-OPTION = 'BT'.
  S_BUDAT-LOW = LV_DATUM_LOW.
  S_BUDAT-HIGH = LV_DATUM_HIGH.
  APPEND S_BUDAT.

** Group code
*  PERFORM GET_GROUP_ZMMT0010.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
*       Select Data
*----------------------------------------------------------------------*

FORM SELECT_DATA .

  FIELD-SYMBOLS: <FS_FIELD> TYPE ANY.

  CHECK GV_ERROR EQ SPACE.

  CLEAR : GT_MAT, GT_MAT[].
  CLEAR : GT_MARA, GT_MARA[].
  CLEAR : GT_RAW, GT_RAW[].
  CLEAR : <GT_TABLE>, <GT_TABLE>[].

  DEFINE _RANGE.
    CLEAR  &1.
    &1-SIGN   = &2.
    &1-OPTION = &3.
    &1-LOW    = &4.
    &1-HIGH   = &5.
    APPEND &1.
  END-OF-DEFINITION.

* Period Setting (미사용)

  PERFORM PERIOD_SETTING.

* Group code

  IF GT_ZMMT0010[] IS INITIAL.
    PERFORM GET_GROUP_ZMMT0010.
  ENDIF.

  PERFORM SHOW_BATCH_DATA.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CREATE_DYNAMIC_TABLE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM CREATE_DYNAMIC_TABLE .

* Group code

  PERFORM GET_GROUP_ZMMT0010.

  CHECK GV_ERROR EQ SPACE.

  PERFORM BUFFER_CLEAR_PROC USING SY-REPID 'GT_DISP'.
  PERFORM BUILD_CATEGORY_100 CHANGING GT_ALV_FIELDCAT_100. "Field Cat.

  CHECK GT_ALV_FIELDCAT_100[] IS NOT INITIAL.
  GT_ALV_FIELDCAT_400[] = GT_ALV_FIELDCAT_100[].

  CASE C_X.
    WHEN P_VAL. " Amount 출력

**     FIELD DELETE
*      " 0100 Screen Fieldcatalog 구성
*      DELETE GT_ALV_FIELDCAT_100 WHERE FIELDNAME EQ 'SQR'
*                                    OR FIELDNAME EQ 'BUDAT'
**                                    OR FIELDNAME EQ 'LGORT'
*                                    OR FIELDNAME EQ 'CHARG'
*                                    OR FIELDNAME EQ 'SOBKZ'
*                                    OR FIELDNAME EQ 'PARTNER'
*                                    OR FIELDNAME EQ 'NAME_ORG1'
*                                    OR FIELDNAME EQ 'MAGRV'
**                                    OR FIELDNAME EQ 'WAERS'
**                                    OR FIELDNAME+0(5) EQ 'DMBTR' " 금액 삭제 요청으로 인한 주석
*                                    OR FIELDNAME EQ 'DMBTR_SG_EI'
*                                    OR FIELDNAME EQ 'MENGE_SG_EI'
*                                    OR FIELDNAME EQ 'INFO'
*                                    OR FIELDNAME EQ 'MARK'
*                                    OR FIELDNAME+0(5) EQ 'DMAVG'
*                                    OR FIELDNAME EQ 'CLABS'.
*      SORT GT_ALV_FIELDCAT_100 BY COL_POS.

      " 0400 Screen Fieldcatalog 구성
      DELETE GT_ALV_FIELDCAT_400 WHERE FIELDNAME EQ 'SQR'
                                    OR FIELDNAME EQ 'SOBKZ'
                                    OR FIELDNAME EQ 'MAGRV'
                                    OR FIELDNAME EQ 'PARTNER'
                                    OR FIELDNAME EQ 'NAME_ORG1'
                                    OR FIELDNAME EQ 'SLLAB'

*                                    OR FIELDNAME EQ 'LGORT'
*                                    OR FIELDNAME EQ 'WAERS'

                                    OR FIELDNAME EQ 'SPART'
                                    OR FIELDNAME EQ 'SPART_TX'
                                    OR FIELDNAME EQ 'DMBTR_SG_EI'
                                    OR FIELDNAME EQ 'MENGE_SG_EI'

*                                    OR FIELDNAME+0(5) EQ 'DMBTR' " 금액 삭제 요청으로 인한 주석

                                    OR FIELDNAME+0(5) EQ 'DMAVG'
                                    OR FIELDNAME EQ 'INFO'
                                    OR FIELDNAME EQ 'MARK'
                                    OR FIELDNAME EQ 'LABST'
                                    OR FIELDNAME EQ 'ZZSTOCKCD'.
      PERFORM BUILD_CATEGORY_400 CHANGING GT_ALV_FIELDCAT_400. " Field Cat. 400

    WHEN OTHERS.      " Amount 미출력

**     FIELD DELETE
*      " 0100 Screen Fieldcatalog 구성
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
*                                    OR FIELDNAME+0(5) EQ 'DMBTR' " 금액 삭제
*                                    OR FIELDNAME EQ 'DMBTR_SG_EI'
*                                    OR FIELDNAME EQ 'MENGE_SG_EI'
*                                    OR FIELDNAME EQ 'INFO'
*                                    OR FIELDNAME EQ 'MARK'
*                                    OR FIELDNAME+0(5) EQ 'DMAVG'
*                                    OR FIELDNAME EQ 'CLABS'.
*      SORT GT_ALV_FIELDCAT_100 BY COL_POS.

      " 0400 Screen Fieldcatalog 구성
      DELETE GT_ALV_FIELDCAT_400 WHERE FIELDNAME EQ 'SQR'
                                    OR FIELDNAME EQ 'SOBKZ'
                                    OR FIELDNAME EQ 'MAGRV'
                                    OR FIELDNAME EQ 'PARTNER'
                                    OR FIELDNAME EQ 'NAME_ORG1'
                                    OR FIELDNAME EQ 'SLLAB'

*                                    OR FIELDNAME EQ 'LGORT'

                                    OR FIELDNAME EQ 'STPRS'

*                                    OR FIELDNAME EQ 'WAERS'

                                    OR FIELDNAME EQ 'SPART'
                                    OR FIELDNAME EQ 'SPART_TX'
                                    OR FIELDNAME EQ 'DMBTR_SG_EI'
                                    OR FIELDNAME EQ 'MENGE_SG_EI'
                                    OR FIELDNAME+0(5) EQ 'DMBTR' " 금액 삭제
                                    OR FIELDNAME+0(5) EQ 'DMAVG'
                                    OR FIELDNAME EQ 'LABST'
                                    OR FIELDNAME EQ 'INFO'
                                    OR FIELDNAME EQ 'MARK'
                                    OR FIELDNAME EQ 'LABST'
                                    OR FIELDNAME EQ 'ZZSTOCKCD'.
      PERFORM BUILD_CATEGORY_400 CHANGING GT_ALV_FIELDCAT_400. " Field Cat. 400

  ENDCASE.

  DATA: LT_TABLE TYPE REF TO DATA,
        LS_TABLE TYPE REF TO DATA.

* Create 0100 SCREEN

  CALL METHOD CL_ALV_TABLE_CREATE=>CREATE_DYNAMIC_TABLE
    EXPORTING
      IT_FIELDCATALOG = GT_ALV_FIELDCAT_100[]
    IMPORTING
      EP_TABLE        = LT_TABLE.

  ASSIGN LT_TABLE->* TO <GT_TABLE>.
  ASSIGN LT_TABLE->* TO <GT_TABLE_TM>.
  CREATE DATA LS_TABLE LIKE LINE OF <GT_TABLE>.
  ASSIGN LS_TABLE->* TO <GS_TABLE>.
  ASSIGN LS_TABLE->* TO <GS_TABLE_TM>.

  CLEAR : <GT_TABLE>, <GT_TABLE>[], <GS_TABLE>.
  CLEAR : <GT_TABLE_TM>, <GT_TABLE_TM>[], <GS_TABLE_TM>.

* Create 0400 SCREEN

  CALL METHOD CL_ALV_TABLE_CREATE=>CREATE_DYNAMIC_TABLE
    EXPORTING
      IT_FIELDCATALOG = GT_ALV_FIELDCAT_400[]
    IMPORTING
      EP_TABLE        = LT_TABLE.

  ASSIGN LT_TABLE->* TO <GT_BATCH>.
  CREATE DATA LS_TABLE LIKE LINE OF <GT_BATCH>.
  ASSIGN LS_TABLE->* TO <GS_BATCH>.
  ASSIGN LS_TABLE->* TO <GS_BATCH_TM>.

  CLEAR : <GT_BATCH>, <GT_BATCH>[], <GS_BATCH>, <GS_BATCH_TM>.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form SCREEN_OUTPUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM SCREEN_OUTPUT .

  LOOP AT SCREEN.

    CASE SCREEN-NAME.
      WHEN 'P_LFGJA'.
        SCREEN-REQUIRED = 2.
      WHEN 'P_LFMON'.
        SCREEN-REQUIRED = 2.
    ENDCASE.

*    CASE C_X.
*      WHEN RA_R1.
*        IF SCREEN-GROUP1 EQ 'CHG'.
*          SCREEN-ACTIVE = 0.
*        ENDIF.
*      WHEN RA_R2.

    IF SCREEN-NAME EQ 'S_WERKS-LOW' OR SCREEN-NAME EQ 'P_SPMON'.
      SCREEN-REQUIRED = 2.
    ENDIF.

    IF RB_MM = ABAP_TRUE.
      IF SCREEN-GROUP1 = 'CO1'.
        SCREEN-ACTIVE = 0.
      ENDIF.

      IF SCREEN-GROUP1 = 'MM1'.
        SCREEN-INPUT = 1.
      ENDIF.
    ELSE.
      IF SCREEN-GROUP1 = 'CO1'.
        SCREEN-ACTIVE = 1.
      ENDIF.

      IF SCREEN-GROUP1 = 'MM1'.
        SCREEN-INPUT = 0.
      ENDIF.
    ENDIF.

*    ENDCASE.

    MODIFY SCREEN.
  ENDLOOP.

  IF RB_MM = ABAP_TRUE.
    P_VAL = ''.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CHECK_INPUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM CHECK_INPUT .

  IF S_BUDAT[] IS INITIAL.
    GV_ERROR = C_X.
    MESSAGE S055(00) DISPLAY LIKE C_E.
    LEAVE LIST-PROCESSING.
  ENDIF.

  IF S_WERKS[] IS INITIAL.
    GV_ERROR = C_X.
    MESSAGE S055(00) DISPLAY LIKE C_E.
    LEAVE LIST-PROCESSING.

  ELSEIF S_WERKS-LOW NE '1010'.

    SELECT SINGLE WERKS
      FROM T001W
     WHERE WERKS IN @S_WERKS[]
      INTO @DATA(LV_WERKS).

    IF SY-SUBRC NE 0.
      MESSAGE S000 WITH S_WERKS-LOW 'is a non-existent plant' DISPLAY LIKE C_E.
    ENDIF.
  ENDIF.

  IF RB_CO = ABAP_TRUE.
    IF P_SPMON IS INITIAL.
      MESSAGE S055(00) DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDIF.

  "Batch
  CLEAR : GR_CHARG, GR_CHARG[].
  GR_CHARG[] = S_CHARG[].

ENDFORM.

*&---------------------------------------------------------------------*
*& Form INPUT_VALUE
*&---------------------------------------------------------------------*
*& INPUT VALUE
*&---------------------------------------------------------------------*

FORM INPUT_VALUE  USING    PS_TABLE
                           PV_FIELDNAME
                           PV_VALUE.

  FIELD-SYMBOLS: <FS_FIELD> TYPE ANY.

  ASSIGN COMPONENT PV_FIELDNAME OF STRUCTURE PS_TABLE TO <FS_FIELD>.
  IF SY-SUBRC EQ 0.
    <FS_FIELD>  = PV_VALUE.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form ADD_VALUE
*&---------------------------------------------------------------------*
*& ADD VALUE
*&---------------------------------------------------------------------*

FORM ADD_VALUE  USING    PV_FIELDNAME1
                         PV_FIELDNAME2
                         PV_VALUE.

  DATA : LV_FIELDNAME TYPE FIELDNAME.
  FIELD-SYMBOLS: <FS_FIELD> TYPE ANY.

  CONCATENATE PV_FIELDNAME1 PV_FIELDNAME2 INTO LV_FIELDNAME.
  ASSIGN (LV_FIELDNAME) TO <FS_FIELD>.
  IF SY-SUBRC EQ 0.
    <FS_FIELD> = <FS_FIELD> + PV_VALUE.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CLEAR_FIELD
*&---------------------------------------------------------------------*
*& CLEAR FIELD VALUE
*&---------------------------------------------------------------------*

FORM CLEAR_FIELD  USING  PS_TABLE
                         PV_FIELD.

  FIELD-SYMBOLS: <FS_FIELD> TYPE ANY.

  ASSIGN COMPONENT PV_FIELD OF STRUCTURE PS_TABLE TO <FS_FIELD>.
  IF SY-SUBRC EQ 0.
    CLEAR <FS_FIELD>.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form ADD_FIELD
*&---------------------------------------------------------------------*
*& ADD TO FIELD VALUE
*&---------------------------------------------------------------------*

FORM ADD_FIELD  USING    PS_TABLE
                         PV_VALUE_SUM
                         PV_VALUE.

  FIELD-SYMBOLS: <FS_FIELD>     TYPE ANY,
                 <FS_FIELD_SUM> TYPE ANY.

  ASSIGN COMPONENT PV_VALUE_SUM OF STRUCTURE PS_TABLE TO <FS_FIELD_SUM>.
  ASSIGN COMPONENT PV_VALUE OF STRUCTURE PS_TABLE TO <FS_FIELD>.
  IF SY-SUBRC EQ 0.
    <FS_FIELD_SUM> = <FS_FIELD_SUM> + <FS_FIELD>.

*    IF PV_VALUE+6(2) EQ 'GI'.
*      <FS_FIELD_SUM> = <FS_FIELD_SUM> - <FS_FIELD>.
*    ELSE.
*      <FS_FIELD_SUM> = <FS_FIELD_SUM> + <FS_FIELD>.
*    ENDIF.

  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form SHOW_SIT_DATA
*&---------------------------------------------------------------------*
*& Stock In Transit
*&---------------------------------------------------------------------*

FORM SHOW_SIT_DATA  CHANGING PS_TABLE.

  CLEAR GS_DISP_SCR.
  MOVE-CORRESPONDING PS_TABLE TO GS_DISP_SCR.
  GS_DISP_SCR-DYNNR = '0300'.

  CLEAR : GT_SIT_DISP, GT_SIT_DISP[].
  LOOP AT GT_SIT WHERE MATNR EQ GS_DISP_SCR-MATNR
                   AND WERKS EQ GS_DISP_SCR-WERKS.

    MOVE-CORRESPONDING GT_SIT TO GT_SIT_DISP.
    APPEND GT_SIT_DISP. CLEAR GT_SIT_DISP.

  ENDLOOP.

  PERFORM BUFFER_CLEAR_PROC USING SY-REPID GV_INTTAB300.

  IF GT_SIT_DISP[] IS INITIAL.
    MESSAGE S079. "No Stock In Transit data
  ELSE.
    CALL SCREEN 0300 STARTING AT 10 2
    ENDING AT 150 30.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form SHOW_SIT_DATA_BATCH
*&---------------------------------------------------------------------*
*& Stock In Transit for Batch
*&---------------------------------------------------------------------*

FORM SHOW_SIT_DATA_BATCH  CHANGING PS_TABLE.

  CLEAR GS_DISP_SCR.
  MOVE-CORRESPONDING PS_TABLE TO GS_DISP_SCR.
  GS_DISP_SCR-DYNNR = '0300'.

  IF GS_DISP_SCR-LGORT EQ SPACE.
    MESSAGE S079.
    EXIT.
  ENDIF.

  CLEAR : GT_SIT_DISP, GT_SIT_DISP[].
  LOOP AT GT_SIT WHERE MATNR EQ GS_DISP_SCR-MATNR
                   AND WERKS EQ GS_DISP_SCR-WERKS
                   AND CHARG EQ GS_DISP_SCR-CHARG.

    IF GS_DISP_SCR-LGORT EQ '1000'.
      IF GT_SIT-LGORT EQ '1000' OR GT_SIT-LGORT EQ SPACE.
      ELSE.
        CONTINUE.
      ENDIF.
    ELSE.
      IF GT_SIT-LGORT EQ GS_DISP_SCR-LGORT.
      ELSE.
        CONTINUE.
      ENDIF.
    ENDIF.

    MOVE-CORRESPONDING GT_SIT TO GT_SIT_DISP.
    APPEND GT_SIT_DISP. CLEAR GT_SIT_DISP.

  ENDLOOP.

  PERFORM BUFFER_CLEAR_PROC USING SY-REPID GV_INTTAB300.

  IF GT_SIT_DISP[] IS INITIAL.
    MESSAGE S079. "No Stock In Transit data.
  ELSE.
    CALL SCREEN 0300 STARTING AT 10 2
    ENDING AT 150 30.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form SHOW_GRLIST_DATA
*&---------------------------------------------------------------------*
*& Stock In Transit(GRLIST)
*&---------------------------------------------------------------------*

FORM SHOW_GRLIST_DATA  CHANGING PS_TABLE.

  DATA : LV_SDATE_TX(20),
         LV_EDATE_TX(20).

  CLEAR GS_DISP_SCR.
  MOVE-CORRESPONDING PS_TABLE TO GS_DISP_SCR.
  GS_DISP_SCR-DYNNR = '0500'.

  CLEAR : GT_GRLIST_DISP, GT_GRLIST_DISP[].
  LOOP AT GT_GRLIST WHERE MATNR EQ GS_DISP_SCR-MATNR
                      AND WERKS EQ GS_DISP_SCR-WERKS.

    MOVE-CORRESPONDING GT_GRLIST TO GT_GRLIST_DISP.
    APPEND GT_GRLIST_DISP. CLEAR GT_GRLIST_DISP.

  ENDLOOP.

  PERFORM BUFFER_CLEAR_PROC USING SY-REPID GV_INTTAB500.

  IF GT_GRLIST_DISP[] IS INITIAL.

* Period

    WRITE GV_SDATE_PO TO LV_SDATE_TX.
    CONDENSE LV_SDATE_TX NO-GAPS.
    WRITE GV_EDATE_PO TO LV_EDATE_TX.
    CONDENSE LV_EDATE_TX NO-GAPS.

    "SiT Stock data is not exist. (Posting Date: GV_SDATE ~ GV_EDATE)
    MESSAGE S080 WITH LV_SDATE_TX LV_EDATE_TX.
  ELSE.
    CALL SCREEN 0500 STARTING AT 10 2
    ENDING AT 150 30.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form SHOW_GROUP_RAW
*&---------------------------------------------------------------------*
*& RAW DATA SHOW
*&---------------------------------------------------------------------*

FORM SHOW_GROUP_RAW  USING    PV_FIELDNAME
                              PV_CALL_SCREEN
                     CHANGING PS_TABLE.

  DATA : LS_ZMMT0010 TYPE ZMMPAT52000.

  LS_ZMMT0010-ZGROUP = PV_FIELDNAME+6(4).

  SELECT SINGLE ZGROUP ZTEXT
  INTO CORRESPONDING FIELDS OF LS_ZMMT0010
  FROM ZMMPAT52000
  WHERE ZGROUP EQ LS_ZMMT0010-ZGROUP.
  IF SY-SUBRC EQ 0.

    CLEAR GS_DISP_SCR.
    MOVE-CORRESPONDING PS_TABLE TO GS_DISP_SCR.
    GS_DISP_SCR-DYNNR = PV_CALL_SCREEN.

    CLEAR : GT_RAW_DISP, GT_RAW_DISP[].
    CASE PV_CALL_SCREEN.

      WHEN '0400'. "Batch

        LOOP AT GT_BATCH_0400 WHERE MATNR EQ GS_DISP_SCR-MATNR
                                AND WERKS EQ GS_DISP_SCR-WERKS
                                AND LGORT EQ GS_DISP_SCR-LGORT
                                AND CHARG EQ GS_DISP_SCR-CHARG
                                AND LIFNR EQ GS_DISP_SCR-LIFNR
                                AND ZGROUP EQ LS_ZMMT0010-ZGROUP.

*          IF GT_RAW-VGART IS INITIAL. "DMBTR EQ '0'.  "Amount Value check

          MOVE-CORRESPONDING GT_BATCH_0400 TO GT_RAW_DISP.

          " Mvt Text 출력요청으로 인한 추가 / " 24.08.20
          SELECT SINGLE BTEXT
                 INTO CORRESPONDING FIELDS OF GT_RAW_DISP
                 FROM T156T
                 WHERE BWART EQ GT_RAW_DISP-BWART
                   AND SPRAS EQ SY-LANGU.

*                   AND SOBKZ EQ 'O'.

          APPEND GT_RAW_DISP. CLEAR GT_RAW_DISP.
        ENDLOOP.

    ENDCASE.

    SORT GT_RAW_DISP BY BUDAT MATNR CHARG.

    LOOP AT GT_RAW_DISP ASSIGNING FIELD-SYMBOL(<GS_RAW_DISP>).
      IF <GS_RAW_DISP>-MENGE < 0.
        <GS_RAW_DISP>-INFO = 'C600'.
      ELSE.
        <GS_RAW_DISP>-INFO = 'C100'.
      ENDIF.
    ENDLOOP.

    PERFORM BUFFER_CLEAR_PROC USING SY-REPID GV_INTTAB200.

    IF GT_RAW_DISP[] IS INITIAL.
      " No data found
      MESSAGE S082 DISPLAY LIKE 'E'.
    ELSE.

      CASE PV_CALL_SCREEN.
        WHEN '0100'.
          GV_TITLE_200 = LS_ZMMT0010-ZTEXT.
        WHEN '0400'.
          CONCATENATE LS_ZMMT0010-ZTEXT TEXT-T14 INTO GV_TITLE_200
                      SEPARATED BY SPACE.
      ENDCASE.
      CALL SCREEN 0200 STARTING AT 10 2
      ENDING AT 150 30.
    ENDIF.

  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form GET_GROUP_ZMMT0010
*&---------------------------------------------------------------------*
*& GET GROUP CODE
*&---------------------------------------------------------------------*

"=== 🔧[R] GET_GROUP_ZMMT0010 가독성 정비 =========================
" 변경: SELECT 컬럼 한글주석 부여(FS §4) + SQL 정렬/들여쓰기 표준화(FS §5)
"       + 섹션 구분 주석 표준화(FS §4). alias/대문자/연산자(EQ·NE) 원본 유지.
" 근거: FS §4 / §5   리스크: 없음(결과·정렬·의미 동일)   Rollback: git revert
"================================================================
FORM GET_GROUP_ZMMT0010 .

  CLEAR : GV_GR_ETC, GV_GI_ETC.          " 🛠[M] 진입 시 잔존값 제거 (FS §7)
  CLEAR : GT_ZMMT0010, GT_ZMMT0010[].
  CLEAR : GT_GROUP, GT_GROUP[].

  "============================================================
  " 1) 이동유형 그룹 마스터 조회 (ZMMPAT52000 = [MM] 이동유형 그룹)
  "============================================================
  SELECT A~ZGROUP      " 이동유형 그룹 코드
         A~ZTEXT       " 그룹 내역(명)
         A~ZSEQ        " 정렬 순서
    INTO CORRESPONDING FIELDS OF TABLE GT_ZMMT0010
    FROM ZMMPAT52000 AS A
   ORDER BY A~ZSEQ.    " 🔧[R] alias 명시 (was: ORDER BY ZSEQ)

*  📌 의미 보존: 아래 ETC 이동유형 처리 블록은 "추후 운영 시 적용 예정"
*     주석과 함께 의도적으로 보존 (삭제 금지 / 한국어 주석 보존 원칙)
**********************************************************************
* ETC. 이동유형 없기에 주석처리..
* 추후 운영 시, ETC 추가될 시 적용 예정
**********************************************************************
*  LOOP AT GT_ZMMT0010 INTO DATA(LS_ZMMT0010).
*    TRANSLATE LS_ZMMT0010-ZTEXT TO UPPER CASE.
*    FIND 'ETC' IN LS_ZMMT0010-ZTEXT.
*    IF SY-SUBRC EQ 0.
*      CASE LS_ZMMT0010-ZGROUP+0(2).
*        WHEN 'GR'.
*          GV_GR_ETC = LS_ZMMT0010-ZGROUP.
*        WHEN 'GI'.
*          GV_GI_ETC = LS_ZMMT0010-ZGROUP.
*      ENDCASE.
*    ENDIF.
*  ENDLOOP.

  "============================================================
  " 2) 이동유형 그룹 상세 조회 — 그룹 마스터(A) INNER JOIN 상세(B)
  "============================================================
  SELECT A~ZGROUP      " 이동유형 그룹 코드
         A~ZTEXT       " 그룹 내역(명)
         B~BWART       " 이동유형 (재고관리)
         B~GRUND       " 이동 사유
    INTO CORRESPONDING FIELDS OF TABLE GT_GROUP
    FROM ZMMPAT52000 AS A
   INNER JOIN ZMMPAT52010 AS B
      ON  A~ZGROUP EQ B~ZGROUP        " 🔧[R] 들여쓰기 정렬 (FS §5)
   WHERE A~ZGROUP NE SPACE.           " 그룹코드 공란 제외

  SORT GT_GROUP BY BWART GRUND ZGROUP.  " 📌 정렬 유지 (BINARY SEARCH 키 일치, FS §6)

ENDFORM.

*&---------------------------------------------------------------------*
*& Form SHOW_BATCH_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- <FS_TABLE>
*&---------------------------------------------------------------------*

FORM SHOW_BATCH_DATA.

* 1) Current Stock & Material Document Data Get
*    + 기초수량(기초금액) SET

  PERFORM MATERIAL_DOC_BASIC_STOCK.

* 2) SUM

  PERFORM CACULATE_TOTAL_BATCH.

* 3) DELETE DUMMY VALUE

  PERFORM DELETE_DUMMY_BATCH.

*4) co 수불일때 금액 변환 co 기준으로

  IF RB_CO = ABAP_TRUE.
    PERFORM CO_AMT.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form DISPLAY_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM DISPLAY_DATA .

  IF <GT_BATCH>[] IS INITIAL.
    MESSAGE S010 DISPLAY LIKE C_E.
  ELSE.
    CALL SCREEN 400.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form SET_AVG
*&---------------------------------------------------------------------*
*& SET AVG VALUE
*&---------------------------------------------------------------------*

FORM SET_AVG  USING    PS_TABLE
                       PV_QTY
                       PV_DMBTR
                       PV_DMAVG.

  FIELD-SYMBOLS: <FS_QTY>   TYPE ANY,
                 <FS_DMBTR> TYPE ANY,
                 <FS_DMAVG> TYPE ANY.

  ASSIGN COMPONENT PV_QTY OF STRUCTURE PS_TABLE TO <FS_QTY>.
  ASSIGN COMPONENT PV_DMBTR OF STRUCTURE PS_TABLE TO <FS_DMBTR>.
  ASSIGN COMPONENT PV_DMAVG OF STRUCTURE PS_TABLE TO <FS_DMAVG>.
  IF SY-SUBRC EQ 0.
    IF <FS_DMBTR> NE '0' AND <FS_QTY> NE '0'.
      <FS_DMAVG> = <FS_DMBTR> / <FS_QTY>.
    ENDIF.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form PERIOD_SETTING
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM PERIOD_SETTING .

  DATA : LV_DATE       TYPE SY-DATUM,
         LV_BACKMONTHS TYPE NUMC3.

* Period Setting
*  CONCATENATE P_LFGJA P_LFMON '01' INTO GV_SDATE. "begin
*  CALL FUNCTION 'LAST_DAY_OF_MONTHS'
*    EXPORTING
*      DAY_IN            = GV_SDATE
*    IMPORTING
*      LAST_DAY_OF_MONTH = GV_EDATE
*    EXCEPTIONS
*      DAY_IN_NO_DATE    = 1
*      OTHERS            = 2.
*
*  GV_EDATE_PO = GV_EDATE.
*
*  "Last 2 month before (PO 수량 계산용)
*  CONCATENATE GV_EDATE_PO+0(6) '01' INTO LV_DATE.
*  LV_BACKMONTHS = '2'.
*  CALL FUNCTION 'CCM_GO_BACK_MONTHS'
*    EXPORTING
*      CURRDATE   = LV_DATE
*      BACKMONTHS = LV_BACKMONTHS
*    IMPORTING
*      NEWDATE    = GV_SDATE_PO.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form REPACKING_REASON_FOR_MOVEMENT
*&---------------------------------------------------------------------*
*& Repacking Reason for movement Get
*& BWART eq '101' or '102' & GRUND is initial
*&---------------------------------------------------------------------*

FORM REPACKING_REASON_FOR_MOVEMENT  TABLES   PT_RAW STRUCTURE GT_RAW.

  DATA : LT_RAW_REP LIKE GT_RAW OCCURS 0 WITH HEADER LINE.

  CHECK PT_RAW[] IS NOT INITIAL.

  LT_RAW_REP[] = PT_RAW[].

  DELETE LT_RAW_REP WHERE BWART NE '101'
                      AND BWART NE '102'.
  DELETE LT_RAW_REP WHERE GRUND IS NOT INITIAL.

  IF LT_RAW_REP[] IS NOT INITIAL.
    SELECT A~MBLNR, A~MJAHR, A~ZEILE, B~BSART
    INTO TABLE @DATA(LT_REP)
    FROM MATDOC AS A
    JOIN EKKO AS B
              ON B~EBELN EQ A~EBELN
    FOR ALL ENTRIES IN @LT_RAW_REP
    WHERE A~MBLNR EQ @LT_RAW_REP-MBLNR
      AND A~MJAHR EQ @LT_RAW_REP-MJAHR
      AND A~ZEILE EQ @LT_RAW_REP-ZEILE.

*      AND b~bsart EQ 'ZRPK'. "Repacking

    "BSART EQ 'ZRPK'
    SORT PT_RAW BY MBLNR MJAHR ZEILE.
    LOOP AT LT_REP INTO DATA(LS_REP).
      READ TABLE PT_RAW ASSIGNING FIELD-SYMBOL(<FS_RAW>)
                        WITH KEY MBLNR = LS_REP-MBLNR
                                 MJAHR = LS_REP-MJAHR
                                 ZEILE = LS_REP-ZEILE
                        BINARY SEARCH.

      IF SY-SUBRC EQ 0.
        <FS_RAW>-GRUND = '1000'.
      ENDIF.

    ENDLOOP.
  ENDIF.

ENDFORM.

**&---------------------------------------------------------------------*
**& Form F4_H_MTART
**&---------------------------------------------------------------------*
**& text
**&---------------------------------------------------------------------*
**&      --> S_MTART_LOW
**&---------------------------------------------------------------------*
*FORM F4_H_MTART  USING    PI_MTART.
*
*  DATA : BEGIN OF LT_MTART OCCURS 0,
*           SPRAS LIKE T134T-SPRAS,
*           MTART LIKE T134T-MTART,
*           MTBEZ LIKE T134T-MTBEZ,
*         END OF LT_MTART.
*
*  DATA: LT_RETURN LIKE TABLE OF DDSHRETVAL WITH HEADER LINE.
*
*  SELECT SPRAS,
*         MTART,
*         MTBEZ
*    INTO TABLE @LT_MTART
*    FROM T134T
*   WHERE SPRAS  = @SY-LANGU
*     AND MTART IN ('HAWA', 'ROH', 'VERP', 'ERSA', 'ZCSD')
*   ORDER BY MTART.
*
*  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
*    EXPORTING
*      RETFIELD        = 'MTART'
*      VALUE_ORG       = 'S'
*    TABLES
*      VALUE_TAB       = LT_MTART
*      RETURN_TAB      = LT_RETURN
*    EXCEPTIONS
*      PARAMETER_ERROR = 1
*      NO_VALUES_FOUND = 2
*      OTHERS          = 3.
*  IF SY-SUBRC = 0.
*    READ TABLE LT_RETURN INDEX 1.
*    PI_MTART = LT_RETURN-FIELDVAL.
*  ENDIF.
*
*ENDFORM.
*&---------------------------------------------------------------------*
*& Form F4_H_LIFNR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> S_LIFNR_LOW
*&---------------------------------------------------------------------*
*FORM F4_H_LIFNR  USING   PI_LIFNR.
*
*  DATA : BEGIN OF LT_LIFNR OCCURS 0,
**          WERKS      LIKE MDLL-WERKS,
*           PARTNER   LIKE BUT000-PARTNER,
*           NAME_ORG1 LIKE BUT000-NAME_ORG1,
*         END OF LT_LIFNR.
*
**  DATA : BEGIN OF LT_CHECK OCCURS 0,
**          WERKS      LIKE MDLL-WERKS,
**          LBEAR      LIKE MDLL-LBEAR,
**         END OF LT_CHECK.
*
*  DATA: LT_RETURN TYPE DDSHRETVAL OCCURS 0.
*
*
*  SELECT FROM BUT000 AS A
*   INNER JOIN MDLL   AS B
*           ON B~LBEAR EQ A~PARTNER
*       FIELDS PARTNER, NAME_ORG1
*        WHERE A~PARTNER IN @S_LIFNR
*          AND A~TYPE EQ '2'
**          AND A~NAMCOUNTRY EQ @SY-LANGU
*         INTO CORRESPONDING FIELDS OF TABLE @LT_LIFNR.
*
*  SORT LT_LIFNR BY PARTNER.
*
*  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
*    EXPORTING
*      RETFIELD        = 'PARTNER'
*      DYNPPROG        = SY-REPID
*      DYNPNR          = SY-DYNNR
*      DYNPROFIELD     = 'S_LIFNR-LOW'
*      WINDOW_TITLE    = 'OEM Vendor'
*      VALUE_ORG       = 'S'
*    TABLES
*      VALUE_TAB       = LT_LIFNR
*      RETURN_TAB      = LT_RETURN[]
*    EXCEPTIONS
*      PARAMETER_ERROR = 1
*      NO_VALUES_FOUND = 2
*      OTHERS          = 3.
*
** FIELD 값 확인을 위한 강제 ENTER
*  CALL FUNCTION 'SAPGUI_SET_FUNCTIONCODE'
*    EXPORTING
*      FUNCTIONCODE           = 'ENTE'
*    EXCEPTIONS
*      FUNCTION_NOT_SUPPORTED = 1
*      OTHERS                 = 2.
*
*
*
*
*ENDFORM.
*&---------------------------------------------------------------------*
*& Form CACULATE_TOTAL_BATCH
*&---------------------------------------------------------------------*
*& Caculate_Batch Mode
*&---------------------------------------------------------------------*

FORM CACULATE_TOTAL_BATCH .

  DATA : BEGIN OF LT_MATNR OCCURS 0,
           MATNR LIKE MARA-MATNR,
         END OF LT_MATNR.
  DATA : LV_FIELDNAME  TYPE FIELDNAME,
         LV_FIELDNAME2 TYPE FIELDNAME,
         LV_FIELDNAME3 TYPE FIELDNAME.

  DATA : LDREF_TABLE TYPE REF TO DATA,
         LDREF_STRUC TYPE REF TO DATA.
  FIELD-SYMBOLS : <LT_BATCH> TYPE TABLE.

  FIELD-SYMBOLS: <FS_FIELD>    TYPE ANY,
                 <FS_WERKS>    TYPE ANY,
                 <FS_MATNR>    TYPE ANY,
                 <FS_CHARG>    TYPE ANY,
                 <FS_MAKTX>    TYPE ANY,
                 <FS_DMBTR_EI> TYPE ANY,
                 <FS_MENGE_EI> TYPE ANY,
                 <FS_MEINS>    TYPE ANY.

  CHECK <GT_BATCH>[] IS NOT INITIAL.

* Material Unit/Desc. READ

  CREATE DATA LDREF_TABLE LIKE <GT_BATCH>.
  ASSIGN LDREF_TABLE->* TO <LT_BATCH>.

  <LT_BATCH>[] = <GT_BATCH>[].

  SORT <LT_BATCH> BY (F_MATNR).
  DELETE ADJACENT DUPLICATES FROM <LT_BATCH> COMPARING (F_MATNR).
  IF <LT_BATCH>[] IS NOT INITIAL.
    LOOP AT <LT_BATCH> ASSIGNING FIELD-SYMBOL(<LS_BATCH>).
      CLEAR : LT_MATNR.
      ASSIGN COMPONENT 'MATNR' OF STRUCTURE <LS_BATCH> TO <FS_MATNR>.
      IF SY-SUBRC EQ 0.
        LT_MATNR-MATNR = <FS_MATNR>.
        APPEND LT_MATNR. CLEAR LT_MATNR.
      ENDIF.
    ENDLOOP.
    IF LT_MATNR[] IS NOT INITIAL.

      DATA(LT_MATNR2) = LT_MATNR[].
      SELECT A~MATNR, A~MEINS,
             B~MAKTX
      FROM MARA AS A LEFT OUTER JOIN MAKT AS B
                          ON B~MATNR EQ A~MATNR
                         AND B~SPRAS EQ @SY-LANGU
      JOIN @LT_MATNR2 AS C
                     ON C~MATNR EQ A~MATNR
      INTO TABLE @DATA(LT_MARA).
      SORT LT_MARA BY MATNR.

    ENDIF.
  ENDIF.

* Company Code data by PLANT

  SELECT A~BWKEY AS WERKS,
         A~BUKRS,
         B~WAERS
  INTO TABLE @DATA(LT_T001)
  FROM T001K AS A INNER JOIN T001 AS B
                     ON B~BUKRS EQ A~BUKRS
  ORDER BY A~BWKEY.

* Ending Inventory(QTY/AMT) 및 Ending Inventory_SG(QTY/AMT) 합계
* 누락 필드 FILL IN (MAKTX,MEINS,WAERS)

  SORT LT_MARA BY MATNR.
  LOOP AT <GT_BATCH> ASSIGNING <GS_BATCH>.

    PERFORM CLEAR_FIELD USING : <GS_BATCH> 'MENGE_EI',
                                <GS_BATCH> 'DMBTR_EI',
                                <GS_BATCH> 'DMAVG_EI',
                                <GS_BATCH> 'MENGE_SG_EI',
                                <GS_BATCH> 'DMBTR_SG_EI',
                                <GS_BATCH> 'DMAVG_SG_EI'.

* Group(QTY/AMT)

    LOOP AT GT_ZMMT0010 INTO DATA(LS_ZMMT0010).
      CLEAR LV_FIELDNAME.
      CONCATENATE 'MENGE_' LS_ZMMT0010-ZGROUP INTO LV_FIELDNAME.
      PERFORM ADD_FIELD USING : <GS_BATCH> 'MENGE_EI' LV_FIELDNAME.

      CLEAR LV_FIELDNAME2.
      CONCATENATE 'DMBTR_' LS_ZMMT0010-ZGROUP INTO LV_FIELDNAME2.
      PERFORM ADD_FIELD USING : <GS_BATCH> 'DMBTR_EI' LV_FIELDNAME2.
    ENDLOOP.

* Ending Inventory_SG(QTY/AMT) = 초기 재고 + 입출고

    PERFORM ADD_FIELD USING : <GS_BATCH> 'MENGE_EI' 'MENGE_BI',
                              <GS_BATCH> 'DMBTR_EI' 'DMBTR_BI'.

    ASSIGN COMPONENT 'DMBTR_EI' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_EI>.
    ASSIGN COMPONENT 'MENGE_EI' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_EI>.

    IF <FS_MENGE_EI> IS ASSIGNED AND <FS_DMBTR_EI> IS ASSIGNED.
      IF <FS_MENGE_EI> = 0 AND <FS_DMBTR_EI> NE 0.
        PERFORM CLEAR_FIELD USING : <GS_BATCH> 'DMBTR_EI'.
      ENDIF.
    ENDIF.

* Fill in Material Desc/Unit

    ASSIGN COMPONENT 'MEINS' OF STRUCTURE <GS_BATCH> TO <FS_MEINS>.
    ASSIGN COMPONENT 'MAKTX' OF STRUCTURE <GS_BATCH> TO <FS_MAKTX>.
    IF  <FS_MEINS> IS INITIAL OR <FS_MAKTX> IS INITIAL.
      ASSIGN COMPONENT 'MATNR' OF STRUCTURE <GS_BATCH> TO <FS_MATNR>.

      READ TABLE LT_MARA INTO DATA(LS_MARA)
                         WITH KEY MATNR = <FS_MATNR>
                         BINARY SEARCH.
      IF SY-SUBRC EQ 0.
        IF <FS_MEINS> IS INITIAL.
          <FS_MEINS> = LS_MARA-MEINS.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDLOOP.

  SORT <GT_TABLE> BY (F_MATNR) (F_WERKS).

  IF P_VAL = C_X.

*   송장으로 인한 원가 산입 금액 기말 금액에 추가-mlee463-26.04.17

    MOVE-CORRESPONDING <GT_BATCH> TO GT_TEMP[].

* 1차 원가 산입 금액 취합

    SELECT A~MATNR,
           A~WERKS,
           A~BWTAR AS CHARG,
           D~CLABS AS SUM_MCHB,

*         SUM( A~STOCK_POSTING ) AS PRD_AMT,

      CASE A~XRUEB WHEN 'X' THEN CASE B~VGART WHEN 'KP' THEN SUM( A~STOCK_POSTING )
                                              ELSE SUM( A~STOCK_POSTING_PP ) END
                   ELSE SUM( A~STOCK_POSTING ) END AS PRD_AMT
          FROM RSEG AS A
          INNER JOIN RBKP AS B
                  ON A~BELNR = B~BELNR
                 AND A~GJAHR = B~GJAHR
          INNER JOIN @GT_TEMP AS C
                  ON A~MATNR = C~MATNR
                 AND A~WERKS = C~WERKS
                 AND A~BWTAR = C~CHARG
          INNER JOIN MCHB AS D
                  ON A~MATNR = D~MATNR
                 AND A~WERKS = D~WERKS
                 AND A~BWTAR = D~CHARG
               WHERE B~STBLG = ''
                 AND ( A~STOCK_POSTING NE ' ' OR A~STOCK_POSTING_PP NE ' ')
                 AND B~BUDAT BETWEEN @S_BUDAT-LOW AND @S_BUDAT-HIGH
                 AND A~MATNR IN @S_MATNR
                 AND A~WERKS IN @S_WERKS
                 AND B~BUKRS IN @S_BUKRS
            GROUP BY A~MATNR, A~WERKS, A~BWTAR, D~CLABS, A~XRUEB, B~VGART
                INTO TABLE @DATA(LT_RSEG2).

* 원가 산입 금액 Roll-up 합계

    SELECT A~MATNR, A~WERKS, A~CHARG,
           SUM( A~SUM_MCHB ) AS SUM_MCHB,
           SUM( A~PRD_AMT ) AS PRD_AMT
      FROM @LT_RSEG2 AS A
     GROUP BY A~MATNR, A~WERKS, A~CHARG
         INTO TABLE @DATA(LT_RSEG).

    SORT LT_RSEG BY MATNR WERKS CHARG.

* Stock_Posting 이 존재하는 경우, 금액 추가

    IF LT_RSEG[] IS NOT INITIAL.

      LOOP AT <GT_BATCH> ASSIGNING <GS_BATCH>.

        ASSIGN COMPONENT 'MATNR' OF STRUCTURE <GS_BATCH> TO <FS_MATNR>.
        ASSIGN COMPONENT 'WERKS' OF STRUCTURE <GS_BATCH> TO <FS_WERKS>.
        ASSIGN COMPONENT 'CHARG' OF STRUCTURE <GS_BATCH> TO <FS_CHARG>.

        READ TABLE LT_RSEG INTO DATA(LS_RSEG) WITH KEY MATNR = <FS_MATNR>
                                                       WERKS = <FS_WERKS>
                                                       CHARG = <FS_CHARG>
                                                       BINARY SEARCH.
        IF SY-SUBRC = 0.

          ASSIGN COMPONENT 'DMBTR_EI' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_EI>.
          ASSIGN COMPONENT 'MENGE_EI' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_EI>.

          IF LS_RSEG-SUM_MCHB NE '0'.
            <FS_DMBTR_EI> = <FS_DMBTR_EI> + ( LS_RSEG-PRD_AMT / LS_RSEG-SUM_MCHB ) * <FS_MENGE_EI>. " 재고산입금액 / MCHB 전제수량 * 저장위치별 기말재고 수량

*        <FS_DMBTR_EI> = <FS_DMBTR_EI> + LS_RSEG-PRD_AMT. " 재고 산입금액 (추가 의사결정 必)

          ELSE.
            <FS_DMBTR_EI> = 0.
          ENDIF.
        ENDIF.

      ENDLOOP.
    ENDIF.

*<---*   송장으로 인한 원가 산입 금액 기말 금액에 추가-mlee463-26.04.17

  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form DELETE_DUMMY_BATCH
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*

FORM DELETE_DUMMY_BATCH .

  DATA LT_INDEX_ROWS TYPE LVC_T_ROW.
  DATA LS_INDEX_ROW  LIKE LINE OF LT_INDEX_ROWS.
  DATA: LT_TABLE TYPE REF TO DATA,
        LS_TABLE TYPE REF TO DATA.

  FIELD-SYMBOLS: <LS_TABLE>     TYPE ANY,
                 <FS_CLABS>     TYPE ANY,

*                 <FS_CLABS>     TYPE ANY, " " VR, VQ 재고 추가 -24.10.25

                 <FS_MENGE_BI>  TYPE ANY,
                 <FS_MENGE_EI>  TYPE ANY,
                 <FS_MENGE_GI1> TYPE ANY,
                 <FS_MENGE_GI2> TYPE ANY,
                 <FS_MENGE_GI3> TYPE ANY,
                 <FS_MENGE_GI4> TYPE ANY,

*                 <FS_MENGE_GI5> TYPE ANY,

                 <FS_MENGE_GR1> TYPE ANY,
                 <FS_MENGE_GR2> TYPE ANY,
                 <FS_MENGE_GR3> TYPE ANY,
                 <FS_MENGE_GR4> TYPE ANY,
                 <FS_MENGE_GR5> TYPE ANY,
                 <LS_DISP>      TYPE ANY.

  CREATE DATA LS_TABLE LIKE LINE OF <GT_BATCH>.
  ASSIGN LS_TABLE->* TO <LS_DISP>.

  LOOP AT <GT_BATCH> ASSIGNING <LS_DISP>.

    ASSIGN COMPONENT: 'CLABS'    OF STRUCTURE <LS_DISP> TO <FS_CLABS>,
                      'MENGE_BI' OF STRUCTURE <LS_DISP> TO <FS_MENGE_BI>,
                      'MENGE_EI' OF STRUCTURE <LS_DISP> TO <FS_MENGE_EI>,

*                      'CLABS' OF STRUCTURE <LS_DISP> TO <FS_CLABS>, " VR, VQ 재고 추가 -24.10.25

                      'MENGE_GI1' OF STRUCTURE <LS_DISP> TO <FS_MENGE_GI1>,
                      'MENGE_GI2' OF STRUCTURE <LS_DISP> TO <FS_MENGE_GI2>,
                      'MENGE_GI3' OF STRUCTURE <LS_DISP> TO <FS_MENGE_GI3>,
                      'MENGE_GI4' OF STRUCTURE <LS_DISP> TO <FS_MENGE_GI4>,

*                      'MENGE_GI5' OF STRUCTURE <LS_DISP> TO <FS_MENGE_GI5>,

                      'MENGE_GR1' OF STRUCTURE <LS_DISP> TO <FS_MENGE_GR1>,
                      'MENGE_GR2' OF STRUCTURE <LS_DISP> TO <FS_MENGE_GR2>,
                      'MENGE_GR3' OF STRUCTURE <LS_DISP> TO <FS_MENGE_GR3>,
                      'MENGE_GR4' OF STRUCTURE <LS_DISP> TO <FS_MENGE_GR4>,
                      'MENGE_GR5' OF STRUCTURE <LS_DISP> TO <FS_MENGE_GR5>.

    IF <FS_CLABS> IS INITIAL AND
       <FS_MENGE_BI> IS INITIAL AND
       <FS_MENGE_EI> IS INITIAL AND

*       <FS_CLABS> IS INITIAL AND " VR, VQ 재고 추가 -24.10.25

       <FS_MENGE_GI1> IS INITIAL AND
       <FS_MENGE_GI2> IS INITIAL AND
       <FS_MENGE_GI3> IS INITIAL AND
       <FS_MENGE_GI4> IS INITIAL AND

*       <FS_MENGE_GI5> IS INITIAL AND

       <FS_MENGE_GR1> IS INITIAL AND
       <FS_MENGE_GR2> IS INITIAL AND
       <FS_MENGE_GR3> IS INITIAL AND
       <FS_MENGE_GR4> IS INITIAL AND
       <FS_MENGE_GR5> IS INITIAL.

      DELETE <GT_BATCH> INDEX SY-TABIX.

    ENDIF.
  ENDLOOP.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form MATERIAL_DOC_BASIC_STOCK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*

FORM MATERIAL_DOC_BASIC_STOCK .

  DATA : LV_LFGJA    LIKE MCHBH-LFGJA,
         LV_LFMON    LIKE MCHBH-LFMON,
         LV_DATE     TYPE DATUM,
         LV_SLLAB    LIKE MSSL-SLLAB,
         LV_JAHRPER  TYPE MLDOC-JAHRPER,
         LV_MENGE_BI LIKE MATDOC-STOCK_QTY,
         LV_DMBTR_BI LIKE MATDOC-DMBTR_STOCK.
  DATA: LV_SUBRC TYPE SY-SUBRC,
        LV_INDEX TYPE SY-TABIX.
  DATA : LT_ZMMT0010 LIKE ZMMPAT52000 OCCURS 0 WITH HEADER LINE.
  DATA : LT_HEAD_0400 LIKE GT_BATCH_0400 OCCURS 0 WITH HEADER LINE.
  DATA : LS_BATCH_0400 LIKE GT_BATCH_0400.
  DATA : LV_FIELDNAME TYPE FIELDNAME,
         LV_PARTNER   LIKE BUT000-PARTNER,
         LV_NAME_ORG1 LIKE BUT000-NAME_ORG1.
  DATA : LS_RAW_0400 LIKE LINE OF GT_BATCH_0400,
         LT_RAW_0400 LIKE GT_BATCH_0400 OCCURS 0.
  DATA : LS_RAW      LIKE LINE OF GT_RAW_DISP.
  DATA : LV_LGORT TYPE LGORT_D.
  DATA : BEGIN OF LT_MBEWH OCCURS 0,
           MATNR LIKE CKMLHD-MATNR,
           WERKS TYPE WERKS_D,
           CHARG TYPE CHARG_D,
           SOBKZ LIKE CKMLHD-SOBKZ,
           MENGE LIKE MLDOC_EXTRACT-QUANT,
         END OF LT_MBEWH.

  FIELD-SYMBOLS: <FS_FIELD>    TYPE ANY,
                 <FS_WERKS>    TYPE ANY,
                 <FS_MATNR>    TYPE ANY,
                 <FS_MAKTX>    TYPE ANY,
                 <FS_MEINS>    TYPE ANY,
                 <FS_LGORT>    TYPE ANY,
                 <FS_LIFNR>    TYPE ANY,
                 <FS_CHARG>    TYPE ANY,
                 <FS_VERPR>    TYPE ANY,
                 <FS_MENGE_BI> TYPE ANY,
                 <FS_DMBTR_BI> TYPE ANY,
                 <FS_CLABS>    TYPE ANY.

*
* Dynamic table build Start - SCREEN 0400

  DATA: LT_TABLE TYPE REF TO DATA,
        LS_TABLE TYPE REF TO DATA.

*  CHECK GT_DISP_SCR[] IS NOT INITIAL.
*  SORT GT_DISP_SCR BY MATNR WERKS LGORT CHARG.

* Create 0400 SCREEN

  CALL METHOD CL_ALV_TABLE_CREATE=>CREATE_DYNAMIC_TABLE
    EXPORTING
      IT_FIELDCATALOG = GT_ALV_FIELDCAT_400[]
    IMPORTING
      EP_TABLE        = LT_TABLE.

  ASSIGN LT_TABLE->* TO <GT_BATCH>.
  CREATE DATA LS_TABLE LIKE LINE OF <GT_BATCH>.
  ASSIGN LS_TABLE->* TO <GS_BATCH>.

* Dynamic table build End - SCREEN 0400

*--------------------------------------------------------------------*

  CLEAR : <GT_BATCH>, <GT_BATCH>[], <GS_BATCH>.

  LT_ZMMT0010[] = GT_ZMMT0010[].
  SORT LT_ZMMT0010 BY ZGROUP.

*--------------------------------------------------------------------*
* Total stocks

  SELECT E~BUKRS,                     " 회사코드
         A~WERKS,                     " 플랜트
         A~MATNR,                     " 자재번호
         B~MAKTX,                     " 자재내역(명)

*         A~SOBKZ,
*         A~LIFNR,
*         C~NAME_ORG1 AS LIFNR_TX,

         A~LGORT,                     " 저장위치
         H~LGOBE,                     " 저장위치명
         A~CHARG,                     " 배치(Batch)
         E~WAERS,                     " 통화
         G~VERPR,                     " 이동평균가
         SUM( A~CLABS ) AS CLABS
   INTO CORRESPONDING FIELDS OF TABLE @LT_RAW_0400
        FROM MCHB AS A
        JOIN MARA AS F
          ON F~MATNR EQ A~MATNR
        LEFT OUTER JOIN MAKT AS B
          ON B~MATNR EQ A~MATNR
         AND B~SPRAS EQ @SY-LANGU

*        LEFT OUTER JOIN BUT000 AS C
*          ON C~PARTNER EQ A~LIFNR

        JOIN T001K AS D
          ON D~BWKEY EQ A~WERKS
        LEFT OUTER JOIN T001 AS E
          ON E~BUKRS EQ D~BUKRS
        JOIN MBEW AS G
          ON G~MATNR EQ A~MATNR
         AND G~BWKEY EQ A~WERKS
         AND G~BWTAR EQ A~CHARG
        LEFT OUTER JOIN T001L AS H
          ON A~LGORT = H~LGORT
         AND A~WERKS = H~WERKS
        JOIN MCHA AS I
          ON A~MATNR = I~MATNR
         AND A~WERKS = I~WERKS
         AND A~CHARG = I~CHARG
         AND I~LVORM = ''
        WHERE A~MATNR IN @S_MATNR
          AND A~WERKS IN @S_WERKS
          AND A~LGORT IN @S_LGORT

*          AND A~LIFNR IN @S_LIFNR
*          AND F~MTART IN @S_MTART

          AND A~CHARG IN @GR_CHARG
          AND D~BUKRS IN @S_BUKRS

*          AND A~CLABS NE 0 "2026.04.28 주석
*          AND A~SOBKZ EQ 'O'

     GROUP BY E~BUKRS, A~WERKS, A~MATNR, B~MAKTX, A~LGORT, H~LGOBE, A~CHARG, E~WAERS, G~VERPR.

  IF P_VAL9 = ABAP_TRUE.

**사급재고일 경우 현재 재고를 MSLB에서 추가해준다.
* Special Stocks with Supplier / 현재고

    SELECT E~BUKRS,                   " 회사코드
           E~WAERS,                   " 통화
           A~WERKS,                   " 플랜트
           A~MATNR,                   " 자재번호
           B~MAKTX,                   " 자재내역(명)
           A~CHARG,                   " 배치(Batch)

*         A~SOBKZ,

           A~LIFNR,                   " 공급처(Vendor)
           C~NAME_ORG1 AS LIFNR_TX,   " 공급처명
           G~VERPR,                   " 이동평균가

*         ' ' AS LGORT,
*         ' ' AS LGOBE,

           SUM( A~LBLAB ) AS CLABS
     APPENDING CORRESPONDING FIELDS OF TABLE @LT_RAW_0400
          FROM MSLB AS A
          JOIN MARA AS F
            ON F~MATNR EQ A~MATNR
          LEFT OUTER JOIN MAKT AS B
            ON B~MATNR EQ A~MATNR
           AND B~SPRAS EQ @SY-LANGU
          LEFT OUTER JOIN BUT000 AS C
            ON C~PARTNER EQ A~LIFNR
          JOIN T001K AS D
            ON D~BWKEY EQ A~WERKS
          LEFT OUTER JOIN T001 AS E
            ON E~BUKRS EQ D~BUKRS
          LEFT OUTER JOIN MBEW AS G
            ON G~MATNR EQ A~MATNR
           AND G~BWKEY EQ A~WERKS
           AND G~BWTAR EQ ''
          WHERE A~MATNR IN @S_MATNR
            AND A~WERKS IN @S_WERKS

*            AND A~LIFNR IN @S_LIFNR

            AND A~CHARG IN @S_CHARG

*            AND F~MTART IN @S_MTART

            AND D~BUKRS IN @S_BUKRS
            AND A~SOBKZ EQ 'O'
       GROUP BY E~BUKRS, E~WAERS, A~WERKS, A~MATNR, B~MAKTX, A~CHARG, A~LIFNR, C~NAME_ORG1, G~VERPR.
  ENDIF.

*--------------------------------------------------------------------*

*  IF LT_RAW_0400[] IS NOT INITIAL.

  SORT LT_RAW_0400 BY BUKRS WERKS MATNR LIFNR CHARG.

*    LOOP AT LT_MCHB INTO DATA(LS_MCHB).
*      READ TABLE LT_RAW_0400 INTO LS_RAW_0400 WITH KEY BUKRS = LS_MCHB-BUKRS
*                                                       WERKS = LS_MCHB-WERKS
*                                                       MATNR = LS_MCHB-MATNR
*                                                       LIFNR = LS_MCHB-LIFNR
*                                                       CHARG = LS_MCHB-CHARG
*                                                       BINARY SEARCH.
*
**   사급자재 Stock 존재하는 경우 -> LT_RAW_0400에 modify
*      IF SY-SUBRC EQ 0.
*        LV_INDEX = SY-TABIX.
*        LS_RAW_0400-CLABS  = LS_MCHB-CLABS.
*        LS_RAW_0400-STPRS2 = LS_MCHB-STPRS2.
*        MODIFY LT_RAW_0400 FROM LS_RAW_0400 INDEX LV_INDEX.
*        CLEAR : LS_MCHB.
*
**   사급자재 Stock 존재하지 않는 경우 -> LT_RAW_0400에 add
*      ELSE.
*        CLEAR LS_RAW_0400.
*        MOVE-CORRESPONDING LS_MCHB TO LS_RAW_0400.
*        APPEND LS_RAW_0400 TO LT_RAW_0400.
*        CLEAR: LS_MCHB.
*      ENDIF.
*
*    ENDLOOP.

*   ITAB에 값 존재하지 않는 경우  LT_RAW_0400에 Append
*  ELSE.

*    LOOP AT LT_MCHB ASSIGNING FIELD-SYMBOL(<FS_MCHB>).
*      CLEAR: LT_RAW_0400[], LS_RAW_0400.
*      MOVE-CORRESPONDING <FS_MCHB> TO LS_RAW_0400.
*      APPEND LS_RAW_0400 TO LT_RAW_0400.
*    ENDLOOP.

*  ENDIF.

*--------------------------------------------------------------------*
* BATCH 기초수량
* Material Document

  SELECT A~BUKRS                      " 회사코드
         A~MJAHR                      " 자재문서연도
         A~MBLNR                      " 자재문서번호
         A~MATNR                      " 자재번호
         B~MAKTX                      " 자재내역(명)
         A~WERKS                      " 플랜트
         A~LGORT                      " 저장위치
         I~LGOBE                      " 저장위치명
         A~CHARG                      " 배치(Batch)
         A~SOBKZ                      " 특별재고지시자
         A~LIFNR_SID AS LIFNR         " 공급처(Vendor)
         D~NAME_ORG1 AS LIFNR_TX      " 공급처명
         A~MENGE                      " 수량
         A~DMBTR                      " 금액(현지통화)
         A~WAERS                      " 통화
         A~BWART                      " 이동유형
         A~GRUND                      " 이동사유
         A~SHKZG                      " 차변/대변 지시자
         A~MEINS                      " 기본단위
         A~WAERS                      " 통화
         A~ZEILE                      " 자재문서항목
         E~MTART                      " 자재유형
         A~VGART            "CHECK
         A~BUDAT            " 전기일 추가
         F~VERPR                      " 이동평균가
         A~SALK3                      " 총평가액
         A~LBKUM                      " 총평가재고수량

*         H~BEIKZ

         H~ZGROUP                     " 이동유형 그룹코드
    INTO CORRESPONDING FIELDS OF TABLE GT_BATCH_0400
                       FROM MATDOC AS A
                       LEFT OUTER JOIN MAKT AS B
                         ON B~MATNR EQ A~MATNR
                        AND B~SPRAS EQ SY-LANGU
                       LEFT OUTER JOIN BUT000 AS D
                         ON D~PARTNER EQ A~LIFNR_SID
                       LEFT OUTER JOIN MARA AS E
                         ON E~MATNR EQ A~MATNR
                       LEFT OUTER JOIN MBEW AS F
                         ON F~MATNR EQ A~MATNR
                        AND F~BWKEY EQ A~WERKS
                        AND F~BWTAR EQ A~CHARG
                       JOIN ZMMPAT52010 AS H
                         ON H~BWART EQ A~BWART
                       LEFT OUTER JOIN T001L AS I
                         ON A~LGORT = I~LGORT
    WHERE A~RECORD_TYPE EQ 'MDOC'

*        AND A~XAUTO EQ SPACE
*        AND A~MJAHR EQ P_LFGJA

      AND A~BUDAT BETWEEN S_BUDAT-LOW AND S_BUDAT-HIGH
      AND A~MATNR IN S_MATNR
      AND A~WERKS IN S_WERKS "PLANT with Auth
      AND A~LGORT IN S_LGORT

*      AND A~LIFNR_SID IN S_LIFNR " Vendor 추가 / 24.08.19
*        AND A~LGORT IN S_LGORT

      AND A~CHARG IN GR_CHARG
      AND A~BUKRS IN S_BUKRS
      AND A~MATNR NE ''
      AND A~CHARG NE ''.

*      AND A~SOBKZ EQ 'O'.

  SORT GT_BATCH_0400 BY BUDAT MBLNR ZEILE MATNR CHARG LGORT.
  DELETE ADJACENT DUPLICATES FROM GT_BATCH_0400 COMPARING BUDAT MBLNR ZEILE MATNR CHARG LGORT.

*  DELETE GT_BATCH_0400 WHERE MATNR IS INITIAL. " 자재코드 없는 이력 제외 2024.08.13
*  DELETE GT_BATCH_0400 WHERE CHARG IS INITIAL. " batch 없는 이력 제외 2024.08.13

*사급자재 포함이 아닌 경우

  IF P_VAL9 = ABAP_FALSE.
    DELETE GT_BATCH_0400 WHERE LGORT = '' AND LIFNR NE ''.
  ENDIF.

*--------------------------------------------------------------------*

  SORT GT_BATCH_0400 BY MATNR WERKS LGORT CHARG LIFNR.
  LOOP AT LT_RAW_0400 INTO LS_RAW_0400.

    READ TABLE GT_BATCH_0400 TRANSPORTING NO FIELDS
                             WITH KEY MATNR = LS_RAW_0400-MATNR
                                      WERKS = LS_RAW_0400-WERKS
                                      LGORT = LS_RAW_0400-LGORT
                                      CHARG = LS_RAW_0400-CHARG
                                      LIFNR = LS_RAW_0400-LIFNR

*                                      SOBKZ = LS_RAW_0400-SOBKZ

                             BINARY SEARCH.

    IF SY-SUBRC EQ 0.
      MODIFY GT_BATCH_0400 FROM LS_RAW_0400 INDEX SY-TABIX
                                            TRANSPORTING CLABS.
    ELSE.
      APPEND LS_RAW_0400 TO GT_BATCH_0400.
    ENDIF.

  ENDLOOP.

*--------------------------------------------------------------------*

  DELETE GT_BATCH_0400 WHERE CHARG IS INITIAL. " batch 없는 이력 제외

*--STO 금액 변환

  DATA(LT_STO) = GT_BATCH_0400[].
  DELETE LT_STO WHERE DMBTR NE 0.
  DELETE LT_STO WHERE BWART NE '101'.

  SELECT A~MJAHR,                     " 자재문서연도
         A~MBLNR,                     " 자재문서번호
         A~ZEILE,                     " 자재문서항목
         A~MATNR,                     " 자재번호
         A~WERKS,                     " 플랜트
         A~LGORT_CID AS LGORT,        " 저장위치
         A~CHARG_CID AS CHARG,        " 배치(Batch)
         A~DMBTR                      " 금액(현지통화)
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

*--------------------------------------------------------------------*

  SORT GT_GROUP BY BWART GRUND.
  LOOP AT GT_BATCH_0400 ASSIGNING FIELD-SYMBOL(<FS_BATCH_0400>).

*--STO 금액 변환

    IF <FS_BATCH_0400>-BWART = '101' AND <FS_BATCH_0400>-DMBTR = 0.
      READ TABLE LT_STO_DMBTR INTO DATA(LS_STO_DMBTR) WITH KEY MJAHR = <FS_BATCH_0400>-MJAHR
                                                               MBLNR = <FS_BATCH_0400>-MBLNR
                                                               ZEILE = <FS_BATCH_0400>-ZEILE
                                                               MATNR = <FS_BATCH_0400>-MATNR
                                                               WERKS = <FS_BATCH_0400>-WERKS
                                                               LGORT = <FS_BATCH_0400>-LGORT
                                                               CHARG = <FS_BATCH_0400>-CHARG
                                                               BINARY SEARCH.
      IF SY-SUBRC = 0.
        <FS_BATCH_0400>-DMBTR = LS_STO_DMBTR-DMBTR.
      ENDIF.
    ENDIF.
    CLEAR LS_STO_DMBTR.

    READ TABLE GT_GROUP INTO DATA(LS_GROUP)
                        WITH KEY BWART = <FS_BATCH_0400>-BWART
                                 GRUND = <FS_BATCH_0400>-GRUND
                        BINARY SEARCH.
    IF SY-SUBRC NE 0.
      READ TABLE GT_GROUP INTO LS_GROUP
                     WITH KEY BWART = <FS_BATCH_0400>-BWART
                     BINARY SEARCH.
      IF SY-SUBRC NE 0.
        CASE <FS_BATCH_0400>-SHKZG.
          WHEN 'H'.
            <FS_BATCH_0400>-ZGROUP = GV_GI_ETC.
          WHEN 'S'.
            <FS_BATCH_0400>-ZGROUP = GV_GR_ETC.
        ENDCASE.
      ELSE.
        <FS_BATCH_0400>-ZGROUP = LS_GROUP-ZGROUP.
      ENDIF.
    ELSE.
      <FS_BATCH_0400>-ZGROUP = LS_GROUP-ZGROUP.
    ENDIF.

    "특정 이동유형은 금액 필드를 바꿔준다.(CO요청)
    IF <FS_BATCH_0400>-BWART = 'Z13' OR <FS_BATCH_0400>-BWART = 'Z14' OR
       <FS_BATCH_0400>-BWART = '311' OR  <FS_BATCH_0400>-BWART = '312' OR
       <FS_BATCH_0400>-BWART = '541' OR  <FS_BATCH_0400>-BWART = '542'.

*  전기 이전의 전체평가재고 & 전기하기 전의 전체평가재고 값 & 이전전기 수량 고려

      IF  <FS_BATCH_0400>-LBKUM NE '0'.
        <FS_BATCH_0400>-DMBTR = ( <FS_BATCH_0400>-SALK3 / <FS_BATCH_0400>-LBKUM ) * <FS_BATCH_0400>-MENGE.
      ELSE.
        <FS_BATCH_0400>-DMBTR = <FS_BATCH_0400>-SALK3.
      ENDIF.

    ENDIF.

    IF ( <FS_BATCH_0400>-ZGROUP(2) = 'GR' AND <FS_BATCH_0400>-SHKZG = 'H' ) OR
       ( <FS_BATCH_0400>-ZGROUP(2) = 'GI' AND <FS_BATCH_0400>-SHKZG = 'H' ).
      <FS_BATCH_0400>-MENGE = <FS_BATCH_0400>-MENGE * -1.
      <FS_BATCH_0400>-DMBTR = <FS_BATCH_0400>-DMBTR * -1.
    ELSE.

*      <FS_RAW>-MENGE.
*      <FS_RAW>-DMBTR.

    ENDIF.

  ENDLOOP.

* STO 운송중 재고 추가

  SELECT M1~BUKRS,                    " 회사코드
         M1~MJAHR,                    " 자재문서연도
         M1~MBLNR,                    " 자재문서번호
         M1~MATNR,                    " 자재번호
         B~MAKTX,                     " 자재내역(명)
         M1~WERKS,                    " 플랜트
         M1~LGORT,                    " 저장위치
         M1~MEINS,                    " 기본단위
         M1~MENGE,                    " 수량
         M1~BWTAR AS CHARG,           " 평가유형
         M1~BWART,                    " 이동유형
         M1~SHKZG,                    " 차변/대변 지시자
         M1~DMBTR,                    " 금액(현지통화)
         M1~BUDAT,                    " 전기일
         M1~WAERS,                    " 통화
         'GR5' AS ZGROUP
    FROM MATDOC AS M1 LEFT OUTER JOIN MAKT AS B
                                   ON B~MATNR EQ M1~MATNR
                                  AND B~SPRAS EQ @SY-LANGU
    APPENDING CORRESPONDING FIELDS OF TABLE @GT_BATCH_0400
   WHERE M1~BWART             = '641'
     AND M1~XAUTO             = 'X'
     AND M1~CANCELLED         = ''
     AND M1~CANCELLATION_TYPE = ''
     AND M1~EBELN            <> ''
     AND M1~VBELN_IM         <> ''
     AND M1~BUDAT BETWEEN @S_BUDAT-LOW AND @S_BUDAT-HIGH
     AND M1~MATNR IN @S_MATNR
     AND M1~WERKS IN @S_WERKS
     AND M1~LGORT IN @S_LGORT
     AND M1~BWTAR IN @GR_CHARG
     AND M1~BUKRS IN @S_BUKRS
     AND NOT EXISTS ( SELECT MBLNR
                        FROM MATDOC
                       WHERE EBELN             = M1~EBELN
                         AND EBELP             = M1~EBELP
                         AND VBELN_IM          = M1~VBELN_IM
                         AND VBELP_IM          = M1~VBELP_IM
                         AND BUDAT BETWEEN @S_BUDAT-LOW AND @S_BUDAT-HIGH
                         AND BWTAR             = M1~BWTAR
                         AND BWART             = '101'
                         AND CANCELLED         = ''
                         AND CANCELLATION_TYPE = ''
                    ).

  IF GT_BATCH_0400[] IS NOT INITIAL.
    SORT GT_BATCH_0400 BY MATNR WERKS LGORT CHARG LIFNR ASCENDING CLABS DESCENDING.
    LT_HEAD_0400[] = GT_BATCH_0400[].
    DELETE ADJACENT DUPLICATES FROM LT_HEAD_0400 COMPARING MATNR WERKS LGORT CHARG LIFNR.

    DATA(LT_POR) = LT_HEAD_0400[].
  ENDIF.

  IF LT_POR[] IS NOT INITIAL.
    SELECT DISTINCT A~MATNR, A~CHARG, A~ZZPOR, A~ZZSTOCKCD, C~DDTEXT, D~MATKL
      FROM MCHA AS A JOIN @LT_POR AS B
                       ON A~MATNR = B~MATNR
                      AND A~CHARG = B~CHARG
                     JOIN MARA AS D
                       ON A~MATNR = D~MATNR
          LEFT OUTER JOIN DD07V AS C
                       ON A~ZZSTOCKCD  = C~DOMVALUE_L
                      AND C~DOMNAME    = 'ZD_ZZSTOCKCD'
                      AND C~DDLANGUAGE = @SY-LANGU
      INTO TABLE @DATA(LT_ZZSTOCKCD).
    SORT LT_ZZSTOCKCD BY MATNR CHARG.
  ENDIF.

*--------------------------------------------------------------------*

  DATA(LT_BB) = GT_BATCH_0400[].
* 🔧[R] 이동유형 그룹(GI1~GR5)별 수량/금액을 CASE WHEN으로 피벗(+SUM CTE)
*       → MATNR/WERKS/LGORT/CHARG/LIFNR 단위로 SUM 집계 (FS §4)
  WITH +SUM AS ( SELECT A~MATNR, A~WERKS, A~LGORT, A~CHARG, A~LIFNR,
                        CASE WHEN ZGROUP EQ 'GI1' THEN MENGE END AS MENGE_GI1,
                        CASE WHEN ZGROUP EQ 'GI2' THEN MENGE END AS MENGE_GI2,
                        CASE WHEN ZGROUP EQ 'GI3' THEN MENGE END AS MENGE_GI3,
                        CASE WHEN ZGROUP EQ 'GI4' THEN MENGE END AS MENGE_GI4,
                        CASE WHEN ZGROUP EQ 'GR1' THEN MENGE END AS MENGE_GR1,
                        CASE WHEN ZGROUP EQ 'GR2' THEN MENGE END AS MENGE_GR2,
                        CASE WHEN ZGROUP EQ 'GR3' THEN MENGE END AS MENGE_GR3,
                        CASE WHEN ZGROUP EQ 'GR4' THEN MENGE END AS MENGE_GR4,
                        CASE WHEN ZGROUP EQ 'GR5' THEN MENGE END AS MENGE_GR5,
                        CASE WHEN ZGROUP EQ 'GI1' THEN DMBTR END AS DMBTR_GI1,
                        CASE WHEN ZGROUP EQ 'GI2' THEN DMBTR END AS DMBTR_GI2,
                        CASE WHEN ZGROUP EQ 'GI3' THEN DMBTR END AS DMBTR_GI3,
                        CASE WHEN ZGROUP EQ 'GI4' THEN DMBTR END AS DMBTR_GI4,
                        CASE WHEN ZGROUP EQ 'GR1' THEN DMBTR END AS DMBTR_GR1,
                        CASE WHEN ZGROUP EQ 'GR2' THEN DMBTR END AS DMBTR_GR2,
                        CASE WHEN ZGROUP EQ 'GR3' THEN DMBTR END AS DMBTR_GR3,
                        CASE WHEN ZGROUP EQ 'GR4' THEN DMBTR END AS DMBTR_GR4,
                        CASE WHEN ZGROUP EQ 'GR5' THEN DMBTR END AS DMBTR_GR5
                   FROM @LT_BB AS A )
  SELECT A~MATNR, A~WERKS, A~LGORT, A~CHARG, A~LIFNR,
         SUM( A~MENGE_GI1 ) AS MENGE_GI1,
         SUM( A~MENGE_GI2 ) AS MENGE_GI2,
         SUM( A~MENGE_GI3 ) AS MENGE_GI3,
         SUM( A~MENGE_GI4 ) AS MENGE_GI4,
         SUM( A~MENGE_GR1 ) AS MENGE_GR1,
         SUM( A~MENGE_GR2 ) AS MENGE_GR2,
         SUM( A~MENGE_GR3 ) AS MENGE_GR3,
         SUM( A~MENGE_GR4 ) AS MENGE_GR4,
         SUM( A~MENGE_GR5 ) AS MENGE_GR5,
         SUM( A~DMBTR_GI1 ) AS DMBTR_GI1,
         SUM( A~DMBTR_GI2 ) AS DMBTR_GI2,
         SUM( A~DMBTR_GI3 ) AS DMBTR_GI3,
         SUM( A~DMBTR_GI4 ) AS DMBTR_GI4,
         SUM( A~DMBTR_GR1 ) AS DMBTR_GR1,
         SUM( A~DMBTR_GR2 ) AS DMBTR_GR2,
         SUM( A~DMBTR_GR3 ) AS DMBTR_GR3,
         SUM( A~DMBTR_GR4 ) AS DMBTR_GR4,
         SUM( A~DMBTR_GR5 ) AS DMBTR_GR5
    FROM +SUM AS A
   GROUP BY A~MATNR, A~WERKS, A~LGORT, A~CHARG, A~LIFNR
   ORDER BY A~MATNR, A~WERKS, A~LGORT, A~CHARG, A~LIFNR
    INTO TABLE @DATA(LT_SUM2).

  "수량이 0인것은 지운다.
  DELETE LT_SUM2 WHERE MENGE_GI1 EQ 0 AND MENGE_GI2 EQ 0 AND
                       MENGE_GI3 EQ 0 AND MENGE_GI4 EQ 0 AND
                       MENGE_GR1 EQ 0 AND MENGE_GR2 EQ 0 AND
                       MENGE_GR3 EQ 0 AND MENGE_GR4 EQ 0 AND
                       MENGE_GR5 EQ 0.

  SORT LT_SUM2 BY MATNR WERKS LGORT CHARG LIFNR.  " 🔒[S] BINARY SEARCH 전 명시 SORT (FS §6: ORDER BY와 동일키 명시화)

  LOOP AT LT_HEAD_0400 INTO DATA(LS_ITAB).

    LS_ITAB-VERPR  = LS_ITAB-CLABS * LS_ITAB-VERPR.

    CLEAR <GS_BATCH>.
    PERFORM INPUT_VALUE USING
          : <GS_BATCH> 'BUKRS'      LS_ITAB-BUKRS,
            <GS_BATCH> 'MATNR'      LS_ITAB-MATNR,
            <GS_BATCH> 'MAKTX'      LS_ITAB-MAKTX,
            <GS_BATCH> 'WERKS'      LS_ITAB-WERKS,
            <GS_BATCH> 'MEINS'      LS_ITAB-MEINS,
            <GS_BATCH> 'WAERS'      LS_ITAB-WAERS,
            <GS_BATCH> 'LGORT'      LS_ITAB-LGORT,
            <GS_BATCH> 'LGOBE'      LS_ITAB-LGOBE,
            <GS_BATCH> 'CHARG'      LS_ITAB-CHARG,
            <GS_BATCH> 'CLABS'      LS_ITAB-CLABS,
            <GS_BATCH> 'VERPR'      LS_ITAB-VERPR,
            <GS_BATCH> 'LIFNR'      LS_ITAB-LIFNR,
            <GS_BATCH> 'LIFNR_TX'   LS_ITAB-LIFNR_TX.

    READ TABLE LT_ZZSTOCKCD INTO DATA(LS_ZZSTOCKCD) WITH KEY MATNR = LS_ITAB-MATNR
                                                             CHARG = LS_ITAB-CHARG
                                                             BINARY SEARCH.
    IF SY-SUBRC = 0.
      PERFORM INPUT_VALUE USING
          : <GS_BATCH> 'ZZPOR'         LS_ZZSTOCKCD-ZZPOR,
            <GS_BATCH> 'ZZSTOCKCD'     LS_ZZSTOCKCD-ZZSTOCKCD,
            <GS_BATCH> 'MATKL'         LS_ZZSTOCKCD-MATKL,
            <GS_BATCH> 'ZZSTOCKCD_TX'  LS_ZZSTOCKCD-DDTEXT.
    ENDIF.

    READ TABLE LT_SUM2 INTO DATA(LS_SUM2) WITH KEY MATNR = LS_ITAB-MATNR
                                                   WERKS = LS_ITAB-WERKS
                                                   LGORT = LS_ITAB-LGORT
                                                   CHARG = LS_ITAB-CHARG
                                                   LIFNR = LS_ITAB-LIFNR
                                                   BINARY SEARCH.
    IF SY-SUBRC = 0.
      IF LS_SUM2-MENGE_GI1 NE 0 OR LS_SUM2-DMBTR_GI1 NE 0 OR
         LS_SUM2-MENGE_GI2 NE 0 OR LS_SUM2-DMBTR_GI2 NE 0 OR
         LS_SUM2-MENGE_GI3 NE 0 OR LS_SUM2-DMBTR_GI3 NE 0 OR
         LS_SUM2-MENGE_GI4 NE 0 OR LS_SUM2-DMBTR_GI4 NE 0 OR
         LS_SUM2-MENGE_GR1 NE 0 OR LS_SUM2-DMBTR_GR1 NE 0 OR
         LS_SUM2-MENGE_GR2 NE 0 OR LS_SUM2-DMBTR_GR2 NE 0 OR
         LS_SUM2-MENGE_GR3 NE 0 OR LS_SUM2-DMBTR_GR3 NE 0 OR
         LS_SUM2-MENGE_GR4 NE 0 OR LS_SUM2-DMBTR_GR4 NE 0 OR
         LS_SUM2-MENGE_GR5 NE 0 OR LS_SUM2-DMBTR_GR5 NE 0.
        PERFORM ADD_VALUE USING
              : '<GS_BATCH>-MENGE_' 'GI1' LS_SUM2-MENGE_GI1,
                '<GS_BATCH>-DMBTR_' 'GI1' LS_SUM2-DMBTR_GI1,
                '<GS_BATCH>-MENGE_' 'GI2' LS_SUM2-MENGE_GI2,
                '<GS_BATCH>-DMBTR_' 'GI2' LS_SUM2-DMBTR_GI2,
                '<GS_BATCH>-MENGE_' 'GI3' LS_SUM2-MENGE_GI3,
                '<GS_BATCH>-DMBTR_' 'GI3' LS_SUM2-DMBTR_GI3,
                '<GS_BATCH>-MENGE_' 'GI4' LS_SUM2-MENGE_GI4,
                '<GS_BATCH>-DMBTR_' 'GI4' LS_SUM2-DMBTR_GI4,
                '<GS_BATCH>-MENGE_' 'GR1' LS_SUM2-MENGE_GR1,
                '<GS_BATCH>-DMBTR_' 'GR1' LS_SUM2-DMBTR_GR1,
                '<GS_BATCH>-MENGE_' 'GR2' LS_SUM2-MENGE_GR2,
                '<GS_BATCH>-DMBTR_' 'GR2' LS_SUM2-DMBTR_GR2,
                '<GS_BATCH>-MENGE_' 'GR3' LS_SUM2-MENGE_GR3,
                '<GS_BATCH>-DMBTR_' 'GR3' LS_SUM2-DMBTR_GR3,
                '<GS_BATCH>-MENGE_' 'GR4' LS_SUM2-MENGE_GR4,
                '<GS_BATCH>-DMBTR_' 'GR4' LS_SUM2-DMBTR_GR4,
                '<GS_BATCH>-MENGE_' 'GR5' LS_SUM2-MENGE_GR5,
                '<GS_BATCH>-DMBTR_' 'GR5' LS_SUM2-DMBTR_GR5.
      ENDIF.
    ENDIF.

    APPEND <GS_BATCH> TO <GT_BATCH>.

    CLEAR : LS_ZZSTOCKCD, LS_SUM2.
  ENDLOOP.

*--------------------------------------------------------------------*
** 기초수량(기초금액) SET

  DATA : LT_ITEM TYPE TABLE OF ZMMPAS51006,
         ET_ITEM TYPE TABLE OF ZMMPAS51006.

  MOVE-CORRESPONDING <GT_BATCH>[] TO LT_ITEM[].

  call function 'ZMMPA_INITIAL_STOCK'
    EXPORTING
      IV_BUDAT = S_BUDAT-LOW
    TABLES
      IT_ITEM  = LT_ITEM
      ET_ITEM  = ET_ITEM.

  SORT ET_ITEM BY WERKS MATNR LGORT LIFNR CHARG.

  LOOP AT <GT_BATCH> ASSIGNING FIELD-SYMBOL(<GS_BATCH>).
    ASSIGN COMPONENT: 'WERKS' OF STRUCTURE <GS_BATCH> TO <FS_WERKS>,
                      'MATNR' OF STRUCTURE <GS_BATCH> TO <FS_MATNR>,
                      'LGORT' OF STRUCTURE <GS_BATCH> TO <FS_LGORT>,
                      'LIFNR' OF STRUCTURE <GS_BATCH> TO <FS_LIFNR>,
                      'CHARG' OF STRUCTURE <GS_BATCH> TO <FS_CHARG>.

    READ TABLE ET_ITEM INTO DATA(LS_ITEM) WITH KEY WERKS = <FS_WERKS>
                                                   MATNR = <FS_MATNR>
                                                   LGORT = <FS_LGORT>
                                                   LIFNR = <FS_LIFNR>
                                                   CHARG = <FS_CHARG>
                                                   BINARY SEARCH.
    IF SY-SUBRC = 0.
      IF P_VAL NE C_X. " Amount 미출력
        ASSIGN COMPONENT: 'MENGE_BI' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_BI>.

        <FS_MENGE_BI> =  LS_ITEM-EV_STOCK_QTY.
      ELSE.
        ASSIGN COMPONENT: 'MENGE_BI' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_BI>,
                          'DMBTR_BI' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_BI>.

        <FS_MENGE_BI> = LS_ITEM-EV_STOCK_QTY.
        <FS_DMBTR_BI> = LS_ITEM-EV_STOCK_DMBTR.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CHK_AUTH
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM CHK_AUTH .

  DATA: LV_MTYPE TYPE BAPI_MTYPE,
        LV_MSGTX TYPE BAPI_MSG.

*
*  회사코드 권한 검증 FUNCTION

  call function 'ZSPPA_AUTHORITY_CHECK_BUKRS'

*    EXPORTING
*      iv_bukrs       = P_BUKRS                 " 회사 코드

    IMPORTING
      EV_MSGTYPE     = LV_MTYPE                " 메시지 유형: S 성공, E 오류, W 경고, I 정보, A 중단
      EV_MESSAGE     = LV_MSGTX                " 메시지 텍스트
    TABLES
      IT_RANGE_BUKRS = S_BUKRS.                 " BAPI 선택구조: 회사코드

  IF LV_MTYPE EQ 'E'.
    MESSAGE LV_MSGTX TYPE 'S' DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.

*  플랜트 권한 검증 FUNCTION

  call function 'ZSPPA_AUTHORITY_CHECK_WERKS'

*    EXPORTING
*      iv_werks       = P_WERKS          " 플랜트

    IMPORTING
      EV_MSGTYPE     = LV_MTYPE         " 메시지 유형: S 성공, E 오류, W 경고, I 정보, A 중단
      EV_MESSAGE     = LV_MSGTX         " 메시지 텍스트
    TABLES
      IT_RANGE_WERKS = S_WERKS.          " BAPI 선택 구조: 플랜트.

  IF LV_MTYPE EQ 'E'.
    MESSAGE LV_MSGTX TYPE 'S' DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form SHOW_GROUP_RAW2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> PS_COLUMN_ID_FIELDNAME
*&      --> P_
*&      <-- <LS_DISP>
*&---------------------------------------------------------------------*

FORM SHOW_GROUP_RAW2  USING    PV_FIELDNAME
                              PV_CALL_SCREEN
                     CHANGING PS_TABLE.

  DATA : LS_ZMMT0010 TYPE ZMMPAT52000.

  LS_ZMMT0010-ZGROUP = PV_FIELDNAME+6(4).

  SELECT SINGLE ZGROUP ZTEXT
  INTO CORRESPONDING FIELDS OF LS_ZMMT0010
  FROM ZMMPAT52000
  WHERE ZGROUP EQ LS_ZMMT0010-ZGROUP.
  IF SY-SUBRC EQ 0.

    CLEAR GS_DISP_SCR.
    MOVE-CORRESPONDING PS_TABLE TO GS_DISP_SCR.
    GS_DISP_SCR-DYNNR = PV_CALL_SCREEN.

    CLEAR : GT_RAW_DISP, GT_RAW_DISP[].
    CASE PV_CALL_SCREEN.

      WHEN '0400'. "Batch

        LOOP AT GT_BATCH_0400 WHERE MATNR EQ GS_DISP_SCR-MATNR
                                AND WERKS EQ GS_DISP_SCR-WERKS
                                AND LGORT EQ GS_DISP_SCR-LGORT
                                AND CHARG EQ GS_DISP_SCR-CHARG
                                AND LIFNR EQ GS_DISP_SCR-LIFNR
                                AND ZGROUP EQ LS_ZMMT0010-ZGROUP.

*          IF GT_RAW-VGART IS INITIAL. "DMBTR EQ '0'.  "Amount Value check

          MOVE-CORRESPONDING GT_BATCH_0400 TO GT_RAW_DISP.

          " Mvt Text 출력요청으로 인한 추가 / " 24.08.20
          SELECT SINGLE BTEXT
                 INTO CORRESPONDING FIELDS OF GT_RAW_DISP
                 FROM T156T
                 WHERE BWART EQ GT_RAW_DISP-BWART
                   AND SPRAS EQ SY-LANGU.

*                   AND SOBKZ EQ 'O'.

          APPEND GT_RAW_DISP. CLEAR GT_RAW_DISP.
        ENDLOOP.

    ENDCASE.

    SORT GT_RAW_DISP BY BUDAT MATNR CHARG.

    LOOP AT GT_RAW_DISP ASSIGNING FIELD-SYMBOL(<GS_RAW_DISP>).
      IF <GS_RAW_DISP>-MENGE < 0.
        <GS_RAW_DISP>-INFO = 'C600'.
      ELSE.
        <GS_RAW_DISP>-INFO = 'C100'.
      ENDIF.
    ENDLOOP.

    PERFORM BUFFER_CLEAR_PROC USING SY-REPID GV_INTTAB200.

    IF GT_RAW_DISP[] IS INITIAL.
      " No data found
      MESSAGE S082 DISPLAY LIKE 'E'.
    ELSE.

      CASE PV_CALL_SCREEN.
        WHEN '0100'.
          GV_TITLE_200 = LS_ZMMT0010-ZTEXT.
        WHEN '0400'.
          CONCATENATE LS_ZMMT0010-ZTEXT TEXT-T14 INTO GV_TITLE_200
                      SEPARATED BY SPACE.
      ENDCASE.
      CALL SCREEN 0200 STARTING AT 10 2
      ENDING AT 150 30.
    ENDIF.

  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form FIELD_DATE_SET
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM FIELD_DATE_SET .

  DATA: LV_DATUM_LOW  TYPE SY-DATUM,
        LV_DATUM_HIGH TYPE SY-DATUM.

  IF RB_CO = 'X'.
    " 실행되는 날로 지정"
    LV_DATUM_HIGH = P_SPMON && '01'.

    "달 마지막일 구하기 "
    CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'
      EXPORTING
        DAY_IN            = LV_DATUM_HIGH
      IMPORTING
        LAST_DAY_OF_MONTH = LV_DATUM_HIGH.

    "달 첫날 일 구하기 "
    LV_DATUM_LOW = LV_DATUM_HIGH+0(6) && '01'.

    CLEAR : S_BUDAT, S_BUDAT[].
    S_BUDAT-SIGN = 'I'.
    S_BUDAT-OPTION = 'BT'.
    S_BUDAT-LOW = LV_DATUM_LOW.
    S_BUDAT-HIGH = LV_DATUM_HIGH.
    APPEND S_BUDAT.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CO_AMT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM CO_AMT .

  FIELD-SYMBOLS: <FS_WERKS>     TYPE ANY,
                 <FS_MATNR>     TYPE ANY,
                 <FS_CHARG>     TYPE ANY,
                 <FS_CLABS>     TYPE ANY,
                 <FS_VERPR>     TYPE ANY,
                 <FS_MENGE_BI>  TYPE ANY,
                 <FS_DMBTR_BI>  TYPE ANY,
                 <FS_MENGE_EI>  TYPE ANY,
                 <FS_DMBTR_EI>  TYPE ANY,
                 <FS_MENGE_GI1> TYPE ANY,
                 <FS_DMBTR_GI1> TYPE ANY,
                 <FS_MENGE_GI2> TYPE ANY,
                 <FS_DMBTR_GI2> TYPE ANY,
                 <FS_MENGE_GI3> TYPE ANY,
                 <FS_DMBTR_GI3> TYPE ANY,
                 <FS_MENGE_GI4> TYPE ANY,
                 <FS_DMBTR_GI4> TYPE ANY,
                 <FS_MENGE_GR1> TYPE ANY,
                 <FS_DMBTR_GR1> TYPE ANY,
                 <FS_MENGE_GR2> TYPE ANY,
                 <FS_DMBTR_GR2> TYPE ANY,
                 <FS_MENGE_GR3> TYPE ANY,
                 <FS_DMBTR_GR3> TYPE ANY,
                 <FS_MENGE_GR4> TYPE ANY,
                 <FS_DMBTR_GR4> TYPE ANY,
                 <FS_MENGE_GR5> TYPE ANY,
                 <FS_DMBTR_GR5> TYPE ANY.

  DATA LV_JAHRPER  TYPE JAHRPER.
  DATA LV_JAHRPER2 TYPE JAHRPER.
  DATA LV_DATE     TYPE D.

  " 당월 JAHRPER (YYYY + '0' + MM = 7자리 NUMC)
  LV_JAHRPER = |{ P_SPMON+0(4) }0{ P_SPMON+4(2) }|.

  " 당월 1일
  LV_DATE = |{ P_SPMON }01|.            " 202606 -> 20260601

  " 당월 1일에서 -1일 = 전월 말일 -> 전월 JAHRPER
  LV_DATE    = LV_DATE - 1.             " 20260601 -> 20260531
  LV_JAHRPER2 = |{ LV_DATE+0(4) }0{ LV_DATE+4(2) }|.

  " 전월 것도 우선 가지고 온다 (당월 기말 금액이 없을 수도 있으므로)
  SELECT JAHRPER, MATNR, BWKEY, BWTAR, PRICE
    FROM ZCOPAV40011_CDS
    WHERE JAHRPER IN ( @LV_JAHRPER, @LV_JAHRPER2 )
      AND MATNR   IN @S_MATNR
      AND BWKEY   IN @S_WERKS
      AND BWTAR   IN @S_CHARG
    INTO TABLE @DATA(LT_CO).

  " 기간 내림차순 정렬 후 중복 제거 -> 자재별 최신 기간(당월 우선) 1건만 남김
  SORT LT_CO BY JAHRPER DESCENDING MATNR BWKEY BWTAR.
  DELETE ADJACENT DUPLICATES FROM LT_CO COMPARING MATNR BWKEY BWTAR.

  " 이후 binary search용 정렬
  SORT LT_CO BY MATNR BWKEY BWTAR.

*  SELECT JAHRPER, MATNR, BWKEY, BWTAR, PRICE
*    FROM ZCOPAV40011_CDS
*   WHERE JAHRPER EQ @LV_JAHRPER
*     AND MATNR   IN @S_MATNR
*     AND BWKEY   IN @S_WERKS
*     AND BWTAR   IN @S_CHARG
*    INTO TABLE @DATA(LT_CO).

  LOOP AT <GT_BATCH> ASSIGNING <GS_BATCH>.
    ASSIGN COMPONENT: 'WERKS' OF STRUCTURE <GS_BATCH> TO <FS_WERKS>,
                      'MATNR' OF STRUCTURE <GS_BATCH> TO <FS_MATNR>,
                      'CHARG' OF STRUCTURE <GS_BATCH> TO <FS_CHARG>.

    READ TABLE LT_CO INTO DATA(LS_CO) WITH KEY MATNR = <FS_MATNR>
                                               BWKEY = <FS_WERKS>
                                               BWTAR = <FS_CHARG>
                                               BINARY SEARCH.
    IF SY-SUBRC = 0.

*현재고

      ASSIGN COMPONENT: 'CLABS' OF STRUCTURE <GS_BATCH> TO <FS_CLABS>,
                        'VERPR' OF STRUCTURE <GS_BATCH> TO <FS_VERPR>.

      IF <FS_CLABS> NE 0.
        IF LS_CO-PRICE NE 0.
          <FS_VERPR> = <FS_CLABS> * LS_CO-PRICE.
        ELSE.
          <FS_VERPR> = 0.
        ENDIF.

      ENDIF.

      IF P_VAL = ABAP_TRUE.

*기초

        ASSIGN COMPONENT: 'MENGE_BI' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_BI>,
                          'DMBTR_BI' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_BI>.

        IF LS_CO-PRICE NE 0.
          <FS_DMBTR_BI> = <FS_MENGE_BI> * LS_CO-PRICE.
        ELSE.
          <FS_DMBTR_BI> = 0.
        ENDIF.

*기말

        ASSIGN COMPONENT: 'MENGE_EI' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_EI>,
                          'DMBTR_EI' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_EI>.

        IF LS_CO-PRICE NE 0.
          <FS_DMBTR_EI> = <FS_MENGE_EI> * LS_CO-PRICE.
        ELSE.
          <FS_DMBTR_EI> = 0.
        ENDIF.

*출고

        ASSIGN COMPONENT: 'MENGE_GI1' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_GI1>,
                          'DMBTR_GI1' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_GI1>.

        IF LS_CO-PRICE NE 0.
          <FS_DMBTR_GI1> = <FS_MENGE_GI1> * LS_CO-PRICE.
        ELSE.
          <FS_DMBTR_GI1> = 0.
        ENDIF.

        ASSIGN COMPONENT: 'MENGE_GI2' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_GI2>,
                          'DMBTR_GI2' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_GI2>.

        IF LS_CO-PRICE NE 0.
          <FS_DMBTR_GI2> = <FS_MENGE_GI2> * LS_CO-PRICE.
        ELSE.
          <FS_DMBTR_GI2> = 0.
        ENDIF.

        ASSIGN COMPONENT: 'MENGE_GI3' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_GI3>,
                          'DMBTR_GI3' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_GI3>.

        IF LS_CO-PRICE NE 0.
          <FS_DMBTR_GI3> = <FS_MENGE_GI3> * LS_CO-PRICE.
        ELSE.
          <FS_DMBTR_GI3> = 0.
        ENDIF.

        ASSIGN COMPONENT: 'MENGE_GI4' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_GI4>,
                          'DMBTR_GI4' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_GI4>.

        IF LS_CO-PRICE NE 0.
          <FS_DMBTR_GI4> = <FS_MENGE_GI4> * LS_CO-PRICE.
        ELSE.
          <FS_DMBTR_GI4> = 0.
        ENDIF.

*입고

        ASSIGN COMPONENT: 'MENGE_GR1' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_GR1>,
                          'DMBTR_GR1' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_GR1>.

        IF LS_CO-PRICE NE 0.
          <FS_DMBTR_GR1> = <FS_MENGE_GR1> * LS_CO-PRICE.
        ELSE.
          <FS_DMBTR_GR1> = 0.
        ENDIF.

        ASSIGN COMPONENT: 'MENGE_GR2' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_GR2>,
                          'DMBTR_GR2' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_GR2>.

        IF LS_CO-PRICE NE 0.
          <FS_DMBTR_GR2> = <FS_MENGE_GR2> * LS_CO-PRICE.
        ELSE.
          <FS_DMBTR_GR2> = 0.
        ENDIF.

        ASSIGN COMPONENT: 'MENGE_GR3' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_GR3>,
                          'DMBTR_GR3' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_GR3>.

        IF LS_CO-PRICE NE 0.
          <FS_DMBTR_GR3> = <FS_MENGE_GR3> * LS_CO-PRICE.
        ELSE.
          <FS_DMBTR_GR3> = 0.
        ENDIF.

        ASSIGN COMPONENT: 'MENGE_GR4' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_GR4>,
                          'DMBTR_GR4' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_GR4>.

        IF LS_CO-PRICE NE 0.
          <FS_DMBTR_GR4> = <FS_MENGE_GR4> * LS_CO-PRICE.
        ELSE.
          <FS_DMBTR_GR4> = 0.
        ENDIF.

        ASSIGN COMPONENT: 'MENGE_GR5' OF STRUCTURE <GS_BATCH> TO <FS_MENGE_GR5>,
                          'DMBTR_GR5' OF STRUCTURE <GS_BATCH> TO <FS_DMBTR_GR5>.

        IF LS_CO-PRICE NE 0.
          <FS_DMBTR_GR5> = <FS_MENGE_GR5> * LS_CO-PRICE.
        ELSE.
          <FS_DMBTR_GR5> = 0.
        ENDIF.

      ENDIF.
    ENDIF.

    CLEAR : LS_CO.
  ENDLOOP.

ENDFORM.

Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2026. Sap Release 755

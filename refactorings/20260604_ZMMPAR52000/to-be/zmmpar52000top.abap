*&---------------------------------------------------------------------*
*& INCLUDE ZMMPAR52000TOP  (To-Be / 리팩토링: R+M)  — 글로벌 선언부
*& 표준: standards/ABAP_CODE_STANDARD.md | 죽은 주석코드 정리 적용
*&---------------------------------------------------------------------*

Code listing for: ZMMPAR52000TOP Description: Include ZMMMAM36100TOP

*&---------------------------------------------------------------------*
*& Include          ZMMMAM36100TOP
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Top 구조
*&   0100 스크린 : 일반모드 메인
*&        ㄴ <GT_TABLE> (GT_DISP 참조)
*&   0200 스크린 : 더블클릭
*&        ㄴ GT_RAW (GT_RAW_DISP 참조)
*&   0400 스크린 : 배치모드 메인
*&        ㄴ <GT_BATCH> (GT_BATCH_0400 참조)
*&   0500 스크린 : 디테일 클릭
*&        ㄴ GT_MATDOC (GT_DISP_0500 참조)
*&---------------------------------------------------------------------*

INCLUDE <ICON>.

TABLES : MBEWH, MCHBH, MATDOC, MAKT, MARA, MBEW, MARD, MCHB.
TABLES : VBAK, VBAP, VBFA, EKKO, EKPO.
TABLES : ZMMPAT52000, ZMMPAT52010.

* 0200 Screen - 더블 클릭 팝업 창

DATA : BEGIN OF GT_RAW_DISP OCCURS 0,
         BUKRS    LIKE ACCTIT-BUKRS,
         MJAHR    LIKE MATDOC-MJAHR,
         BUDAT    LIKE MATDOC-BUDAT,
         MBLNR    LIKE MATDOC-MBLNR,

         MATNR    LIKE MATDOC-MATNR,
         MAKTX    LIKE MAKT-MAKTX,
         WERKS    LIKE MATDOC-WERKS,
         LGORT    LIKE MATDOC-LGORT,
         CHARG    LIKE MATDOC-CHARG,
         KUNNR    LIKE MATDOC-KUNNR,
         KUNNR_TX LIKE BUT000-NAME_ORG1,
         LIFNR    LIKE MATDOC-LIFNR,
         LIFNR_TX LIKE BUT000-NAME_ORG1,
         SOBKZ    LIKE MATDOC-SOBKZ,
         ZGROUP   LIKE ZMMPAT52000-ZGROUP,
         MENGE    LIKE MATDOC-MENGE,
         DMBTR    LIKE ACDOCA-WSL, "MATDOC-DMBTR,
         BWART    LIKE MATDOC-BWART,
         GRUND    LIKE MATDOC-GRUND,
         SHKZG    LIKE MATDOC-SHKZG,
         SLLAB    LIKE MSSL-SLLAB,   " 가용재고 추가(MSSL)
         CLABS    LIKE MCHB-CLABS,  " 가용재고 추가
         SALK3    LIKE MATDOC-SALK3, " 추가
         LABST    LIKE MARD-LABST,  " 가용재고 추가(MARD)
         LBKUM    LIKE MATDOC-LBKUM, " 추가

* No-Out

         STPRS    LIKE MBEW-STPRS,   " Current Stock Value

*         STPRS2   LIKE MBEW-STPRS,   " VR* & VQ* Stock Value

         BTEXT    LIKE T156T-BTEXT,
         ZEILE    LIKE MATDOC-ZEILE,
         VGART    TYPE MLDOC-VGART,
         MEINS    LIKE MATDOC-MEINS,
         WAERS    LIKE MATDOC-WAERS,
         BELNR    LIKE RSEG-BELNR,
         GJAHR    LIKE RSEG-GJAHR,
         BUZEI    LIKE RSEG-BUZEI,
         ZIV_CHK  TYPE C,  "IV Doc
         ZSP_CHK  TYPE C,  "Adjust Sales Price
         CELLTAB  TYPE LVC_T_STYL, "field to switch editability
         COLINFO  TYPE LVC_T_SCOL, "Color
         INFO(4)  TYPE C,
         MARK,
         MTART    LIKE MARA-MTART,
       END OF GT_RAW_DISP.
DATA : GT_RAW           LIKE GT_RAW_DISP OCCURS 0  WITH HEADER LINE.

* 0500 Screen - Detail 클릭 팝업 창

DATA : BEGIN OF GT_DISP_0500 OCCURS 0,
         BUKRS    LIKE ACCTIT-BUKRS,
         MJAHR    LIKE MATDOC-MJAHR,
         BUDAT    LIKE MATDOC-BUDAT,
         MBLNR    LIKE MATDOC-MBLNR,
         ZEILE    LIKE MATDOC-ZEILE,

         MATNR    LIKE MATDOC-MATNR,
         MAKTX    LIKE MAKT-MAKTX,
         WERKS    LIKE MATDOC-WERKS,
         LGORT    LIKE MATDOC-LGORT,
         CHARG    LIKE MATDOC-CHARG,
         KUNNR    LIKE MATDOC-KUNNR,
         KUNNR_TX LIKE BUT000-NAME_ORG1,
         LIFNR    LIKE MATDOC-LIFNR,
         LIFNR_TX LIKE BUT000-NAME_ORG1,
         SOBKZ    LIKE MATDOC-SOBKZ,
         ZGROUP   LIKE ZMMPAT52000-ZGROUP,
         MENGE    LIKE MATDOC-MENGE,
         DMBTR    LIKE ACDOCA-WSL, "MATDOC-DMBTR,
         BWART    LIKE MATDOC-BWART,
         GRUND    LIKE MATDOC-GRUND,
         SHKZG    LIKE MATDOC-SHKZG,

* No-Out

         SALK3    LIKE MATDOC-SALK3, " 추가
         LBKUM    LIKE MATDOC-LBKUM, " 추가
         BTEXT    LIKE T156T-BTEXT,
         VGART    TYPE MLDOC-VGART,
         MEINS    LIKE MATDOC-MEINS,
         WAERS    LIKE MATDOC-WAERS,
         BELNR    LIKE RSEG-BELNR,
         GJAHR    LIKE RSEG-GJAHR,
         BUZEI    LIKE RSEG-BUZEI,
         ZIV_CHK  TYPE C,  "IV Doc
         ZSP_CHK  TYPE C,  "Adjust Sales Price
         CELLTAB  TYPE LVC_T_STYL, "field to switch editability
         COLINFO  TYPE LVC_T_SCOL, "Color
         INFO(4)  TYPE C,
         MARK,
         MTART    LIKE MARA-MTART,
       END OF GT_DISP_0500.
DATA : GT_MATDOC      LIKE GT_DISP_0500 OCCURS 0  WITH HEADER LINE.

* 0400번 스크린 BATCH

DATA : BEGIN OF GT_BATCH_0400 OCCURS 0,
         BUKRS            LIKE ACCTIT-BUKRS,
         MJAHR            LIKE MATDOC-MJAHR,
         BUDAT            LIKE MATDOC-BUDAT,
         MBLNR            LIKE MATDOC-MBLNR,
         MATNR            LIKE MATDOC-MATNR,
         MAKTX            LIKE MAKT-MAKTX,
         WERKS            LIKE MATDOC-WERKS,
         LGORT            LIKE MATDOC-LGORT,
         LGOBE            LIKE T001L-LGOBE,
         CHARG            LIKE MATDOC-CHARG,
         KUNNR            LIKE MATDOC-KUNNR,
         KUNNR_TX         LIKE BUT000-NAME_ORG1,
         LIFNR            LIKE MATDOC-LIFNR,
         LIFNR_TX         LIKE BUT000-NAME_ORG1,
         SOBKZ            LIKE MATDOC-SOBKZ,
         ZGROUP           LIKE ZMMPAT52000-ZGROUP,
         MENGE            LIKE MATDOC-MENGE,
         DMBTR            LIKE ACDOCA-WSL, "MATDOC-DMBTR,
         BWART            LIKE MATDOC-BWART,
         GRUND            LIKE MATDOC-GRUND,
         SHKZG            LIKE MATDOC-SHKZG,

         VERPR            LIKE MBEW-VERPR,

         CLABS            LIKE MCHB-CLABS,  " 가용재고 추가(MCHB)

* No-Out

         SALK3            LIKE MATDOC-SALK3, " 추가
         LBKUM            LIKE MATDOC-LBKUM, " 추가
         BTEXT            LIKE T156T-BTEXT,
         ZEILE            TYPE MATDOC-ZEILE,
         VGART            TYPE MLDOC-VGART,
         MEINS            LIKE MATDOC-MEINS,
         WAERS            LIKE MATDOC-WAERS,
         BELNR            LIKE RSEG-BELNR,
         GJAHR            LIKE RSEG-GJAHR,
         BUZEI            LIKE RSEG-BUZEI,
         ZZPOR            LIKE  MCHA-ZZPOR,
         MAKTL            LIKE MARA-MATKL,
         ZZSTOCKCD        LIKE  MCHA-ZZSTOCKCD,
         ZZSTOCKCD_TX(10),
         ZIV_CHK          TYPE C,  "IV Doc
         ZSP_CHK          TYPE C,  "Adjust Sales Price
         CELLTAB          TYPE LVC_T_STYL, "field to switch editability
         COLINFO          TYPE LVC_T_SCOL, "Color
         INFO(4)          TYPE C,
         MARK,
         MTART            LIKE MARA-MTART,
       END OF GT_BATCH_0400.
DATA : GT_BATCH LIKE GT_BATCH_0400 OCCURS 0  WITH HEADER LINE.

* 송장 금액으로 인해 데이터선언추가mlee463-26.04.17

DATA: GT_TEMP LIKE STANDARD TABLE OF GT_BATCH_0400,
      LS_TEMP LIKE LINE OF GT_TEMP.

* [MM]Inventory In&Out Report Setting Header

DATA : GT_ZMMT0010 LIKE ZMMPAT52000 OCCURS 0 WITH HEADER LINE.

* Movement Type Group

DATA : BEGIN OF GT_GROUP OCCURS 0,
         ZGROUP LIKE ZMMPAT52000-ZGROUP,
         ZTEXT  LIKE ZMMPAT52000-ZTEXT,
         BWART  LIKE ZMMPAT52010-BWART,
         GRUND  LIKE ZMMPAT52010-GRUND,
       END OF GT_GROUP.

DATA : GV_GR_ETC LIKE ZMMPAT52000-ZGROUP,  "
       GV_GI_ETC LIKE ZMMPAT52000-ZGROUP.

* <GT_TABLE> 참조 Structure

DATA : BEGIN OF GT_DISP OCCURS 0,
         BUKRS            LIKE T001-BUKRS,
         WERKS            LIKE  MARC-WERKS,
         LIFNR            LIKE  MATDOC-LIFNR,     " Vendor 추가
         LIFNR_TX         LIKE  BUT000-NAME_ORG1, " Vendor Text 추가
         MATNR            LIKE  MARA-MATNR,
         MAKTX            LIKE  MAKT-MAKTX,
         LGORT            LIKE T001L-LGORT,
         LGOBE            LIKE T001L-LGOBE,

*         MAT_DESC LIKE  MAKT-MAKTX,    "Sales Text
* batch key Start

         SQR              LIKE AUSP_COM-ATWRT,
         SOBKZ            LIKE MSKU-SOBKZ,
         PARTNER          LIKE BUT000-PARTNER,
         NAME_ORG1        LIKE BUT000-NAME_ORG1,

* batch key End
* MAKTX2    LIKE  MAKT-MAKTX,    "Material Description2  MAKT-MAKTX

         MAGRV            LIKE  MARA-MAGRV,
         SPART            LIKE  MARA-SPART,
         SPART_TX         LIKE  TSPAT-VTEXT,

         MEINS            LIKE MARA-MEINS,
         WAERS            LIKE T001-WAERS,

*         SLLAB     LIKE MSSL-SLLAB,   " 가용재고 추가(MSSL)

         CLABS            LIKE MCHB-CLABS,  "
         VERPR            LIKE MBEW-VERPR,
         MENGE            LIKE MBEWH-LBKUM,
         DMBTR            LIKE MBEWH-SALK3,
         DMAVG            LIKE MBEWH-SALK3,  "AVERAGE 20200513 ADD

* No-Out

         CHARG            LIKE  MCHA-CHARG,
         ZZPOR            LIKE  MCHA-ZZPOR,
         MATKL            LIKE  MARA-MATKL,
         ZZSTOCKCD        LIKE  MCHA-ZZSTOCKCD,
         ZZSTOCKCD_TX(10),
         CELLTAB          TYPE LVC_T_STYL, "field to switch editability
         COLINFO          TYPE LVC_T_SCOL, "Color
         INFO(4)          TYPE C,
         MARK,
       END OF GT_DISP.

DATA : BEGIN OF GS_DISP_SCR,
         MATNR LIKE  MARA-MATNR,
         MAKTX LIKE  MAKT-MAKTX,
         WERKS LIKE  MARC-WERKS,
         LGORT LIKE  MARD-LGORT,
         LIFNR LIKE  MATDOC-LIFNR,  " Add / 24.08.19
         CHARG LIKE  MCHA-CHARG,
         MEINS LIKE  MARA-MEINS,
         DYNNR TYPE SY-DYNNR,
       END OF GS_DISP_SCR.
DATA : GT_DISP_SCR LIKE GS_DISP_SCR OCCURS 0 WITH HEADER LINE.

DATA : BEGIN OF GT_SIT_DISP OCCURS 0,
         BUKRS   LIKE ACCTIT-BUKRS,
         EBELN   LIKE EKPO-EBELN,
         EBELP   LIKE EKPO-EBELP,
         MATNR   LIKE EKPO-MATNR,
         WERKS   LIKE EKPO-WERKS,
         LGORT   LIKE EKPO-LGORT,
         LIFNR   LIKE EKKO-LIFNR,
         CHARG   LIKE EKET-CHARG,
         MENGE   LIKE EKPO-MENGE,
         NETWR   LIKE EKPO-NETWR,
         WEMNG   LIKE EKET-WEMNG,
         SITQTY  LIKE EKET-MENGE,  "Stock in Transfer
         SITAMT  LIKE EKPO-NETWR,  "Stock in Transfer Amount

* No-Out

         MEINS   LIKE EKPO-MEINS,
         WAERS   LIKE EKKO-WAERS,
         CELLTAB TYPE LVC_T_STYL, "field to switch editability
         COLINFO TYPE LVC_T_SCOL, "Color
         INFO(4) TYPE C,
         MARK,
       END OF GT_SIT_DISP.
DATA : GT_SIT LIKE GT_SIT_DISP OCCURS 0  WITH HEADER LINE.

DATA : BEGIN OF GT_GRLIST_DISP OCCURS 0,
         EBELN   LIKE EKPO-EBELN,
         EBELP   LIKE EKPO-EBELP,
         MJAHR   LIKE MATDOC-MJAHR,
         MBLNR   LIKE MATDOC-MBLNR,
         ZEILE   LIKE MATDOC-ZEILE,
         BUDAT   LIKE MATDOC-BUDAT,
         MATNR   LIKE MATDOC-MATNR,
         WERKS   LIKE MATDOC-WERKS,
         LGORT   LIKE MATDOC-LGORT,
         CHARG   LIKE MATDOC-CHARG,
         MENGE   LIKE MATDOC-MENGE,
         DMBTR   LIKE MATDOC-DMBTR,

* No-Out

         MEINS   LIKE MATDOC-MEINS,
         WAERS   LIKE MATDOC-WAERS,
         CELLTAB TYPE LVC_T_STYL, "field to switch editability
         COLINFO TYPE LVC_T_SCOL, "Color
         INFO(4) TYPE C,
         MARK,
       END OF GT_GRLIST_DISP.
DATA : GT_GRLIST LIKE GT_GRLIST_DISP OCCURS 0  WITH HEADER LINE.

"Sales Material Text
DATA : BEGIN OF GT_MAT OCCURS 0,
         WERKS    LIKE MARC-WERKS,
         MATNR    LIKE MARC-MATNR,
         MAT_DESC LIKE MAKT-MAKTX,
       END OF GT_MAT.

DATA : BEGIN OF GT_MARA OCCURS 0,
         MATNR    LIKE MARA-MATNR,
         MAGRV    LIKE  MARA-MAGRV,
         SPART    LIKE  MARA-SPART,
         SPART_TX LIKE  TSPAT-VTEXT,
       END OF GT_MARA.

DATA : BEGIN OF GT_MBEW OCCURS 0,
         MATNR LIKE MBEW-MATNR,
         BWKEY LIKE MBEW-BWKEY,
         STPRS LIKE MBEW-STPRS,
       END OF GT_MBEW.

*-> Export to ZCOR0020 - 2020.06.02 ABAP03
*<- Export to ZCOR0020 - 2020.06.02 ABAP03

* Main Table

FIELD-SYMBOLS: <GT_TABLE>    TYPE TABLE,
               <GT_TABLE_TM> TYPE TABLE,  "<GT_TABLE> COPY
               <GS_TABLE>    TYPE ANY,
               <GS_TABLE_TM> TYPE ANY,  "<GS_TABLE> COPY
               <FS_TABLE>    TYPE ANY.

* Batch Table

FIELD-SYMBOLS: <GT_BATCH>      TYPE TABLE,
               <GS_BATCH>      TYPE ANY,
               <GS_BATCH_TM>   TYPE ANY,
               <FS_BATCH>      TYPE ANY,
               <FS_BATCH_0400> TYPE ANY.

DATA : GV_SDATE TYPE DATUM,
       GV_EDATE TYPE DATUM.

DATA : GV_SDATE_PO TYPE DATUM,  "PO Start Date
       GV_EDATE_PO TYPE DATUM.  "PO End Date

* Ranges with Auth

RANGES : GR_WERKS FOR T001W-WERKS.

* Menu control

DATA: BEGIN OF GT_EXCLUD OCCURS 0,
        TCODE(10),
      END OF GT_EXCLUD.

DATA : GV_INTTAB100 TYPE DD02L-TABNAME VALUE 'GT_DISP',
       GV_INTTAB400 TYPE DD02L-TABNAME VALUE 'GT_BATCH',
       GV_INTTAB110 TYPE DD02L-TABNAME.

DATA : GV_INTTAB200 TYPE DD02L-TABNAME VALUE 'GT_RAW_DISP'.
DATA : GV_INTTAB300 TYPE DD02L-TABNAME VALUE 'GT_SIT_DISP'.
DATA : GV_INTTAB500 TYPE DD02L-TABNAME VALUE 'GT_DISP_0500'.

DATA: F_MATNR   TYPE STRING VALUE 'MATNR',
      F_WERKS   TYPE STRING VALUE 'WERKS',
      F_LGORT   TYPE STRING VALUE 'LGORT',
      F_CHARG   TYPE STRING VALUE 'CHARG',
      F_SOBKZ   TYPE STRING VALUE 'SOBKZ',
      F_PARTNER TYPE STRING VALUE 'PARTNER'.

*----------------------------------------------------------------------*
* Constants
*----------------------------------------------------------------------*

CONSTANTS: C_      VALUE ' ',
           C_3     VALUE '3',
           C_8     VALUE '8',
           C_9     VALUE '9',
           C_A     VALUE 'A',
           C_B     VALUE 'B',
           C_C     VALUE 'C',
           C_D     VALUE 'D',
           C_O     VALUE 'O',
           C_R     VALUE 'R',
           C_I     VALUE 'I',
           C_X     VALUE 'X',
           C_E     VALUE 'E',
           C_S     VALUE 'S',
           C_V     VALUE 'V',
           C_W     VALUE 'W',
           C_MARK  VALUE 'X',
           C_YES   VALUE '1',
           C_NO    VALUE '2',
           C_CANC  VALUE 'A',
           C_NEW   VALUE 'N',      "NEW
           C_DISP  VALUE 'D',      "DISP
           C_EDIT  VALUE 'E',      "EDIT
           C_EQ(2) VALUE 'EQ',
           C_WE(2) VALUE 'WE',
           C_UN(2) VALUE '_N'.

CONSTANTS : C_HEAD     TYPE DD02L-TABNAME VALUE 'GT_HEAD',
            C_RAW      TYPE DD02L-TABNAME VALUE 'GT_RAW',
            C_SIT      TYPE DD02L-TABNAME VALUE 'GT_SIT',
            GC_INVOICE TYPE STRING VALUE 'GC_INVOICE'.

*&---------------------------------------------------------------------*
*& Datas
*&---------------------------------------------------------------------*

DATA : GV_ERROR.

DATA : GV_TITLE_200 TYPE TEXT200.

DATA: GV_OKCODE          LIKE SY-UCOMM,
      GV_SAVE_OKCODE     LIKE SY-UCOMM,
      GV_TEMP_TEXT(100),
      GV_TEMP_TEXT1(100),
      GV_ANSWER,
      GV_CHAN,
      GV_ERR.

RANGES : GR_CHARG FOR MATDOC-CHARG.  "Batch

*----------------------------------------------------------------------*
*  MACRO                                                               *
*----------------------------------------------------------------------*
* Menu Control

DEFINE __EXCLUDE.
  CLEAR GT_EXCLUD.
  MOVE : &1 TO GT_EXCLUD-TCODE.
  APPEND GT_EXCLUD.
END-OF-DEFINITION.

" Pop-up message
DEFINE _MC_POPUP_CONFIRM.
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      TITLEBAR              = &1

      TEXT_QUESTION         = &2
      TEXT_BUTTON_1         = 'YES'
      ICON_BUTTON_1         = '@2K@'
      TEXT_BUTTON_2         = 'NO'
      ICON_BUTTON_2         = '@2O@ '
    IMPORTING
      ANSWER                = &3
    EXCEPTIONS
      TEXT_NOT_FOUND        = 1
      OTHERS                = 2.
END-OF-DEFINITION.

Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2026. Sap Release 755

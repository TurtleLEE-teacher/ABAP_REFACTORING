*&---------------------------------------------------------------------*
*& INCLUDE ZMMPAR52000F02  (To-Be / ALV 모던화 v2 — ALV Setup 계층)
*& 표준: standards/patterns/ALV_MODERN_PATTERN.md  (§3 인스턴스 / §4 필드카탈로그 / §5 생명주기 / §6 이벤트 / §7 Display)
*&---------------------------------------------------------------------*
*& [구조 변경 요약]
*&   구: CREATE_GRID_OBJECT_/ALV_CLEAR_VARIABLE_/BUILD_LAYOUT_/BUILD_SORT_/
*&       BUILD_COLOR_STYLE_/BUILD_EVENT_/DISPLAY_ALV_  ×5벌  (≈2000줄)
*&   신: 역할별 2벌(ALV_DISPLAY_MAIN / ALV_DISPLAY_POP) + 공통 폼
*&   - 그리드: NEW + 메서드체이닝, 풀스크린=SCREEN0 Splitter / 팝업=Docking
*&   - 필드카탈로그: CL_SALV_DATA_DESCR(RTTI) 자동생성 + 화면별 CASE 커스터마이징
*&   - 이벤트: 단일 LCL_EVENT_RECEIVER(=C01) + CREATE_EVENT_RECEIVER 공통 등록
*&   - 생명주기: 자식 FREE 금지(CLEAR만)·팝업 "열기 직전" 해제·FREE 후 FLUSH
*&
*& ⚠️ SE38 완성 필요:
*&   (1) BUILD_FIELDCAT의 화면별 CASE 컬럼 커스터마이징은 기존 BUILD_CATEGORY_200/300/500
*&       (to-be/zmmpar52000f02.abap)의 컬럼 규칙을 옮겨와 완성할 것.
*&   (2) 비즈니스/핸들러 FORM(HANDLE_DOUBLE_CLICK_100~500, HANDLE_USER_COMMAND_100/400,
*&       HANDLER_TOOLBAR(_0400), TOP_OF_PAGE, HTML_DISPLAY, SHOW_* 등)은 기존 to-be 버전에서
*&       그대로 이관(로직 무변경) — 본 파일 하단 "이관 대상" 표 참조.
*&---------------------------------------------------------------------*

* 필드카탈로그 텍스트 6종 일괄 설정 매크로
DEFINE _LMC_SET_TEXT.
  <LS_FCAT>-SCRTEXT_S = <LS_FCAT>-SCRTEXT_M = <LS_FCAT>-TOOLTIP =
  <LS_FCAT>-SCRTEXT_L = <LS_FCAT>-COLTEXT  = <LS_FCAT>-REPTEXT = &1.
END-OF-DEFINITION.

*&---------------------------------------------------------------------*
*& Form OUTTAB_ASSIGN  — 화면별 출력 인터널테이블을 FS에 바인딩
*&---------------------------------------------------------------------*
FORM OUTTAB_ASSIGN USING    PV_DYNNR TYPE SY-DYNNR
                   CHANGING CT_FS    TYPE ANY TABLE.       "참조용(미사용 시 FS 직접)
" 실제 사용은 ASSIGN으로 글로벌 itab을 FS에 연결 (호출부 참조)
ENDFORM.

*&---------------------------------------------------------------------*
*& Form ALV_DISPLAY_MAIN  — 풀스크린(0100 메인 / 0400 배치) 표시
*&   O01 모듈에서 CHECK GCL_GRID_MAIN IS INITIAL 후 1회 호출
*&---------------------------------------------------------------------*
FORM ALV_DISPLAY_MAIN USING PV_DYNNR TYPE SY-DYNNR.

  FIELD-SYMBOLS <FT_OUT> TYPE STANDARD TABLE.

  " 1) 출력 테이블 바인딩 (화면별)
  CASE PV_DYNNR.
    WHEN '0100'. ASSIGN GT_DISP[]       TO <FT_OUT>.   " 메인
    WHEN '0400'. ASSIGN GT_BATCH_0400[] TO <FT_OUT>.   " 배치
  ENDCASE.
  CHECK <FT_OUT> IS ASSIGNED.

  " 2) 컨테이너/그리드 생성 (SCREEN0 Splitter)
  PERFORM CREATE_INSTANCE_MAIN.

  " 3) 레이아웃 / 필드카탈로그 / 정렬 / 제외기능
  PERFORM BUILD_LAYOUT   CHANGING GS_LAYOUT_MAIN.
  PERFORM BUILD_FIELDCAT USING PV_DYNNR <FT_OUT> CHANGING GT_FCAT_MAIN.
  PERFORM BUILD_SORT_MAIN.
  PERFORM EXCLUDE_FUNCTIONKEY USING 'GT_ALV_EXTAB_100' CHANGING GT_EXCLUDE_MAIN.

  " 4) 이벤트 등록 + Display
  PERFORM CREATE_EVENT_RECEIVER USING GCL_GRID_MAIN.

  GS_VARIANT_MAIN-REPORT = SY-REPID.
  GCL_ALV_DOCUMENT = NEW CL_DD_DOCUMENT( STYLE = 'ALV_GRID' ).
  GCL_ALV_DOCUMENT->INITIALIZE_DOCUMENT( ).
  GCL_GRID_MAIN->LIST_PROCESSING_EVENTS(
    EXPORTING I_EVENT_NAME = 'TOP_OF_PAGE'
              I_DYNDOC_ID  = GCL_ALV_DOCUMENT ).

  GCL_GRID_MAIN->SET_TABLE_FOR_FIRST_DISPLAY(
    EXPORTING IS_LAYOUT            = GS_LAYOUT_MAIN
              IS_VARIANT           = GS_VARIANT_MAIN
              IT_TOOLBAR_EXCLUDING = GT_EXCLUDE_MAIN
              I_SAVE               = 'A'
    CHANGING  IT_OUTTAB            = <FT_OUT>
              IT_FIELDCATALOG      = GT_FCAT_MAIN
              IT_SORT              = GT_SORT_MAIN ).

ENDFORM.

*&---------------------------------------------------------------------*
*& Form ALV_DISPLAY_POP  — 팝업(0200 그룹RAW / 0300 SIT / 0500 자재문서) 표시
*&---------------------------------------------------------------------*
FORM ALV_DISPLAY_POP USING PV_DYNNR TYPE SY-DYNNR.

  FIELD-SYMBOLS <FT_OUT> TYPE STANDARD TABLE.

  CASE PV_DYNNR.
    WHEN '0200'. ASSIGN GT_RAW_DISP[]  TO <FT_OUT>.   " 그룹 RAW
    WHEN '0300'. ASSIGN GT_SIT_DISP[]  TO <FT_OUT>.   " SIT
    WHEN '0500'. ASSIGN GT_DISP_0500[] TO <FT_OUT>.   " 자재문서
  ENDCASE.
  CHECK <FT_OUT> IS ASSIGNED.

  PERFORM CREATE_INSTANCE_POP.

  PERFORM BUILD_LAYOUT   CHANGING GS_LAYOUT_POP.
  PERFORM BUILD_FIELDCAT USING PV_DYNNR <FT_OUT> CHANGING GT_FCAT_POP.
  PERFORM BUILD_SORT_POP.
  PERFORM EXCLUDE_FUNCTIONKEY USING 'GT_ALV_EXTAB_200' CHANGING GT_EXCLUDE_POP.

  PERFORM CREATE_EVENT_RECEIVER USING GCL_GRID_POP.

  GS_VARIANT_POP-REPORT = SY-REPID.
  GCL_ALV_DOCUMENT = NEW CL_DD_DOCUMENT( STYLE = 'ALV_GRID' ).
  GCL_ALV_DOCUMENT->INITIALIZE_DOCUMENT( ).
  GCL_GRID_POP->LIST_PROCESSING_EVENTS(
    EXPORTING I_EVENT_NAME = 'TOP_OF_PAGE'
              I_DYNDOC_ID  = GCL_ALV_DOCUMENT ).

  GCL_GRID_POP->SET_TABLE_FOR_FIRST_DISPLAY(
    EXPORTING IS_LAYOUT            = GS_LAYOUT_POP
              IS_VARIANT           = GS_VARIANT_POP
              IT_TOOLBAR_EXCLUDING = GT_EXCLUDE_POP
              I_SAVE               = 'A'
    CHANGING  IT_OUTTAB            = <FT_OUT>
              IT_FIELDCATALOG      = GT_FCAT_POP
              IT_SORT              = GT_SORT_POP ).

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CREATE_INSTANCE_MAIN  — 풀스크린 컨테이너/그리드 (SCREEN0)
*&---------------------------------------------------------------------*
FORM CREATE_INSTANCE_MAIN.
  CHECK GCL_GRID_MAIN IS NOT BOUND.

  GCL_SPLIT_MAIN = NEW CL_GUI_SPLITTER_CONTAINER(
                     PARENT  = CL_GUI_CONTAINER=>SCREEN0
                     ROWS    = 2
                     COLUMNS = 1 ).
  GCL_SPLIT_MAIN->SET_ROW_MODE( MODE = CL_GUI_SPLITTER_CONTAINER=>MODE_RELATIVE ).
  GCL_SPLIT_MAIN->SET_ROW_HEIGHT( ID = 1 HEIGHT = 10 ).

  GCL_TOP_CONT_MAIN     = GCL_SPLIT_MAIN->GET_CONTAINER( ROW = 1 COLUMN = 1 ).
  DATA(LCL_GRID_CONT)   = GCL_SPLIT_MAIN->GET_CONTAINER( ROW = 2 COLUMN = 1 ).
  GCL_GRID_MAIN         = NEW CL_GUI_ALV_GRID( I_PARENT = LCL_GRID_CONT ).
ENDFORM.

*&---------------------------------------------------------------------*
*& Form CREATE_INSTANCE_POP  — 팝업 컨테이너/그리드 (Docking)
*&---------------------------------------------------------------------*
FORM CREATE_INSTANCE_POP.
  CHECK GCL_GRID_POP IS NOT BOUND.

  GCL_DOCK_POP = NEW CL_GUI_DOCKING_CONTAINER(
                   DYNNR     = SY-DYNNR
                   REPID     = SY-REPID
                   SIDE      = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_TOP
                   EXTENSION = 1500 ).
  DATA(LCL_SPLIT) = NEW CL_GUI_SPLITTER_CONTAINER(
                      PARENT  = GCL_DOCK_POP
                      ROWS    = 2
                      COLUMNS = 1 ).
  LCL_SPLIT->SET_ROW_MODE( MODE = CL_GUI_SPLITTER_CONTAINER=>MODE_RELATIVE ).
  LCL_SPLIT->SET_ROW_HEIGHT( ID = 1 HEIGHT = 20 ).

  GCL_TOP_CONT_POP    = LCL_SPLIT->GET_CONTAINER( ROW = 1 COLUMN = 1 ).
  DATA(LCL_GRID_CONT) = LCL_SPLIT->GET_CONTAINER( ROW = 2 COLUMN = 1 ).
  GCL_GRID_POP        = NEW CL_GUI_ALV_GRID( I_PARENT = LCL_GRID_CONT ).
ENDFORM.

*&---------------------------------------------------------------------*
*& Form CREATE_EVENT_RECEIVER  — 단일 이벤트 리시버 등록 (공통)
*&---------------------------------------------------------------------*
FORM CREATE_EVENT_RECEIVER USING PO_GRID TYPE REF TO CL_GUI_ALV_GRID.
  IF GCL_EVENT IS NOT BOUND.
    CREATE OBJECT GCL_EVENT.
  ENDIF.
  SET HANDLER GCL_EVENT->HANDLE_DOUBLE_CLICK FOR PO_GRID.
  SET HANDLER GCL_EVENT->HANDLE_USER_COMMAND FOR PO_GRID.
  SET HANDLER GCL_EVENT->HANDLE_TOOLBAR      FOR PO_GRID.
  SET HANDLER GCL_EVENT->ON_TOP_OF_PAGE      FOR PO_GRID.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form BUILD_FIELDCAT  — RTTI 자동생성 + 화면별 컬럼 커스터마이징
*&   PV_DYNNR: 화면, PT_OUT: 바인딩된 출력 테이블, CT_FCAT: 결과 필드카탈로그
*&---------------------------------------------------------------------*
FORM BUILD_FIELDCAT USING    PV_DYNNR TYPE SY-DYNNR
                             PT_OUT   TYPE ANY TABLE
                    CHANGING CT_FCAT  TYPE LVC_T_FCAT.

  CLEAR CT_FCAT.

  " RTTI: 출력 테이블 라인타입으로 필드카탈로그 자동 생성 (FS §3-2)
  CT_FCAT = CORRESPONDING #(
    CL_SALV_DATA_DESCR=>READ_STRUCTDESCR(
      CAST CL_ABAP_STRUCTDESCR(
        CAST CL_ABAP_TABLEDESCR(
          CL_ABAP_STRUCTDESCR=>DESCRIBE_BY_DATA( PT_OUT )
        )->GET_TABLE_LINE_TYPE( ) ) ) ).

  " 화면별 컬럼 커스터마이징 (col_pos / key / text / no_out / do_sum / 통화·수량 참조)
  LOOP AT CT_FCAT ASSIGNING FIELD-SYMBOL(<LS_FCAT>).
    CLEAR <LS_FCAT>-KEY.

    " 공통: 금액/수량 참조 필드 (KRW ×100 방지, FS §3-6)
    CASE <LS_FCAT>-FIELDNAME.
      WHEN 'MENGE' OR 'CLABS'.            <LS_FCAT>-QFIELDNAME = 'MEINS'. <LS_FCAT>-DO_SUM = ABAP_TRUE.
      WHEN 'DMBTR' OR 'SALK3' OR 'VERPR'. <LS_FCAT>-CFIELDNAME = 'WAERS'. <LS_FCAT>-DO_SUM = ABAP_TRUE.
      WHEN 'CELLTAB' OR 'COLINFO' OR 'INFO' OR 'MARK'. <LS_FCAT>-NO_OUT = ABAP_TRUE.
    ENDCASE.

    " *** TODO(SE38): 화면별 세부 컬럼 규칙(컬럼순서/한글텍스트/숨김)을
    "     기존 BUILD_CATEGORY_200/300/500 (to-be/zmmpar52000f02.abap)에서 이관 ***
    CASE PV_DYNNR.
      WHEN '0100'.  " 메인(GT_DISP)  — 구 BUILD_CATEGORY_100(주석처리, REUSE 기본)
      WHEN '0400'.  " 배치(GT_BATCH_0400) — 구 BUILD_CATEGORY_400(주석처리)
      WHEN '0200'.  " 그룹RAW(GT_RAW_DISP) — 구 BUILD_CATEGORY_200 규칙 이관
      WHEN '0300'.  " SIT(GT_SIT_DISP)     — 구 BUILD_CATEGORY_300 규칙 이관
      WHEN '0500'.  " 자재문서(GT_DISP_0500) — 구 BUILD_CATEGORY_500 규칙 이관
    ENDCASE.
  ENDLOOP.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form BUILD_LAYOUT  — 공통 레이아웃
*&---------------------------------------------------------------------*
FORM BUILD_LAYOUT CHANGING CS_LAYO TYPE LVC_S_LAYO.
  CLEAR CS_LAYO.
  CS_LAYO-CWIDTH_OPT = ABAP_TRUE.
  CS_LAYO-ZEBRA      = ABAP_TRUE.
  CS_LAYO-SEL_MODE   = 'A'.
  CS_LAYO-CTAB_FNAME = 'COLINFO'.   " 셀 컬러 (기존 사용 시)
  CS_LAYO-STYLEFNAME = 'CELLTAB'.   " 셀 스타일 (기존 사용 시)
ENDFORM.

*&---------------------------------------------------------------------*
*& Form BUILD_SORT_MAIN / BUILD_SORT_POP  — 정렬 (필요 시 화면별 채움)
*&---------------------------------------------------------------------*
FORM BUILD_SORT_MAIN. CLEAR GT_SORT_MAIN. ENDFORM.
FORM BUILD_SORT_POP.  CLEAR GT_SORT_POP.  ENDFORM.

*&---------------------------------------------------------------------*
*& Form FREE_POPUP_CONTROLS  — 팝업 "열기 직전" 호출 (FS §5-1)
*&---------------------------------------------------------------------*
FORM FREE_POPUP_CONTROLS.
  CLEAR GCL_HTML_VIEWER.                       " ⚠️ FREE 금지, CLEAR만
  IF GCL_GRID_POP IS BOUND. GCL_GRID_POP->FREE( ). CLEAR GCL_GRID_POP. ENDIF.
  IF GCL_DOCK_POP IS BOUND. GCL_DOCK_POP->FREE( ). CLEAR GCL_DOCK_POP. ENDIF.
  CLEAR GCL_TOP_CONT_POP.
  CL_GUI_CFW=>FLUSH( ).
ENDFORM.

*&---------------------------------------------------------------------*
*& Form EXIT_RTN  — 풀스크린만 직접 FREE / 팝업은 LEAVE만 (FS §5-3)
*&---------------------------------------------------------------------*
FORM EXIT_RTN.
  CLEAR GCL_HTML_VIEWER.
  CASE SY-DYNNR.
    WHEN '0100' OR '0400'.                     " 풀스크린
      IF GCL_GRID_MAIN  IS BOUND. GCL_GRID_MAIN->FREE( ).  CLEAR GCL_GRID_MAIN.  ENDIF.
      IF GCL_SPLIT_MAIN IS BOUND. GCL_SPLIT_MAIN->FREE( ). CLEAR GCL_SPLIT_MAIN. ENDIF.
      CLEAR GCL_TOP_CONT_MAIN.
      CL_GUI_CFW=>FLUSH( ).
      LEAVE TO SCREEN 0.
    WHEN OTHERS.                               " 팝업
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDFORM.

*======================================================================
* [이관 대상] 아래 FORM은 기존 to-be/zmmpar52000f02.abap 에서 로직 변경 없이 이관:
*   - 핸들러: HANDLE_DOUBLE_CLICK_100/200/300/400/500,
*             HANDLE_USER_COMMAND_100/400, HANDLER_TOOLBAR, HANDLER_TOOLBAR_0400
*   - TOP_OF_PAGE, HTML_DISPLAY (단, HTML Viewer는 CLEAR만/FS §5,§8)
*   - EXCLUDE_FUNCTIONKEY (CHANGING 시그니처로 정리 권장)
*   - 비즈니스 UI: SHOW_GROUP_RAW, SHOW_BATCH_DATA 표시 보조 등
* ※ 구 인프라 폼(CREATE_GRID_OBJECT_*/ALV_CLEAR_VARIABLE_*/BUILD_LAYOUT_*/
*    BUILD_SORT_*/BUILD_COLOR_STYLE_*/BUILD_EVENT_*/DISPLAY_ALV_*/BUILD_CATEGORY_*)
*    은 위 공통 폼으로 대체되어 제거됨.
*======================================================================

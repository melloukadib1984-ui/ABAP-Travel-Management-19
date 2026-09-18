CLASS zcl_travel_19 DEFINITION
  PUBLIC

  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS constructor
    IMPORTING
      iv_travel_id   TYPE /dmo/travel_id
      iv_agency_id   TYPE /dmo/agency_id
      iv_begin_date  TYPE /dmo/begin_date
      iv_end_date    TYPE /dmo/end_date
      iv_description TYPE /dmo/description
      iv_status      TYPE /dmo/overall_status
    RAISING
      zcx_travel_19.


       METHODS get_travel_id
    RETURNING VALUE(rv_travel_id) TYPE /dmo/travel_id.

   METHODS get_description
     RETURNING VALUE(rv_description) TYPE /dmo/description.
   METHODS calculate_duration
     RETURNING VALUE(rv_duration) TYPE i.
     METHODS check_travel_period
  RETURNING VALUE(rv_valid) TYPE abap_boolean.
   PROTECTED SECTION.
   PRIVATE SECTION.

  DATA mv_travel_id   TYPE /dmo/travel_id.
  DATA mv_agency_id   TYPE /dmo/agency_id.
  DATA mv_begin_date  TYPE /dmo/begin_date.
  DATA mv_end_date    TYPE /dmo/end_date.
  DATA mv_description TYPE /dmo/description.
  DATA mv_status      TYPE /dmo/overall_status.
ENDCLASS.



CLASS zcl_travel_19 IMPLEMENTATION.
 METHOD constructor.
IF iv_end_date < iv_begin_date.
    RAISE EXCEPTION TYPE zcx_travel_19.
  ENDIF.
    mv_travel_id   = iv_travel_id.
    mv_agency_id   = iv_agency_id.
    mv_begin_date  = iv_begin_date.
    mv_end_date    = iv_end_date.
    mv_description = iv_description.
    mv_status      = iv_status.



  ENDMETHOD.
  METHOD get_travel_id.

    rv_travel_id = mv_travel_id.

  ENDMETHOD.
  METHOD get_description.

  rv_description = mv_description.

ENDMETHOD.
METHOD calculate_duration.

  rv_duration = mv_end_date - mv_begin_date.

ENDMETHOD.
METHOD check_travel_period.

  rv_valid = xsdbool( mv_end_date >= mv_begin_date ).

ENDMETHOD.
ENDCLASS.


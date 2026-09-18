CLASS zcl_travel_sql_19 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
*  METHODS read_travel_data.
 METHODS read_travel_data
  IMPORTING
    iv_travel_id TYPE /dmo/travel_id.
  PROTECTED SECTION.
  PRIVATE SECTION.
*  DATA mt_travel TYPE TABLE OF zstr_travel_19.
TYPES:
  BEGIN OF ty_travel_agency,
    travel_id   TYPE /dmo/travel_id,
    agency_id   TYPE /dmo/agency_id,
    description TYPE /dmo/description,
    begin_date  TYPE /dmo/begin_date,
    end_date    TYPE /dmo/end_date,
    agency_name TYPE /dmo/agency_name,
  END OF ty_travel_agency.
DATA mt_travel TYPE TABLE OF ty_travel_agency.
ENDCLASS.



CLASS zcl_travel_sql_19 IMPLEMENTATION.
 METHOD read_travel_data.
 SELECT FROM ztravel_19 AS t
    INNER JOIN /dmo/agency AS a
      ON a~agency_id = t~agency_id
    FIELDS
      t~travel_id,
      t~agency_id,
      t~description,
      t~begin_date,
      t~end_date,
      a~name AS agency_name
    WHERE t~travel_id = @iv_travel_id
    INTO CORRESPONDING FIELDS OF TABLE @mt_travel.
LOOP AT mt_travel INTO DATA(ls_travel).

  DATA(lv_text) = |{ ls_travel-travel_id } - { ls_travel-agency_name }|.

ENDLOOP.
  ENDMETHOD.
ENDCLASS.

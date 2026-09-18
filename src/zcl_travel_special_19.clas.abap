CLASS zcl_travel_special_19 DEFINITION
  PUBLIC
  INHERITING FROM zcl_travel_19
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS get_description REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
  DATA mv_special_note TYPE string VALUE 'Special Travel'.
ENDCLASS.



CLASS zcl_travel_special_19 IMPLEMENTATION.
METHOD get_description.

  rv_description = |{ super->get_description( ) } - { mv_special_note }|.

ENDMETHOD.
ENDCLASS.

*"* use this source file for your ABAP unit test classes
CLASS ltcl_travel_19 DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS test_valid_travel
      FOR TESTING
      RAISING zcx_travel_19.

    METHODS test_invalid_travel
      FOR TESTING.

ENDCLASS.


CLASS ltcl_travel_19 IMPLEMENTATION.

  METHOD test_valid_travel.

    DATA(lo_travel) = NEW zcl_travel_19(
      iv_travel_id   = '00000001'
      iv_agency_id   = '070001'
      iv_begin_date  = '20260915'
      iv_end_date    = '20260920'
      iv_description = 'Test Travel'
      iv_status      = 'O'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lo_travel->get_travel_id( )
      exp = '00000001'
    ).

    cl_abap_unit_assert=>assert_true(
      act = lo_travel->check_travel_period( )
    ).

  ENDMETHOD.


  METHOD test_invalid_travel.

    TRY.

        DATA(lo_travel) = NEW zcl_travel_19(
          iv_travel_id   = '00000002'
          iv_agency_id   = '070001'
          iv_begin_date  = '20260920'
          iv_end_date    = '20260915'
          iv_description = 'Invalid Travel'
          iv_status      = 'O'
        ).

        cl_abap_unit_assert=>fail(
          msg = 'Expected exception ZCX_TRAVEL_19 was not raised'
        ).

      CATCH zcx_travel_19.
        " هذا هو السلوك المتوقع

    ENDTRY.

  ENDMETHOD.

ENDCLASS.

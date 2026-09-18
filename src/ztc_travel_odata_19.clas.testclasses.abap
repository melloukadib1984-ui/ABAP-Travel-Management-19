"!@testing SRVB:ZTRAVEL_UI_19_O4

CLASS ltc_task18 DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS validation_positive_1
      FOR TESTING
      RAISING cx_static_check.

    METHODS validation_positive_2
      FOR TESTING
      RAISING cx_static_check.

    METHODS validation_negative
      FOR TESTING
      RAISING cx_static_check.

    METHODS determination_default
      FOR TESTING
      RAISING cx_static_check.

    METHODS determination_keep_text
      FOR TESTING
      RAISING cx_static_check.

    METHODS create_proxy
      RETURNING VALUE(ro_proxy)
        TYPE REF TO /iwbep/if_cp_client_proxy
      RAISING cx_static_check.

ENDCLASS.


CLASS ltc_task18 IMPLEMENTATION.

  METHOD create_proxy.

    ro_proxy =
      /iwbep/cl_cp_factory_unit_tst=>create_v4_local_proxy(
        EXPORTING
          is_service_key = VALUE #(
            service_id      = 'ZTRAVEL_UI_19'
            repository_id   = 'SRVD'
            service_version = '0001'
          )
          iv_do_write_traces = abap_true
      ).

  ENDMETHOD.


  METHOD validation_positive_1.

    DATA ls_business_data TYPE zi_travel_19.

    ls_business_data = VALUE #(
      TravelId   = '90000001'
      AgencyId   = '070001'
      CustomerId = '000001'
      BeginDate  = '20260915'
      EndDate    = '20260920'
      Status     = 'O'
    ).

    DATA(lo_client_proxy) = create_proxy( ).

    DATA(lo_request) =
      lo_client_proxy->create_resource_for_entity_set( 'TRAVEL' )->create_request_for_create( ).

    lo_request->set_business_data( ls_business_data ).

    DATA(lo_response) = lo_request->execute( ).

    CLEAR ls_business_data.

    lo_response->get_business_data(
      IMPORTING
        es_business_data = ls_business_data
    ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_business_data-TravelId
      exp = '90000001'
    ).

  ENDMETHOD.


  METHOD validation_positive_2.

    DATA ls_business_data TYPE zi_travel_19.

    ls_business_data = VALUE #(
      TravelId   = '90000002'
      AgencyId   = '070001'
      CustomerId = '000001'
      BeginDate  = '20260915'
      EndDate    = '20260915'
      Status     = 'O'
    ).

    DATA(lo_client_proxy) = create_proxy( ).

    DATA(lo_request) =
      lo_client_proxy->create_resource_for_entity_set( 'TRAVEL' )->create_request_for_create( ).

    lo_request->set_business_data( ls_business_data ).

    DATA(lo_response) = lo_request->execute( ).

    CLEAR ls_business_data.

    lo_response->get_business_data(
      IMPORTING
        es_business_data = ls_business_data
    ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_business_data-TravelId
      exp = '90000002'
    ).

  ENDMETHOD.


  METHOD validation_negative.

    DATA ls_business_data TYPE zi_travel_19.

    ls_business_data = VALUE #(
      TravelId   = '90000003'
      AgencyId   = '070001'
      CustomerId = '000001'
      BeginDate  = '20260920'
      EndDate    = '20260915'
      Status     = 'O'
    ).

    DATA(lo_client_proxy) = create_proxy( ).

    DATA(lo_request) =
      lo_client_proxy->create_resource_for_entity_set( 'TRAVEL' )->create_request_for_create( ).

    lo_request->set_business_data( ls_business_data ).

    DATA lv_rejected TYPE abap_bool VALUE abap_false.

    TRY.

        lo_request->execute( ).

      CATCH cx_root.
        lv_rejected = abap_true.

    ENDTRY.

    cl_abap_unit_assert=>assert_true(
      act = lv_rejected
      msg = 'Invalid travel dates must be rejected'
    ).

  ENDMETHOD.


  METHOD determination_default.

    DATA ls_business_data TYPE zi_travel_19.

    ls_business_data = VALUE #(
      TravelId   = '90000004'
      AgencyId   = '070001'
      CustomerId = '000001'
      BeginDate  = '20260915'
      EndDate    = '20260920'
      Status     = 'O'
    ).

    DATA(lo_client_proxy) = create_proxy( ).

    DATA(lo_request) =
      lo_client_proxy->create_resource_for_entity_set( 'TRAVEL' )->create_request_for_create( ).

    lo_request->set_business_data( ls_business_data ).

    DATA(lo_response) = lo_request->execute( ).

    CLEAR ls_business_data.

    lo_response->get_business_data(
      IMPORTING
        es_business_data = ls_business_data
    ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_business_data-Description
      exp = 'New Travel'
    ).

  ENDMETHOD.


  METHOD determination_keep_text.

    DATA ls_business_data TYPE zi_travel_19.

    ls_business_data = VALUE #(
      TravelId     = '90000005'
      AgencyId     = '070001'
      CustomerId   = '000001'
      BeginDate    = '20260915'
      EndDate      = '20260920'
      Description  = 'Business Trip'
      Status       = 'O'
    ).

    DATA(lo_client_proxy) = create_proxy( ).

    DATA(lo_request) =
      lo_client_proxy->create_resource_for_entity_set( 'TRAVEL' )->create_request_for_create( ).

    lo_request->set_business_data( ls_business_data ).

    DATA(lo_response) = lo_request->execute( ).

    CLEAR ls_business_data.

    lo_response->get_business_data(
      IMPORTING
        es_business_data = ls_business_data
    ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_business_data-Description
      exp = 'Business Trip'
    ).

  ENDMETHOD.

ENDCLASS.


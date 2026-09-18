*CLASS lhc_ZI_TRAVEL_19 DEFINITION
*INHERITING FROM cl_abap_behavior_handler.
*  PRIVATE SECTION.
*METHODS setDescription FOR DETERMINE ON MODIFY
*  IMPORTING keys FOR ZI_TRAVEL_19~setDescription.
*
*    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
*      keys REQUEST requested_authorizations FOR zi_travel_19 RESULT result.
*
*    METHODS validateDates FOR VALIDATE ON SAVE
*       keys FOR zi_travel_19~validateDates.
*METHODS cancelTravel
*  FOR MODIFY
*  IMPORTING keys FOR ACTION ZI_TRAVEL_19~cancelTravel.
*ENDCLASS.
*
*CLASS lhc_ZI_TRAVEL_19 IMPLEMENTATION.
*
*  METHOD get_instance_authorizations.
*  ENDMETHOD.
*
*  METHOD validateDates.
*
*  READ ENTITIES OF ZI_TRAVEL_19 IN LOCAL MODE
*    ENTITY ZI_TRAVEL_19
*    FIELDS ( BeginDate EndDate )
*    WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_travel).
*
*  LOOP AT lt_travel ASSIGNING FIELD-SYMBOL(<travel>).
*
*    IF <travel>-BeginDate IS NOT INITIAL
*       AND <travel>-EndDate IS NOT INITIAL
*       AND <travel>-EndDate < <travel>-BeginDate.
*
*      APPEND VALUE #( %tky = <travel>-%tky )
*        TO failed-zi_travel_19.
*
*      APPEND VALUE #(
*        %tky = <travel>-%tky
*        %msg = new_message_with_text(
*          severity = if_abap_behv_message=>severity-error
*          text = 'End date must not be earlier than begin date'
*        )
*        %element-BeginDate = if_abap_behv=>mk-on
*        %element-EndDate   = if_abap_behv=>mk-on
*      ) TO reported-zi_travel_19.
*
*    ENDIF.
*
*  ENDLOOP.
*
*ENDMETHOD.
*METHOD setDescription.
*
*
*  READ ENTITIES OF ZI_TRAVEL_19 IN LOCAL MODE
*    ENTITY ZI_TRAVEL_19
*      FIELDS ( Description )
*      WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_travel).
*
*  MODIFY ENTITIES OF ZI_TRAVEL_19 IN LOCAL MODE
*    ENTITY ZI_TRAVEL_19
*      UPDATE FIELDS ( Description )
*      WITH VALUE #(
*        FOR travel IN lt_travel
*        WHERE ( Description IS INITIAL )
*        (
*          %tky = travel-%tky
*          Description = 'New Travel'
*        )
*      ).
*
*ENDMETHOD.
*METHOD cancelTravel.
*
*  READ ENTITIES OF ZI_TRAVEL_19 IN LOCAL MODE
*    ENTITY ZI_TRAVEL_19
*      FIELDS ( Status )
*      WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_travel).
*
*  MODIFY ENTITIES OF ZI_TRAVEL_19 IN LOCAL MODE
*    ENTITY ZI_TRAVEL_19
*      UPDATE FIELDS ( Status )
*      WITH VALUE #(
*        FOR travel IN lt_travel
*        WHERE ( Status = 'O' )
*        (
*          %tky = travel-%tky
*          Status = 'X'
*        )
*      ).
*
*ENDMETHOD.
*
*ENDCLASS.
 CLASS lhc_ZI_TRAVEL_19 DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS setDescription FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZI_TRAVEL_19~setDescription.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_travel_19 RESULT result.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_travel_19~validateDates.

    METHODS cancelTravel FOR MODIFY
      IMPORTING keys FOR ACTION ZI_TRAVEL_19~cancelTravel.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR ZI_TRAVEL_19 RESULT result.

ENDCLASS.

CLASS lhc_ZI_TRAVEL_19 IMPLEMENTATION.

  METHOD get_instance_authorizations.
    " ملاحظة: فارغة حاليًا - مقبولة لأغراض التمرين
    " للسماح بالكامل لكل العمليات، يمكن إضافة:
    " result = VALUE #( FOR key IN keys
    "   ( %tky                     = key-%tky
    "     %update                  = if_abap_behv=>auth-allowed
    "     %delete                  = if_abap_behv=>auth-allowed
    "     %action-cancelTravel     = if_abap_behv=>auth-allowed ) ).
     result = VALUE #(
    FOR key IN keys
    (
      %tky = key-%tky

      %update =
        if_abap_behv=>auth-allowed

      %action-cancelTravel =
        if_abap_behv=>auth-allowed
    )
  ).
  ENDMETHOD.

  METHOD validateDates.

    READ ENTITIES OF ZI_TRAVEL_19 IN LOCAL MODE
      ENTITY ZI_TRAVEL_19
      FIELDS ( BeginDate EndDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travel).

    LOOP AT lt_travel ASSIGNING FIELD-SYMBOL(<travel>).

      IF <travel>-BeginDate IS NOT INITIAL
         AND <travel>-EndDate IS NOT INITIAL
         AND <travel>-EndDate < <travel>-BeginDate.

        APPEND VALUE #( %tky = <travel>-%tky )
          TO failed-zi_travel_19.

        APPEND VALUE #(
          %tky = <travel>-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'End date must not be earlier than begin date'
          )
          %element-BeginDate = if_abap_behv=>mk-on
          %element-EndDate   = if_abap_behv=>mk-on
        ) TO reported-zi_travel_19.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD setDescription.

    READ ENTITIES OF ZI_TRAVEL_19 IN LOCAL MODE
      ENTITY ZI_TRAVEL_19
        FIELDS ( Description )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travel).

    MODIFY ENTITIES OF ZI_TRAVEL_19 IN LOCAL MODE
      ENTITY ZI_TRAVEL_19
        UPDATE FIELDS ( Description )
        WITH VALUE #(
          FOR travel IN lt_travel
          WHERE ( Description IS INITIAL )
          (
            %tky        = travel-%tky
            Description = 'New Travel'
          )
        ).

  ENDMETHOD.

  METHOD cancelTravel.

    READ ENTITIES OF ZI_TRAVEL_19 IN LOCAL MODE
      ENTITY ZI_TRAVEL_19
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travel).

    MODIFY ENTITIES OF ZI_TRAVEL_19 IN LOCAL MODE
      ENTITY ZI_TRAVEL_19
        UPDATE FIELDS ( Status )
        WITH VALUE #(
          FOR travel IN lt_travel
          WHERE ( Status = 'O' )
          (
            %tky   = travel-%tky
            Status = 'X'
          )
        ).

  ENDMETHOD.

METHOD get_global_authorizations.

  IF requested_authorizations-%create = if_abap_behv=>mk-on.

    result-%create =
      if_abap_behv=>auth-allowed.

  ENDIF.

ENDMETHOD.

ENDCLASS.

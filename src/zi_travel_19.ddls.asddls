@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Management CDS View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TRAVEL_19
  as select from ztravel_19
  association [0..1] to ZI_AGENCY_19 as _Agency
    on $projection.AgencyId = _Agency.AgencyId
{
  key travel_id        as TravelId,
      agency_id        as AgencyId,
      customer_id      as CustomerId,
      begin_date       as BeginDate,
      end_date         as EndDate,
      description      as Description,
      status            as Status,
      created_by       as CreatedBy,
      created_at       as CreatedAt,
      last_changed_by  as LastChangedBy,
      last_changed_at  as LastChangedAt
}

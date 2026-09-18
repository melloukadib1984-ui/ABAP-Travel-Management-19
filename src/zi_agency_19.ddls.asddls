@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Agency'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_AGENCY_19 as select from /dmo/agency
{
    key agency_id as AgencyId,
    name as Name,
    city as City,
    country_code as CountryCode
   
}

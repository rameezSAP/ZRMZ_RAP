@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RAP CDS 1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connections',
    title: {    type: #STANDARD, value: 'CarrierId' },
    description: {
    type: #STANDARD,
    value: 'ConnectionId' }
}

@Search.searchable: true

define view entity ZCDS_RAP1
  as select from /dmo/connection
  association [1..1] to /DMO/I_Carrier as _Carrier on  $projection.CarrierId = _Carrier.AirlineID

  association [1..*] to ZCDS_RAP1_1    as _Flight  on  $projection.CarrierId    = _Flight.CarrierId
                                                   and $projection.ConnectionId = _Flight.ConnectionId
{
      @UI.facet: [{
          id: 'IdConnection',
          purpose: #STANDARD,
          position: 10,
          label: 'Connection Details',
          type: #IDENTIFICATION_REFERENCE
      },
      {
          id: 'IdFlight',
          purpose: #STANDARD,
          position: 20,
          label: 'All Flights',
          type: #LINEITEM_REFERENCE,
          targetElement: '_Flight'
      }
      ]

      @UI.lineItem: [{ position: 10 , label: 'AirPlane ID'}]
      @UI.identification: [{ position: 09, label: 'Flight ID' }]
      @ObjectModel.text.association: '_Carrier'
  key carrier_id      as CarrierId,
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 10, label: 'AirCraft ID' }]
  key connection_id   as ConnectionId,
      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 20 }]
      @UI.selectionField: [{ position: 10  }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Consumption.valueHelpDefinition: [{ entity: {
          name: '/DMO/I_Airport_StdVH',
          element: 'AirportID'
      } }]
      airport_from_id as AirportFromId,
      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 30, label: 'To Airport' }]
      @UI.selectionField: [{ position: 20  }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: '/DMO/I_Airport_StdVH',
              element: 'AirportID'
          }
      }]
      airport_to_id   as AirportToId,
      @UI.lineItem: [{ position: 50, label: 'Depart Time' }]
      departure_time  as DepartureTime,
      arrival_time    as ArrivalTime,
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      @UI.lineItem: [{ position: 11, label: 'Distance' }]
      distance        as Distance,
      distance_unit   as DistanceUnit,

      //Associations
      _Carrier,
      @Search.defaultSearchElement: true
      _Flight

}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rap 1 _1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@Search.searchable: true
define view entity ZCDS_RAP1_1 as select from /dmo/flight
{
      @UI.facet: [{
          id: 'IdFlight',
          purpose: #STANDARD,
          position: 10,
          label: 'Flight Details',
          type: #IDENTIFICATION_REFERENCE
      }
     ]
    @UI.lineItem: [{ position: 10  }]
    key carrier_id as CarrierId,
    @UI.lineItem: [{ position: 20  }]
    key connection_id as ConnectionId,
    @UI.lineItem: [{ position: 30  }]
    key flight_date as FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    @UI.lineItem: [{ position: 40  }]
    @UI.identification: [{ position: 10, label: 'Price' }]
    price as Price,
    currency_code as CurrencyCode,
    @UI.lineItem: [{ position: 50  }]
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    plane_type_id as PlaneTypeId,
    @UI.lineItem: [{ position: 60  }]
    seats_max as SeatsMax,
    @UI.lineItem: [{ position: 70  }]
    @UI.identification: [{ position: 10, label: 'Seats Occupied' }]
    seats_occupied as SeatsOccupied
}

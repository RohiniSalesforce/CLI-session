trigger QuickBookutils on QucikBookscustomer__c (after insert) {

    CreatecustomerQBtrigerhandler.Createcustomermethod(Trigger.new);

}
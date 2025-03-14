public with sharing class Platfromeventresulthandler implements EventBus.EventPublishSuccessCallback, EventBus.EventPublishFailureCallback{
   
   // implemetn both this since we are having siccess n failure
   //EventBus.EventPublishSuccessCallback, EventBus.EventPublishFailureCallback
    public void onSuccess(EventBus.SuccessResult result){
        System.debug('Success');
        System.debug(result.getEventUuids());
    }

    public void onFailure(EventBus.FailureResult result){
        System.debug('Failure');
        System.debug(result.getEventUuids());
    }
}
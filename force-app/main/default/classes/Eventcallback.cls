public with sharing class Eventcallback implements EventBus.EventPublishSuccessCallback {
    //this onsuccess method will hold the result which we get from the call back
// to verify the result we need to implement this method from event bus -EventBus.EventPublishSuccessCallback 
    public void onSuccess(EventBus.SuccessResult result){
        System.debug('Success');
        System.debug(result.getEventUuids());
    }
}
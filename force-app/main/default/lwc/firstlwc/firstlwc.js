import { LightningElement } from 'lwc';
import { subscribe, unsubscribe, onError}from 'lightning/empApi';
export default class Firstlwc extends LightningElement {

    subscription;
    // eventName = '/event/BatchApexErrorEvent';
    eventName = '/event/SAPAccount__e';
    eventMessage;

    connectedCallback(){
        this.reisterErrorHandler();
        this.handleSubscribe();
    }

    handleSubscribe(){
        this.subscription = subscribe(this.eventName, -2, this.handleSuccessErrorMessage.bind(this));
        console.log(this.subscription);
    }

    handleSuccessErrorMessage(message){
        console.log('Message Received!');
        this.eventMessage = JSON.stringify(message);
    }

    disconnectedCallback(){
        this.handleUnSubscribe();
    }

    handleUnSubscribe(){
        unsubscribe(this.subscription, (response) => {
            console.log(response);
        });
    }

    reisterErrorHandler(){
        onError((error) => {
            console.error(error);
        });
    }

}
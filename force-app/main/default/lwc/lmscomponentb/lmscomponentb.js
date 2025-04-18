import { LightningElement,wire } from 'lwc';
import SAMPLEMC from "@salesforce/messageChannel/SampleMessagingChannel__c";
import { subscribe,publish, MessageContext, APPLICATION_SCOPE,unsubscribe } from 'lightning/messageService';

export default class Lmscomponentb extends LightningElement {
    recivedMessage
    subscription
    @wire(MessageContext)
     messageContext;

     connectedCallback() {
        if (this.messageContext) {
            this.subscribeMessage();
        } else {
            console.error('MessageContext not available during connectedCallback.');
        }
    }
 
     
     subscribeMessage(){
     this.subscription=subscribe(this.messageContext,SAMPLEMC, (message) => {this.handleMessage(message)},
     {scope:APPLICATION_SCOPE});
     }
     handleMessage(message){
        this.recivedMessage=message.LMSComponentAData.value?message.LMSComponentAData.value:'No message received';
     }

     UnsubscribeMessage(){
        unsubscribe(this.subscription)
        this.subscription=null;
     }
}
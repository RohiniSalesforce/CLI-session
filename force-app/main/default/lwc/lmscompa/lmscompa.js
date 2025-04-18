import { LightningElement,wire } from 'lwc';
import SAMPLEMC from "@salesforce/messageChannel/SampleMessagingChannel__c";
import { subscribe,publish, MessageContext } from 'lightning/messageService';
export default class Lmscompa extends LightningElement {
    inputvalue;
    @wire(MessageContext)
     messageContext;

   
     handleInputChange(event){
        this.inputvalue = event.target.value;
     }
     publishmessage(){
        const message = {
            
            LMSComponentAData:{
                value: this.inputvalue
            }
        };
        publish(this.messageContext, SAMPLEMC, message);

}
}
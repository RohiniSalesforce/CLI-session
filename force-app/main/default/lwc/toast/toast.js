import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Toast extends LightningElement {
    showToast(event){
        this.commontoastmethod('Success', 'Record created', 'success');
    }
    showToastError(event){
        this.commontoastmethod('Error', '{0} Record not created {1} ', 'error');
    
    }
    showToastWarning(event){
        this.commontoastmethod('Warning', 'Record should have 15 chanrs', 'warning');
    
    }
    showToastInfo(event){
        this.commontoastmethod('Info', 'summer 20 release availbel', 'info');
    
    }
    commontoastmethod(title, message, variant,mode){
        const evt= new ShowToastEvent({
            title,
            message,    
            variant,
            messageData:[
                'salesforce',
                {
                    url: 'https://www.salesforce.com',
                    label: 'click here'
                }
            ],
            mode:'dismissable',
            duration: 2000
         });
         this.dispatchEvent(evt);
    }
}
import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';

export default class Lwcrecordform extends LightningElement {
    @api recordId;
    @api objectApiName ;
OBJECT_NAME = ACCOUNT_OBJECT;
field_list=[
    NAME_FIELD,
    ANNUAL_REVENUE_FIELD,
    INDUSTRY_FIELD,
    TYPE_FIELD,
    PHONE_FIELD
]
handleSuccess(event) {
    const recordId = event.detail.id;
    console.log('Record ID: ' + recordId);
    const toastEvent = new ShowToastEvent({
        title: 'Success',
        message: 'Record created successfully with ID: ' + recordId,
        variant: 'success',
    });
    this.dispatchEvent(toastEvent);
}
}
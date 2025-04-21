import { LightningElement, wire, api } from 'lwc';
import { getRecord,getRecordUi ,getFieldDisplayValue,getFieldValue} from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import OWNER_NAME_FIELD from '@salesforce/schema/Account.Owner.Name';
import ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';

export default class Getrecorddemo extends LightningElement {
    name;
    OWNER;
    annualrev;
    @api recordId; // Record ID passed to the component

    // Fields to fetch
    fields = [NAME_FIELD, OWNER_NAME_FIELD, ANNUAL_REVENUE_FIELD];

    // Wire adapter to fetch the record
    @wire(getRecord, { recordId: '$recordId', fields: '$fields' })
    accounthandler({ data, error }) {
        if (data) {
            // this.name = data.fields.Name.value;
            // this.OWNER = data.fields.Owner.displayValue;
            // this.annualrev = data.fields.AnnualRevenue.value;
            // feild value
            this.name = getFieldValue(data, NAME_FIELD);
            this.OWNER = getFieldValue(data, OWNER_NAME_FIELD);  
            this.annualrev = getFieldDisplayValue(data, ANNUAL_REVENUE_FIELD);
            console.log('Record Data:', data);
        }
        if (error) {
            console.error('Error:', error);
        }
    }
    name1;
    OWNER1;
    annualrev1;
    @wire(getRecordUi, { recordIds: '$recordId', layoutTypes: ['Full'], modes: ['View'] })
    recordUiHandler({ data, error }) {
        if (data) {
            console.log('Record UI Data:', data);
            const record = data.records[this.recordId];
            this.name1 = record.fields.Name.value;
            this.OWNER1 = record.fields.Owner.displayValue;
            this.annualrev1 = record.fields.AnnualRevenue.value;
        }
        if (error) {
            console.error('Error:', error);
        }
    }
}
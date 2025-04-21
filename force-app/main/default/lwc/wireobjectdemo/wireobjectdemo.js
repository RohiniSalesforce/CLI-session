import { LightningElement, wire } from 'lwc';
import { getObjectInfo, getObjectInfos } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity';

export default class Wireobjectdemo extends LightningElement {
    objectApiName = ACCOUNT_OBJECT.objectApiName; // Specify the object API name
    objectInfo; // To hold the object info
    error; // To hold any errors
    objectApiNames = [ACCOUNT_OBJECT.objectApiName, OPPORTUNITY_OBJECT.objectApiName]; // Array of object API names

    // Fetch single object info
    @wire(getObjectInfo, { objectApiName: '$objectApiName' })
    objectInfoHandler
    objectInfos;
    // Fetch multiple object infos
    @wire(getObjectInfos, { objectApiNames: '$objectApiNames' }) // Corrected parameter name
    multipleobjectInfoHandler({ data, error }) {
        if (data) {
            this.objectInfos = data;
            console.log('Multiple Object Info:', data);
        } else if (error) {
            console.error('Error fetching multiple object info:', error);
        }
    }
}
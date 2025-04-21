import { LightningElement, wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import TYPE_FIELD from '@salesforce/schema/Account.Type';

export default class Wirepicklistdemo extends LightningElement {
    options = []; // Initialize options as an empty array

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objectInfo

    get recordTypeId() {
        return this.objectInfo?.data?.defaultRecordTypeId || null;
    }
    selectedIndustry = '';
    Industryoption=[];
    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: INDUSTRY_FIELD })
    picklistValues({ error, data }) {
        if (data) {
          this.Industryoption= [...this.generateOptions(data)];
            console.log('Picklist values:',data);
        } else if (error) {
            console.error('Error fetching picklist values:', error);
        }
    }

 
    generateOptions(data) {
        return  data.values.map(item =>  ({ label: item.label, value: item.value}));

    }

    handleChange(event) {
        this.selectedIndustry = event.detail.value;
    }

    typeoption=[];
    selectedType='';
    // secont piclist of type
    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: TYPE_FIELD })
    typepicklistValues({ error, data }) {
        if (data) {
          this.typeoption= [...this.generateOptions(data)];
            console.log('Picklist values:',data);
        } else if (error) {
            console.error('Error fetching picklist values:', error);
        }
    }
    handleTypeChange(event) {
        this.selectedType = event.detail.value;
    }

}
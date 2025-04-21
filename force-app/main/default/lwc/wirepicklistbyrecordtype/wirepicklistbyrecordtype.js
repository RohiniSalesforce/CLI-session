import { LightningElement,wire} from 'lwc';
import { getPicklistValuesByRecordType, getObjectInfo } from 'lightning/uiObjectInfoApi';

import ACCOUNT_OBJECT from '@salesforce/schema/Account';
export default class Wirepicklistbyrecordtype extends LightningElement {
    ratingoptions=[];
    industryoptions=[];
    selectedfeildInd='';
    selectedfeildrating='';
    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
        objectInfo
    
        get recordTypeId() {
            return this.objectInfo?.data?.defaultRecordTypeId || null;
        }


    @wire(getPicklistValuesByRecordType, {objectApiName: ACCOUNT_OBJECT, recordTypeId: '$recordTypeId'})
    industryPicklistValues({ data, error }) {
        if (data) {
    this.industryoptions= [...this.generateOptions(data.picklistFieldValues.Industry)];
    this.ratingoptions= [...this.generateOptions(data.picklistFieldValues.Rating)];
            console.log('Accoutnoptions',data);
        } else if (error) {
            console.error('Error fetching picklist values:', error);
        }
    }
    generateOptions(data) {
        return  data.values.map(item =>  ({ label: item.label, value: item.value}));

    }
    handlePicklistChange(event) {
        // here we have are getting event.target.name and event.target.value
        //  both mentioned in same variable name as a const , so that name=event.target.name and value=event.target.value
        // destructuring the event.target.name and event.target.value
        const {name,value} = event.target;

        if (name === 'Industry') {
            this.selectedfeildInd = value;
        } else if (name === 'Rating') {
            this.selectedfeildrating = value;
        }

    }
    
}
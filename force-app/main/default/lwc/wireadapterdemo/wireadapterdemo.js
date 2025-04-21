import { LightningElement, wire } from 'lwc';
import getUserId from '@salesforce/user/Id';
import { getRecord } from 'lightning/uiRecordApi';
import USER_NAME from '@salesforce/schema/User.Name';
import USER_EMAIL from '@salesforce/schema/User.Email';
const FIELDS = [USER_NAME, USER_EMAIL];

export default class Wireadapterdemo extends LightningElement {
    userID = getUserId; // Dynamically fetch the current user's ID
    userdetails = null; // Initialize as null to avoid undefined errors

    @wire(getRecord, { recordId: '$userID', fields:FIELDS })
    userdetailhandler({ data, error }) {
        if (data) {
            console.log('User Data:', data); // Debugging the data structure
            this.userdetails = {
                email: data.fields.Email.value,
                name: data.fields.Name.value
            };
        } else if (error) {
            console.error('Error:', error); // Log the error
        }
    }

    @wire(getRecord, { recordId: '$userID', fields: FIELDS})
    userdetailsproperty
}
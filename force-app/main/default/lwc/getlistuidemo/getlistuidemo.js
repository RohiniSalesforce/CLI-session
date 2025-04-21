import { LightningElement,wire } from 'lwc';
import {getListUi} from 'lightning/uiListApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import TITLE_FIELD from '@salesforce/schema/Contact.Title';
export default class Getlistuidemo extends LightningElement {
contactrec=[]
pageToken = null; // Current page token
    prevPageToken = null; // Previous page token
    nextPageToken = null; // Next page token

@wire(getListUi, { objectApiName: CONTACT_OBJECT, listViewApiName: 'AllContacts',pageSize: 10 ,sortBy: TITLE_FIELD,
    pageToken: '$pageToken'  })
listViewUi({ error, data }) {
    if (data) {
        this.contactrec = data.records.records;
        this.prevPageToken = data.records.previousPageToken; // Update previous page token
            this.nextPageToken = data.records.nextPageToken; // Update next page token
            
        console.log('List View Data:', data);
    } else if (error) {
        console.error('Error fetching list view data:', error);
    }
}
Previous(){
    this.pageToken = this.prevPageToken;
}
Next(){
    this.pageToken = this.nextPageToken;
}
}
import { LightningElement ,wire} from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import { updateRecord } from 'lightning/uiRecordApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact'; 
import Title from '@salesforce/schema/Contact.Title';
const columnsdaata = [
    { label: 'Id', fieldName: 'Id', type: 'text' },
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' ,editable: true},
    { label: 'AccountId', fieldName: 'AccountId', type: 'text' },
    { label: 'Title', fieldName: Title.fieldApiName, type: Title.objectApiName },
    { label: 'AccountName', fieldName: 'AccountName', type: 'text' }
];
export default class Updaterecord extends LightningElement {
    contacts=[];
    columns = columnsdaata;
    draftValues=[];
    @wire(getListUi, { objectApiName: CONTACT_OBJECT.objectApiName, listViewApiName: 'AllContacts'})
    listViewUi({ data, error }) {
        if (data) {
            this.contacts = data.records.records.map(record => {
                return {
                    Id: this.getvalue(record, 'Id'),
                    Name: this.getvalue(record, 'Name'),
                    Email: this.getvalue(record, 'Email'),
                    Phone: this.getvalue(record, 'Phone'),
                    AccountId: this.getvalue(record, 'AccountId'),
                    Title: this.getvalue(record, 'Title'),
                    AccountName: this.getvalue(record, 'AccountId') // Custom logic for AccountName
               };
            });
            console.log('List View Data for update record:', data);
        } else if (error) {
            console.error('Error fetching list view data:', error);
        }
    }
    getvalue(record, field) {
        if (record && record.fields && record.fields[field]) {
            return record.fields[field].value; // Safely access the field value
        }
        return null; // Return null if the field is missing
    }
    savechanges(event){
        // 0: {Phone: '367-', id: 'row-0'}
        const updatedfields = event.detail.draftValues.map(draft => {
            const fields = {...draft}; 
            //  fields will be {Phone: '367-', id: 'row-0'}
            return {fields:fields};
        });
        
//  since we have multiple recods to update we need to loop through the updatedfields
const promises = updatedfields.map(record => updateRecord(record));

    Promise.all(promises)
        .then(() => {
            console.log('Records updated successfully');
            // Clear draft values in the datatable
            this.template.querySelector('lightning-datatable').draftValues = [];
        })
        .catch(error => {
            console.error('Error updating records:', error);
            // Handle error if needed
        });
    
    }
}
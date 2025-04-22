import { LightningElement,wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact' 
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Createrecordui extends LightningElement {
   formfeild={};
   handleInputChange(event){
        const {name,value}=event.target;
        this.formfeild[name]=value;
    }
    createContact(event){
      const eachrecord={apiName:CONTACT_OBJECT.objectApiName,fields:this.formfeild};
      createRecord(eachrecord).then(record=>{
        this.showtoast('Success in creation',`Contact has been creaded ${record.id}` ,'success')
        this.template.querySelector('form.createform').reset();
        this.formfeild={};
      }).catch(error=>{
        this.showtoast('eror in creation',error.body.message,'error')
      })
    }

    showtoast(title,message,variant){
        this.dispatchEvent(new ShowToastEvent({
            title,
            message,
            variant:variant||'success'
        }))
    }
}
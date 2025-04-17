import { LightningElement } from 'lwc';

export default class Parenttochildevent extends LightningElement {

    isModalOpen=false;
    data;
    handleOpenModal(event){  
        this.isModalOpen=true;
    }
    handleclose(event){
        // te fetch the data
         this.data = event.detail.message;
        this.isModalOpen=false;
    }
}

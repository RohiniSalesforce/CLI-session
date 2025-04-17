import { LightningElement } from 'lwc';

export default class Slotchild extends LightningElement {
    handlefooterchange(){
        const footer = this.template.querySelector('.slds-card__footer');
        if(footer){
            footer.classList.remove('slds-hide');
        }
    }
}
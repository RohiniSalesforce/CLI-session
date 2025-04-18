import { LightningElement } from 'lwc';

export default class Customlightningcard extends LightningElement {

    handlefooterhcnage(event){
        const footerele = this.template.querySelector('footer');
        if(footerele){
            footerele.classList.remove('slds-hide');
        }
    }
}
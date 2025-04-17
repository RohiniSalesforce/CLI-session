import { LightningElement,api } from 'lwc';

export default class Sliderchildcomponent extends LightningElement {
    val=20;
    changehandleslider(event){
        this.val=event.target.value;
    
    }
    @api resetslider(event){
        this.val=0;
    }
}
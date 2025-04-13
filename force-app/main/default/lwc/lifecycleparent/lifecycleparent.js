import { LightningElement } from 'lwc';

export default class Lifecycleparent extends LightningElement {
    ischildvisible=false;
    constructor() {
        super();
        console.log('Lifecycle Parent Constructor');
    }
    connectedCallback() {
        console.log('Lifecycle Parent connectedCallback');
    }
    renderedCallback(){
        console.log('Lifecycle Parent renderedCallback');
    }
    toggleChild(event){
        this.ischildvisible=!this.ischildvisible;
    }
    errorCallback(error, stack){
        console.log('Error in Parent');
        console.log(error.message);
        console.log(stack);
    }
    
}
import { LightningElement } from 'lwc';

export default class Childlifecyclecomponent extends LightningElement {
    constructor() {
        super();
        console.log('Lifecycle child Constructor');
    }
    connectedCallback() {
        console.log('Lifecycle child connectedCallback');
        throw new Error('Error in connectedCallback');
    }
    renderedCallback(){
        console.log('Lifecycle child renderedCallback');
    }
    disconnectedCallback() {
        alert('Lifecycle child disconnectedCallback');
    }
}
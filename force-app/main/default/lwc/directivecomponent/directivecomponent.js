import { LightningElement } from 'lwc';

export default class Directivecomponent extends LightningElement {
    visible = false
    name

    handleClick(event) {
        // Your logic here
        this.visible = true;
    }
    handleclickinput(event){
        // Your logic here
        this.name = event.target.value;
        
    }
    get handleChangeinput() {  
        // Your logic here
        return  this.name === 'hello' ? true : false;
    }
}
import { LightningElement } from 'lwc';
import Signintemplate from './Signintemplate.html';
import Signuntemplate from './Signuptemplate.html';
import rendercomponent from './rendercomponent.html';
export default class Rendercomponent extends LightningElement {
    selected=''
    render(){ 
        return this.selected === 'Signin' ? Signintemplate : this.selected === 'Signup' ? Signuntemplate : rendercomponent;
    }
    toggleChild(event){
        // here we ar assignthe label name randomly based on the button clicked
        this.selected = event.target.label;
       
    }
    subithandler(event){
       console.log(`${event.target.label} button clicked`);
    }
}
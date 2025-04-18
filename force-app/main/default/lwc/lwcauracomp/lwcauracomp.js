import { LightningElement ,api} from 'lwc';

export default class Lwcauracomp extends LightningElement {
 @api title
 handleClick(){
   const evnt= new CustomEvent('mycustomevent', { detail: { message: 'Hello from lwc' } });
    this.dispatchEvent(evnt)
 }
}
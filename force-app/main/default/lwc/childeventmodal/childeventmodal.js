import { LightningElement } from 'lwc';

export default class Childeventmodal extends LightningElement {
    closehandler() {
        const closeEvent = new CustomEvent('closemodal',{
            bubbles: true,
            detail: {
                message: 'Modal closed'
            }

        }

        );
        this.dispatchEvent(closeEvent); 
    }
    footerhandler(){
        console.log('footer event handler called');
    }
}
import { LightningElement,api} from 'lwc';

export default class Childcomponentforcomminocation extends LightningElement {
    @api message;
    @api isvalid;
    @api number;
}
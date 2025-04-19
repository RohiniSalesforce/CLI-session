import { LightningElement } from 'lwc';
// this is a placeholder for the static resource component 
// buy default mention this -@salesforce/resourceUrl and give imagename
import userimage from '@salesforce/resourceUrl/userimage';

export default class Staticresource extends LightningElement {
    UserImage=userimage
}
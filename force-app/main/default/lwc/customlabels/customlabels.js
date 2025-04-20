import { LightningElement } from 'lwc';
import customlabelcode	 from '@salesforce/label/c.customlabelcode';
import description2 from '@salesforce/label/c.description2';

export default class Customlabels extends LightningElement {

    labels={
        labelone: customlabelcode,
        labeltwo: description2
    }
}
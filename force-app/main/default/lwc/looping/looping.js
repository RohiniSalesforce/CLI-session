import Company from '@salesforce/schema/Lead.Company';
import { LightningElement } from 'lwc';

export default class Looping extends LightningElement {
    carlist=["volvo","saab","mercedes","audi"];
    ceolist=[
        {
        id:1,
        Company:'volvo',
        Model:'s60'
    },
    {
        id:2,
        Company:'saab',
        Model:'s80'
    },
    {
        id:3,
        Company:'mercedes',
        Model:'e200'    
    },
    {
        id:4,
        Company:'audi',
        Model:'a8'
    }


]
        
    
}
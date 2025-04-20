import { LightningElement ,api} from 'lwc';
import hasviewalldata from '@salesforce/userPermission/ViewAllData';
import custompermission from '@salesforce/customPermission/showdetails';
import formfactor from '@salesforce/client/formFactor';
import ID from '@salesforce/user/Id';
import isguest from '@salesforce/user/isGuest';

export default class Checkpermissiondemo extends LightningElement {
    // import the recordid and objectid from the record page for app page it will be null
    @api recordId;
    @api objectApiName;
   userid=ID
    isguestuser=isguest
    hasViewAllData = hasviewalldata;
    formfactor1 = formfactor;
    custpermission=custompermission
    get viewalldataavialbale(){
        return this.hasViewAllData;
    }
    get checkpermisionavialbale(){
        return this.custpermission;
    }
}
import { LightningElement, wire } from 'lwc';
import { NavigationMixin,CurrentPageReference } from 'lightning/navigation';
import {encodeDefaultFieldValues} from 'lightning/pageReferenceUtils';
import FirstName from '@salesforce/schema/Contact.FirstName';
import LeadSource from '@salesforce/schema/Contact.LeadSource';
export default class Navigatetohome extends NavigationMixin(LightningElement){
    @wire(CurrentPageReference) 
    pageRef;
    get getCurrentPageReference(){
        return this.pageRef ? JSON.stringify(this.pageRef,null,2 ): '';
    }
    navigateToHome(){
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'home'
            }
        });
    }
    navigateToChatter(){
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'chatter'
            }
        });
    }
    navigateToObject(){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'new'
            }
        });
    }
    navigateToObjectdefaultvalues(){
       const defaultvalue= encodeDefaultFieldValues({
           FirstName: 'John',
            LastName: 'Doe',  
            Phone: '1234567890',
            LeadSource: 'Web'
        });
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName: 'new'
            },
            state: {
                // defaultFieldValues: 'Industry=Banking,Type=Customer'
                defaultFieldValues: defaultvalue
            }
        });
    }
    navigateToListView(){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'list'
            },
            state: {
                filterName: 'RecentAccounts'
            }
        });
    }
    navigateToFiles(){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'ContentDocument',
                actionName: 'home'
            }
        });
    }
    navigateToRecordviewmode(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: '001dL00000rUNlTQAW',
                objectApiName: 'Account',
                actionName: 'view'
            }
        });
    }
    navigateToRecordEditmode(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: '001dL00000rUNlTQAW',
                objectApiName: 'Account',
                actionName: 'edit'
            }
        });
    }
    navigateToNavigateitemtab(){
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'Order__x'
            }
        });
    }
    navigateToRelationpage(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
                recordId: '001dL00000rUNlTQAW',
                objectApiName: 'Account',
                relationshipApiName: 'Contacts',
                actionName: 'view'
            }
        });
    }

    navigateToExternalWebpage(){
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://www.google.com'
            }
        });
    }
    navigateToLWCPage(){
        var compdef={
            componentDef: 'c:looping',
            attributes: {
                recordId: '001dL00000rUNlTQA2'
            }
        
        };
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
               url:'/one/one.app#' +btoa(JSON.stringify(compdef))
            }
        });
    }
    navigateToAurapage(){
        this[NavigationMixin.Navigate]({
            type: 'standard__component',
            attributes: {
                componentName: 'c__auralwccomponent'
            },
            state: {
                c__id: '12345'
                
            }
        });
    }
    navigateToVFPage(){
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/apex/lwctovfcommunication'
            }
        }).then(generatedurl => {
            window.open(generatedurl, '_blank');
            // Handle any additional logic after navigation if needed
        }).catch(error => {
            console.error('Error navigating to VF page:', error);
        });
    }
}
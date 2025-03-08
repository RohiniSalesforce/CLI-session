public with sharing class CreatecustomerQBtrigerhandler {
    public static void Createcustomermethod(List<QucikBookscustomer__c> Customer) {

        for(QucikBookscustomer__c eachcustomer:Customer){
            QucikBookCustomerWrapper wraptest=new QucikBookCustomerWrapper();

        wraptest.FullyQualifiedName=eachcustomer.Name;
        wraptest.DisplayName=eachcustomer.Name;
        wraptest.Suffix=eachcustomer.Suffix__c;
        wraptest.Title=eachcustomer.Title__c;
        wraptest.MiddleName=eachcustomer.Middle_Name__c;
        wraptest.Notes=eachcustomer.Notes__c;
        wraptest.FamilyName=eachcustomer.Name;
        wraptest.CompanyName=eachcustomer.Compant_Name__c;
        wraptest.GivenName=eachcustomer.Given_Name__c;

        QucikBookCustomerWrapper.PrimaryEmailAddr emailaddobject=new QucikBookCustomerWrapper.PrimaryEmailAddr();
        //with this object we need to assign values 
        emailaddobject.Address=eachcustomer.Primary_Email__c;

        // the assign this objct to outer class
        wraptest.PrimaryEmailAddr=emailaddobject;

        // for primary emai add is an inner class , so we have create objet 
        QucikBookCustomerWrapper.PrimaryPhone phoneddobject=new QucikBookCustomerWrapper.PrimaryPhone();
        //with this object we need to assign values 
        phoneddobject.FreeFormNumber=eachcustomer.Primary_Phone__c;

        // the assign this objct to outer class
        wraptest.PrimaryPhone=phoneddobject;
          //json to string - so serialize
        makecallout(System.JSON.serialize(wraptest));

        }

    }

    // we are using thsi method to do callout , since we shouldn;t do callout in for loop
    @future(callout=true)
    public static void makecallout(String requestwrapper){
        QucikBookCustomerWrapper wraptest=(QucikBookCustomerWrapper)System.JSON.deserialize(requestwrapper,QucikBookCustomerWrapper.class);
          
        QucikBookCustomerUtils.createcustomer(wraptest);

    }
}

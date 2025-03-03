@RestResource(urlMapping = '/v1/PS_ContactManager/*')
global with sharing class contactmanager {

    @httpGet
global static ContactWrapper getcontact(){
    RestRequest req  = RestContext.request;
    System.debug(System.JSON.serializePretty(req));

    RestResponse res = RestContext.response;
    System.debug(System.JSON.serializePretty(res));
// /v1/PS_AccountManager/001Hu000038vjRiIAI
        /**
         * 1 - Get the Account ID from URL 
         *  1.1 - get last index of / 
         *  1.2 - use the substring method of your String Apex Class
         * 1.1.1
         *  - subStringAfterLast method of your String class
         * 2 - Query the Account with all the Informaton
         * here we trying to get one contact detials infp using /contct/uniqueid
         */
        ContactWrapper con=new ContactWrapper();
String requuri=req.requestURI.subStringAfterLast('/');

 Contact cont= [SELECT ID, Name, Email, Phone FROM Contact WHERE Id=:requuri
  LIMIT 1
  ];
  

  con.ID=cont.ID;
  con.Phone=cont.Phone;
  con.Name=cont.Name;
  con.Email=cont.Email;

  return con;
}

@httpDelete
global static void Deletecontact(){
    RestRequest req  = RestContext.request;
   
String requuri=req.requestURI.subStringAfterLast('/');
Database.Delete(requuri);

}
   
/* this methos we hav tried without input wraper




@httpPost
global static ResponseWrapper processrecords(Account accountRecord, Contact contactRecord){
    ResponseWrapper wrapper=new ResponseWrapper();
    List<Contact> check=[SELECT Id, FirstName, LastName, Email FROM Contact WHERE Email=:contactRecord.Email];
    if(check?.size()>0){
        //donothing
        wrapper.status='existing';
        wrapper.Message='Existing Contact';
        wrapper.contactRecord=contactRecord;
        wrapper.accountRecord=accountRecord;
        
        
    }else{
        insert accountRecord;
        contactRecord.AccountId=accountRecord.Id;
        insert contactRecord;
        wrapper.status='New';
        wrapper.Message='New Contact';
        wrapper.contactRecord=contactRecord;
        wrapper.accountRecord=accountRecord;
        
    }
    return wrapper;

    
}
    */

    /* this methos we hav tried with input wraper*/

@httpPost
global static ResponseWrapper processrecords(InputWrapper INWrapper){
    ResponseWrapper wrapper=new ResponseWrapper();
    List<Contact> check=[SELECT Id, FirstName, LastName, Email FROM Contact WHERE Email=:INWrapper.email];
    if(check?.size()>0){
        //donothing
        wrapper.contactRecord=check.get(0);
        wrapper.status='existing';
        wrapper.Message='Existing Contact';
        
        
    
    }else{
        Account acc= new Account( Name = INWrapper.accountName);
         insert acc;
        Contact con= new Contact(
        
        FirstName=    INWrapper.firstName,
         LastName=   INWrapper.lastName,
         Email=    INWrapper.email

         );
         
         con.AccountId = acc.Id;
        insert con;
        wrapper.status='New';
        wrapper.Message='New Contact';
        wrapper.contactRecord=con;
        wrapper.accountRecord=acc;
        
    }
    return wrapper;

    
}
    
//to show the customize repsonse messag in an appropriate way use this responseWrapper

global class ResponseWrapper{
    global Account accountRecord;
    global Contact contactRecord;
    global String status; // New, Existing
    global String message; // Success, Error
} 
//now to pass the input in the customaize format

global class InputWrapper{
    global String  accountName;
    global String firstName;
    global String lastName;
    global String email;

}
global class ContactWrapper{
    global String ID;
    global String Phone;
    global String Name; // New, Existing
    global String Email; // Success, Error
} 
}

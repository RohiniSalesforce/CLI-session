@IsTest
public with sharing class AccountManagerRestAPITest {
    @IsTest
    public static void deleteRecordsTest(){
       
        //create record to delete
        Account acc=new Account();
        acc.name='Rohini';
        insert acc;
        
        // now prepare the request to delete
        RestRequest req = new RestRequest();
        req.requestURI = '/v1/Accounts/'+acc.Id;

        RestContext.request = req;
        //to start the test we need to use this 

        Test.startTest();
        //call the methos
        AccountManagerRestAPI.deleteRecords();
        Test.stopTest();


    }
    @IsTest
    public static void viewAccountRecordsTest(){
       
        //create record to delete
        Account acc=new Account();
        acc.name='Rohini';
        insert acc;
        
        // now prepare the request to delete
        RestRequest req = new RestRequest();
        req.requestURI = '/v1/Accounts/'+acc.Id;

        RestContext.request = req;
        //to start the test we need to use this 

        Test.startTest();
        //call the methos
        Account acheck=AccountManagerRestAPI.getaccountlist();
        Test.stopTest();

      //verify the result
      Assert.areEqual('Rohini', acheck.Name, 'The account name does not match!');
    }
    @IsTest
    public static void createaccountTest(){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse(); // Create a RestResponse

        req.requestURI = '/v1/Accounts/';
        req.httpMethod = 'POST'; // Add http method

        String requestBody = '{'+
            '"Name" : "Salesforce.com",'+
            '"Rating": "Hot",'+
            '"Phone": "123-456-7890"'+ // Added phone field
        '}';

        req.requestBody = Blob.valueOf(requestBody);

        RestContext.request = req;
        RestContext.response = res; // Set RestContext.response

        Test.startTest();
        Account acc = AccountManagerRestAPI.createaccount();
        Test.stopTest();

        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals('Salesforce.com', acc.Name);
        System.assertEquals('Hot', acc.Rating);
        System.assertEquals('123-456-7890', acc.Phone);
    }
   
    /* just to demo the error
    @IsTest
    private static void createAccountErrorTest(){
        RestRequest req = new RestRequest();
        req.requestURI = '/v1/PS_AccountManager/';

        RestContext.request = req;

        RestResponse res = new RestResponse();
        RestContext.response = res;

        Test.startTest();
        PS_AccountManager.createAccount();
        Test.stopTest();
    }
     */

     @IsTest
    public static void UpdateaccountTest(){
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        Account acc = new Account(Name='Rohini');
        insert acc;

        req.requestURI = '/v1/Accounts/' + acc.Id;
        req.httpMethod = 'PATCH';

        String requestBody = '{' +
            '"Name" : "PantherSchools.com",' +
            '"Phone" : "3456788978",' +
            '"Rating" : "Hot"' +
        '}';
        req.requestBody = Blob.valueOf(requestBody);

        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        Account updatedAccount = AccountManagerRestAPI.Updateaccount();
        Test.stopTest();

        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals('PantherSchools.com', updatedAccount.Name);
        System.assertEquals('3456788978', updatedAccount.Phone);
        System.assertEquals('Hot', updatedAccount.Rating);

        Account verifyAccount = [SELECT Name, Phone, Rating FROM Account WHERE Id = :acc.Id];
        System.assertEquals('PantherSchools.com', verifyAccount.Name);
        System.assertEquals('3456788978', verifyAccount.Phone);
        System.assertEquals('Hot', verifyAccount.Rating);
    }
        
    
}
@RestResource(urlMapping='/v1/Accounts/*')
global with sharing class AccountManagerRestAPI {
    // made this class as global because so we can access it anywhere
/**
 * Org Base Url - Instance Url + services/apexrest/v1/PS_AccountManager/
 * https://integration-org2-dev-ed.develop.my.salesforce.com/services/apexrest/v1/PS_AccountManager/
 */
    /**
     * @httpGet - GET
     * @httpPost - POST
     * @httpPut - PUT
     * @httpPatch - PATCH
     * @httpDelete - DELETE
     */


 @httpGet
 global static Account getaccountlist(){

    //we are using the below sntax to print the request and response on debug
   // rest is a apex class we need to convert to json response so we are using serialize

    RestRequest req  = RestContext.request;
        System.debug(System.JSON.serializePretty(req));

        RestResponse res = RestContext.response;
        System.debug(System.JSON.serializePretty(res));
    return [SELECT  Id, Name, Rating, Phone, Fax, Industry, BillingAddress, ShippingAddress
                 FROM Account
                 Limit 1
    
    ];
    
 }    
/*
//below method is to pass the argumenet and tel post methos to take this comp ,not anyother apart from this
//  RestRequest req  = RestContext.request; -> this will be null here , it will ocnsider only the request params we are passing in post body
// and not in arguments 
@httpPost
 global static Account createaccount(String accountname, String rating, String Phone){

 Account acc=new Account();

 acc.Name     = accountname;
 acc.Phone    = Phone;
 acc.Rating= rating;

 return acc;
 
 }
 */


 //below method is to fetch  the argumenet from request body creae data using it,here we can pass n nof of params.both ways we can do 
//  RestRequest req  = RestContext.request; -> this will be having the values which we pass as part od request body , we cn validate thsi
// and not in arguments

 @httpPost
 global static Account createaccount(){
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;

    // Get the raw request body as a string
    String requestBodyString = req.requestBody.toString();
    Account acc=new Account();
    try {
        // Attempt to deserialize the JSON request body
        Map<String, Object> requestData = (Map<String, Object>) JSON.deserializeUntyped(requestBodyString);

        // Process the data
        String name = (String) requestData.get('Name');
        String Phone = (String) requestData.get('Phone');
        String Rating = (String) requestData.get('Rating');

        

        acc.Name     = name;
        acc.Phone    = Phone;
        acc.Rating= Rating;
       

        //Construct a response
        res.responseBody = Blob.valueOf('{"message": "Data received successfully"}');
        res.statusCode = 200;


    } catch (JSONException e) {
        // Handle JSON parsing errors
        res.responseBody = Blob.valueOf('{"error": "Invalid JSON"}');
        res.statusCode = 400;
    }
    return acc;
 
 }


 @httpPatch
 global static Account Updateaccount(){
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;

    // Get the raw request body as a string
    String requestBodyString = req.requestBody.toString();
   
    String requuri=req.requestURI.subStringAfterLast('/');
    Account acc=new Account(Id=requuri);
    try {
        // Attempt to deserialize the JSON request body
        Map<String, Object> requestData = (Map<String, Object>) JSON.deserializeUntyped(requestBodyString);

        // Process the data
        acc.Name = (String) requestData.get('Name');
        acc.Phone = (String) requestData.get('Phone');
        acc.Rating = (String) requestData.get('Rating');


       
        update acc;

        // Construct a response
        res.responseBody = Blob.valueOf('{"message": "Data received successfully"}');
        res.statusCode = 200;

    } catch (JSONException e) {
        // Handle JSON parsing errors
        res.responseBody = Blob.valueOf('{"error": "Invalid JSON"}');
        res.statusCode = 400;
    }
    return acc;
 
 }
 @httpDelete
    global static void deleteRecords(){
        String accountId = RestContext.request.requestURI.substringAfterLast('/');
        Database.delete(accountId);
    }







}
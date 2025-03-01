public with sharing class Accountutils {
   //Accountutils.createaccount('Ro','hot');


    public static void createaccount(String name,String rating){

        //get the client id , secetr from metatda

        OAuthSalesforce__mdt oathconfig=OAuthSalesforce__mdt.getInstance('oauthconfig');
        if(oathconfig!=null){

            //token expiry check
            boolean validcheck=OAUTHbaseclas.tokenvalid(oathconfig);
            Map<String, Object> fieldWithValuesMap=new Map<String, Object>();
            String acctoken=oathconfig.Accesstoken__c;
            if(!validcheck){
             fieldWithValuesMap=OAUTHbaseclas.refreshtoken(oathconfig);
                //here value is in from of object , but we are expecting the accesstoke in form of string
                //so typecast to string 
                //Accesstoken__c is u ned get from custom feild value on metadata type
                 acctoken=(String)fieldWithValuesMap.get('Accesstoken__c');
            }
           //https://autorabt-dev-ed.develop.my.salesforce.com/services/data/v60.0/sobjects/Account
            String endpoint=oathconfig.Instanceurl__c+'/services/data/v60.0/sobjects/Account';
            String meth='POST';
            String conte='application/json';
            String Accept='application/json';
            String body='{'+
            '    "Name": "'+name+'",'+
            '    "Rating": "'+rating+'",'+
            '    "Phone": "9876543210",'+
            '    "Industry": "Education",'+
            '    "Active__c": "Yes"'+
            '}';
            //prepare body with admin booster class

//preparehttprequest(String Endoint,String method,String body,String accept,String contenttype){
    
        HTTPRequest req=Calloututils.preparehttprequest(endpoint,meth,body,Accept,conte);

        //req add bearer token

        req.setHeader('Authorization','Bearer '+acctoken);
        try{
            HttpResponse httpRes = (new Http()).send(req);
            if(httpRes.getStatusCode() == 200 || httpRes.getStatusCode() == 201 ){
                System.debug('Success \n '+ httpRes.getBody() );
            }else{
                System.debug('ERROR \n '+ httpRes.getBody() );
            }
        }catch(Exception e){

        }
         //to save the values after callout comepleted succesfully
         if(fieldWithValuesMap.size()>0){
            String fullname='OAuthSalesforce.'+'oauthconfig';
            String label ='oauthconfig';
            CustomMetadatypedeployment.CreatecustomMedatatype(fullname, label, fieldWithValuesMap);
            
        }
        }

    }
}
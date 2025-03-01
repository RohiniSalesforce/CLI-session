public with sharing class OAUTHbaseclas {

public static PageReference getauthcode(){

/* url to prepare
https://login.salesforce.com/services/oauth2/authorize?client_id=
3MVG9GCMQoQ6rpzQhHRuM8hzMF6eOSmT9XnoxubNadS7kj.dbA1Q6UpTcqOsr.6k5Db9ucExS7EN_DbZ79oTN&redirect_uri
=https://developer.zendesk.com/api-reference/ticketing/tickets/tickets/&response_type=code

2. OAuthSalesforce -> wee can add this in custom label also

*/

OAuthSalesforce__mdt oathconfig=OAuthSalesforce__mdt.getInstance('oauthconfig');
if(oathconfig!=null){

String orgUrl  = oathconfig.Environment__c == 'Production' ? 'https://login.salesforce.com' : 'https://test.salesforce.com';

            System.System.debug( orgUrl );

            String redirect_uri = System.URL.getOrgDomainURL().toExternalForm()+'/apex/'+oathconfig.PageName__c;
            System.System.debug( redirect_uri );

            String authorizeUrl = orgUrl+oathconfig.authurl__c+'?client_id='+oathconfig.clientid__c
                            +'&redirect_uri='+redirect_uri+'&response_type=code';
            System.System.debug( authorizeUrl );

        

            return new PageReference(authorizeUrl);

}else{
return null;
}


    }

    public void getAccessToken(){

        /*
          To get auth code from url 
          https://autorabt-dev-ed--c.develop.vf.force.com/apex/OAUTHPAgeredirect?
          code=aPrxp.7fR25AS7PyXuXiAVpsez2vCKFz6Ex2KE.Vul4deu_41SPD7co2vKXD5hmhzZg7a7ztZg%3D%3D
        */
        OAuthSalesforce__mdt oathconfig=OAuthSalesforce__mdt.getInstance('oauthconfig');
        if(oathconfig!=null){

            String orgUrl  = oathconfig.Environment__c == 'Production' ? 'https://login.salesforce.com' : 'https://test.salesforce.com';
        String endpoint=orgUrl+oathconfig.tokenurl__c;

    
String code=ApexPages.currentPage().getParameters().get('code');
        HTTPRequest req=new HTTPRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setHeader('Accept','application/json');
        String redirect_uri = System.URL.getOrgDomainURL().toExternalForm()+'/apex/'+oathconfig.PageName__c;
    String body='code='+code+'&grant_type=authorization_code&client_id='
                                +oathconfig.clientid__c+'&client_secret='+oathconfig.clientsecret__c
                                +'&redirect_uri='+redirect_uri;
    
    req.setBody(body);
         
        HTTP http = new HTTP();
    
        try{
           HTTPResponse response=http.send(req);
           if(response.getStatusCode() == 200){
           System.debug(response);
        
             String res= response.getBody();

             OAUTHWrapper wrapper=(OAUTHWrapper)System.JSON.deserialize(res,OAUTHWrapper.class);
           
              //now to pass the values to custommetadat class to save n deploy
               //fullname- objectname.+labelname
              String fullname='OAuthSalesforce.'+'oauthconfig';
            String label ='oauthconfig';
            //diff label name
            // String fullname='OAuthSalesforce.'+'name';
            // String label ='name';

            Map<String, Object> fieldWithValuesMap = new Map<String, Object>();
            fieldWithValuesMap.put('Accesstoken__c', wrapper.access_token);
            //fieldWithValuesMap.put('expires_in__c',wrapper.);
            fieldWithValuesMap.put('Expireintime__c', System.now().addHours(2) );
            fieldWithValuesMap.put('Instanceurl__c', wrapper.instance_url);
            fieldWithValuesMap.put('refreshtoken__c', wrapper.refresh_token);
            fieldWithValuesMap.put('Scope__c',wrapper.scope);
            fieldWithValuesMap.put('clientid__c',oathconfig.clientid__c);
            fieldWithValuesMap.put('clientsecret__c',oathconfig.clientsecret__c);
            System.debug('SUCCESS \n '+response.getBody());
            CustomMetadatypedeployment.CreatecustomMedatatype(fullname, label, fieldWithValuesMap);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Successfull!'));
           
            // Success
        } else {
            // 400
            System.debug('ERROR \n '+ response.getBody());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, response.getBody() ));
            // error
        }

           }catch(CalloutException e){
    
        }
    }

    }

    //to check the expires in time is less than system,now time , if so thenw e hve to call refresh api

    public static boolean tokenvalid(OAuthSalesforce__mdt oathconfig){
        boolean tokenvalid=true;

       if( oathconfig.Expireintime__c <System.now()){
        tokenvalid=false;
       }
       return tokenvalid;
    }

    public static Map<String, Object> refreshtoken(OAuthSalesforce__mdt oathconfig1){

        /*refresh url 
            POST /services/oauth2/token HTTP/1.1
            Host: login.salesforce.com/ 
            grant_type=refresh_token&
            client_id=3MVG9lKcPoNINVBIPJjdw1J9LLM82HnFVVX19KY1uA5mu0QqEWhqKpoW3svG3XHrXDiCQjK1mdgAvhCscA9GE&client_secret=1955279925675241571&
            refresh_token=your token here 

        */

       

        OAuthSalesforce__mdt oathconfig=OAuthSalesforce__mdt.getInstance('oauthconfig');
       

            String orgUrl  = oathconfig.Environment__c == 'Production' ? 'https://login.salesforce.com' : 'https://test.salesforce.com';
        String finaltokenurl=orgUrl+oathconfig.tokenurl__c;

        
        String body='grant_type=refresh_token&client_id='
                                +oathconfig.clientid__c+'&client_secret='
                                +oathconfig.clientsecret__c+'&refresh_token='+oathconfig.refreshtoken__c;
                                HTTPRequest req=Calloututils.preparehttprequest(finaltokenurl,'POST',body,'application/json','application/x-www-form-urlencoded');
                                Map<String, Object> fieldWithValuesMap = new Map<String, Object>();
                               
                                try{
                                    HttpResponse httpRes = (new Http()).send(req);
                                    if(httpRes.getStatusCode() == 200 || httpRes.getStatusCode() == 201 ){

                                        System.debug('Success \n '+ httpRes.getBody() );
                                        //now we have to save response on custom metadata so
                                        OAUTHWrapper wrapper=(OAUTHWrapper)System.JSON.deserialize(httpRes.getBody(),OAUTHWrapper.class);
           
              //now to pass the values to custommetadat class to save n deploy
        
// here only refresh and access toke woll be changed so we have to write only for this
           
            fieldWithValuesMap.put('Accesstoken__c', wrapper.access_token);
           
            fieldWithValuesMap.put('refreshtoken__c', wrapper.refresh_token);
           
        

                                    }else{
                                        System.debug('ERROR \n '+ httpRes.getBody() );
                                    }
                                }catch(Exception e){
                        
                                }


                                return fieldWithValuesMap;
    
    
                                // since we canot doe callout and dml operation . so first perform the callout. save thsi values in map
    
                          
                            }

   
    
}



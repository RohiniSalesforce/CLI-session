public with sharing class deviceflow {
    public static void getauthcode(){
        
        /* url to prepare
        Host: MyDomainName.my.salesforce.com
grant_type=client_credentials&
client_id=*******************&
client_secret=*******************
        2. OAuthSalesforce -> wee can add this in custom label also
        
*/

Deviceflow__mdt oathconfig=Deviceflow__mdt.getInstance('deviceflow');
if(oathconfig!=null){

String orgUrl  = 'https://login.salesforce.com/services/oauth2/token';




String body='response_type=device_code&client_id='
                        +oathconfig.client_id__c;
                        HTTPRequest req=Calloututils.preparehttprequest(orgUrl,'POST',body,'application/json','application/x-www-form-urlencoded');
                        
                       
                       
                        try{
                            HttpResponse httpRes = (new Http()).send(req);
                            if(httpRes.getStatusCode() == 200 || httpRes.getStatusCode() == 201 ){

                                System.debug('Success \n '+ httpRes.getBody() );
                                String bb=httpRes.getBody();
                                //now we have to save response on custom metadata so


                                Devicewrapper wrapper=(Devicewrapper)System.JSON.deserialize(bb,Devicewrapper.class);
                                
                                
                                String fullname='Deviceflow.'+'deviceflow';
                                String label ='deviceflow';
                                //diff label name
                                // String fullname='OAuthSalesforce.'+'name';(object name +Label name)
                                // String label ='name';
                    
                                Map<String, Object> fieldWithValuesMap = new Map<String, Object>();
                                fieldWithValuesMap.put('user_code__c', wrapper.user_code );
                                fieldWithValuesMap.put('device_code__c', wrapper.device_code);
                                //fieldWithValuesMap.put('expires_in__c',wrapper.);
                                fieldWithValuesMap.put('intervaltime__c', wrapper.interval);
                                fieldWithValuesMap.put('verificationurl__c', wrapper.verification_uri);
                                
                              
                                System.debug('SUCCESS \n '+httpRes.getBody());
                                
                                CustomMetadatypedeployment.CreatecustomMedatatype(fullname, label, fieldWithValuesMap);
                                
                        
    

                            }else{
                                System.debug('ERROR \n '+ httpRes.getBody() );
                            }
                        }catch(Exception e){
                
                        }


        

        

}

}

public static void getaccesstoken(){
        
    /* url to prepare
    POST /services/oauth2/token  HTTP/1.1
Host: login.salesforce.com
Content-Type: application/x-www-form-urlencoded

grant_type=device&
client_id=3MVG9PhR6g6B7ps7TTI4cP7Mppg3l7tu.MRAYULyVqcmA9hGLpHiiS.​Q7rO9yjlmffiBUM6tFpYAlXEkRjHb9&
code=M01WRzlQaFI2ZzZCN3BzN1RUSTRjUDdNcHBnM2w3dHUu​TVJBWVVMeVZxY21BOWhHTHBIaWlTLlE3ck85eWpsbWZmaUJVTTZ0RnBZQWxYRWtSakhiOTsxMC4yMi4zNC45MjsxNDc3N​jc0NDg3NTA1O1gxRDlTRUVU

*/

Deviceflow__mdt oathconfig=Deviceflow__mdt.getInstance('deviceflow');
if(oathconfig!=null){

String orgUrl  = 'https://login.salesforce.com/services/oauth2/token';




String body='grant_type=device&client_id='
                    +oathconfig.client_id__c+'&code='+oathconfig.device_code__c;
                    HTTPRequest req=Calloututils.preparehttprequest(orgUrl,'POST',body,'application/json','application/x-www-form-urlencoded');
                    
                   
                   
                    try{
                        HttpResponse httpRes = (new Http()).send(req);
                        if(httpRes.getStatusCode() == 200 || httpRes.getStatusCode() == 201 ){

                            System.debug('Success \n '+ httpRes.getBody() );
                            String bb=httpRes.getBody();
                            //now we have to save response on custom metadata so


                            Devicewrapper wrapper=(Devicewrapper)System.JSON.deserialize(bb,Devicewrapper.class);
                            
                            
                            String fullname='Deviceflow.'+'deviceflow';
                            String label ='deviceflow';
                            //diff label name
                            // String fullname='OAuthSalesforce.'+'name';(object name +Label name)
                            // String label ='name';
                
                            Map<String, Object> fieldWithValuesMap = new Map<String, Object>();
                            fieldWithValuesMap.put('access_token__c', wrapper.access_token );
                            fieldWithValuesMap.put('refreshtoken__c', wrapper.refresh_token);
                            fieldWithValuesMap.put('signature__c', wrapper.signature);
                            fieldWithValuesMap.put('scope__c', wrapper.scope);
                            fieldWithValuesMap.put('Instanceurl__c', wrapper.instance_url );
                            fieldWithValuesMap.put('id__c', wrapper.id);
                            fieldWithValuesMap.put('token_type__c', wrapper.token_type);
                            fieldWithValuesMap.put('verificationurl__c', wrapper.issued_at);
                            
                          
                            System.debug('SUCCESS \n '+httpRes.getBody());
                            
                            CustomMetadatypedeployment.CreatecustomMedatatype(fullname, label, fieldWithValuesMap);
                            
                    


                        }else{
                            System.debug('ERROR \n '+ httpRes.getBody() );
                        }
                    }catch(Exception e){
            
                    }


    

    

}

}
}
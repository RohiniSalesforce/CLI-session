public with sharing class cleintcredentialflow {
   

        public static void getauthcode(){
        
                /* url to prepare
                Host: MyDomainName.my.salesforce.com
        grant_type=client_credentials&
        client_id=*******************&
        client_secret=*******************
                2. OAuthSalesforce -> wee can add this in custom label also
                
        */
        
        Serverintuserinfo__mdt oathconfig=Serverintuserinfo__mdt.getInstance('Serverintuserinfo');
        if(oathconfig!=null){
        
        String orgUrl  = oathconfig.instance_url__c;
        
       

        
        String body='grant_type=client_credentials&client_id='
                                +oathconfig.client_id__c+'&client_secret='
                                +oathconfig.client_secret__c;
                                HTTPRequest req=Calloututils.preparehttprequest(orgUrl,'POST',body,'application/json','application/x-www-form-urlencoded');
                                
                               
                               
                                try{
                                    HttpResponse httpRes = (new Http()).send(req);
                                    if(httpRes.getStatusCode() == 200 || httpRes.getStatusCode() == 201 ){

                                        System.debug('Success \n '+ httpRes.getBody() );
                                        String bb=httpRes.getBody();
                                        //now we have to save response on custom metadata so


                                        Clientcredwrapper wrapper=(Clientcredwrapper)System.JSON.deserialize(bb,Clientcredwrapper.class);
                                        
                                        
                                        String fullname='Serverintuserinfo.'+'Serverintuserinfo';
                                        String label ='Serverintuserinfo';
                                        //diff label name
                                        // String fullname='OAuthSalesforce.'+'name';(object name +Label name)
                                        // String label ='name';
                            
                                        Map<String, Object> fieldWithValuesMap = new Map<String, Object>();
                                        fieldWithValuesMap.put('access_token__c', wrapper.access_token);
                                        //fieldWithValuesMap.put('expires_in__c',wrapper.);
                                        fieldWithValuesMap.put('instance_url__c', wrapper.instance_url );
                                        fieldWithValuesMap.put('id__c', wrapper.id);
                                        fieldWithValuesMap.put('token_type__c', wrapper.token_type);
                                        fieldWithValuesMap.put('scope__c',wrapper.scope);
                                        fieldWithValuesMap.put('issued_at__c',wrapper.issued_at);
                                        fieldWithValuesMap.put('signature__c',wrapper.signature);
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
        
        
        

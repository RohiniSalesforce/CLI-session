public with sharing class Quickbookutil {
    public PageReference authcode() {

        QuickBooks__mdt config=QuickBooks__mdt.getInstance('QBToken');

        if(config!=null){
// prepare auth url
/*

https://appcenter.intuit.com/connect/oauth2?
    client_id=Q3ylJatCvnkYqVKLmkxxxxxxxxxxxxxxxkYB36b5mws7HkKUEv9aI&response_type=code&
    scope=com.intuit.quickbooks.accounting&
    redirect_uri=https://www.mydemoapp.com/oauth-redirect&
    state=security_token%3D138r5719ru3e1%26url%3Dhttps://www.mydemoapp.com/oauth-redirect

    rediect uri=https://autorabt-dev-ed--c.develop.vf.force.com/apex/QuickBookPAge
    */
    
    String redirectURI=System.URL.getOrgDomainURL().toExternalForm()+'/apex/'+config.PageName__c;
    String authurl=config.authurl__c+'?client_id='+config.clientid__c+'&response_type=code&scope='+config.Scope__c+'&redirect_uri='+redirectURI+'&state='
    +UserInfo.getOrganizationID()+redirectURI;
    System.System.debug(redirectURI);
    System.System.debug(authurl);

    return new PageReference(authurl);

        }else{
            //we have to add error here
            return null;
        }
        
    }
    public void get_accessToken(){
      /*
        https://autorabt-dev-ed--c.develop.vf.force.com/apex/QuickBookPAge?code=AB11741354123dcXstzPcSr6QUHTlYqZ7XL8dNGrfk0akG0HRE
        &state=00DdL00000Kteu9UABhttps%3A%2F%2Fautorabt-dev-ed.develop.my.salesforce.com%2Fapex%2FQuickBookPAge
       &realmId=9341454220981335
         use this to get access token

       */
      QuickBooks__mdt config=QuickBooks__mdt.getInstance('QBToken');

      if(config!=null){
       
      String code=ApexPages.currentPage().getParameters().get('code');
       String realmid=ApexPages.currentPage().getParameters().get('realmId');
       String redirectURI=System.URL.getOrgDomainURL().toExternalForm()+'/apex/'+config.PageName__c;
    

       //prepare the request

       HTTPRequest req=new HTTPRequest();

       req.setMethod('POST');
       req.setHeader('Content-Type','application/x-www-form-urlencoded');
       req.setHeader('Accept','application/json');
       req.setEndpoint(config.tokenurl__c);
    
       /*
       grant_type=authorization_code&
        code=L3114709614564VSU8JSEiPkXx1xhV8D9mv4xbv6sZJycibMUI&
        redirect_uri=https://www.mydemoapp.com/oauth-redirect
        */
    
        String body='grant_type=authorization_code&code='+code+'&redirect_uri='+redirectURI+'&client_id='+config.clientid__c+'&client_secret='+config.clientsecret__c;
       req.setBody(body);
        try{
            HTTP http=new HTTP();
            HTTPResponse res=http.send(req);
            String bodytext=res.getBody();
            if(res.getStatusCode()==200 ||res.getStatusCode()==201 ){
             //create wrapper class to pass this reponse
             QuickBookWrapper wrapp=(QuickBookWrapper)JSON.deserialize(bodytext,QuickBookWrapper.class);
            // Map<String, Object> respomap =(Map<String, Object> )JSON.deserializeUntyped(res.getBody())


             String fullname='QuickBooks.'+'QBToken';
            String label ='QBToken';

            Map<String, Object> fieldWithValuesMap = new Map<String, Object>();
            fieldWithValuesMap.put('token_type__c', wrapp.token_type);
            fieldWithValuesMap.put('expiresin__c', wrapp.expires_in );
            fieldWithValuesMap.put('refreshtoken__c', wrapp.refresh_token);
            //add this must to derive the logic for refresh token
            fieldWithValuesMap.put('Expireintime__c', System.now().addSeconds(wrapp.expires_in) );
            // fieldWithValuesMap.put('Expireintime__c', wrapp.x_refresh_token_expires_in);
            fieldWithValuesMap.put('Accesstoken__c',wrapp.access_token);
            System.debug('SUCCESS \n '+body);
            CustomMetadatypedeployment.CreatecustomMedatatype(fullname, label, fieldWithValuesMap);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Successfull!'));
            
            }else{
                System.System.debug(res.getBody());
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, res.getBody() ));
            }

            

        }catch(CalloutException ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, ex.getMessage() ));
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage() ));
        }

      }else{
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Config not found' ));

      }
       
        
    
    }

    public static Map<String,Object> refreshtoken(QuickBooks__mdt config){
        // QuickBooks__mdt config=QuickBooks__mdt.getInstance('QBToken');
        Map<String,Object> feildvalue=new Map<String,Object>();
        if(config!=null){
         
        // String code=ApexPages.currentPage().getParameters().get('code');
        //  String realmid=ApexPages.currentPage().getParameters().get('realmId');
        //  String redirectURI=System.URL.getOrgDomainURL().toExternalForm()+'/apex/'+config.PageName__c;
      
  
         //prepare the request

         HTTPRequest req=new HTTPRequest();
  
         req.setMethod('POST');
         req.setHeader('Content-Type','application/x-www-form-urlencoded');
         req.setHeader('Accept','application/json');
         req.setEndpoint(config.tokenurl__c);
      
         /*
         grant_type=authorization_code&
          code=L3114709614564VSU8JSEiPkXx1xhV8D9mv4xbv6sZJycibMUI&
          redirect_uri=https://www.mydemoapp.com/oauth-redirect
          */
      
          String body='grant_type=refresh_token&refresh_token='+config.refreshtoken__c+'&client_id='+config.clientid__c+'&client_secret='+config.clientsecret__c;
         req.setBody(body);
         
          try{
              HTTP http=new HTTP();
              HTTPResponse res=http.send(req);
              String bodytext=res.getBody();
              if(res.getStatusCode()==200 ||res.getStatusCode()==201 ){
               //create wrapper class to pass this reponse
               
               feildvalue= getfeildvalues(bodytext);
              
              }else{
                  System.System.debug(res.getBody());
                  
              }
  
              
  
          }catch(CalloutException ex){
              
          }catch(Exception e){
              
          }
  
        }else{
          
  
        }
        return feildvalue;
    }

    //to validate tthe token expiry 


    public static Boolean isvlaid(QuickBooks__mdt config){
               Boolean validcheck=true;
            if(config.Expireintime__c<=System.now()){
                 validcheck=false;
            }
       return validcheck;
    }
     // preapare util clas to save the feild values seperately

   public static Map<String,Object> getfeildvalues(String responsebody){
 /*
 another way to impleemtn 
 Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(requestBody);
        String access_token  = (String)responseMap.get('access_token');
        String refresh_token = (String)responseMap.get('refresh_token');
        Integer expires_in   = (Integer)responseMap.get('expires_in');

         Map<String, Object> fieldWithValuesMap = new Map<String, Object>();
        fieldWithValuesMap.put('access_token__c', access_token);
        fieldWithValuesMap.put('expires_in__c',expires_in);
        fieldWithValuesMap.put('expires_in_time__c', System.now().addSeconds(expires_in) );
        fieldWithValuesMap.put('refresh_token__c', refresh_token);
        if(!String.isBlank(realmId)){
            fieldWithValuesMap.put('realmId__c', realmId);
        }
        return fieldWithValuesMap;
 */

    QuickBookWrapper wrapp=(QuickBookWrapper)JSON.deserialize(responsebody,QuickBookWrapper.class);
            
 
   Map<String, Object> fieldWithValuesMap = new Map<String, Object>();
   fieldWithValuesMap.put('token_type__c', wrapp.token_type);
   fieldWithValuesMap.put('expiresin__c', wrapp.expires_in );
   fieldWithValuesMap.put('refreshtoken__c', wrapp.refresh_token);
   fieldWithValuesMap.put('Expireintime__c', System.now().addSeconds(wrapp.expires_in) );
   // fieldWithValuesMap.put('Expireintime__c', wrapp.x_refresh_token_expires_in);
   fieldWithValuesMap.put('Accesstoken__c',wrapp.access_token);


    return fieldWithValuesMap;
   
   }
}
public with sharing class QucikBookCustomerUtils {

    public static void testdataforcreatecustoer(){
    
        QucikBookCustomerWrapper wraptest=new QucikBookCustomerWrapper();

        wraptest.FullyQualifiedName='test2';
        wraptest.DisplayName='dis2';
        wraptest.Suffix='su2';
        wraptest.Title='titl2';
        wraptest.MiddleName='MN2';
        wraptest.Notes='Notes2';
        wraptest.FamilyName='FM2';
        wraptest.CompanyName='CN2';
        wraptest.GivenName='gib2';

         
        // for primary emai add is an inner class , so we have create objet 
        QucikBookCustomerWrapper.PrimaryEmailAddr emailaddobject=new QucikBookCustomerWrapper.PrimaryEmailAddr();
        //with this object we need to assign values 
        emailaddobject.Address='hjhjh@gmail.com';

        // the assign this objct to outer class
        wraptest.PrimaryEmailAddr=emailaddobject;

        // for primary emai add is an inner class , so we have create objet 
        QucikBookCustomerWrapper.PrimaryPhone phoneddobject=new QucikBookCustomerWrapper.PrimaryPhone();
        //with this object we need to assign values 
        phoneddobject.FreeFormNumber='8978675645';

        // the assign this objct to outer class
        wraptest.PrimaryPhone=phoneddobject;

        // invoke the below method

        createcustomer(wraptest);


    }
    public static void  createcustomer(QucikBookCustomerWrapper wrap) {

       Map<String,Object> feildvalue=new Map<String,Object>();

        // sicne we get error 400 for token is toolong or too short so we can use this dml statement and using this we will get the access token
        List<QuickBooks__mdt> configList = [SELECT Id, DeveloperName, Accesstoken__c,Environment__c,Sandboxurl__c,
                                        Companyid__c,minor_version__c,Expireintime__c,tokenurl__c,refreshtoken__c,token_type__c,
                                        expiresin__c,clientid__c,clientsecret__c
                                        FROM QuickBooks__mdt 
                                        WHERE DeveloperName = 'QBToken' 
                                        LIMIT 1];
                        
         // prepare the post request
         QuickBooks__mdt config=configList.get(0);

         String accesstoken =config.Accesstoken__c;

         if(config!=null){
            

            if(Quickbookutil.isvlaid(config)!=true){
                feildvalue= Quickbookutil.refreshtoken(config);
                // since rfrom map we get object , we need to conver to string

                accesstoken=(String)feildvalue.get('Accesstoken__c');
            }


            HTTPRequest req=new HTTPRequest();
            req.setMethod('POST');
            req.setHeader('Content-Type','application/json');
            req.setHeader('Accept','application/json');
            req.setHeader('Authorization','Bearer '+accesstoken);
            //endpoint -/v3/company/9341454220981335/customer?minorversion=75
            String endpoint='';
            if(config.Environment__c.equals('Sandbox')){
                endpoint= config.Sandboxurl__c+'/v3/company/'+config.Companyid__c+'/customer?minorversion='+config.minor_version__c;
            
            }else{
                endpoint=  config.production_based_url__c+'/v3/company/'+config.Companyid__c+'/customer?minorversion='+config.minor_version__c;
            
            }
            req.setEndpoint(endpoint);
            System.debug(endpoint);
            //here we use serialize because we are converting the class to json
            String reqbody=System.JSON.serializePretty(wrap);
             System.debug(reqbody);
            req.setBody(reqbody);
            try{
                HTTP http=new HTTP();
                HTTPResponse response=http.send(req);
                //any response between thisis success
                
                if(response.getStatusCode()>=200 && response.getStatusCode()<300  ){
                    String res=response.getBody();
                       System.System.debug(response.getBody());
                       System.System.debug(response.getStatusCode());
                       
                       Quickbookresponsewrapper wp=(Quickbookresponsewrapper)System.JSON.deserialize(res, Quickbookresponsewrapper.class);
                      // to get the customer id values
                    //    Map<String,Object> responseMap = (Map<String,Object>)System.JSON.deserializeUntyped(res);
                    // String customerId = (String)responseMap.get('Id');
                    // String CompanyName = (String)responseMap.get('CompanyName');
                    System.System.debug(wp);
                
                    System.System.debug( wp.Customer.Id);
                    System.System.debug(wp.Customer.CompanyName);
                   
                    List<QucikBookscustomer__c> customerup=[SELECT Id,Compant_Name__c,QuickBookExternalID__c,Sync_in_quickbook__c
                                                               FROM QucikBookscustomer__c
                                                             WHERE Name!=null
                                                             ];
                    for(QucikBookscustomer__c cu:customerup){
                        if(cu.Compant_Name__c==wp.Customer.CompanyName){
                            cu.QuickBookExternalID__c=wp.Customer.Id;
                            cu.Sync_in_quickbook__c=true;
                            update cu;
                        }
                    }
                    System.debug('Successfully Inserted Customer '+ wp.Customer.Id);
                }else{
                    //error catch
                    System.System.debug(response.getBody());
                       System.System.debug(response.getStatusCode());
                }
            }catch(CalloutException ex){
                System.System.debug(ex.getMessage());
            }catch(Exception e){
                System.System.debug(e.getMessage());
            }
         }else{

         }
         

         if(feildvalue?.size()>0){
            // we have to deploy it
            System.debug('Updating the Custom Metadata... ');
            String fullname='QuickBooks.'+'QBToken';
            String label ='QBToken';
            CustomMetadatypedeployment.CreatecustomMedatatype(fullname, label, feildvalue);
            
         }

    }
}
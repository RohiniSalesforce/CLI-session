public with sharing class QucikBookItemutils {


    public static void updateproduct(){
        List<Product2> product=[SELECT Id,Name FROM Product2 WHERE QuickbookProductId__c=null];

        for(Product2 prod:product ){
            itemsync(prod);
        }
        update product;
        
    }
    
    public static Product2  itemsync(Product2 productRecord){
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
            endpoint= config.Sandboxurl__c+'/v3/company/'+config.Companyid__c+'/item?minorversion='+config.minor_version__c;
        
        }else{
            endpoint=  config.production_based_url__c+'/v3/company/'+config.Companyid__c+'/item?minorversion='+config.minor_version__c;
        
        }
        req.setEndpoint(endpoint);
        System.debug(endpoint);
        //here we use serialize because we are converting the class to json
        String requestBody = '{'+
            '    "TrackQtyOnHand": false,'+
            '    "Name": "'+productRecord.Name+'",'+
            '    "QtyOnHand": 180,'+
            '    "IncomeAccountRef": {'+
            '        "name": "Sales of Product Income",'+
            '        "value": 79'+
            '    },'+
            '    "AssetAccountRef": {'+
            '        "name": "Inventory Asset",'+
            '        "value": 81'+
            '    },'+
            '    "InvStartDate": "2025-01-01",'+
            '    "Type": "Service",'+
            '    "ExpenseAccountRef": {'+
            '        "name": "Cost of Goods Sold",'+
            '        "value": 80 '+
            '    }'+
            '}';
    
        req.setBody(requestBody);
        try{
            HTTP http=new HTTP();
            HTTPResponse response=http.send(req);
            //any response between thisis success
            
            if(response.getStatusCode()>=200 && response.getStatusCode()<300  ){
                String res=response.getBody();
                   System.System.debug(response.getBody());
                   System.System.debug(response.getStatusCode());

                   /* reposnse id is under item 
                   {
  "Item": {
    "FullyQualifiedName": "Garden Supplies", 
    "domain": "QBO", 
    "Id": "19", 
    "Name": "Garden Supplies", 
    "TrackQtyOnHand": true, 
    "UnitPrice": 0, 
    "PurchaseCost": 0, 
    "QtyOnHand": 10, 
    "IncomeAccountRef": {
      "name": "Sales of Product Income", 
      "value": "79"
    }, 
    "AssetAccountRef": {
      "name": "Inventory Asset", 
      "value": "81"
    }, 
    "Taxable": false, 
    "sparse": false, 
    "Active": true, 
    "SyncToken": "0", 
    "InvStartDate": "2015-01-01", 
    "Type": "Inventory", 
    "ExpenseAccountRef": {
      "name": "Cost of Goods Sold", 
      "value": "80"
    }, 
    "MetaData": {
      "CreateTime": "2015-12-09T11:12:39-08:00", 
      "LastUpdatedTime": "2015-12-09T11:12:41-08:00"
    }
  }, 
  "time": "2015-12-09T11:12:39.748-08:00"
}
                   */
            // to get the customer id values
            Map<String,Object> responseMap = (Map<String,Object>)System.JSON.deserializeUntyped(res);

            

                Object item =responseMap.get('Item');
                Map<String,Object> itemMap = (Map<String,Object>)item;
                productRecord.QuickbookProductId__c  = (String)itemMap.get('Id');
                productRecord.Sync_in_quickbook__c =true;
                
        
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
     return productRecord;
}
}
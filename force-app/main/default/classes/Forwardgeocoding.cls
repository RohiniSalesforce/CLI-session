public with sharing class Forwardgeocoding {
   public static void forwardgeocodingex(String accountid){

         Account accid=[

                   SELECT Id, BillingStreet,BillingState,BillingPostalCode,BillingCountry 
                   FROM Account
                   WHERE Id=:accountid
                   LIMIT 1


         ];
        // https://api.opencagedata.com/geocode/v1/json?q=Frauenplan+1%2C+99423+Weimar%2C+Germany&key={{key}}
         //Frauenplan 1, 99423 Weimar, Germany
         String Queryparams=accid.BillingStreet+','+accid.BillingPostalCode+accid.BillingState+','+accid.BillingCountry;
         System.debug(Queryparams);
         HTTPRequest req=new HTTPRequest();
         req.setEndpoint(System.Label.OpencageURL+'?q='+Queryparams+'&key='+System.Label.opencagekey);
         req.setHeader('Content-Type','application/json');
         req.setHeader('Accept','application/json');
         req.setMethod('GET');
        

         HTTP http=new HTTP();
         try{
            HTTPResponse response=http.send(req);
            String resbody=response.getBody();
            System.debug(response.getBody());
            System.debug(response.getStatus());
            System.debug(response.getStatusCode());
            ForwardGeoCodingWrapper wrap=   (ForwardGeoCodingWrapper)System.JSON.deserialize(resbody,ForwardGeoCodingWrapper.class);

            if(wrap?.results?.size()>0){
                ForwardGeoCodingWrapper.results res=wrap.results.get(0);
                accid.Latitude_Degree_format__c=res.annotations.DMS.lat;
                accid.Longitude_Degree_format__c=res.annotations.DMS.lng;
                update accid; 
            }

         }catch(CalloutException ex){

         }catch(Exception e){

         }

   }
}
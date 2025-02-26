public with sharing class OpenCage {
    public static void OpenCagecallout(String accid) {

        Account accRecord = [SELECT Id, Location__Latitude__s, Location__Longitude__s 
        FROM 
            Account 
        WHERE 
            Id =: accid 
            AND Location__Latitude__s != null
            AND Location__Longitude__s != null
        LIMIT 1
                   
                   ];

       // 52.5432379%2C+13.4142133
        String param= accRecord.Location__Latitude__s+','+accRecord.Location__Longitude__s;
        System.debug(param);

        HTTPRequest req=new HTTPRequest();

    req.setEndpoint(System.Label.OpencageURL+'?key='+System.Label.opencagekey+'&q='+param+'&pretty=1');
    req.setHeader('Content-Type','application/json');
    req.setHeader('Accept','application/json');
    req.setMethod('GET');
    HTTP http=new HTTP();
    try {
        HTTPResponse res=http.send(req);
        String responseBody = res.getBody(); 
        opencodewrapper wrapper=(opencodewrapper)System.JSON.deserialize(responseBody, opencodewrapper.class);
                
        if(wrapper?.results?.size()>0){
            opencodewrapper.results result=wrapper.results.get(0);
            accRecord.BillingStreet =result?.components?.road;
            accRecord.BillingCity = result?.components?.city;
            accRecord.BillingState = result?.components?.state;
            accRecord.BillingPostalCode = result?.components?.postcode;
            accRecord.BillingCountry = result?.components?.country;

            accRecord.ShippingStreet = result?.components?.road;
            accRecord.ShippingCity = result?.components?.city;
            accRecord.ShippingState = result?.components?.state;
            accRecord.ShippingPostalCode = result?.components?.postcode;
            accRecord.ShippingCountry = result?.components?.country;
            update accRecord; 
        }else {
            
        }
        System.System.debug(res.getBody());
        System.System.debug(res.getStatus());
        System.System.debug(res.getStatusCode());


    } catch (CalloutException ex) {
        
    }catch(Exception e){

    }

    }
}
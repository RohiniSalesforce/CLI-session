public with sharing class ExchangeRatesWithoutAuthentication{
   public static void getExchangeRatesmethod(){

    HTTPRequest request=new HTTPRequest();
      request.setEndpoint('https://open.er-api.com/v6/latest/USD');
      request.setHeader('Content-Type','application/json');
      request.setHeader('Accept','application/json');
      request.setMethod('GET');

      HTTP http=new HTTP();
     try{

         HTTPResponse res=http.send(request);
         String body=res.getBody();
         String status=res.getStatus();//ok
         Integer statuscode=res.getStatusCode(); //200 500
        System.System.debug(body);
        System.System.debug(statuscode);
        System.System.debug(status);


         
     }catch(CalloutException ex){

     }catch(Exception e){

     }


   }
}
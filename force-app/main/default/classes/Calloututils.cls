public with sharing class Calloututils {
    

    public static HTTPRequest preparehttprequest(String Endoint,String method,String body,String accept,String contenttype){
        HTTPRequest req=new HTTPRequest();
        req.setEndpoint(Endoint);
        req.setHeader('Content-Type',contenttype);
        req.setMethod(method);
        if(!String.isBlank(body)){
            req.setBody(body);
        }
        if(!String.isBlank(accept)){
            req.setHeader('Accept','application/json');
        }
       
    return req;
        
           
           
    }
}
public with sharing class Zendesk {
    /*
    usecase here is once the case is created in sales force , it should be created in zendesk , 
    updtae back tick numbere back to salesorce
    */

    public class zendeskticketWrapper{
        public String body;
        public String subject;
        public String priority;
        public String name;
        public String email;
    }
    /*
    Zendesk.zendeskticketWrapper wrapinner= new Zendesk.zendeskticketWrapper();
    wrapinner.body='hjhj';
    */
    public static void zendeskcallout(zendeskticketWrapper wrap){
      
    String Basicauth=System.Label.Zendeskusername+':'+System.Label.Zendesktoken;

    HTTPRequest req=new HTTPRequest();
    req.setEndpoint(System.Label.Zendeskurl+'api/v2/tickets');
    req.setHeader('Content-Type','application/json');
    req.setHeader('Accept','application/json');
    req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(Basicauth)));
    req.setMethod('POST');

    String body='{'+
		'    "ticket": {'+
		'        "comment": {'+
		'            "body": "'+wrap.body+'"'+
		'        },'+
		'        "priority": "'+wrap.subject+'",'+
		'        "subject": "'+wrap.priority+'",'+
		'        "requester": {'+
		'            "locale_id": 8,'+
		'            "name": "'+wrap.name+'",'+
		'            "email": "'+wrap.email+'"'+
		'        }'+
		'    }'+
		'}';
    req.setBody(body);
     System.debug('Body: '+body);
     System.debug('auth: '+EncodingUtil.base64Encode(Blob.valueOf(Basicauth)));
     
    HTTP http = new HTTP();

    try{
       HTTPResponse response=http.send(req);
       System.debug(response);
       String resbody=response.getBody();
       ZendeskWrapper zendobj=(ZendeskWrapper)System.JSON.deserialize(resbody,ZendeskWrapper.class);
       if(zendobj.ticket != null){

        List<Case> caseupdate= [SELECT
        CaseNumber,
        Subject,
        ZendeskTicketnumber__c
    FROM
        Case
    WHERE
    Status != null
   
        ];
        for(Case c:caseupdate){
            if(c.Subject.equals(wrap.subject)){
                c.ZendeskTicketnumber__c=zendobj.ticket.id;
                update c;

            }
        }

       

       }
    }catch(CalloutException e){

    }


}



}
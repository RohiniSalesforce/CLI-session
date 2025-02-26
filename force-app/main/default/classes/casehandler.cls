public with sharing class casehandler {
    public static void casehandlermethod(List<Case> casedes) {

       for(Case c:casedes){
        Zendesk.zendeskticketWrapper wrapinner= new Zendesk.zendeskticketWrapper();
            wrapinner.body=c.Description;
            Case con=[SELECT
            CaseNumber,
            Contact.Name,
            Contact.Email,
            Contact.Phone
        FROM
            Case
        WHERE
            ContactId != null
        LIMIT 1
            ];
            System.debug(con.Contact.Email);
            System.debug(con.Contact.Phone);
            // c.Subject=c.Subject.trim().replaceAll('\\s+', ' ');
            wrapinner.subject=c.Subject;
            wrapinner.priority=c.Priority;
            wrapinner.name=con.Contact.Name;
            wrapinner.email=con.Contact.Email;
            makeCallout(JSON.serialize(wrapinner));
           
       }
    }
         @future(callout=true)
         public static void makeCallout(String det){
           //now we have to convert the string to onject of that inner calss
           Zendesk.zendeskticketWrapper wraper= (Zendesk.zendeskticketWrapper)System.JSON.deserialize(det,Zendesk.zendeskticketWrapper.class);
           Zendesk.zendeskcallout(wraper);
         }

    
}

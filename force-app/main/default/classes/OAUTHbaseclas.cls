public with sharing class OAUTHbaseclas {
    public static PageReference getauthcode(){

/* url to prepare
https://login.salesforce.com/services/oauth2/authorize?client_id=
3MVG9GCMQoQ6rpzQhHRuM8hzMF6eOSmT9XnoxubNadS7kj.dbA1Q6UpTcqOsr.6k5Db9ucExS7EN_DbZ79oTN&redirect_uri
=https://developer.zendesk.com/api-reference/ticketing/tickets/tickets/&response_type=code

2. OAuthSalesforce -> wee can add this in custom label also

*/

OAuthSalesforce__mdt oathconfig=OAuthSalesforce__mdt.getInstance('oauthconfig');
if(oathconfig!=null){

String orgUrl  = oathconfig.Environment__c == 'Production' ? 'https://login.salesforce.com' : 'https://test.salesforce.com';

            System.System.debug( orgUrl );

            String redirect_uri = System.URL.getOrgDomainURL().toExternalForm()+'/apex/'+oathconfig.PageName__c;
            System.System.debug( redirect_uri );

            String authorizeUrl = orgUrl+oathconfig.authurl__c+'?client_id='+oathconfig.clientid__c
                            +'&redirect_uri='+redirect_uri+'&response_type=code';
            System.System.debug( authorizeUrl );

        

            return new PageReference(authorizeUrl);

}else{
return null;
}


    }

    public void getAccessToken(){

        /*
          To get auth code from url 
          https://autorabt-dev-ed--c.develop.vf.force.com/apex/OAUTHPAgeredirect?
          code=aPrxp.7fR25AS7PyXuXiAVpsez2vCKFz6Ex2KE.Vul4deu_41SPD7co2vKXD5hmhzZg7a7ztZg%3D%3D
        */


        

    }

    
    }

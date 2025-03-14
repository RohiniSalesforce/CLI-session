public with sharing class JWT {
    
private static final String JWT_HEADER = '{"alg":"RS256"}';
public static String retrievePrivateKey(){
    try {
        ContentVersion base64Content = [SELECT VersionData FROM ContentVersion WHERE Title = 'server.key' ORDER BY Title LIMIT 1];
        Blob keyBlob = base64Content.VersionData; // Get the Blob directly

        String keyContents = keyBlob.toString(); // Convert the Blob to a String for manipulation

        // Remove PEM headers and footers
        keyContents = keyContents.replace('-----BEGIN RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('-----END RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replaceAll('\r\n', '\n');
        keyContents = keyContents.replaceAll('\r', '\n');
        keyContents = keyContents.replaceAll('\n', '');
        keyContents = keyContents.trim();

        // Convert the modified string back to a Blob, then encode to Base64
        Blob cleanedKeyBlob = Blob.valueOf(keyContents);
        String base64Key = EncodingUtil.base64Encode(cleanedKeyBlob);

        return base64Key;
    } catch (QueryException e) {
        System.debug('Query Error: ' + e.getMessage());
        return null; // Or handle the error as needed
    } catch (StringException e) {
        System.debug('String Error: ' + e.getMessage());
        return null; // Or handle the error as needed
    }
}
public static void run(){
    DateTime rightNow = System.now();
    rightNow = rightNow.addMinutes(3);
    Long expiry = rightNow.getTime();
    String jsonreq='{"iss": "3MVG9WVXk15qiz1JFEGaezd9NSxgcN0tNm6RIcoJFGmUXs0JHMyvrArSl1d9tLLSytEOIwM9mkFTEVpOhlUmM","sub":"rohinisource@gmail.com","aud":"https://login.salesforce.com","exp":'+expiry+'}';
		
    // JWT jwt = new JWT('3MVG9n_HvETGhr3COGSBZ2RGw0UCthndmDcWklbdHdn08L0Idmk3gMp8P7c6iNsTnhM_61ZuvP3rrAqOcpHi5','sfdcpanther+hindi@gmail.com','https://login.salesforce.com',expiry);
    String base64UrlJWTHeader = base64UrlEncode( JWT_HEADER );

    String base64UrlJWTClaims = base64UrlEncode( jsonreq );
    String combinedHeaderClaim =base64UrlJWTHeader+'.'+base64UrlJWTClaims;
    System.debug('combinedHeaderClaim \n'+combinedHeaderClaim);
    String jwtAssertion = shaSignPrivateKey(combinedHeaderClaim);
    System.debug('jwtstr \n '+ jwtAssertion);
    // getAccessToken(jwtAssertion);

}
public static String shaSignPrivateKey(String combinedHeaderClaim){
    // base64Decode the Private key Content
    Blob privateKey = EncodingUtil.base64Decode(retrievePrivateKey());
    // Sign the private Key usiusing rsa-sha256 Algorithm
    Blob signature = Crypto.sign('rsa-sha256',Blob.valueOf(combinedHeaderClaim), privateKey);
    // Add the signature into the assertion
    combinedHeaderClaim += '.' +SFDC_BASE64_URLENCODE(signature);
    return combinedHeaderClaim;
}
public static String base64UrlEncode(String header){
    String base64UrlEncode = SFDC_BASE64_URLENCODE(Blob.valueOf(header));
    return base64UrlEncode;
    }
    private static String SFDC_BASE64_URLENCODE(Blob input){
    if(input == null) {
    return null;
    }
    return EncodingUtil.base64Encode(input)
    .replace('/', '_')
    .replace('+', '-')
    .replaceAll('=+$', '');
    }

    private static void getAccessToken(String assertionValue){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://login.salesforce.com/services/oauth2/tokePantherSchooln?grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion='+assertionValue);
        req.setMethod('POST');
        req.setHeader('Content-Type',
        'application/x-www-form-urlencoded');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        String response = res.getBody();

    }
}
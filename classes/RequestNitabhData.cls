public class RequestNitabhData {
    
    public static String main(){
        
        HttpRequest req = new HttpRequest();  
        String CLIENT_ID = '3MVG9VMBZCsTL9hnVNVukGk6UOvRPFJG5mdvx7pMCNhv7g6KCOFMsa0o5hZJItd_.Vtzyt29B_RhARZxkvUaZ';
        String CLIENT_SECRET = '670E30400EA269ACD698B2EAB0EF82B357129FBF996CFB47FF2E563779F3616B';
        String USERNAME = 'tomcruise@sf.com';
        String PASSWORD = 'Kumar2365@$';
        
        req.setBody('grant_type=password' + '&client_id='+ CLIENT_ID + 
                    '&client_secret=' + CLIENT_SECRET + '&username=' + USERNAME + '&password=' +PASSWORD);
        
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        //req.setHeader('content-type', 'application/x-www-form-urlencoded');
        //req.setHeader('Accept', 'application/json');
        req.setMethod('POST');
        HTTP http =  new HTTP();
        HttpResponse response = http.send(req);
        
        if(response.getStatusCode() == 200){
            Map<String, Object> resonseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug(resonseMap.get('access_token'));
            return (String) resonseMap.get('access_token');            
        } 
        
        return null;
        
    }
    
    public static void createRecordTargetOrg(){
        
        String accessToken = main();
        //System.debug(obj);        
        HttpRequest req = new HttpRequest();
        String accountName = 'Abhisehk';
        String firstName = 'John';
        String lastName = 'Doe';
        String email = 'john.doe@eple.com';
        
        req.setEndpoint('https://fexleservicesprivatelimi-a9-dev-ed.develop.my.salesforce.com/services/apexrest/Account/');
        req.setHeader('Authorization','Bearer ' + accessToken);
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');
        String jsonBody = '{"AccountName": "' + accountName + '", "FirstName": "' + firstName + '", "LastName": "' + lastName + '", "Email": "' + email + '"}';
        req.setBody(jsonBody);

        Http http = new Http();
        HttpResponse response = http.send(req);        
        System.debug('response body : ' + response.getBody());
        
    }
}
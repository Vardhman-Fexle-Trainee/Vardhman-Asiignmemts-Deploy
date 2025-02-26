@RestResource(urlMapping='/Account/*')
global class AccountResourceInformation {
    
    @HttpGet
    global static Account getAccount() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name,Phone FROM Account WHERE Id = :accountId];
        return result;
    }
    
    @HttpPost    
    global static String createAccountContact() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String JsonBody = req.requestBody.toString();
        Id ContactId;
        Id accountId;        
        
        Map<String, Object> mapOfRequestedBody = (Map<String, Object>) JSON.deserializeUntyped(JsonBody);
        String name = (String) mapOfRequestedBody.get('AccountName');
        String firstName = (String) mapOfRequestedBody.get('FirstName');
        String lastName = (String) mapOfRequestedBody.get('LastName');
        String email = (String) mapOfRequestedBody.get('Email');
        
        Account[] existingAccount = [SELECT Id,Name FROM Account WHERE Name = :name LIMIT 1];
        
        if (existingAccount.size()>0) {
            
            for(Account acc :existingAccount ){
                accountId = acc.Id;
            }            
            Contact[] existingContact = [SELECT Id,Email,AccountId FROM Contact 
                                         WHERE Email = :email AND AccountId = :accountId LIMIT 1];
            if (existingContact.size()>0) {
                
                return JSON.serialize(new Map<String, Object>{
                    'Error' => 'Duplicate Contact found with the same Email on this Account',
                        'AccountId' => accountId
				});
            }
        } else{
            
            Account newAccount = new Account(Name = name);
            insert newAccount;
            accountId = newAccount.Id;
        }                
        Contact contactToInsert = new Contact(FirstName = firstName, LastName = lastName, Email = email, AccountId = accountId);
        insert contactToInsert;                
        return JSON.serialize(new Map<String, Object>{
            'Success' => true,
                'ContactId' => contactToInsert.Id,
                'AccountId'=> accountId                
		});        
    }
}
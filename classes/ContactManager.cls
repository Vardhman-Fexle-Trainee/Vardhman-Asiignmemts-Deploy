public class ContactManager {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accountId, String dataSearch, Boolean wantCount) {
        
        try {
            if(String.isBlank(dataSearch)) {
                
                if(wantCount){
                    List<Contact> contacts = [SELECT Id, Name, Email, Phone FROM Contact WHERE AccountId = :accountId];
                    return contacts;
                }else {
                    List<Contact> contacts = [SELECT Id, Name, Email, Phone FROM Contact WHERE AccountId = :accountId];
                    return contacts;
                }
                
            }else {
                List<Contact> contacts = [SELECT Id, Name, Email, Phone FROM Contact WHERE AccountId = :accountId AND Name LIKE :'%'+dataSearch+'%'];
                return contacts;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
        
    }
    
    
    @AuraEnabled
    public static String createContact(Contact contact) {
        
        try {
            if(contact != null){
                insert contact;
                return 'Contact created successfully';
            }else {
                return 'Contact is null';
            }
                
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
    
}
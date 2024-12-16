public class AccountProcessor {
    
    public static void countContacts(List<Id> accountIds){
        
        List<Account> listOfAccounts = [SELECT ID, Name 
                                        FROM Account 
                                        WHERE Id IN :accountIds] ;
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for(Account acc : listOfAccounts){
            
            acc.Number_Of_Contacts__c = [SELECT COUNT()
                                        FROM Contact 
                                        WHERE AccountId = :acc.Id];
            accountsToUpdate.add(acc);
            
        }
        try{
            update accountsToUpdate;
        }catch(DMLException dE){
            System.debug('Exception occured duirng updation - ' + dE.getMessage());
        }
        
        
        
        
        
        /*        Map<Id, Integer> mapOfAccIdAndContactSize = new Map<Id, Integer>();
        for(Id i : accountIds){
            List<Contact> listOfContacts = [SELECT Id  FROM Contact WHERE AccountId = :i ];
            mapOfAccIdAndContactSize.put(i, listOfContacts.size());
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        for(Id i : mapOfAccIdAndContactSize.keySet()){
            Account acc ;
            acc.Id = i;
            acc.Number_Of_Contacts__c = mapOfAccIdAndContactSize.get(i);
            accountsToUpdate.add(acc);
        }
        
        try{
            update accountsToUpdate;
        }catch(DMLException dE){
            System.debug('Exception occured duirng insertion - ' + dE.getMessage());
        }
  */     
        
    }
}
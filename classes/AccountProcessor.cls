public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
       
        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();
        
        List<AggregateResult> contactCounts = [SELECT AccountId, COUNT(Id) contactCount
                                               FROM Contact
                                               WHERE AccountId IN :accountIds
                                               GROUP BY AccountId];

        for(AggregateResult ar : contactCounts) {
            
            Id accountId = (Id) ar.get('AccountId');
            Integer contactCount = (Integer) ar.get('contactCount');
            contactCountMap.put(accountId, contactCount);
        }
        
        List<Account> accountsToUpdate = new List<Account>();

        for(Id accountId : accountIds) {
            
            Account acc = new Account(Id = accountId);
            if(contactCountMap.containsKey(accountId)){
                
                acc.Number_Of_Contacts__c = contactCountMap.get(accountId);
            } else{
                
                acc.Number_Of_Contacts__c = 0;
            }
            accountsToUpdate.add(acc);
        }


        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}

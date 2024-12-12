public without sharing class ContactTriggerHandler {
    
    public static void emailDomain(List<Contact> newConList){

        Set<Id> setOfAccountIds = new Set<Id>(); 

        if(!newConList.isEmpty()){

            for(Contact newCon : newConList){

                if(newCon.AccountId != null){
                    setOfAccountIds.add(newCon.AccountId);
                }
            }

        }

        Map<Id, String> mapOfAccoubtIdAndDomainName = new Map<Id, String>();
        if(!setOfAccountIds.isEmpty()){
            for(Account acc: [SELECT Id, Domain__c FROM Account WHERE Id IN : setOfAccountIds]){

                mapOfAccoubtIdAndDomainName.put(acc.Id, acc.Domain__c);

            }
        }

        for(Contact newCon : newConList){

            if(newCon.AccountId != null && newCon.Email != null){
                if(newCon.Email.substringAfter('@').toLowerCase() != mapOfAccoubtIdAndDomainName.get(newCon.AccountId)){
                    newCon.addError('The email domain ' + newCon.Email+ ' you are entering is not matched with the parent account Domain name ' + mapOfAccoubtIdAndDomainName.get(newCon.AccountId));
                }


            }

        }


    }
}
global class AccountSupportScoreBatch implements Database.Batchable<sObject> {
    
    global static Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator([SELECT Id, Status, Priority, AccountId, CreatedDate FROM Case WHERE Status != 'Closed']);
    }
    
    global static void execute(Database.BatchableContext bc, List<Case> listOfCases){
        
        System.debug(listOfCases);
        
        Set<Id> accountIds = new Set<Id>();
        List<Case> listOfCasesToCalcScore = new List<Case>();
        List<Account> accountsToUpdate = new List<Account>();
        List<Account> queriedAccountsList = new List<Account>(); 
            
            
        for(Case thisCase : listOfCases){
            if(String.isNotBlank(thisCase.AccountId) && String.isBlank(thisCase.Priority)){
                
                thisCase.Priority = 'Low';
            }
            
            if(String.isNotBlank(thisCase.AccountId)){
                accountIds.add(thisCase.AccountId);
            }
        }
        
        queriedAccountsList = [SELECT Id, Support_Score__c, 
                               (SELECT Id, Status, Priority, AccountId, CreatedDate FROM Cases) 
                                FROM Account WHERE Id IN :accountIds];
        
        for(Account acc : queriedAccountsList){
            
            
            for(Case thisCase : acc.Cases){            	
                listOfCasesToCalcScore.add(thisCase);
            }
            
            acc.Support_Score__c += (Decimal)AccountSupportScoreBatch.scoreCalculation(listOfCasesToCalcScore);            
            accountsToUpdate.add(acc);
            listOfCasesToCalcScore.clear();            
        }
        
        try{
            if(!accountsToUpdate.isEmpty()){
                update accountsToUpdate;
            }
        }catch(Exception e){
            
            System.debug(e.getMessage());
        }
        
    }
    
    global static void finish(Database.BatchableContext bc){}
    
    
    
    global static Decimal scoreCalculation(List<Case> listOfCasesToCalcScore){
        
        Decimal score = 0;
        
        for(Case thisCase : listOfCasesToCalcScore){
            
            if(thisCase.Priority == 'Low'){
                
                score += 1;
            }else if(thisCase.Priority == 'Medium'){
                
                score += 2;
            }else if(thisCase.Priority == 'High'){
                
                score += 3;
            }
            
            if(thisCase.CreatedDate >= System.today()-30){
                
                score += 1;
            }else if(thisCase.CreatedDate <= System.today()-60){
                
                score -= 1;
            }
            
        }
        return score;
    }
}
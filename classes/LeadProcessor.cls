global class LeadProcessor implements Database.Batchable<SObject>, Schedulable {
    
    global  Integer recordProcesses = 0; 
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead WHERE LeadSource != Dreamforce' );
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> leadsToUpdate){
        
        for(Lead updateLead : leadsToUpdate){
            if(updateLead.LeadSource != 'Dreamforce'){
                
                updateLead.LeadSource = 'Dreamforce';
            }
            
        }
        
        update leadsToUpdate;
    }
    

    
    global void finish(Database.BatchableContext bc){
        
        System.debug('Success.');
    }
    
global  void execute(SchedulableContext sc){
        LeadProcessor lp = new LeadProcessor();
        String str  = Database.executeBatch(lp,25);
        
     }
    
}

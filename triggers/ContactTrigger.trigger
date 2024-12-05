trigger ContactTrigger on Contact (before insert, before update) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            ContactTriggerHandler.emailDomain(Trigger.new);
        }
        if(Trigger.isUpdate){
            ContactTriggerHandler.emailDomain(Trigger.new);
        }

    }
    
}
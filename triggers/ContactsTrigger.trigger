trigger ContactTrigger on Contact (after insert) {
    
    if(trigger.isAfter){
        
        if(trigger.isInsert){
            ContactTriggerHandler.verifyAddress(trigger.new);
        }
    }	
}
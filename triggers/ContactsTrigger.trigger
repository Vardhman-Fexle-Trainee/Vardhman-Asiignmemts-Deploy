trigger ContactsTrigger on Contact (after insert) {
    
    if(trigger.isAfter){
        
        if(trigger.isInsert){
            ContactsTriggerHandler.verifyAddress(trigger.new);
        }
    }	
}

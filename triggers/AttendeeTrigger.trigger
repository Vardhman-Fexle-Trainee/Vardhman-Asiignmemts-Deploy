trigger AttendeeTrigger on Attendee__c (after insert, after update, after delete) {
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){

            AttendeeTriggerHandler.countTrainingSession(trigger.new);   
        }                
    }   
}

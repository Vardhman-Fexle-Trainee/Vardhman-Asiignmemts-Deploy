trigger AttendeeTrigger on Attendee__c (after insert, after update, after delete) {
    
    if(Trigger.isAfter ||  Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete){
        
    	AttendeeTriggerHandler.countTrainingSession(trigger.new);   
        //System.debug('Error occurred inside after trigger.' + trigger.new);
    }
    
}
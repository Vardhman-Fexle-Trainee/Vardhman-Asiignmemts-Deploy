trigger EventTigger on Event (after insert, after update, after delete, after undelete) {

    if(Trigger.isAfter){
        
        if(Trigger.isInsert || Trigger.isUndelete){
            EventTriggerHandler.rollUpEventActivities(Trigger.new, null);
            
        }
        
        if(Trigger.isUpdate){
            
            EventTriggerHandler.rollUpEventActivities(Trigger.new, Trigger.oldMap);
        }
        
        if(Trigger.isDelete){
            
            EventTriggerHandler.rollUpEventActivities(Trigger.old, null);
        }
        
    }
    
    
}
trigger TaskTigger on Task (before insert) {

     if(Trigger.isAfter){
        
        if(Trigger.isInsert || Trigger.isUndelete){
            TaskTriggerHandler.rollUpTaskActivities(Trigger.new, null);
            
        }
        
        if(Trigger.isUpdate){
            
            TaskTriggerHandler.rollUpTaskActivities(Trigger.new, Trigger.oldMap);
        }
        
        if(Trigger.isDelete){
            
            TaskTriggerHandler.rollUpTaskActivities(null, Trigger.oldMap);
        }
        
    }
}
/**
*  Description :- This file is only managing the events, context and passing to handler class which contains the logic. 
*  
* Created by :- Vardhman Jain
* 
*  Created Date :- 06-Dec-2024
* 
*  Revision Logs :- v1.0
*                    
*/

trigger ContactTrigger on Contact (before insert, before update) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            ContactTriggerHandler.emailDomain(Trigger.new);
            ContactTriggerHandler.checkRecordObjectName(Trigger.new, null);
        }
        if(Trigger.isUpdate){
            ContactTriggerHandler.emailDomain(Trigger.new);
            ContactTriggerHandler.checkRecordObjectName(Trigger.new, Trigger.oldMap);
        }
    }    
}
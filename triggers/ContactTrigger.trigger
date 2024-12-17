/**
*  Description :- ContactTrigger only managing the events and passing to handler class which contains the logic. 
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
        }
        if(Trigger.isUpdate){
            ContactTriggerHandler.emailDomain(Trigger.new);
        }

    }
    
}

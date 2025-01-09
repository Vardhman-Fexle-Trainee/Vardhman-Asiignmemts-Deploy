public class TaskTriggerHandler {
    
    public static void rollUpTaskActivities(List<Task> listOfTasks, Map<Id, Task> mapOfTasks){
        
        Set<Id> openTasksSet = new Set<Id>();
        Set<Id> closedTasksSet = new Set<Id>();
        
        if(!listOfTasks.isEmpty()){
            
            for(Task tsk : listOfTasks){
                
                if(mapOfTasks == null){
                    
                    if(tsk.Status__c == 'Open'){
                        
                        openTasksSet.add(tsk.WhatId);
                        
                    }else if(tsk.Status__c == 'Closed'){
                        
                        closedTasksSet.add(tsk.WhatId);
                    }
                }else if(mapOfTasks != null){
                    
                    if(tsk.Status__c != mapOfTasks.get(tsk.Id).Status__c ){
                        
                        if(tsk.Status__c == 'Open'){
                            
                            openTasksSet.add(tsk.WhatId);
                            
                        }else if(tsk.Status__c == 'Closed'){
                            
                            closedTasksSet.add(tsk.WhatId);
                        }                        
                    }
                    if(tsk.WhatId != mapOfTasks.get(tsk.Id).WhatId){
                        
                        if(tsk.Status__c == 'Open'){
                            
                            openTasksSet.add(mapOfTasks.get(tsk.Id).WhatId);
                            openTasksSet.add(tsk.WhatId);
                            
                        }else if(tsk.Status__c == 'Closed'){
                            
                            closedTasksSet.add(mapOfTasks.get(tsk.Id).WhatId);
                            closedTasksSet.add(tsk.WhatId);
                        } 
                    }                    
                }
            }
        }
        
        List<Account> accountsListToUpdate = new List<Account>();
        if(!openTasksSet.isEmpty()){
            
            List<AggregateResult> aggregateOfOpenTasks = [SELECT WhatId, Count(Id) OpenTasks FROM Task 
                                                           WHERE WhatId IN : openTasksSet GROUP BY WhatId];
            
            if(!aggregateOfOpenTasks.isEmpty()){
                
                for(AggregateResult aggResult: aggregateOfOpenTasks){
                    
                    Account acc = new Account();
                    acc.Id = (Id)aggResult.get('WhatId');
                    acc.Total_Open_Activities__c = 0;
                    acc.Total_Open_Activities__c = (Decimal)aggResult.get('OpenTasks');
                    accountsListToUpdate.add(acc);                   
                }
            }
        }
        
        if(!closedTasksSet.isEmpty()){
            
            List<AggregateResult> aggregateOfClosedTasks = [SELECT WhatId, Count(Id) ClosedTasks FROM Task 
                                                             WHERE WhatId IN : closedTasksSet GROUP BY WhatId];
            
            if(!aggregateOfClosedTasks.isEmpty()){
                
                for(AggregateResult aggResult: aggregateOfClosedTasks){
                    
                    Account acc = new Account();
                    acc.Id = (Id)aggResult.get('WhatId');
                    acc.Total_Closed_Activities__c = 0;
                    acc.Total_Closed_Activities__c = (Decimal)aggResult.get('ClosedTasks');
                    accountsListToUpdate.add(acc);                   
                }
            }
        }
        
        if(!accountsListToUpdate.isEmpty()){
            
            for(Account acc : accountsListToUpdate){
                
               acc.Total__c = 0; 
               acc.Total__c = (Decimal)acc.Total_Open_Activities__c + acc.Total_Closed_Activities__c;
            }
            
            
            try{
                
                update accountsListToUpdate;
            }catch(Exception e){
                
                System.debug(e.getMessage());
            }
        }
        
    }    
}
public class EventTriggerHandler {
    
    public static void rollUpEventActivities(List<Event> listOfEvents, Map<Id, Event> mapOfEvents){
        
        Set<Id> openEventsSet = new Set<Id>();
        Set<Id> closedEventsSet = new Set<Id>();
        
        if(!listOfEvents.isEmpty()){
            
            for(Event evnt : listOfEvents){
                
                if(mapOfEvents == null && !String.isBlank(evnt.WhatId)){
                    
                    if(evnt.Status__c == 'Open'){
                        
                        openEventsSet.add(evnt.WhatId);
                        
                    }else if(evnt.Status__c == 'Closed'){
                        
                        closedEventsSet.add(evnt.WhatId);
                    }
                }else if(mapOfEvents != null && !String.isBlank(evnt.WhatId)){
                    
                    if(evnt.Status__c != mapOfEvents.get(evnt.Id).Status__c ){
                        
                        if(evnt.Status__c == 'Open'){
                            
                            openEventsSet.add(evnt.WhatId);
                            
                        }else if(evnt.Status__c == 'Closed'){
                            
                            closedEventsSet.add(evnt.WhatId);
                        }                        
                    }
                    if(evnt.WhatId != mapOfEvents.get(evnt.Id).WhatId){
                        
                        if(evnt.Status__c == 'Open'){
                            
                            openEventsSet.add(mapOfEvents.get(evnt.Id).WhatId);
                            openEventsSet.add(evnt.WhatId);
                            
                        }else if(evnt.Status__c == 'Closed'){
                            
                            closedEventsSet.add(mapOfEvents.get(evnt.Id).WhatId);
                            closedEventsSet.add(evnt.WhatId);
                        } 
                    }                    
                }
            }
        }
        
        List<Account> accountsListToUpdate = new List<Account>();
        if(!openEventsSet.isEmpty()){
            
            List<AggregateResult> aggregateOfOpenEvents = [SELECT WhatId, Count(Id) OpenEvents FROM Event 
                                                           WHERE WhatId IN : openEventsSet GROUP BY WhatId];
            
            if(!aggregateOfOpenEvents.isEmpty()){
                
                for(AggregateResult aggResult: aggregateOfOpenEvents){
                    
                    Account acc = new Account();
                    acc.Id = (Id)aggResult.get('WhatId');
                    acc.Total_Open_Activities__c = 0;
                    acc.Total_Open_Activities__c = (Decimal)aggResult.get('OpenEvents');
                    accountsListToUpdate.add(acc);                   
                }
            }
        }
        
        if(!closedEventsSet.isEmpty()){
            
            List<AggregateResult> aggregateOfClosedEvents = [SELECT WhatId, Count(Id) ClosedEvents FROM Event 
                                                             WHERE WhatId IN : closedEventsSet GROUP BY WhatId];
            
            if(!aggregateOfClosedEvents.isEmpty()){
                
                for(AggregateResult aggResult: aggregateOfClosedEvents){
                    
                    Account acc = new Account();
                    acc.Id = (Id)aggResult.get('WhatId');
                    acc.Total_Closed_Activities__c = 0;
                    acc.Total_Closed_Activities__c = (Decimal)aggResult.get('ClosedEvents');
                    accountsListToUpdate.add(acc);                   
                }
            }
        }
        
        if(!accountsListToUpdate.isEmpty()){
            
            for(Account acc : accountsListToUpdate){
                
               acc.Total__c = 0; 
               acc.Total__c = (Decimal) acc.Total_Open_Activities__c + acc.Total_Closed_Activities__c;
            }
            
            
            try{
                
                update accountsListToUpdate;
            }catch(Exception e){
                
                System.debug(e.getMessage());
            }
        }
        
    }    
}
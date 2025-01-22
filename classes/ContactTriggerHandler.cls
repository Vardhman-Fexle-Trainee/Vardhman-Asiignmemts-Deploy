/**
*  Description :- ContactTriggerHandler will handle before insert event on Contact
*  
* Created by :- Vardhman Jain
* 
*  Created Date :- 06-Dec-2024
* 
*  Revision Logs :- v1.0
*                  
* 
*/


public without sharing class ContactTriggerHandler {
    
    public static String str = 'Contact e-mail must have account domain.';
    /**
*  Description :- checkRecordObjectName method checks object name using record id and populates picklist field values. 
*  
* Created by :- Vardhman Jain
* 
*  Created Date :- 27-Dec-2024
* 
*  Revision Logs :- v1.0
*                    
*/
    public static void checkRecordObjectName(List<Contact> conList, Map<Id, Contact> oldConMap){
        
        
        if(conList.isEmpty()){
        
            return;
        }
        
        //Map<String, Schema.SObjectType> globalSObjects = Schema.getGlobalDescribe();        
        for(Contact con : conList){            
            
            if( (oldConMap == null  && String.isNotBlank(con.RecordId__c) && con.RecordId__c.length() == 18 )  ||

               (oldConMap != null && oldConMap.get(con.Id).RecordId__c != con.RecordId__c && 

                String.isNotBlank(con.RecordId__c) && con.RecordId__c.length() == 18 ) ){                                                           
                    
                   // Accessing recordId to populate Object Name  
                   Id recordId = Id.valueOf(con.RecordId__c);
                   Schema.SObjectType sObjectName = recordId.getSobjectType();
                   
                   //Populate object name
                   con.Object_Name__c = ((Id)recordId).getSobjectType().getDescribe().getName();                                      
                   Schema.DescribeSObjectResult sObjectResult = sObjectName.getDescribe();
                   
                   List<string> picklistfieldNames = new List<string>();
                   for(Schema.SObjectField sObjfield  : sObjectResult.fields.getMap().values()){
                    
                       Schema.DescribeFieldResult fieldResult = sObjfield.getDescribe();
                       
                       if(fieldResult.getType() == Schema.DisplayType.PICKLIST){
                           picklistfieldNames.add(fieldResult.getName());                                               
                       }
                   } 
                   if(!picklistfieldNames.isEmpty())
                        {
                            con.Picklist_Field__c = '';
                            for(String val : picklistfieldNames)
                            {
                                con.Picklist_Field__c += val + '\n';       
                            }
                        }                
            }                          
            if(con.RecordId__c == null){
                        
                con.Object_Name__c = null;
                con.Picklist_Field__c = null;
            }       
    }

    
}
    
    /**
*  Description :- emailDomain method ensures contact Email contains related account domain. 
*  
* Created by :- Vardhman Jain
* 
*  Created Date :- 06-Dec-2024
* 
*  Revision Logs :- v1.0
*                    
*/
    
    public static void emailDomain(List<Contact> newConList){
        
        Set<Id> setOfAccountIds = new Set<Id>(); 
        
        if(!newConList.isEmpty()){
            
            for(Contact newCon : newConList){
                
                if(newCon.AccountId != null){
                    setOfAccountIds.add(newCon.AccountId);
                }
            }
            
        }
        
        Map<Id, String> mapOfAccoubtIdAndDomainName = new Map<Id, String>();
        if(!setOfAccountIds.isEmpty()){
            for(Account acc: [SELECT Id, Domain__c FROM Account WHERE Id IN : setOfAccountIds]){
                
                mapOfAccoubtIdAndDomainName.put(acc.Id, acc.Domain__c);
                
            }
        }
        
        for(Contact newCon : newConList){
            
            if(newCon.AccountId != null && newCon.Email != null){
                if(newCon.Email.substringAfter('@').toLowerCase() != mapOfAccoubtIdAndDomainName.get(newCon.AccountId)){
                    newCon.addError('The email domain ' + newCon.Email+ ' you are entering is not matched with the parent account Domain name ' + mapOfAccoubtIdAndDomainName.get(newCon.AccountId));
                }
                
                
            }
            
        }
        
        
    }
}
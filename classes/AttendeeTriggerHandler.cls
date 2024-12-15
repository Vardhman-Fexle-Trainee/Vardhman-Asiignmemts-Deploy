public class AttendeeTriggerHandler {
    public static void countTrainingSession(List<Attendee__c> listOfNewAttendees){
       
/*        if(listOfNewAttendees != null){
            
            Set<Contact> setOfContacts = new Set<Contact>();
        	Set<Id> setOfTrainingSessionIds = new Set<Id>();
        
        	for(Attendee__c att : listOfNewAttendees ){
            	
            	setOfContacts.add(att.Contact_Attende__c);
        	}
            
        	List<Contact> listOfContAndRelatedAtt = [SELECT Id, Name, (SELECT Id, Name, Training_Session_Attendee__c FROM Attendees__r) 
            	                                     FROM Contact WHERE Id IN : setOfContacts];
        
        	//System.debug('Error Occurred after query in handler.'+ listOfNewAttendees );
            Integer i = 0;
            for(Contact con : listOfContAndRelatedAtt){
            
            	for(Attendee__c att : con.Attendees__r){
                
                	setOfTrainingSessionIds.add(att.Training_Session_Attendee__c);
            	}
            	con.Count_Sessions__c = setOfTrainingSessionIds.size() ;
               /* try{
                    
                     insert con;
                }catch(Exception e){
                    con.addError('Error ocurred in insertion.');
                    System.debug('Insertion error. ' + e.getMessage());
                }*
                
            	setOfTrainingSessionIds.clear();
        	}
        }
        
        else{
            System.debug('Error.');
        }*/
        
        Set<Id> setOfContactIds = new Set<Id>();
        for(Attendee__c att : listOfNewAttendees){
            
            if(att.Contact_Attendee__c != null){
                setOfContactIds.add(att.Contact_Attendee__c);
            }
        }
        
        List<Contact> contactsToUpdate = new List<Contact>();
        for(AggregateResult result : [SELECT Contact_Attendee__c, COUNT(Id) AttendeeCount 
                                      FROM Attendee__c 
                                      WHERE Contact_Attendee__c IN : setOfContactIds 
                                      GROUP BY Contact_Attendee__c ]){
            
            Contact con = new Contact(Id = (Id)result.get('Contact_Attendee__c'), Count_Sessions__c = (Integer)result.get('AttendeeCount'));
			contactsToUpdate.add(con);
        }
        if(!contactsToUpdate.isEmpty()){
            update contactsToUpdate;
        }
    }
}
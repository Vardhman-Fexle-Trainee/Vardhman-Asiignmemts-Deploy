/**
 *  Description :- AttendeeTriggerHandler class will handle all events of trigger while perfoming any DML operations on Attendee.
 *  
 * Created by :- Vardhman Jain
 * 
 *  Created Date :- 06-Dec-2024
 * 
 *  Revision Logs :- v1.0
 *                  
 * 
 */

public class AttendeeTriggerHandler {

/**
 *  Description :- countTrainingSession() method will count the related Attendee__c to Contact and reflect on contact field.
 *  
 * Created by :- Vardhman Jain
 * 
 *  Created Date :- 06-Dec-2024
 * 
 *  Revision Logs :- v1.0
 *                  
 * 
 */
    public static void countTrainingSession(List<Attendee__c> listOfNewAttendees){

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

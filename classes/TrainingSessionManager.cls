/**
*	Description:- TrainingSessionManager class manage records in Training_Session__c and Attendee__c by performing DML operations. 
*
*	Created By:- Vardhman Jain
*
*	Created Date:- 27-Nov-2024
*
*	version logs:- v1. 0
***/

public class TrainingSessionManager {
    /** 
    *   Description:- createTrainingSessionRecords() will insert records in Training session and Attendee object using DML INSERT command. 
    *   
    *   Created By:- Vardhman Jain
    *
    *   Created Date:- 27-Nov-2024
    *
    *   version logs:- v1. 0
    */
    public static void createTrainingSessionRecords() {
        
        List<Training_Session__c> listOfTrainingSessionRecord = new List<Training_Session__c>() ;
        listOfTrainingSessionRecord.add( new Training_Session__c(Name = 'Session1', Location__c = 'MH'));
        listOfTrainingSessionRecord.add( new Training_Session__c(Name = 'Session2',Location__c = 'GJ'));
        listOfTrainingSessionRecord.add( new Training_Session__c(Name = 'Session3',Location__c = 'PB'));
        insert listOfTrainingSessionRecord;
        
        List<Attendee__c> listOfAttendeeRecord = new List<Attendee__c>();
        listOfAttendeeRecord.add( new Attendee__c(Name = 'Attendee1', Phone__c = 0987456321, Email__c ='attendee@one.com', Training_Session_Attendee__c = listOfTrainingSessionRecord[0].Id )); 
        listOfAttendeeRecord.add( new Attendee__c(Name = 'Attendee2', Phone__c = 0987654321, Email__c ='attendee@one.com', Training_Session_Attendee__c = listOfTrainingSessionRecord[1].Id));
        listOfAttendeeRecord.add( new Attendee__c(Name = 'Attendee3', Phone__c = 0887654321, Email__c ='attendee@one.com', Training_Session_Attendee__c = listOfTrainingSessionRecord[2].Id));
        Insert listOfAttendeeRecord;
    }

    /** 
    *   Description:- fetchTrainingSessionRecords method is created to read records from both Training_Session__c and Attendee__c object using single query.
    *   
    *   Created By:- Vardhman Jain
    *
    *   Created Date:- 27-Nov-2024
    *
    *   version logs:- v1. 0
    */    

    public static void fetchTrainingSessionRecords() {
      List<Training_Session__c> fetchAllRecords = [SELECT Name, Location__c, (SELECT Name, Phone__c, Email__c FROM Attendees__r ) FROM Training_Session__c];
        
        for(Training_Session__c sessionRecordAndAttendeeList : fetchAllRecords){
            System.debug(sessionRecordAndAttendeeList) ;
            for(Attendee__c attendeesRecord : sessionRecordAndAttendeeList.Attendees__r){
                System.debug(attendeesRecord) ;
            }
        }        
   }
    
    
    /** 
    *   Description:- updateTrainingSessionRecords method will update existing records field value
    *   
    *   Created By:- Vardhman Jain
    *
    *   Created Date:- 27-Nov-2024
    *
    *   version logs:- v1. 0
    */

    public static void updateTrainingSessionRecords() { 
       
        List<Attendee__c> updateAttendeeRecord = [Select Id, Training_Session_Attendee__c From Attendee__c LIMIT 1];
       
        List<Training_Session__c> updateTrainingSessionRecord = [SELECT Id, Location__c FROM Training_Session__c WHERE Name = 'Session2' LIMIT 1];
        
        updateAttendeeRecord[0].Training_Session_Attendee__c = updateTrainingSessionRecord[0].Id;
        update updateAttendeeRecord ;
    }  
    
    /** 
    *   Description:- deleteTrainingSessionRecords method will delete useless Records
    *   
    *   Created By:- Vardhman Jain
    *
    *   Created Date:- 27-Nov-2024
    *
    *   version logs:- v1. 0
    */
    
    public static void deleteTrainingSessionRecords(){
        Attendee__c deleteAttendee = [SELECT Id FROM Attendee__c WHERE Name = 'Attendee1' LIMIT 1];
        System.debug(deleteAttendee);
        delete deleteAttendee;
    }
    
    /** 
    *   Description:- undeleteTrainingSessionRecords method will restore deleted records.
    *   
    *   Created By:- Vardhman Jain
    *
    *   Created Date:- 27-Nov-2024
    *
    *   version logs:- v1. 0
    */
    public static void undeleteTrainingSessionRecords(){
        List<Attendee__c> undeleteAttendee = [SELECT Id, Name FROM Attendee__c WHERE Name = 'Attendee1' ALL ROWS];
        undelete undeleteAttendee;
        System.debug(undeleteAttendee);
        
    }
    
    /** 
    *   Description:- addAttendeesToTrainingSession method will ensure that given child record belongs to particular parent or not.
    *   
    *   Created By:- Vardhman Jain
    *
    *   Created Date:- 27-Nov-2024
    *
    *   version logs:- v1. 0
    */
    public static void addAttendeesToTrainingSession(){
        
        List<Training_Session__c> trainingSessionList =[SELECT Name, Session_Date__c, Location__c, RecordTypeId
                                                        FROM   Training_Session__c];
        Set<Training_Session__c> trainingSessionSet = new Set<Training_Session__c>();
        
        for(Training_Session__c trainingSession: trainingSessionList){
            //Added records without any duplicate records
            trainingSessionSet.add(trainingSession);
        }
        System.debug(trainingSessionList.size() - trainingSessionSet.size() + 'Duplicate records founnd.');
        System.debug(trainingSessionSet);
    }
    
    
     /** 
    *   Description:- safeNavigationOperatorUse method explains use of  safe navigation operator.
    *   
    *   Created By:- Vardhman Jain
    *
    *   Created Date:- 27-Nov-2024
    *
    *   version logs:- v1. 0
    */
    
    public static void safeNavigationOperatorUse(Id attendeeId) {
        String att = [SELECT Texting__c FROM Attendee__c WHERE ID = :attendeeId ]?.Texting__c;
       
        System.debug(att);
    
	}
    
    /** 
    *   Description:- SessionType enum is created with some values and  generateSessionMessage method is created to use these values.
    *   
    *   Created By:- Vardhman Jain
    *
    *   Created Date:- 27-Nov-2024
    *
    *   version logs:- v1. 0
    */
    
    public enum SessionType { 
        WEBINAR, 
        WORKSHOP, 
        SEMINAR 
     } 
    // Method to generate a message based on the session type 
    public void generateSessionMessage(SessionType sessionType) { 
        String message; 
        switch on sessionType { 
            when WEBINAR { 
                message = 'You have a Webinar session scheduled.'; 
            } 
            when WORKSHOP { 
                message = 'You have a Workshop session scheduled.'; 
            } 
            when SEMINAR { 
                message = 'You have a Seminar session scheduled.'; 
            } 
            when else { 
                message = 'Invalid session type.'; 
            } 
        } 
        System.debug('Session Message: ' + message); 
    }
}

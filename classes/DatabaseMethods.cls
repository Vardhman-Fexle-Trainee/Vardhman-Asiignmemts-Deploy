/**
 * Description : DatabaseMethods class contains method of insert, update and delete.
 * 
 * Created By : Vardhman Jain
 * 
 * Created on : 02/12/2024
 * 
 * Version Logs :  V1.0 - Created
 * 
 */
   

public class DatabaseMethods {    
/**
 * Description : insertBulkDataofTrainingSession method is created to insert records in bulk with partial success.
 * 
 * Created By : Vardhman Jain
 * 
 * Created on : 02/12/2024
 * 
 * Version Logs :  V1.0 - Created
 * 
 */
    
    
    public static void insertBulkDataofTrainingSession(){
        
        List<Training_Session__c> listOfTrainingSession = new List<Training_Session__c> { new Training_Session__c( Location__c ='MH'), 
            new Training_Session__c(Name='RJ', Location__c ='KR')};
            
            Database.saveResult[] arrOfCreatedRecords = Database.insert(listOfTrainingSession, false);
        
            for (Database.saveResult insertedRecord :arrOfCreatedRecords ) {
                if (insertedRecord.isSuccess()) {
        
                    System.debug(insertedRecord + 'Record inserted successfully');
                }
                else {
                           
                    System.debug(System.Label.CL_Generate_Message_For_Session_Type);
                        
                        
                    }                 
         }
    }

 /**
 * Description : bulkUpdateTrainingSession method will update records field value.
 * 
 * Created By : Vardhman Jain
 * 
 * Created on : 02/12/2024
 * 
 * Version Logs :  V1.0 - Created
 * 
 */
        
    public static void bulkUpdateTrainingSession(String nameOfSession, String dateOfSession){
            
            Date sessionDate = Date.valueof(dateOfSession);
            
            Training_Session__c recordToUpdate =[SELECT Name, Location__c, Session_Date__c 
                                              FROM Training_Session__c WHERE Name = :nameOfSession AND Session_Date__c =:sessionDate];
            recordToUpdate.Location__c ='Jaipur';
            recordToUpdate.Name ='Harshit';
            
            Database.saveResult updatedRecord = database.update(recordToUpdate,false);
            
            if(updatedRecord.isSuccess()){
                
                System.debug('Successfully updated');
            }
            else{
                System.debug('Error not  updated');
 
            }
        }
            
/**
 * Description : deleteExistingRecord method will delete the existing records and use custom labels to generate messages.
 * 
 * Created By : Vardhman Jain
 * 
 * Created on : 02/12/2024
 * 
 * Version Logs :  V1.0 - Created
 * 
 */    
  
    public static void deleteRecordsOfSesion(String sessionName, String place){
                
            Training_Session__c sessionRecordToDelete = [SELECT Name, Location__c 
                                                         FROM Training_Session__c 
                                                         WHERE Name = :sessionName AND Location__c = :place];
                
            database.deleteResult deletedRecord = Database.delete(sessionRecordToDelete);
                
            if(deletedRecord.isSuccess()){                    
                System.debug('Records deleted successfully.');
            }                
            else{                    
                System.debug('Record not deleted. Please enter correct values');
            }            
    }
}

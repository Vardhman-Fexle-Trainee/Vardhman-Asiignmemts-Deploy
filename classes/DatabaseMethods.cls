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
        
        List<Training_Session__c> listOfTrainingSession = new list<Training_Session__c> { new Training_Session__c( Location__c ='MH'), 
            new Training_Session__c(Name='RJ', Location__c ='KR')};
            
            Database.SaveResult[] arrOfCreatedRecords = Database.insert(listOfTrainingSession, false);
        
            for (Database.SaveResult insertedRecord :arrOfCreatedRecords ) {
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
            
            date sessionDate = date.valueof(dateOfSession);
            
            Training_Session__c recordToUpdate =[select Name, Location__c, Session_Date__c 
                                              from Training_Session__c where Name = :nameOfSession AND Session_Date__c =:sessionDate];
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
                
            Training_Session__c sessionRecordToDelete = [select Name, Location__c 
                                                         from Training_Session__c 
                                                         where Name = :sessionName and Location__c = :place];
                
            database.deleteresult deletedRecord = Database.delete(sessionRecordToDelete);
                
            if(deletedRecord.issuccess()){                    
                System.debug('Records deleted successfully.');
            }                
            else{                    
                System.debug('Record not deleted. Please enter correct values');
            }            
    }
}
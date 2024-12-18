@IsTest
public with sharing class LeadProcessorTest {
    
    @TestSetup
    private static void insertLeads(){
     
        List<Lead> leadsToInsert = new List<Lead>();

        for(Integer i=0 ; i<200 ; i++){
            leadsToInsert.add(new Lead(LastName = 'LeadRecord ' + (i+1), 
            Company = 'Fexle', LeadSource = 'Web', Status = 'Close - Converted'));
        }
		System.debug(leadsToInsert.size());
        insert leadsToInsert;
        
    }

    @IsTest
    private static void testLeadSource(){
        Test.startTest();
        
        //insertLeads();
        LeadProcessor leadpro = new LeadProcessor();
        Id batchId = Database.executeBatch(leadpro);
        Test.stopTest();
        
        List<Lead> leadList = [SELECT LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        
        System.debug(leadList.size());
        System.assertEquals(200, leadList.size(), 'List is not returning 200 records') ;
    }
}
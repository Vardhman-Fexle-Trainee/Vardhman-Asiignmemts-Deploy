@IsTest

public class AddPrimaryContactTest {

    @TestSetup
    public static void setupTestData(){
        
        List<Account> accList = new List<Account>();
        
        for(Integer i = 1 ; i <= 50 ; i++){
            
            accList.add(new Account(Name = 'Test' + i, BillingState = 'NY' ));
        }
        
        for(Integer i = 51 ; i <= 100 ; i++){
            
            accList.add(new Account(Name = 'Test' + i, BillingState = 'CA' ));
        }
        
        System.debug(accList.size());
        
        
        
        Test.startTest();
        insert accList;        
        Test.stopTest();
        
    }
    
    @IsTest
    public static void testExecute(){
        Contact con = new Contact(LastName = 'test');
        insert con;
        Test.startTest();
        AddPrimaryContact acp = new AddPrimaryContact(con, 'CA' );
        System.enqueueJob(acp);
        Test.stopTest();
        
        List<Contact> conList = [SELECT Id FROM Contact];
        
        Assert.areEqual(51, conList.size());
        
    }
}
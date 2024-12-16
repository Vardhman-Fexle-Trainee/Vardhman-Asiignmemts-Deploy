@IsTest(SeeAllData=False)
public class AccountProcessorTest {
	
    @IsTest
    public static void testNumberOfContacts(){
        
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Mark';
        con1.LastName = 'Wahlberg';
        con1.AccountId = acc.Id;
        insert con1;
        
        Contact con2 = new Contact();
        con2.FirstName = 'Tom';
        con2.LastName = 'Cruise';
        con2.AccountId = acc.Id;
        insert con2;
        
        Contact con3 = new Contact();
        con3.FirstName = 'John';
        con3.LastName = 'Cena';
        con3.AccountId = acc.Id;
        insert con3;
        
        List<Id> accountIds = new List<Id>();
        accountIds.add(acc.Id);
        
        Test.StartTest();
        AccountProcessor.countContacts(accountIds);
        Test.StopTest();
        //Assert.areEqual(3, acc.Number_Of_Contacts__c, 'Count must be 3');
        
    }
}
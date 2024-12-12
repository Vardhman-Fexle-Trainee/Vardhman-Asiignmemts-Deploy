@isTest(SeeAllData=false)
private class ContactTriggerHandlerTest {
    @isTest static void emailDomainTest(){
        
        Account existingAccount = new Account();
        existingAccount.Name = 'Vardhman';
        existingAccount.Domain__c = 'Fexle.com';
        insert existingAccount;
        
        Contact con = new Contact();
        con.LastName = 'Jain';
        con.AccountId = existingAccount.Id;
        con.Email = 'vardhman@fexle.com';
        insert con;
        
        Contact con3 = new Contact();
        con3.LastName = 'Jain';
        con3.AccountId = existingAccount.Id;
        insert con3;
        
        Contact con2 = new Contact();
        con2.LastName = 'Jaini';
        con2.AccountId = existingAccount.Id;
        con2.Email = 'vardhman@fex.com';
        try{
            insert con2;
        }catch(DMLException dE){
            System.debug('Insertion exception - ' + dE.getMessage());
        }
        
    }	
}
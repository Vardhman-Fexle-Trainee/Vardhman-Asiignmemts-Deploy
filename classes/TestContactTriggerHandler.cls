/**
 *  Description :- ContactTriggerHandlerTest covering all the testing cases for trigger to ensure coverage of all cases.
 *  
 * Created by :- Vardhman Jain
 * 
 *  Created Date :- 06-Dec-2024
 * 
 *  Revision Logs :- v1.0
 *                  
 */

@isTest
public class TestContactTriggerHandler {
    @isTest 
      static void emailDomainTest(){
        
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
            Assert.areEqual('Contact e-mail must have account domain.', ContactTriggerHandler.str,'Unexpected error');
        }        
    }
    
    
    @IsTest
    static void testCheckRecordObjectName(){
        
        Account existingAccount = new Account();
        existingAccount.Name = 'Vardhman';        
        insert existingAccount; 
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.StageName = 'Prospecting';        
        opp.CloseDate = System.Today();
        opp.Amount = 12345678;
        insert opp;
                        
        Contact cont = new Contact();
        cont.LastName = 'Jain';           
        cont.RecordId__c = existingAccount.Id;
        insert cont;                
                        
        List<Contact> conList = [SELECT Id, Object_Name__c, Picklist_Field__c FROM Contact WHERE Id = :cont.Id];
        Assert.areEqual('Account', conList[0].Object_Name__c);
        
        conList[0].RecordId__c = opp.Id;
        
        update conList;
        
        List<Contact> conList2 = [SELECT Object_Name__c FROM Contact WHERE Id = :cont.Id];
        Assert.areEqual('Opportunity', conList2[0].Object_Name__c);
    }
}
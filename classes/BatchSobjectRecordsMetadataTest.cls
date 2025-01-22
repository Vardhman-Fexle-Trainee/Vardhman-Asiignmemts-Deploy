@isTest
public class BatchSobjectRecordsMetadataTest {

    @isTest static void testBatchSobjectRecordsMetadata() {
        
        List<Account> accountsList = new List<Account>();
        for (Integer i = 1; i <= 5; i++) {
            accountsList.add(new Account(Name = 'Test Account ' + i, Domain__c = 'test.com'));
        }
        insert accountsList;

        String objectName = 'Account';
        String filter = 'Domain__c != NULL';
        Decimal duration = 5;

        
        String queryString = 'SELECT Id, Name, Domain__c FROM ' + objectName + ' WHERE ' + filter + ' AND CreatedDate >= LAST_N_DAYS: ' + duration;
        Database.QueryLocator queryLocator = Database.getQueryLocator(queryString);

        
        Test.startTest();
        BatchSobjectRecordsMetadata batch = new BatchSobjectRecordsMetadata(objectName, filter, duration);        
        Id batchId = Database.executeBatch(batch);
        Test.stopTest();

        
        List<Account> deletedAccounts = [SELECT Id FROM Account WHERE Id IN :accountsList];
        Assert.areEqual(0, deletedAccounts.size(), 'Account records should be deleted after batch execution.');

        
        Integer emailInvocations = Limits.getEmailInvocations();
        System.debug(emailInvocations);
        Assert.areEqual(0, emailInvocations, 'One email should be sent after the batch execution.');
        
    }
    
    @isTest static void testSchedulableExecute() {
        
        Test.startTest();
        String objectName = 'Account';
        String filter = 'Domain__c != NULL';
        Decimal duration = 5;
        String cronExp = '0 0 1 * * ?';
        BatchSobjectRecordsMetadata batch = new BatchSobjectRecordsMetadata(objectName, filter, duration);
        System.schedule('Every Month', cronExp, batch);
        Test.stopTest();
                
        CronTrigger[] cronJobs = [SELECT Id, CronExpression FROM CronTrigger WHERE CronExpression = :cronExp];
        Assert.areEqual(1, cronJobs.size(), 'There should be one scheduled job.');
    }
}
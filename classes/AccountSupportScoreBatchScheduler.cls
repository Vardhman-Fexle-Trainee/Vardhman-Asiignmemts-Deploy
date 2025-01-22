public class AccountSupportScoreBatchScheduler implements Schedulable {

    public static void execute(SchedulableContext sc){
        
        AccountSupportScoreBatch executeAccountSupportScoreBatch = new AccountSupportScoreBatch();
        Database.executeBatch(executeAccountSupportScoreBatch, 200);
    }
}
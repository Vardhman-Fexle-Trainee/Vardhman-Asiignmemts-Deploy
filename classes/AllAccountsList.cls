public class AllAccountsList {
    @AuraEnabled(cacheable=true)

    public static List<Account> getAccounts() {

        List<Account> accList = [SELECT Id, Name, AccountNumber, Phone FROM Account ORDER BY CreatedDate DESC LIMIT 50000];

        return accList;

    }
    @AuraEnabled

    public static Account createAccounts(Account accRecord) {

        insert accRecord;
        return accRecord;

}
    @AuraEnabled

    public static void createContacts(Contact conRecord){
        insert conRecord;
    }
}
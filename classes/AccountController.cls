public with sharing class AccountController {

    @AuraEnabled(cacheable=true)
     
    public static List<Account>  getHighRevenueAccounts() {

        try{
            return [SELECT Name, AnnualRevenue FROM Account ORDER BY AnnualRevenue desc NULLS LAST LIMIT 5];
        }catch(Exception e){

            throw new AuraHandledException(e.getMessage());
        }
    }       
}
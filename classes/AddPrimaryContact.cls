public class AddPrimaryContact implements Queueable{

    Contact con;
    String state;
    
    public AddPrimaryContact(Contact con, String state){
        this.con = con;
        this.state = state;
        
    }
    
    public void execute(QueueableContext qc){
        
        List<Account> accList = [SELECT Id, BillingState FROM Account 
                                 WHERE BillingState =: state LIMIT 200];
        
        List<Contact> conList = new List<Contact>();
        
        for(Account acc : accList){
            
            Contact c = con.clone(false, true, true, true);           
            c.AccountId = acc.Id;
            conList.add(c);
        }
        
        insert conList;
    }
}
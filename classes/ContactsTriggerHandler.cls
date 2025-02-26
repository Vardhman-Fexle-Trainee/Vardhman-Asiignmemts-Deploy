public class ContactTriggerHandler{
    
    public static void verifyAddress(List<Contact> listOfContacts){
        
        if(listOfContacts.isEmpty()){return;}        
        
        Set<Id> contactIds = new Set<Id>();                           
        for(Contact thisContact : listOfContacts){
        	
            if(String.isNotBlank(thisContact.MailingCity) && String.isNotBlank(thisContact.MailingStreet)){
            	contactIds.add(thisContact.Id);                    
            }
        }        
        System.debug('0');
        verifyAddressByCallout(contactIds);
    }
    
    @future(callout=true)
    public static void verifyAddressByCallout(Set<Id> contactIds){
        
        List<Contact> listOfContacts = [SELECT ID, MailingCity, MailingStreet, Address_Verified__c FROM Contact WHERE Id IN :contactIds ];
        Set<Id> contactIdsToUpdate = new Set<Id>();        
        
        for(Contact thisContact : listOfContacts){
            
            String street = EncodingUtil.urlEncode(thisContact.MailingStreet, 'UTF-8');
            String city = EncodingUtil.urlEncode(thisContact.MailingCity, 'UTF-8');
            String state = EncodingUtil.urlEncode(thisContact.MailingState, 'UTF-8');
            
            Http http = new Http();
        	HttpRequest request = new HttpRequest();
            
            request.setEndpoint('https://us-street.api.smarty.com/street-address?street='+street+'&city='+city+'&state='+ state+'&auth-id=7f17e288-d1ad-965b-df69-2082634e22ab&auth-token=31eo21fuRZd2p7T5J9WD&candidates=10');
            request.setMethod('GET');
            
            HttpResponse response = http.send(request);
            if(response.getStatusCode() == 200) {       
                contactIdsToUpdate.add(thisContact.Id);
            }
        }
        
        if(!contactIdsToUpdate.isEmpty()){
            verifiedAddress(contactIdsToUpdate);
        }
    }
    
    public static void verifiedAddress(Set<Id> contactIds){
        
        List<Contact> contactsToUpdate = new List<Contact>();
        
        for(Id contactId : contactIds){
            Contact con = new Contact() ;
            con.Id = contactId;
            con.Address_Verified__c = true;
            contactsToUpdate.add(con);
        }
        update contactsToUpdate;
		
	}
}
import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AllAccountsList.getAccounts';
import createAccounts from '@salesforce/apex/AllAccountsList.createAccounts';
import createContacts from '@salesforce/apex/AllAccountsList.createContacts';
import { refreshApex } from '@salesforce/apex';
import getobjectApiName from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_NUMBER_FIELD from '@salesforce/schema/Account.AccountNumber';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import PHONE__FIELD from '@salesforce/schema/Contact.Phone';
import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';


const COLUMNS = [ { label: 'Name', fieldName: 'Name', type: 'text' }, 
        { label: 'AccountNumber', fieldName: 'AccountNumber', type: 'text'},
        { label: 'Phone', fieldName: 'Phone', type: 'phone'}];
export default class AccountContactRecordCreation extends LightningElement {
    
    @track accountRecord=[];
    @track myAccount = { 'sobjectType': 'Account' };
    @track myContact = { 'sobjectType': 'Contact' };  
    namefield = NAME_FIELD ;
    AccountNumberfield = ACCOUNT_NUMBER_FIELD ;
    Phonefield = PHONE_FIELD ;
    firstnamefield = FIRST_NAME_FIELD;
    lastNameField = LAST_NAME_FIELD
    contactPhonefield = PHONE__FIELD
    columns = COLUMNS;
    error;
    objectApiName = getobjectApiName;
    isCreated = false;
    isContactCreated = false;
    accountRecordId;

    createAccounts(){            
            this.isCreated = !this.isCreated;                    
        }
    
        // AccountHandlers    
    NameChange(event){
        this.myAccount.Name = event.target.value;
    }
    PhoneChange(event){
        this.myAccount.Phone = event.target.value;
    }
    AccountNumberChange(event){
        this.myAccount.AccountNumber = event.target.value;
    }        
    handleAccountSaveButton(){
        createAccounts({accRecord : this.myAccount})
        .then(result => {
            this.accountRecordId = result;
            this.isCreated=false;
            this.isContactCreated=true;
            refreshApex(this.wiredListResultData);
          })
    }
    handleAccountCancelButton(){
        this.isCreated=false;
    }

        // ContactHandlers    
    firstNameChange(event){
        this.myContact.FirstName = event.target.value;
    }
    lastNameChange(event){
        this.myContact.LastName = event.target.value;
        this.myContact.AccountId = this.accountRecordId.Id;
    }
    emailChange(event){
        this.myContact.Email = event.target.value;
    }
    handleContactSaveButton(){
        createContacts({conRecord : this.myContact})
        this.isContactCreated=false;
        this.isCreated=false;
    }
    handleContactCancelButton(){
        this.isCreated = false;
        this.isContactCreated=false;
    }

        // wire method calls
        @wire(getAccounts)
        wiredAccount(Result){
            this.wiredListResultData = Result;
            if(Result.data){
                this.accountRecord=Result.data;
            }
            else if(Result.error){
                this.error=Result.error;
            }
        }                
}

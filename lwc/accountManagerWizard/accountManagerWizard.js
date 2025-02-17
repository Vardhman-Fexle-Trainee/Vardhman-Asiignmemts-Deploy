import { LightningElement, api, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactManager.getContacts';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createContact from '@salesforce/apex/ContactManager.createContact';
import { refreshApex } from '@salesforce/apex';

const ACCOUNT_FIELDS = [
    'Account.Name',
    'Account.OwnerId',
    'Account.Description'
];

export default class AccountManagerWizard extends LightningElement {
    @api recordId;
    @api objectApiName;
    searchData = '';
    isModalOpen = false;
    passBlank = '';
    contactsCount;
    wiredContactToCountResult;

    columnsContact = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email', type: 'email' },
        { label: 'Phone', fieldName: 'Phone', type: 'phone' }
    ]; 

    @wire(getRecord, { recordId: '$recordId', fields: ACCOUNT_FIELDS })
    account;

    @wire(getContacts, { accountId: '$recordId', dataSearch: '$passBlank' })
    contactToCount(value) {        
       
        this.wiredContactToCountResult = value;
        const { data, error } = value;
        if (data) { this.contactsCount = data.length;   }
        else if (error) { 
            console.log('error', error);             
         }
    }

    @wire(getContacts, { accountId: '$recordId', dataSearch: '$searchData'})
    contacts;

    handleKeyUp(event) {
        this.searchData = event.target.value;
    }

    handleCreateNewContact() {
        this.isModalOpen = true;
    }

    handleCloseModal() {
        this.isModalOpen = false;
    }

    handleSave(){
        this.template.querySelector('c-contact-save-form').handleContact();
    }

    handleSaveContact(event) {
        const contactDetails = event.detail; 

        let myContact = { 'sobjectType': 'Contact' };

        myContact.FirstName = contactDetails.firstName;
        myContact.LastName = contactDetails.lastName;
        myContact.Email = contactDetails.email;
        myContact.AccountId = this.recordId;

        createContact({ contact : myContact })
            .then(result => {
                this.showToast('Success', 'Contact created successfully.', 'success');
                this.isModalOpen = false;
                refreshApex(this.contacts);
                refreshApex(this.account);
                refreshApex(this.wiredContactToCountResult);
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }
    
    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant,
            })
        );
    }
}

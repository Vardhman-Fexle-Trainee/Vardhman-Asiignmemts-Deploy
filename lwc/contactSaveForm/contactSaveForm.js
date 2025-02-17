import { api, track } from 'lwc';
import LightningModal from 'lightning/modal';
import LeadSource from '@salesforce/schema/Contact.LeadSource';

export default class ContactSaveForm extends LightningModal {

    @track errorMessage = '';
    @api handleContact() {

        let isError = false;
        let contact = {
            firstName: '',
            lastName: '',
            email: '',
            leadSource:'',
        };

        var inp = this.template.querySelectorAll("lightning-input");

        inp.forEach(function (element) {
            if (element.name == "firstName") {
                contact.firstName = element.value;
            }

            if (element.name == "lastName") {
                
                if (!element.value) {
                    element.setCustomValidity("Last Name should not be blank.");                                                           
                    isError = true;

                } else {                    
                    element.setCustomValidity("");
                    contact.lastName = element.value;
                    isError = false;
                }                
                element.reportValidity();                
            }

            if (element.name == "email") {
                const pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                let email = element.value;

                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!element.value || !pattern.test(email)) {
                    element.setCustomValidity("Please enter a valid email address.");                    
                    isError = true;

                }else {                    
                    element.setCustomValidity("");
                    contact.email = element.value;
                    isError = false;
                }
                element.reportValidity();
            }
        }, this);
        
        if (!isError) {

            const selectEvent = new CustomEvent('save', {
                detail: contact
            });
            var result = this.dispatchEvent(selectEvent);                        
        }
    }

    handleSelectedValue() {
    }
}
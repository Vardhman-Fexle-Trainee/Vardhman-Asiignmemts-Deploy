import { LightningElement, api, track } from 'lwc';
import FETCH_OBJECT from '@salesforce/schema/Contact';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';

export default class RecordForm extends LightningElement {

    isCreate = false;
    isEdit = false;
    isReadOnly = false;
    @track fields = [FIRSTNAME_FIELD, PHONE_FIELD, EMAIL_FIELD, LASTNAME_FIELD, FIRSTNAME_FIELD];
    @api recordId ;

    handleClick(){
        if(this.isCreate == true){
            this.isCreate = false;            
        }else{
            this.isCreate = true;
        }
    }

    handleEditClick(){
        if(this.isEdit == true){
            this.isEdit = false;
        }else{
            this.isEdit = true;
        }
    }
    handleReadOnlyClick(){
        if(this.isReadOnly == true){
            this.isReadOnly = false;
        }else{
            this.isReadOnly = true;
        }
}

}
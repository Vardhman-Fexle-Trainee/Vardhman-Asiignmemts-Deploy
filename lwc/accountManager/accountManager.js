import { LightningElement, track} from 'lwc';
import getAccounts from '@salesforce/apex/AccountManagerController.getAccounts';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Rating', fieldName: 'Rating', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Type', fieldName: 'Type', type: 'text' },
    { label: 'Industry', fieldName: 'Industry', type: 'text' },
];

export default class AccountManagers extends LightningElement {

    @track accounts;
    column=columns;    
    
    connectedCallback(){
        this.fetchAccounts();
    }
    
    fetchAccounts(){
        getAccounts()
        .then(result => {
            this.accounts=result;            
        })
        .catch(error => {
            console.log(error);
        })
    }    
}
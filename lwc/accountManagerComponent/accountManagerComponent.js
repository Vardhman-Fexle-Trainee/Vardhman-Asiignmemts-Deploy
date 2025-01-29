import { LightningElement,wire,track } from 'lwc';
import getHighRevenueAccounts from '@salesforce/apex/AccountController.getHighRevenueAccounts';
export default class AccountManager extends LightningElement {
    @track accounts;
    @track record = [
        { label: 'Name', fieldName: 'Name'},        
        { label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'currency'}];
    @wire(getHighRevenueAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            console.error('Error fetching accounts:', error);
        }
    }  
}
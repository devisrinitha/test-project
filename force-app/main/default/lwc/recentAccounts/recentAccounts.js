import { LightningElement, wire, track } from 'lwc';
import getRecentAccounts from '@salesforce/apex/AccountController.getRecentAccounts';

export default class RecentAccountsList extends LightningElement {
    @track accounts = [];

    @wire(getRecentAccounts)
    wiredAccounts({ data, error }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            console.error('Error fetching recent accounts:', error);
        }
    }
}

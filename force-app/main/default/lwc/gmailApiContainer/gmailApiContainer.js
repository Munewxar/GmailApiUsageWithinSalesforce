import { LightningElement } from 'lwc';
import retrieveMessages from '@salesforce/apex/GmailPublicApiController.retrieveMessages';

export default class GmailApiContainer extends LightningElement {
    messages = [];
    error;
    isLoading = true;

    connectedCallback() {
        this.callRetrieveMessages();
    }

    callRetrieveMessages() {
        retrieveMessages()
            .then(result => {
                this.messages = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.messages = undefined;
            })
            .finally(() => {
                this.isLoading = false;
            })
    }

    handleSendEmail() { }
}
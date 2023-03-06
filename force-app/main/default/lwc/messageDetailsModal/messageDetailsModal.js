import { api } from 'lwc';
import LightningModal from 'lightning/modal';

export default class MessageDetailsModal extends LightningModal {
    @api message;

    get headerLabel() {
        return this.message.Subject__c;
    }

    handleClose() {
        this.close();
    }
}
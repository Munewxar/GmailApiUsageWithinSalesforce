import { api, LightningElement } from 'lwc';
import MessageDetailsModal from 'c/messageDetailsModal';

export default class GmailApiMessage extends LightningElement {
    @api message;

    get senderName() {
        return this.message.Sender_Name__c;
    }

    get messageText() {
        return this.message.Message_Text__c;
    }

    handleMessageClick() {
        MessageDetailsModal.open({
            size: 'small',
            message: this.message
        });
    }
}
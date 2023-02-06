import { api, LightningElement } from 'lwc';

export default class GmailApiMessage extends LightningElement {
    @api message;

    get senderName() {
        return this.message.fromValue;
    }

    get messageText() {
        return this.message.messageValue;
    }

    handleMessageClick() {
        const showEmailEvent = new CustomEvent('showemail');
        showEmailEvent.fire();
    }
}
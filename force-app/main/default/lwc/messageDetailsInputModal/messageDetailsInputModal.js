import LightningModal from 'lightning/modal';

export default class MessageDetailsInputModal extends LightningModal {
    handleSendClick() {
        const emailElement = this.template.querySelector('.email');
        const subjectElement = this.template.querySelector('.subject');
        const messageElement = this.template.querySelector('.message');

        const toAddress = emailElement.value;
        const subject = subjectElement.value;
        const messageText = messageElement.value;

        const sendMessageEvent = new CustomEvent('sendmessage', {
            detail: {
                'toAddress': toAddress,
                'subject': subject,
                'messageText': messageText
            }
        });

        this.dispatchEvent(sendMessageEvent);

        this.close();
    }
}
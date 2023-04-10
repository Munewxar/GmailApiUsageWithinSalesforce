import LightningModal from 'lightning/modal';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class MessageDetailsInputModal extends LightningModal {
    handleSendClick() {
        const emailElement = this.template.querySelector('.email');
        const subjectElement = this.template.querySelector('.subject');
        const messageElement = this.template.querySelector('.message');

        const isValid = this.checkInputValidity(emailElement, subjectElement, messageElement);

        if (isValid) {
            const toAddress = emailElement.value;
            const subject = subjectElement.value;
            const messageText = messageElement.value;

            this.fireSendMessageEvent(toAddress, subject, messageText);
            this.close();
        } else {
            this.showInputError();
        }
    }

    checkInputValidity(emailElement, subjectElement, messageElement) {
        return emailElement.checkValidity()
            && subjectElement.value
            && messageElement.value;
    }

    fireSendMessageEvent(toAddress, subject, messageText) {
        const sendMessageEvent = new CustomEvent('sendmessage', {
            detail: {
                'toAddress': toAddress,
                'subject': subject,
                'messageText': messageText
            }
        });

        this.dispatchEvent(sendMessageEvent);
    }

    showInputError() {
        const showInputErrorEvent = new ShowToastEvent({
            title: 'Invalid Input',
            message: 'Please review your input',
            variant: 'error',
        });

        this.dispatchEvent(showInputErrorEvent);
    }
}
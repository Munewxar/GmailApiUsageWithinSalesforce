import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import MessageDetailsInputModal from 'c/messageDetailsInputModal';

import getTotalMessagesAmount from '@salesforce/apex/GmailPublicApiController.getTotalMessagesAmount';
import retrieveMessages from '@salesforce/apex/GmailPublicApiController.retrieveMessages';
import sendMessage from '@salesforce/apex/GmailPublicApiController.sendMessage';

export default class GmailApiContainer extends LightningElement {
    messages = [];
    error;
    pageNumber = 1;
    datasetNumber = this.pageNumber - 1;
    totalMessagesAmount = 0;
    totalPagesAmount = 1;
    messagesPerPageAmount = 10;
    isLoading = true;
    isPrevButtonDisabled = true;
    isNextButtonDisabled = true;

    connectedCallback() {
        this.handleInit();
    }

    handleInit() {
        getTotalMessagesAmount()
        .then((result) => {
            this.totalMessagesAmount = result;
            this.totalPagesAmount = Math.ceil(this.totalMessagesAmount / this.messagesPerPageAmount);
            this.error = undefined;

            this.callRetrieveMessages();
        })
        .catch((error) => {
            this.error = error;
            this.totalMessagesAmount = undefined;

            const event = new ShowToastEvent({
                title: 'Error',
                message: 'There was an error loading component',
                variant: 'error',
            });
            this.dispatchEvent(event);
        })
    }

    callRetrieveMessages() {
        this.isLoading = true;
        this.disableOrEnablePrevAndNexButtons();

        retrieveMessages({ 'datasetNumber': this.datasetNumber })
            .then(result => {
                this.messages = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.messages = undefined;

                const event = new ShowToastEvent({
                    title: 'Error',
                    message: 'There was an error retrieving messages',
                    variant: 'error',
                });
                this.dispatchEvent(event);
            })
            .finally(() => {
                this.isLoading = false;
            })
    }

    disableOrEnablePrevAndNexButtons() {
        if (this.totalPagesAmount > this.pageNumber) {
            this.isNextButtonDisabled = false;
        } else {
            this.isNextButtonDisabled = true;
        }

        if (this.pageNumber > 1) {
            this.isPrevButtonDisabled = false;
        } else {
            this.isPrevButtonDisabled = true;
        }
    }

    handlePrevPageNav() {
        this.pageNumber--;
        this.datasetNumber--;
        this.callRetrieveMessages();
    }

    handleNextPageNav() {
        this.pageNumber++;
        this.datasetNumber++;
        this.callRetrieveMessages();
    }

    handleOpenMessageDetailsInputModal() {
        MessageDetailsInputModal.open({
            size: 'small',
            onsendmessage: (event) => {
                event.stopPropagation();
                this.handleSendMessage(event.detail);
            }
        });
    }

    handleSendMessage(messageInfo) {
        this.callSendMessage(messageInfo);
    }

    callSendMessage(messageInfo) {
        sendMessage({ 'serializedMessageInfo': JSON.stringify(messageInfo) })
            .then(() => {
                const event = new ShowToastEvent({
                    title: 'Success',
                    message: 'Message sent successfully',
                    variant: 'success',
                });
                this.dispatchEvent(event);
            })
            .catch(() => {
                const event = new ShowToastEvent({
                    title: 'Error',
                    message: 'There was an error sending message',
                    variant: 'error',
                });
                this.dispatchEvent(event);
            })
    }
}
import { LightningElement, track, wire } from 'lwc';
import {publish ,subscribe, MessageContext } from 'lightning/messageService';
import MESSAGE_CHANNEL from '@salesforce/messageChannel/ComponentCommunicationChannel__c';

export default class MessangerB extends LightningElement {
    
    @wire(MessageContext)
    messageContext;

    subscription = null;
    recievedMessage = ' No message recieved yet';

    connectedCallback(){
        if(!this.subscription){
            this.subscription = subscribe(
                this.messageContext,
                MESSAGE_CHANNEL,
                (payload) => this.handleMessage(payload)
            );
        }
    }

    handleMessage(payload){
        if(payload.message){
            this.recievedMessage = ' '+ payload.message;
        }            
    }

    handleButton(){
        const msgInput = this.template.querySelector('lightning-input').value;   //
        const payload ={messageb: msgInput};
        publish(this.messageContext, MESSAGE_CHANNEL, payload);
    }
}
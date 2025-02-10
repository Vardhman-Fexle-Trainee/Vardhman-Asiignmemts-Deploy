import { LightningElement, wire } from 'lwc';
import { publish, subscribe, MessageContext } from 'lightning/messageService';
import MESSAGE_CHANNEL from '@salesforce/messageChannel/ComponentCommunicationChannel__c';

export default class MessangerA extends LightningElement {

    @wire(MessageContext)
    messageContext;    
    subscription =  null;
    aRecievedMessage = ' No message recieved yet';

    connectedCallback(){
        if(!this.subscription){
            this.subscription = subscribe(
                this.messageContext,
                MESSAGE_CHANNEL,
                (payload)=> this.handlemessageb(payload)
            );
        }
    }

    handlemessageb(payload){
        if(payload.messageb){
            this.aRecievedMessage = ' ' + payload.messageb;
        }        
    }

    handleButtonClick() {
        const msgInput = this.template.querySelector('lightning-input').value;
        const payload = {message: msgInput};    
        publish(this.messageContext, MESSAGE_CHANNEL, payload);        
    }
}
import { LightningElement,api, wire, track } from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';

export default class GenericPicklistComponent extends LightningElement {

    @api objectName ;
    @api fieldName ;

    @track picklistOption= [{ label: '--None--', value: '' }];
    @track value = '';

    @wire(getObjectInfo, { objectApiName: '$objectName' })
    objectInfo;

    @wire(getPicklistValues, {
        recordTypeId: '$objectInfo.data.defaultRecordTypeId',
        fieldApiName: '$fieldName',
    })
    picklistValues({ data, error }) {
        if (data) {
            this.picklistOption = [
                { label: '--None--', value: '' },
                ...data.values.map(item => ({ label: item.label, value: item.value }))
            ];
            console.log('this.picklistOption',JSON.stringify(this.picklistOption));
            console.log('objectInfo.data.defaultRecordTypeId',JSON.stringify(this.objectInfo.data.defaultRecordTypeId));

        } else if (error) {
        }
    }

    handleChange(event) {

        this.value = event.target.value;
        const selectEvent = new CustomEvent('selectedvalue', {
            detail: this.value
        });
        var result = this.dispatchEvent(selectEvent);        
       
    }
}
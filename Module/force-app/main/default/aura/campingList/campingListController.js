({
    doInit: function(component, event, helper) {
        let action = component.get('c.getItems');
        
        action.setCallback(this, function (response) {
            let state = response.getState();
            if(state === 'SUCCESS') {
                component.set('v.items', response.getReturnValue());
            } else {
                console.log(`Failed. State: ${state}`); 
            }
        });
        
        $A.enqueueAction(action);
    },
    clickCreateItem : function(component, event, helper) {
        
        const validInput = component.find('campingitemform').reduce(function(valid, inputComponent) {
            inputComponent.showHelpMessageIfInvalid();
            return valid && inputComponent.get('v.validity').valid;
        }, true);
        
        if(validInput) {                   
            let item = component.get('v.newItem');

 			helper.createItem(component, item);
            
            // Reset newItem value
            component.set('v.newItem', {'sobjectType': 'Camping_Item__c','Quantity__c': 0,'Price__c': 0});
        }
    }
})
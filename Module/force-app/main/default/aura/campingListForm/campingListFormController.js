({
    clickCreateItem : function(component, event, helper) {
        const validInput = component.find('campingitemform').reduce(function(valid, inputComponent) {
            inputComponent.showHelpMessageIfInvalid();
            return valid && inputComponent.get('v.validity').valid;
        }, true);
        
        if(validInput) {   
            console.log('input valid');
            const item = component.get('v.newItem');
            
            // Call helper function
            helper.createItem(component, item);          
        }
    }
})
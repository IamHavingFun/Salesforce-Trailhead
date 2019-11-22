({
    createItem: function(component, item) {
        console.log('create item');
        
        // Fire event 
        const addItemEvent = component.getEvent('addItem');
        addItemEvent.setParams({
            'item': item
        });
        addItemEvent.fire();
        
        // Reset form
        component.set('v.newItem', {'sobjectType': 'Camping_Item__c','Quantity__c': 0,'Price__c': 0});           
    } 
})
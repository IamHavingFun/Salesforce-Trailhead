({
    doInit: function(component, event, helper) {
        console.log('update list');
        const action = component.get('c.getItems');
        
        action.setCallback(this, function (response) {
            const state = response.getState();
            if(state === 'SUCCESS') {
                component.set('v.items', response.getReturnValue());
            } else {
                console.log(`Failed. State: ${state}`); 
            }
        });

        $A.enqueueAction(action);
    }, 
    handleAddItem: function(component, event, helper) {
        console.log('handle add item');
        // Save record to database and add to items value provider
       	const newItem = event.getParam('item');
        
        const action = component.get('c.saveItem');
        action.setParams({
            'item': newItem
        }); 
        action.setCallback(this, function (response)  {
            let state = response.getState();
            if(state === 'SUCCESS') {
                console.log('item saved');
                let items = component.get('v.items');
                items.push(response.getReturnValue());
                component.set('v.items', items);                              
            } else {
                console.log(`Failed. State: ${state}`); 
            }
        });

        $A.enqueueAction(action);
    }
})
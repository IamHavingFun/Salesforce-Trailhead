({
	packItem: function(component, event, helper) {
		let button = event.getSource();
        button.set('v.disabled', true);
        component.set('v.item.Packed__c', true);
	}
})
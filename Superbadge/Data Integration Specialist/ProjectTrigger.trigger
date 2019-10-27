trigger ProjectTrigger on Project__c (before update) {
    if(!System.isFuture()) {
        List<Id> projectIds = new List<Id>();
        Map<Id, Project__c> oldProjects = Trigger.oldMap;
        Map<Id, Project__c> updatedProjects = Trigger.newMap;
        
        //Filter out projects that already has a status of billable
        for(Id key : oldProjects.keySet()) {
            if(oldProjects.get(key).Status__c != 'Billable' && updatedProjects.get(key).status__c == 'Billable') {
                projectIds.add(key);  
                updatedProjects.get(key).Status__c = 'Billed';
            }
        }
        
        BillingCalloutService.callBillingService(projectIds); 
    }
}
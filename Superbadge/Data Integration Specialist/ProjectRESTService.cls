//Inbound call: https://<instance>.salesforce.com/services/apexrest/project
@RestResource(urlMapping='/project/*')
global with sharing class ProjectRESTService {
    //Implement service logic here
    @HttpPost
    global static String postProjectData(
    	String ProjectRef,
        String ProjectName,
        String OpportunityId,
        Date StartDate,
        Date EndDate,
        Double Amount,
        String Status
    ) {
        Savepoint savePoint = Database.setSavepoint();     
        //Create or update project record
        try {
            Project__c project = new Project__c(
                ProjectRef__c=ProjectRef, //External Id
                Opportunity__c=OpportunityId,  
                Name=ProjectName,
                Start_Date__c=StartDate,
                End_Date__c=EndDate,
                Billable_Amount__c=Amount,
            	Status__c=Status);
            upsert project ProjectRef__c; //Upsert against external Id
            
            Opportunity opportunity = new Opportunity(
                Id=OpportunityId, 
                DeliveryInstallationStatus__c='In Progress');
            update opportunity;
            return 'OK';
        } catch (Exception error){
            Database.rollback(savePoint);
            return error.getMessage();
        }   
    }
}
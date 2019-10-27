public class BillingCalloutService {
    @future(callout=true)
    public static void callBillingService(List<Id> projectIds) {
       	BillingServiceProxy.InvoicesPortSoap11 service = new BillingServiceProxy.InvoicesPortSoap11();
        String username = ServiceCredentials__c.getValues('BillingServiceCredential').Username__c;
        String password = ServiceCredentials__c.getValues('BillingServiceCredential').Password__c;
        List<Project__c> projects = [
            SELECT ProjectRef__c, Billable_Amount__c
            FROM Project__c
            WHERE Id IN :projectIds
        ];
        
        for(Project__c project : projects) {
            BillingServiceProxy.project billingProject = new BillingServiceProxy.project();
            billingProject.username = username;
            billingProject.password = password;
            billingProject.projectid = project.ProjectRef__c;
            billingProject.billAmount = project.Billable_Amount__c;
         	String responseStatus = service.billProject(billingProject);
            //If outbound call is successful, update project
        	if(responseStatus == 'OK') {
            	project.Status__c = 'Billed';
        	}           
        }
        
        update projects;
    }
}
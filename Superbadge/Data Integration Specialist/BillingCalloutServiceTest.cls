@isTest
private class BillingCalloutServiceTest {
    private static Id setup() {
        Opportunity opportunity = new Opportunity(
        	CloseDate=Date.today(),
            Name='Test Opportunity',
            StageName='Closed Won'
        );
        insert opportunity;
        
        Project__c project = new Project__c(
        	Opportunity__c=opportunity.Id,
            ProjectRef__c='externalId',
            Status__c='Running'
        );
        insert project;
		
        //Create Custom Settings
        ServiceCredentials__c credentials = new ServiceCredentials__c(
        	Name='BillingServiceCredential',
            Username__c='user1',
            Password__c='pass1'
        );
        insert credentials;
        
        return project.Id;
    }
    
    @isTest static void testBillingCalloutTrigger() {
        Id projectId = setup();    
		Project__c project = [
            SELECT Status__c
            FROM Project__c
            Where Id = :projectId
        ][0];   
        
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());
        Test.startTest();
        project.Status__c = 'Billable';
        update project;
        Test.stopTest();
        
		String currentStatus = [
            SELECT Status__c
            FROM Project__c
            Where Id = :projectId
        ][0].Status__c;    
		     
        System.assertEquals('Billed', currentStatus);        
    }
    
    @isTest static void testBillingCalloutService() {
        Id projectId = setup();
		List<Id> projectIds = new List<Id>();
        projectIds.add(projectId);
        
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());
        Test.startTest();
		BillingCalloutService.callBillingService(projectIds);
        Test.stopTest();
        
		String currentStatus = [
            SELECT Status__c
            FROM Project__c
            Where Id = :projectId
        ][0].Status__c;    
		     
        System.assertEquals('Billed', currentStatus);
    }
    
    @isTest static void testBillingCalloutServiceFailure() {
        Id projectId = setup();
		List<Id> projectIds = new List<Id>();
        projectIds.add(projectId);
        
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMockFailure());
        Test.startTest();
		BillingCalloutService.callBillingService(projectIds);
        Test.stopTest();
        
		String currentStatus = [
            SELECT Status__c
            FROM Project__c
            Where Id = :projectId
        ][0].Status__c;    
		     
        System.assertEquals('Running', currentStatus);
    }    
}
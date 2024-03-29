@isTest
private class ProjectCalloutServiceTest {
  //Implement mock callout tests here
    private static Id setup() {
        Account account = new Account(
        	Name='Test Account'    
        );
        insert account;
        
        Opportunity opportunity = new Opportunity( 
            Name='TestOpportunity', 
            AccountId=account.Id, 
            CloseDate=Date.today(), 
            StageName='Closed Won',
            Amount=999
        );
        insert opportunity;
        
        //Create Custom Settings
        ServiceTokens__c setting = new ServiceTokens__c(
        	Name='ProjectServiceToken',
            Token__c = 'TestToken'
        );
        insert setting;
        
        return opportunity.Id;
    }
    
    @isTest static void testProjectCallout() {
      	Id opportunityId = setup();
        List<Id> opportunityIds = new List<Id>();
        opportunityIds.add(opportunityId);
        
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock());
        Test.startTest();
		ProjectCalloutService.PostOpportunityToPMS(opportunityIds);
        Test.stopTest();
        
        String currentStage = [SELECT StageName FROM Opportunity WHERE Id = :opportunityId][0].StageName;
        System.assertEquals(currentStage, 'Submitted Project');
    }
    
    @isTest static void testProjectCalloutFailure() {
      	Id opportunityId = setup();
        List<Id> opportunityIds = new List<Id>();
        opportunityIds.add(opportunityId);
        
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMockFailure());
        Test.startTest();
		ProjectCalloutService.PostOpportunityToPMS(opportunityIds);
        Test.stopTest();
        
        String currentStage = [
            SELECT StageName 
            FROM Opportunity 
            WHERE Id = :opportunityId][0].StageName;
        System.assertEquals(currentStage, 'Resubmit Project');        
    }
}
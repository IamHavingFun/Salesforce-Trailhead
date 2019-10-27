@isTest
private class ProjectRESTServiceTest {
    @isTest static void testRESTService() {
        Opportunity opportunity = new Opportunity(
        	CloseDate=Date.today(),
            Name='Test Opportunity',
            StageName='Closed Won'
        );
        insert opportunity;
        
        Test.startTest();
        ProjectRESTService.postProjectData(
            'extRef', 
            'name', 
            opportunity.Id, 
            date.today(), 
            date.today(), 
            999,
            'Running');
        Test.stopTest();
        List<Project__c> projects = [
            SELECT ProjectRef__c
        	FROM Project__c
        	WHERE ProjectRef__c = 'extRef'];
        System.assertEquals(projects.size(), 1);
    }
    @isTest static void testRESTServiceFailure() {      
        Test.startTest();
        ProjectRESTService.postProjectData(
            'extRef', 
            'name', 
            'Invalid Id', //Invalid opportunity Id to enter catch block 
            date.today(), 
            date.today(), 
            999,
            'Running');
        Test.stopTest();
        List<Project__c> projects = [
            SELECT ProjectRef__c
        	FROM Project__c
        	WHERE ProjectRef__c = 'extRef'];
        System.assertEquals(projects.size(), 0);
    }    
}
@IsTest
private class InstallationTests {
    @isTest static void testPositiveMaintenanceRequest() { 	
        List<Case> requests = TestDataHelper.populate('Working');
        Integer updatedRequestCount = requests.size();
        
        Test.startTest();     
        for(Case request : requests) {
            request.Status = 'Closed';
        }
        update requests;
        Test.stopTest();

        Integer newRequestCount = [SELECT Id FROM Case WHERE Status = 'New'].size();
        System.assertEquals(updatedRequestCount, newRequestCount, 'Maintenance Request should be created.');
    }
    
     @isTest static void testNegativeMaintenanceRequest() {
        List<Case> requests = TestDataHelper.populate('Closed');  
        
        //Status is already closed, no request should be created
        Test.startTest();     
        for(Case request : requests) {
            request.Description = 'Test Comment';
        }
        update requests;
        Test.stopTest();
        
        Integer newRequestCount = [SELECT Id FROM Case WHERE Status = 'New'].size();        
        System.assertEquals(0, newRequestCount, 'No new Maintenance Request should be created.');
    }
}
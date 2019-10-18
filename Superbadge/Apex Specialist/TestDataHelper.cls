@isTest
public class TestDataHelper {
    public static List<Case> populate(String status) {   
   		Integer requestCount = 300;
    	Integer equipmentCount = 2;      
        
        Vehicle__c vehicle = new Vehicle__c();
        vehicle.Name = 'Test Vehicle';
        insert vehicle;
        
        List<Product2> equipments = new List<Product2>();
        for(Integer i = 0; i < equipmentCount; i++) {
            Product2 equipment = new Product2();
            equipment.Name = 'Test Equipment ' + i;
            equipment.Replacement_Part__c = true;
            equipment.Maintenance_Cycle__c = i + 1;
            equipment.Warehouse_SKU__c = '100000';
            equipments.add(equipment);
        }
        insert equipments;
        
        List<Case> requests = new List<Case>();
        for(Integer j = 0; j < requestCount; j++) {
            Case request = new Case();
            request.Description = 'Test Maintenance ' + j;
            request.Type = 'Routine Maintenance';
            request.Status = status;
            request.Vehicle__c = vehicle.Id;           
            requests.add(request);
        }
        insert requests;
        
        List<Work_Part__c> workParts = new List<Work_Part__c>();
        for(Product2 equipment : equipments) {
            for(Case request : requests) {
                Work_Part__c workPart = new Work_Part__c();
                workPart.Maintenance_Request__c = request.Id;
                workPart.Equipment__c = equipment.Id;
                workParts.add(workPart);
            }
        }        
        insert workParts;
        
        return requests;
    }
}
/*Write a class that makes a REST callout to an external warehouse system to get a list of equipment that needs to be updated. 
 * The callout’s JSON response returns the equipment records that you upsert in Salesforce. 
 * Beyond inventory, you also ensure that other potential warehouse changes carry over to Salesforce. 
 * Your class maps the following fields: replacement part (always true), cost, current inventory, lifespan, maintenance cycle, and warehouse SKU. 
 * Use the warehouse SKU as the external ID to identify which equipment records to update within Salesforce.
*/

public with sharing class WarehouseCalloutService {
    public class WarehouseEquipment {
        public Boolean replacement;
        public Integer quantity;
        public String name;
        public Integer maintenanceperiod;
        public Integer lifespan;
        public Integer cost;
        public String sku;
    }
    
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200) {
            List<WarehouseEquipment> warehouseEquipments = (List<WarehouseEquipment>)JSON.deserialize(response.getBody(), List<WarehouseEquipment>.class);
            List<Product2> updatedEquipments = new List<Product2>();
            for(WarehouseEquipment warehouseEquipment : warehouseEquipments) {
                //Update replacement part, cost, current inventory, lifespan, maintenance cycle, and warehouse SKU
                List<Product2> equipments = [
                	SELECT Replacement_Part__c, Cost__c, Current_Inventory__c, Lifespan_Months__c, Maintenance_Cycle__c, Warehouse_SKU__c 
                    FROM Product2
                    WHERE Warehouse_SKU__c = :warehouseEquipment.sku];
                Product2 equipment = new Product2();
                equipment.Warehouse_SKU__c = warehouseEquipment.sku;
                
                if(equipments.size() > 0) {
                    equipment = equipments[0];
                }
                
                equipment.Name = warehouseEquipment.name;
                equipment.Replacement_Part__c = true; //Always true
                equipment.Cost__c = warehouseEquipment.cost;
                equipment.Current_Inventory__c = warehouseEquipment.quantity;
                equipment.Lifespan_Months__c = warehouseEquipment.lifespan;
                equipment.Maintenance_Cycle__c = warehouseEquipment.maintenanceperiod;
                updatedEquipments.add(equipment);
            }
            
            if(updatedEquipments.size() > 0) {
                upsert updatedEquipments;
            }
        }
    }
}
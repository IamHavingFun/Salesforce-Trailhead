/* When an existing maintenance request(Case) of type Repair or Routine Maintenance is Closed, 
* you create a new maintenance request for a future routine checkup. 
* This new request is tied to the same vehicle and piece of equipment to be serviced as the original closed service request.
* This new request's Type should be set as Routine Maintenance. 
* The Subject should not be null and the Report Date field reflects the day the request was created. 
* Another aspect about parts is they all have different lifespans. 
* Therefore, you need to calculate and set the next due date using the maintenance cycle defined on the related work part records. 
* If multiple work parts are used in the maintenance request, choose the shortest maintenance cycle to define the service date.
*/

//Find out which request status is not already 'Closed' before updated
public class MaintenanceRequestHelper {
    public static void updateWorkOrders(List<Case> oldRequests, List<Case> updatedRequests){
        Set<Id> requestIds = new Set<Id>();
        
        for(Case oldRequest : oldRequests) { 
            //Only request maintenance if the status of maintenance is changed to 'Closed'
            if((oldRequest.Type == 'Repair' || oldRequest.Type == 'Routine Maintenance') &&
               (oldRequest.Status != 'Closed')) {
                   requestIds.add(oldRequest.Id);
               }
        }     
        
        List<Case> requests = new List<Case>();       
        
        List<Work_Part__c> workParts = [
            SELECT Maintenance_Request__r.Id, Equipment__r.Maintenance_Cycle__c 
            FROM Work_Part__c 
            WHERE Maintenance_Request__r.Id IN :requestIds AND Equipment__c != null];
        
        //Map request Id to minimum cycle
        Map<Id, Integer> minCycles = new Map<Id, Integer>(); 
        for(Work_Part__c workPart : workParts) {
            if(workPart.Equipment__r.Maintenance_Cycle__c != null) {
                if(!minCycles.containsKey(workPart.Maintenance_Request__c) || //If map does not contains key or
                   (minCycles.get(workPart.Maintenance_Request__c) > workPart.Equipment__r.Maintenance_Cycle__c)) { //Current cycle is more
                    minCycles.put(workPart.Maintenance_Request__c, (Integer)workPart.Equipment__r.Maintenance_Cycle__c);
                } 
            }
        }
        
        for(Case updatedRequest : updatedRequests) {        
            if(updatedRequest.Status == 'Closed' && requestIds.contains(updatedRequest.Id)) {
                Case newRequest = new Case();
                newRequest.Status = 'New';
                //Subject is not null
                newRequest.Subject += '(Routine Maintenance)';
                //Same vehicle
                newRequest.Vehicle__c = updatedRequest.Vehicle__c;
                //Same equipment
                newRequest.Equipment__c = updatedRequest.Equipment__c;
                //Type is Routine Maintenance
                newRequest.Type = 'Routine Maintenance';
                //Reported date reflects created date
                newRequest.Date_Reported__c = Date.today();
                
                //Find the shortest maintenance cycle and set next due date
                newRequest.Date_Due__c = Date.today(); 
                if(minCycles.containsKey(updatedRequest.Id)) {
                    Integer cycle = minCycles.get(updatedRequest.Id);
                	newRequest.Date_Due__c = newRequest.Date_Due__c.AddDays(cycle);  
                }
                
                requests.add(newRequest);
            }
        }
        
        //Bulk insert
        if(requests.size() > 0) {
            insert requests;
        }
    }           
}
/*All maintenance requests are processed during HQ’s normal business hours. You need to update Salesforce data during off hours (at 1:00 AM PST). 
 * This logic runs daily so that the inventory is up to date every morning at HQ.
 */
global class WarehouseSyncSchedule implements Schedulable {
    global void execute(SchedulableContext ctx) {
        WarehouseCalloutService.runWarehouseEquipmentSync();
        
        //Schduling Code:
        /*
       	WarehouseSyncSchedule schedule = new WarehouseSyncSchedule();
        String cronExp = '0 0 1 * * ?';
        String jobID = System.schedule('Sync Equipment Info', cronExp, schedule);
        */
	}
}
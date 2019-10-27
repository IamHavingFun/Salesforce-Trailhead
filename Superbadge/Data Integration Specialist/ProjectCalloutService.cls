public class ProjectCalloutService {
    //Complete the implementation for business and callout logic
    //Process will not be called in bulk

    @InvocableMethod
    public static void PostOpportunityToPMS(List<Id> opportunityIds){
        if(opportunityIds.size() > 0) {
            List<Opportunity> opportunities = [
                SELECT Id, Name, AccountId, CloseDate, Amount
            	FROM Opportunity
            	WHERE Id IN :opportunityIds];
			System.enqueueJob(new QueueablePMSCall(opportunities));
        }
    }
    public class QueueablePMSCall implements Queueable, Database.AllowsCallouts {
        private List<Opportunity> opportunities;
        private String token; 
        public QueueablePMSCall(List<Opportunity> opportunities) {
            this.opportunities = opportunities;
            this.token = ServiceTokens__c.getValues('ProjectServiceToken').Token__c;
        }
        
        public void execute(QueueableContext context) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:ProjectService');
            request.setMethod('POST');
            request.setHeader('token', token);
            request.setHeader('Content-Type', 'application/json');     

            for(Opportunity opportunity : opportunities) {
                String requestBody = 
                    '{\"opportunityId\": '+ '\"' + opportunity.Id + '\",' +
                    '\"opportunityName\": ' + '\"' + opportunity.Name  + '\",' +
                    '\"accountName\": ' + '\"' + opportunity.AccountId + '\",' +
                    '\"closeDate\": ' + '\"' + opportunity.CloseDate + '\",' +
                    '\"amount\": ' + opportunity.Amount + '}';
                
                request.setBody(requestBody);      
                HttpResponse response = http.send(request);
                if(response.getStatusCode() == 201) {
                    opportunity.StageName = 'Submitted Project';
                } else if(response.getStatusCode() == 500) {
                    opportunity.StageName = 'Resubmit Project';
                }  
            }
            update opportunities;
        }
    }
}
## Selecting Automation Tool 
### Read [Module](https://trailhead.salesforce.com/en/content/learn/modules/business_process_automation/process_whichtool)
Type of Business Process|Description|Available Tools
---|---|---|
Guided visual experience|Business processes that need input from users, whether they’re employees or customers.|Flow Builder
Behind-the-scenes automation|Business processes that get all the necessary data from your Salesforce org or a connected system. In other words, user input isn’t needed.|Process Builder,Flow Builder,Apex
Approval automation|Business processes that determine how a record, like a time-off request, gets approved by the right stakeholders.|Approvals

## Selecting Asynchronous Apex
### Read [Module](https://trailhead.salesforce.com/en/content/learn/modules/asynchronous_apex/async_apex_introduction)
Type|Overview|Common Scenarios
---|---|---|
Future Methods|Run in their own thread, and do not start until resources are available.|Web service callout.
Batch Apex|Run large jobs that would exceed normal processing limits.|Data cleansing or archiving of records.
Queueable Apex|Similar to future methods, but provide additional job chaining and allow more complex data types to be used.|Performing sequential processing operations with external Web services.
Scheduled Apex|Schedule Apex to run at a specified time.|Daily or weekly tasks.

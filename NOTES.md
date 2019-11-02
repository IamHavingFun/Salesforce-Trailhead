# Notes
Task/Issue|Url|Solution/Code Sample
---|---|---|
Set Named Credentials for APEX Callout|[Link](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_callouts_named_credentials.htm)
Set Request Header|[Link](https://developer.salesforce.com/docs/atlas.en-us.api_tooling.meta/api_tooling/intro_rest_header_examples.htm)
Accessing Custom Settings (Global Constants)|[Link](https://help.salesforce.com/articleView?id=cs_accessing.htm)
Enable Callouts in Batch Apex|[Link](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_batch_interface.htm)
Custom Settings not Accessible in test (NullPointerException de-reference)|[Link](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_seealldata_using.htm)|Use `@isTest(SeeAllData=true)` annotation or create a new Custom Settings in test method then insert
Set savepoint/rollback database|[Link](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/langCon_apex_transaction_control.htm)
Specify external ID with upsert statement to reduce DML calls|[Link](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/langCon_apex_dml_examples_upsert.htm)|`upsert assets Line_Item_ID__c;`
Use `Trigger.newMap and Trigger.oldMap` instead of `Trigger.new` and `Trigger.old` to compare items against Id|[Link](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_triggers_context_variables.htm)
Test Web Service Callouts with WebServiceMock|[Link](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_callouts_wsdl2apex_testing.htm)
Prevent trigger from being called from update with `System.isFuture()`|[Link](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_system.htm)
Use `before update` trigger instead of `after update` since objects in `after update` trigger are read-only|[Link]( https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_System_Trigger.htm)
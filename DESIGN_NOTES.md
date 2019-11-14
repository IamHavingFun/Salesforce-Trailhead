## Selecting Automation Tool

### Read [Module](https://trailhead.salesforce.com/en/content/learn/modules/business_process_automation/process_whichtool)

| Type of Business Process     | Description                                                                                                                                 | Available Tools                   |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------- |
| Guided visual experience     | Business processes that need input from users, whether they’re employees or customers.                                                      | Flow Builder                      |
| Behind-the-scenes automation | Business processes that get all the necessary data from your Salesforce org or a connected system. In other words, user input isn’t needed. | Process Builder,Flow Builder,Apex |
| Approval automation          | Business processes that determine how a record, like a time-off request, gets approved by the right stakeholders.                           | Approvals                         |

## Selecting Asynchronous Apex

### Read [Module](https://trailhead.salesforce.com/en/content/learn/modules/asynchronous_apex/async_apex_introduction)

| Type           | Overview                                                                                                     | Common Scenarios                                                        |
| -------------- | ------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------- |
| Future Methods | Run in their own thread, and do not start until resources are available.                                     | Web service callout.                                                    |
| Batch Apex     | Run large jobs that would exceed normal processing limits.                                                   | Data cleansing or archiving of records.                                 |
| Queueable Apex | Similar to future methods, but provide additional job chaining and allow more complex data types to be used. | Performing sequential processing operations with external Web services. |
| Scheduled Apex | Schedule Apex to run at a specified time.                                                                    | Daily or weekly tasks.                                                  |

## Big Objects

### Read [Module](https://trailhead.salesforce.com/content/learn/modules/big_objects)

Common Scenarios: Transactions, Orders, Billing Information

#### Big Object uses Async SOQL to query database instead of Standard SOQL. Read more [here](https://developer.salesforce.com/docs/atlas.en-us.222.0.bigobjects.meta/bigobjects/async_query_overview.htm)

# Platform Cache

## Read [Module](https://trailhead.salesforce.com/en/content/learn/modules/platform_cache)

| Use Case                                                                         | Common Scenarios                                                        |
| -------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Data that is reused throughout a session or reused across all users and requests | User's shopping card                                                    |
| Static data that does not change often                                           | Public transit schedule, Tab headers, Daily snapshots of exchange rates |
| Data from complex calculations (expensive to compute or retrieve)                | Total of sales over the past week, Top sales ranking                    |

| Task                                                               | Code Sample                                                      |
| ------------------------------------------------------------------ | ---------------------------------------------------------------- |
| Store values in org cache with key (`DollarToEuroRate`)            | `Cache.Org.put('local.CurrencyCache.DollarToEuroRate', '0.91');` |
| Get stored value from org cache (check for `null` if cache exists) | `orgPart.get('DollarToEuroRate');`                               |

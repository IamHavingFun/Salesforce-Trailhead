# Automate Leads
1. Create a validation rule:
  **Setup -> Object Manager -> Lead -> Validation Rules**
1. Create two queues for leads:
  **Setup -> Queue**
1. Create lead assignment rules:
  **Setup -> Lead Assignment Rule**
# Create Robot Setup Object
1. Add account formula fields: 
  **Setup -> Object Manager -> Account -> Fields & Relationships**
1. Create a validation rule:
  **Setup -> Object Manager -> Account -> Validation Rules**
# Create Sales Process and Validate Opportunities
1. Create sales process: 
  **Setup -> Sales Processes**
1. Create email alerts:
  **Setup -> Email Alerts**
1. Assign "Nushi Davoud" to be your manager:
  **Account Icon(Top Right) -> Settings -> Approver Settings**
1. Create Process: 
  **Setup -> Process Builder**
# Create Flow for Opportunities
1. Create flow:
  **Setup -> Flow Builder**
1. Put component in lightning page:
  **Setup -> Lightning App Builder**
## Validation Rule (Country):
 ` NOT(REGEX( Country , "^(United States|USA|US)$|^$"))`
## Validation Rule (State):
 ` NOT(REGEX( State , "^(A[KLRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY])$"))`
## Validation Rule (Opportunity with Amount more than 100K)
 ` AND( Amount > 100000, Approved__c = false)`

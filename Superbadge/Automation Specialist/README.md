# Automate Leads
1. Create a validation rule:
  **Setup -> Object Manager -> Lead -> Validation Rules**
1. Create two queues for leads:
  **Setup -> Queue**
1. Create lead assignment rules:
  **Setup -> Lead Assignment Rule**
# Create Robot Setup Object
1. Create a validation rule:
  **Setup -> Object Manager -> Account -> Validation Rules**
## Validation Rule (Country):
 ` NOT(REGEX( Country , "^(United States|USA|US)$|^$"))`
## Validation Rule (State):
 ` NOT(REGEX( State , "^(A[KLRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY])$"))`

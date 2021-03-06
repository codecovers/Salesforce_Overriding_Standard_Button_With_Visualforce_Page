global with sharing class AccountOverrideController {

    private final Account ACCOUNT;

    public AccountOverrideController (ApexPages.StandardController controller) {
        this.ACCOUNT = (Account)controller.getRecord();
    }

    public PageReference save() {
        try {
            ACCOUNT.type = 'Pending';
            upsert ACCOUNT;
            return new ApexPages.StandardController(ACCOUNT).view();
        }
        catch(Exception e) {
            System.debug('Error message at NewAccountController ' + e.getMessage() + ' Line: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, e.getMessage()));
            return null;
        }
    }
    
    @AuraEnabled
    public static void saveAccount(Account accRec) {
        upsert accRec;
    }
}
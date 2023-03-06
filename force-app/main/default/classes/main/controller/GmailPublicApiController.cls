public with sharing class GmailPublicApiController {
    @AuraEnabled
    public static Integer getTotalMessagesAmount() {
        try {
            GmailPublicApiService service = new GmailPublicApiService();
            return service.getTotalMessagesAmount();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Custom_Email_Message__c> retrieveMessages(Integer datasetNumber) {
        try {
            GmailPublicApiService service = new GmailPublicApiService();
            return service.retrieveMessageRecords(datasetNumber);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void sendMessage(String serializedMessageInfo) {
        try {
            GmailPublicApiService service = new GmailPublicApiService();
            service.sendMessage(serializedMessageInfo);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
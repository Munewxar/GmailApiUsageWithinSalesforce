public with sharing class GmailPublicApiController {
	@TestVisible
	private static GmailPublicApiService service = new GmailPublicApiService();

	@AuraEnabled
	public static Integer getTotalMessagesAmount() {
		try {
			return service.getTotalMessagesAmount();
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<Custom_Email_Message__c> retrieveMessages(Integer datasetNumber) {
		try {
			return service.retrieveMessageRecords(datasetNumber);
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static void sendMessage(String serializedMessageInfo) {
		try {
			service.sendMessage(serializedMessageInfo);
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}
}

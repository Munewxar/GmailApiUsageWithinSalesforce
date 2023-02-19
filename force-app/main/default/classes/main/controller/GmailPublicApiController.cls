public with sharing class GmailPublicApiController {
	@AuraEnabled
	public static List<MessageDto> retrieveMessages() {
		List<MessageDto> messageDtos;

		System.debug('call controller');

		try {
			GmailPublicApiService service = new GmailPublicApiService();
			messageDtos = service.retrieveMessages();
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}

		return messageDtos;
	}

	@AuraEnabled
	public static List<Custom_Email_Message__c> retrieveMessages(Integer pageNumber) {
		try {
			Integer offset = pageNumber * 50;
			return CustomEmailMessageSelector.selectMessagesWithOffset(offset);
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}
}

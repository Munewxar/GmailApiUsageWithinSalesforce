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
}

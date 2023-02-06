public with sharing class GmailPublicApiService {
	private static final Integer MAX_MESSAGES_AMOUNT = 10;

	GmailPublicApiCalloutExecutor calloutExecutor;
	GmailJsonParser parser;

	public GmailPublicApiService() {
		calloutExecutor = new GmailPublicApiCalloutExecutor();
		parser = new GmailJsonParser(MAX_MESSAGES_AMOUNT);
	}

	public List<MessageDto> retrieveMessages() {
		List<MessageDto> messageDtos = new List<MessageDto>();
		// TODO: check lists size

		String messageIdsResponse = calloutExecutor.retrieveMessageIds();
		List<String> messageIds = parser.parseMessageIds(messageIdsResponse);

		for (String messageId : messageIds) {
			String messageResponse = calloutExecutor.retrieveMessageById(messageId);

			MessageDto dto = parser.parseMessage(messageResponse);
			messageDtos.add(dto);
		}

		return messageDtos;
	}
}

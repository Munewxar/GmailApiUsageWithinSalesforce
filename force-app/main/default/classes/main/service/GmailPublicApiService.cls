public with sharing class GmailPublicApiService {
	private static final Integer MAX_MESSAGES_AMOUNT = 99;
	private static final String HEADER_SUBJECT = 'Subject';
	private static final String HEADER_FROM = 'From';
	private static final String PART_ID = '0';

	GmailPublicApiCalloutExecutor calloutExecutor;
	GmailJsonParser parser;

	public GmailPublicApiService() {
		calloutExecutor = new GmailPublicApiCalloutExecutor();
		parser = new GmailJsonParser(MAX_MESSAGES_AMOUNT);
	}

	public void processEmails() {
		List<MessageDto> messageDtoList = retrieveMessages();
		List<Custom_Email_Message__c> messageRecords = createCustomEmailMessageRecords(
			messageDtoList
		);

		Database.insert(messageRecords, false);
	}

	private List<MessageDto> retrieveMessages() {
		List<MessageDto> messageDtoList = new List<MessageDto>();
		// TODO: check lists size

		String messageIdsResponse = calloutExecutor.retrieveMessageIds();
		List<String> messageIds = parser.parseMessageIds(messageIdsResponse);

		for (String messageId : messageIds) {
			String messageResponse = calloutExecutor.retrieveMessageById(messageId);

			MessageDto dto = MessageDto.parse(messageResponse);
			messageDtoList.add(dto);
		}

		return messageDtoList;
	}

	private List<Custom_Email_Message__c> createCustomEmailMessageRecords(
		List<MessageDto> messageDtoList
	) {
		List<Custom_Email_Message__c> messagesList = new List<Custom_Email_Message__c>();

		for (MessageDto dto : messageDtoList) {
			Custom_Email_Message__c message = new Custom_Email_Message__c();
			message.Message_Id__c = dto.id;

			for (MessageDto.Headers header : dto.payload.headers) {
				if (header.name == HEADER_SUBJECT) {
					message.Subject__c = header.value;
				} else if (header.name == HEADER_FROM) {
					message.Sender_Name__c = parser.parseSenderName(header.value);
					message.Sender_Email__c = parser.parseSenderEmail(header.value);
				}
			}

			if (dto.payload.parts != null) {
				for (MessageDto.Parts part : dto.payload.parts) {
					if (part.partId == PART_ID) {
						message.Message_Text__c = parser.decodeMessage(part.body.data);
						break;
					}
				}
			}

			messagesList.add(message);
		}

		return messagesList;
	}
}

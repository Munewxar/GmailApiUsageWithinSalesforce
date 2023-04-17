public with sharing class GmailPublicApiService {
	private static final Integer MAX_MESSAGES_AMOUNT = 99;
	private static final String HEADER_SUBJECT = 'Subject';
	private static final String HEADER_FROM = 'From';
	private static final String PART_ID = '0';
	private static final Integer SUCCESS_STATUS_CODE = 200;

	@TestVisible
	private CustomEmailMessageSelector selector;
	@TestVisible
	private GmailPublicApiCalloutExecutor calloutExecutor;

	private GmailJsonParser parser;

	public GmailPublicApiService() {
		selector = new CustomEmailMessageSelector();
		calloutExecutor = new GmailPublicApiCalloutExecutor();
		parser = new GmailJsonParser(MAX_MESSAGES_AMOUNT);
	}

	public Integer getTotalMessagesAmount() {
		return selector.selectMessagesCount();
	}

	public void sendMessage(String serializedMessageInfo) {
		if (serializedMessageInfo == null) {
			throw new ContractViolationException('Incoming parameters must not be null');
		}

		Map<String, Object> messageInfo = (Map<String, Object>) JSON.deserializeUntyped(
			serializedMessageInfo
		);

		Integer statusCode = calloutExecutor.sendMessage(messageInfo);

		if (statusCode != SUCCESS_STATUS_CODE) {
			throw new GmailCalloutException('There was an error sending message');
		}
	}

	public List<Custom_Email_Message__c> retrieveMessageRecords(Integer datasetNumber) {
		if (datasetNumber == null) {
			throw new ContractViolationException('Incoming parameters must not be null');
		}

		Integer messagesLimit = 10;
		Integer offset = datasetNumber * 10;

		return selector.selectMessagesWithOffset(messagesLimit, offset);
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

		List<String> messageIds = retrieveAndFilterMessageIds();

		for (String messageId : messageIds) {
			String messageResponse = calloutExecutor.retrieveMessageById(messageId);

			MessageDto dto = MessageDto.parse(messageResponse);
			messageDtoList.add(dto);
		}

		return messageDtoList;
	}

	private List<String> retrieveAndFilterMessageIds() {
		String messageIdsResponse = calloutExecutor.retrieveMessageIds();
		List<String> messageIds = parser.parseMessageIds(messageIdsResponse);
		List<String> filteredMessageIds = filterExistingMessageIds(messageIds);

		return filteredMessageIds;
	}

	private List<String> filterExistingMessageIds(List<String> messageIds) {
		Integer messagesToSelectAmount = 100;
		List<Custom_Email_Message__c> messageRecords = selector.selectLastMessages(
			messagesToSelectAmount
		);

		List<String> filteredMessageIds = new List<String>();

		for (String messageIdFromResponse : messageIds) {
			Boolean isExistingId = false;

			for (Custom_Email_Message__c message : messageRecords) {
				if (messageIdFromResponse.equals(message.Message_Id__c)) {
					isExistingId = true;
				}
			}

			if (!isExistingId) {
				filteredMessageIds.add(messageIdFromResponse);
			}
		}

		return filteredMessageIds;
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

	public class GmailCalloutException extends Exception {
	}

	public class ContractViolationException extends Exception {
	}
}

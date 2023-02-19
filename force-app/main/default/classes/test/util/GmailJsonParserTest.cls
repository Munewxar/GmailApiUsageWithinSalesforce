@isTest
public with sharing class GmailJsonParserTest {
	private static final Integer MAX_MESSAGES_AMOUNT = 2;

	@isTest
	private static void parseMessageIdsShouldReturnValidMessageIdsWhenValidJsonPassed() {
		GmailJsonParser parser = new GmailJsonParser(MAX_MESSAGES_AMOUNT);

		List<String> parsedMessageIds = parser.parseMessageIds(
			JsonResponsesContainer.MESSAGE_IDS_RESPONSE
		);

		Assert.isTrue(
			parsedMessageIds.size() == MAX_MESSAGES_AMOUNT,
			'Should return list with valid size'
		);
		Assert.areEqual(
			JsonResponsesContainer.parsedMessageIds,
			parsedMessageIds,
			'Should correctly parse message Ids'
		);
	}

	@isTest
	private static void parseMessageShouldReturnValidMessageDtoWhenValidJsonPassed() {
		GmailJsonParser parser = new GmailJsonParser(MAX_MESSAGES_AMOUNT);

		MessageDto parsedMessage = parser.parseMessage(JsonResponsesContainer.MESSAGE_RESPONSE);

		Assert.areEqual(
			JsonResponsesContainer.parsedMessage.id,
			parsedMessage.id,
			'Should correctly parse id'
		);

		// Assert.areEqual(
		// 	JsonResponsesContainer.parsedMessage.fromValue,
		// 	parsedMessage.fromValue,
		// 	'Should correctly parse from value'
		// );

		// Assert.areEqual(
		// 	JsonResponsesContainer.parsedMessage.subjectValue,
		// 	parsedMessage.subjectValue,
		// 	'Should correctly parse subject value'
		// );

		// Assert.areEqual(
		// 	JsonResponsesContainer.parsedMessage.messageValue,
		// 	parsedMessage.messageValue,
		// 	'Should correctly parse message value'
		// );
	}
}

@IsTest
private class GmailJsonParserTest {
	private static final Integer MAX_MESSAGES_AMOUNT = 2;

	@IsTest
	private static void parseMessageIdsShouldReturnValidMessageIdsWhenValidJsonPassed() {
		GmailJsonParser parser = new GmailJsonParser(MAX_MESSAGES_AMOUNT);

		List<String> actualParsedMessageIds = parser.parseMessageIds(
			JsonResponsesContainer.MESSAGE_IDS_RESPONSE
		);

		Assert.isTrue(
			actualParsedMessageIds.size() == JsonResponsesContainer.parsedMessageIds.size(),
			'Should return list with valid size'
		);

		Set<String> expectedParsedMessageIds = new Set<String>(
			JsonResponsesContainer.parsedMessageIds
		);

		Assert.isTrue(
			expectedParsedMessageIds.containsAll(actualParsedMessageIds),
			'Should return correctly parsed Ids'
		);
	}

	@IsTest
	private static void decodeMessageShouldCorrectlyDecodeMessage() {
		GmailJsonParser parser = new GmailJsonParser(MAX_MESSAGES_AMOUNT);

		String encodedMessage = 'VGVzdCENCg==';
		String expectedDecodedMessage = 'Test!';

		String actualDecodedMessage = parser.decodeMessage(encodedMessage);

		Assert.areEqual(
			expectedDecodedMessage,
			actualDecodedMessage,
			'Should correctly decode message'
		);
	}

	@IsTest
	private static void decodeMessageShouldReturnEmptyStringWhenNullPassed() {
		GmailJsonParser parser = new GmailJsonParser(MAX_MESSAGES_AMOUNT);

		String decodedMessage = parser.decodeMessage(null);

		Assert.areEqual('', decodedMessage, 'Should return an empty string when null passed');
	}

	@IsTest
	private static void parseSenderNameShouldCorrectlyParseSenderName() {
		GmailJsonParser parser = new GmailJsonParser(MAX_MESSAGES_AMOUNT);

		String sender = 'Mike Tyson <mike.tyson@gmail.com>';
		String expectedSenderName = 'Mike Tyson';

		String actualSenderName = parser.parseSenderName(sender);

		Assert.areEqual(expectedSenderName, actualSenderName, 'Should correctly parse sender name');
	}

	@IsTest
	private static void parseSenderNameShouldReturnEmptyStringWhenNullPassed() {
		GmailJsonParser parser = new GmailJsonParser(MAX_MESSAGES_AMOUNT);

		String senderName = parser.parseSenderName(null);

		Assert.areEqual('', senderName, 'Should return an empty string when null passed');
	}

	@IsTest
	private static void parseSenderEmailShouldCorrectlyParseSenderEmail() {
		GmailJsonParser parser = new GmailJsonParser(MAX_MESSAGES_AMOUNT);

		String sender = 'Mike Tyson <mike.tyson@gmail.com>';
		String expectedSenderEmail = 'mike.tyson@gmail.com';

		String actualSenderEmail = parser.parseSenderEmail(sender);

		Assert.areEqual(
			expectedSenderEmail,
			actualSenderEmail,
			'Should correctly parse sender name'
		);
	}

	@IsTest
	private static void parseSenderEmailShouldReturnEmptyStringWhenNullPassed() {
		GmailJsonParser parser = new GmailJsonParser(MAX_MESSAGES_AMOUNT);

		String senderEmail = parser.parseSenderEmail(null);

		Assert.areEqual('', senderEmail, 'Should return an empty string when null passed');
	}
}

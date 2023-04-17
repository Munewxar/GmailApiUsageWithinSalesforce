@IsTest
private class CustomEmailMessageSelectorTest {
	@TestSetup
	private static void generateMessages() {
		List<Custom_Email_Message__c> messages = new List<Custom_Email_Message__c>();

		for (Integer i = 0; i < 20; i++) {
			Custom_Email_Message__c message = new Custom_Email_Message__c();
			message.Message_Id__c = 'Test' + i;
			message.Message_Text__c = 'Test Text';
			message.Sender_Email__c = 'test' + i + '@email.com';
			message.Sender_Name__c = 'Test Test';
			message.Subject__c = 'Test Subject';

			messages.add(message);
		}

		insert messages;
	}

	@IsTest
	private static void selectMessagesCountShouldReturnCorrectNumberOfMessages() {
		Integer totalMessagesAmount = 20;

		Test.startTest();

		Integer messagesAmount = new CustomEmailMessageSelector().selectMessagesCount();

		Assert.areEqual(
			totalMessagesAmount,
			messagesAmount,
			'Should return total amount of messages'
		);

		Test.stopTest();
	}

	@IsTest
	private static void selectLastMessagesShouldReturnCorrectMessagesWhenAmountParamPassed() {
		Integer messagesToSelectAmount = 5;

		List<Custom_Email_Message__c> expectedMessages = [
			SELECT Id, Message_Id__c
			FROM Custom_Email_Message__c
			ORDER BY CreatedDate DESC
			LIMIT :messagesToSelectAmount
		];

		Test.startTest();

		List<Custom_Email_Message__c> actualMessages = new CustomEmailMessageSelector()
			.selectLastMessages(messagesToSelectAmount);

		Assert.areEqual(
			expectedMessages.size(),
			actualMessages.size(),
			'Should return correct amount of messages'
		);

		Map<Id, Custom_Email_Message__c> expectedMessagesMap = new Map<Id, Custom_Email_Message__c>(
			expectedMessages
		);
		Map<Id, Custom_Email_Message__c> actualMessagesMap = new Map<Id, Custom_Email_Message__c>(
			actualMessages
		);

		Boolean areMessageIdsEqual = expectedMessagesMap.keySet()
			.containsAll(actualMessagesMap.keyset());

		Assert.isTrue(areMessageIdsEqual, 'Should return correct messages');

		Test.stopTest();
	}

	@IsTest
	private static void selectMessagesWithOffsetShouldReturnCorrectMessagesWhenOffsetParamPassed() {
		Integer messagesLimit = 5;
		Integer offset = 5;

		List<Custom_Email_Message__c> expectedMessages = [
			SELECT Id
			FROM Custom_Email_Message__c
			ORDER BY CreatedDate DESC
			LIMIT :messagesLimit
			OFFSET :offset
		];

		Test.startTest();

		List<Custom_Email_Message__c> actualMessages = new CustomEmailMessageSelector()
			.selectMessagesWithOffset(messagesLimit, offset);

		Assert.areEqual(
			expectedMessages.size(),
			actualMessages.size(),
			'Should return correct amount of messages'
		);

		Map<Id, Custom_Email_Message__c> expectedMessagesMap = new Map<Id, Custom_Email_Message__c>(
			expectedMessages
		);
		Map<Id, Custom_Email_Message__c> actualMessagesMap = new Map<Id, Custom_Email_Message__c>(
			actualMessages
		);

		Boolean areMessageIdsEqual = expectedMessagesMap.keySet()
			.containsAll(actualMessagesMap.keyset());

		Assert.isTrue(areMessageIdsEqual, 'Should return correct messages');

		Test.stopTest();
	}
}

@IsTest
private class GmailPublicApiControllerTest {
	private static fflib_ApexMocks mocks = new fflib_ApexMocks();
	private static GmailPublicApiService serviceMock = (GmailPublicApiService) mocks.mock(
		GmailPublicApiService.class
	);

	@IsTest
	private static void getTotalMessagesAmountShouldReturnCorrectMessagesAmount() {
		GmailPublicApiController.service = serviceMock;

		Integer expectedTotalMessagesAmount = 10;

		mocks.startStubbing();
		mocks.when(serviceMock.getTotalMessagesAmount()).thenReturn(expectedTotalMessagesAmount);
		mocks.stopStubbing();

		Integer actualTotalMessagesAmount = GmailPublicApiController.getTotalMessagesAmount();

		Assert.areEqual(
			expectedTotalMessagesAmount,
			actualTotalMessagesAmount,
			'Should return correct messages amount'
		);

		((GmailPublicApiService) mocks.verify(serviceMock)).getTotalMessagesAmount();
	}

	@IsTest
	private static void getTotalMessagesAmountShouldThrowAuraHandledExceptionWhenServiceExceptionOccurs() {
		GmailPublicApiController.service = serviceMock;

		mocks.startStubbing();
		((GmailPublicApiService) mocks.doThrowWhen(
				new fflib_ApexMocks.ApexMocksException('Bad'),
				serviceMock
			))
			.getTotalMessagesAmount();
		mocks.stopStubbing();

		AuraHandledException ahe;
		try {
			Integer actualTotalMessagesAmount = GmailPublicApiController.getTotalMessagesAmount();
		} catch (AuraHandledException e) {
			ahe = e;
		}

		Assert.isTrue(ahe != null, 'Should throw AuraHandledException');

		((GmailPublicApiService) mocks.verify(serviceMock)).getTotalMessagesAmount();
	}

	@IsTest
	private static void retrieveMessagesShouldReturnCorrectMessagesWhenValidParamPassed() {
		GmailPublicApiController.service = serviceMock;

		List<Custom_Email_Message__c> messageRecords = generateMessageRecords();

		mocks.startStubbing();
		mocks.when(serviceMock.retrieveMessageRecords(fflib_Match.anyInteger()))
			.thenReturn(messageRecords);
		mocks.stopStubbing();

		List<Custom_Email_Message__c> actualMessageRecords = GmailPublicApiController.retrieveMessages(
			0
		);

		Assert.areEqual(
			messageRecords.size(),
			actualMessageRecords.size(),
			'Should return correct messages'
		);

		((GmailPublicApiService) mocks.verify(serviceMock))
			.retrieveMessageRecords(fflib_Match.anyInteger());
	}

	@IsTest
	private static void retrieveMessagesShouldThrowAuraHandledExceptionWhenServiceExceptionOccurs() {
		GmailPublicApiController.service = serviceMock;

		mocks.startStubbing();
		((GmailPublicApiService) mocks.doThrowWhen(
				new fflib_ApexMocks.ApexMocksException('Bad'),
				serviceMock
			))
			.retrieveMessageRecords(fflib_Match.anyInteger());
		mocks.stopStubbing();

		AuraHandledException ahe;
		try {
			List<Custom_Email_Message__c> actualMessageRecords = GmailPublicApiController.retrieveMessages(
				0
			);
		} catch (AuraHandledException e) {
			ahe = e;
		}

		Assert.isTrue(ahe != null, 'Should throw AuraHandledException');

		((GmailPublicApiService) mocks.verify(serviceMock))
			.retrieveMessageRecords(fflib_Match.anyInteger());
	}

	@IsTest
	private static void sendMessageShouldSendMessageWhenValidParamPassed() {
		GmailPublicApiController.service = serviceMock;

		String serializedMessageInfo = '{"toAddress":"test", "subject":"test", "messageText":"test"}';
		GmailPublicApiController.sendMessage(serializedMessageInfo);

		((GmailPublicApiService) mocks.verify(serviceMock)).sendMessage(serializedMessageInfo);
	}

	@IsTest
	private static void sendMessageShouldThrowAuraHandledExceptionWhenServiceExceptionOccurs() {
		GmailPublicApiController.service = serviceMock;

		mocks.startStubbing();
		((GmailPublicApiService) mocks.doThrowWhen(
				new fflib_ApexMocks.ApexMocksException('Bad'),
				serviceMock
			))
			.sendMessage(fflib_Match.anyString());
		mocks.stopStubbing();

		AuraHandledException ahe;
		try {
			String serializedMessageInfo = '{"toAddress":"test", "subject":"test", "messageText":"test"}';
			GmailPublicApiController.sendMessage(serializedMessageInfo);
		} catch (AuraHandledException e) {
			ahe = e;
		}

		Assert.isTrue(ahe != null, 'Should throw AuraHandledException');

		((GmailPublicApiService) mocks.verify(serviceMock)).sendMessage(fflib_Match.anyString());
	}

	private static List<Custom_Email_Message__c> generateMessageRecords() {
		List<Custom_Email_Message__c> messageRecords = new List<Custom_Email_Message__c>();

		Custom_Email_Message__c messageRecord = new Custom_Email_Message__c();
		messageRecord.Message_Id__c = 'Test1';
		messageRecord.Message_Text__c = 'Test';
		messageRecord.Sender_Email__c = 'test@email.com';
		messageRecord.Sender_Name__c = 'Test';
		messageRecord.Subject__c = 'Test';

		messageRecords.add(messageRecord);

		return messageRecords;
	}
}

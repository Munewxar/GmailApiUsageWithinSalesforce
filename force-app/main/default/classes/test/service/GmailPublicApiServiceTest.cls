@IsTest
private class GmailPublicApiServiceTest {
	private static fflib_ApexMocks mocks = new fflib_ApexMocks();

	private static CustomEmailMessageSelector selectorMock = (CustomEmailMessageSelector) mocks.mock(
		CustomEmailMessageSelector.class
	);
	private static GmailPublicApiCalloutExecutor calloutExecutorMock = (GmailPublicApiCalloutExecutor) mocks.mock(
		GmailPublicApiCalloutExecutor.class
	);
	private static GmailJsonParser parserMock = (GmailJsonParser) mocks.mock(GmailJsonParser.class);

	@IsTest
	private static void getTotalMessagesAmountShouldRetrunCorrectAmountOfMessages() {
		GmailPublicApiService service = new GmailPublicApiService();
		service.selector = selectorMock;

		Integer expectedTotalMessagesAmount = 10;

		mocks.startStubbing();
		mocks.when(selectorMock.selectMessagesCount()).thenReturn(expectedTotalMessagesAmount);
		mocks.stopStubbing();

		Integer actualTotalMessagesAmount = service.getTotalMessagesAmount();

		Assert.areEqual(
			expectedTotalMessagesAmount,
			actualTotalMessagesAmount,
			'Should return correct amount of messages'
		);

		((CustomEmailMessageSelector) mocks.verify(selectorMock)).selectMessagesCount();
	}

	@IsTest
	private static void sendMessageShouldCorrectlySendMessageWhenValidParamPassed() {
		GmailPublicApiService service = new GmailPublicApiService();
		service.calloutExecutor = calloutExecutorMock;

		Integer statusCodeSuccess = 200;

		mocks.startStubbing();
		mocks.when(calloutExecutorMock.sendMessage((Map<String, Object>) fflib_Match.anyObject()))
			.thenReturn(statusCodeSuccess);
		mocks.stopStubbing();

		String serializedMessageInfo = '{"toAddress":"test", "subject":"test", "messageText":"test"}';
		service.sendMessage(serializedMessageInfo);

		((GmailPublicApiCalloutExecutor) mocks.verify(calloutExecutorMock))
			.sendMessage((Map<String, Object>) fflib_Match.anyObject());
	}

	@IsTest
	private static void sendMessageShouldThrowCveWhenInvalidParamPassed() {
		GmailPublicApiService service = new GmailPublicApiService();
		GmailPublicApiService.ContractViolationException cve;

		try {
			service.sendMessage(null);
		} catch (GmailPublicApiService.ContractViolationException e) {
			cve = e;
		}

		Assert.isTrue(cve != null, 'Should throw CVE when invalid param passed');
	}

	@IsTest
	private static void sendMessageShouldThrowExceptionWhenReturnedStatusCodeIsError() {
		GmailPublicApiService service = new GmailPublicApiService();
		service.calloutExecutor = calloutExecutorMock;

		Integer statusCodeError = 403;

		mocks.startStubbing();
		mocks.when(calloutExecutorMock.sendMessage((Map<String, Object>) fflib_Match.anyObject()))
			.thenReturn(statusCodeError);
		mocks.stopStubbing();

		String serializedMessageInfo = '{"toAddress":"test", "subject":"test", "messageText":"test"}';

		GmailPublicApiService.GmailCalloutException gce;

		try {
			service.sendMessage(serializedMessageInfo);
		} catch (GmailPublicApiService.GmailCalloutException e) {
			gce = e;
		}

		Assert.isTrue(gce != null, 'Should throw GCE when status code error');

		((GmailPublicApiCalloutExecutor) mocks.verify(calloutExecutorMock))
			.sendMessage((Map<String, Object>) fflib_Match.anyObject());
	}

	@IsTest
	private static void retrieveMessageRecordsShouldReturnCorrectRecords() {
		GmailPublicApiService service = new GmailPublicApiService();
		service.selector = selectorMock;

		List<Custom_Email_Message__c> expectedMessageRecords = generateMessageRecords();

		mocks.startStubbing();
		mocks.when(
				selectorMock.selectMessagesWithOffset(
					fflib_Match.anyInteger(),
					fflib_Match.anyInteger()
				)
			)
			.thenReturn(expectedMessageRecords);
		mocks.stopStubbing();

		Integer datasetNumber = 1;
		List<Custom_Email_Message__c> actualMessageRecords = service.retrieveMessageRecords(
			datasetNumber
		);

		Assert.areEqual(
			expectedMessageRecords.size(),
			actualMessageRecords.size(),
			'Should return correct message records'
		);

		((CustomEmailMessageSelector) mocks.verify(selectorMock))
			.selectMessagesWithOffset(fflib_Match.anyInteger(), fflib_Match.anyInteger());
	}

	@IsTest
	private static void retrieveMessageRecordsShouldThrowCveWhenInvalidParamPassed() {
		GmailPublicApiService service = new GmailPublicApiService();
		GmailPublicApiService.ContractViolationException cve;

		try {
			List<Custom_Email_Message__c> messageRecords = service.retrieveMessageRecords(null);
		} catch (GmailPublicApiService.ContractViolationException e) {
			cve = e;
		}

		Assert.isTrue(cve != null, 'Should throw CVE when invalid param passed');
	}

	@IsTest
	private static void processEmailsShouldCollectMessagesThatAreNotAlreadyInsertedAndInsertThem() {
		GmailPublicApiService service = new GmailPublicApiService();
		service.selector = selectorMock;
		service.calloutExecutor = calloutExecutorMock;

		List<Custom_Email_Message__c> messageRecords = generateMessageRecords();
		insert messageRecords;

		mocks.startStubbing();
		mocks.when(calloutExecutorMock.retrieveMessageIds())
			.thenReturn(JsonResponsesContainer.MESSAGE_IDS_RESPONSE); // callout for message ids
		mocks.when(selectorMock.selectLastMessages(fflib_Match.anyInteger()))
			.thenReturn(messageRecords);
		mocks.when(calloutExecutorMock.retrieveMessageById(JsonResponsesContainer.MESSAGE_ID))
			.thenReturn(JsonResponsesContainer.MESSAGE_RESPONSE); // callout for message
		mocks.stopStubbing();

		Test.startTest();
		service.processEmails();
		Test.stopTest();

		Integer expectedAmountOfMessagesAfterProccessing = JsonResponsesContainer.parsedMessageIds.size();
		Integer actualTotalAmountOfMessagesAfterProcessing = [
			SELECT COUNT()
			FROM Custom_Email_Message__c
		];

		Assert.areEqual(
			expectedAmountOfMessagesAfterProccessing,
			actualTotalAmountOfMessagesAfterProcessing,
			'Should insert only not existing messages'
		);

		String messageId = JsonResponsesContainer.MESSAGE_ID;
		Custom_Email_Message__c messageRecord = [
			SELECT Message_Id__c
			FROM Custom_Email_Message__c
			WHERE Message_Id__c = :messageId
			LIMIT 1
		];

		Assert.isTrue(messageRecord != null, 'Should insert message to database');

		((GmailPublicApiCalloutExecutor) mocks.verify(calloutExecutorMock)).retrieveMessageIds();

		((GmailPublicApiCalloutExecutor) mocks.verify(calloutExecutorMock))
			.retrieveMessageById(JsonResponsesContainer.MESSAGE_ID);

		((CustomEmailMessageSelector) mocks.verify(selectorMock))
			.selectLastMessages(fflib_Match.anyInteger());
	}

	private static List<Custom_Email_Message__c> generateMessageRecords() {
		List<Custom_Email_Message__c> messageRecords = new List<Custom_Email_Message__c>();

		Custom_Email_Message__c messageRecord = new Custom_Email_Message__c();
		messageRecord.Message_Id__c = JsonResponsesContainer.MESSAGE_ID_FOR_FILTERING;
		messageRecord.Message_Text__c = 'Test';
		messageRecord.Sender_Email__c = 'test@email.com';
		messageRecord.Sender_Name__c = 'Test';
		messageRecord.Subject__c = 'Test';

		messageRecords.add(messageRecord);

		return messageRecords;
	}
}

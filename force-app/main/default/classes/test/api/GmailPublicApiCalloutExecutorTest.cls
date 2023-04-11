@IsTest
private class GmailPublicApiCalloutExecutorTest {
	private class SuccessMock implements HttpCalloutMock {
		public HttpResponse respond(HttpRequest request) {
			HttpResponse res = new HttpResponse();
			res.setHeader('Content-Type', 'application/json');
			res.setBody('{"test":"test"}');
			res.setStatusCode(200);
			return res;
		}
	}

	private class ErrorMock implements HttpCalloutMock {
		public HttpResponse respond(HttpRequest request) {
			HttpResponse res = new HttpResponse();
			res.setHeader('Content-Type', 'application/json');
			res.setBody('{"test":"test"}');
			res.setStatusCode(403);
			return res;
		}
	}

	@IsTest
	private static void retrieveMessageIdsShouldReturnCorrectResponseWhenStatusCodeSuccess() {
		Test.setMock(HttpCalloutMock.class, new SuccessMock());

		Test.startTest();

		GmailPublicApiCalloutExecutor calloutExecutor = new GmailPublicApiCalloutExecutor();
		String actualResponse = calloutExecutor.retrieveMessageIds();

		String expectedResponse = '{"test":"test"}';

		Assert.areEqual(
			expectedResponse,
			actualResponse,
			'Should return correct response when status code 200'
		);

		Test.stopTest();
	}

	@IsTest
	private static void retrieveMessageIdsShouldReturnEmptyResponseWhenStatusCodeError() {
		Test.setMock(HttpCalloutMock.class, new ErrorMock());

		Test.startTest();

		GmailPublicApiCalloutExecutor calloutExecutor = new GmailPublicApiCalloutExecutor();
		String actualResponse = calloutExecutor.retrieveMessageIds();

		Assert.areEqual(
			'',
			actualResponse,
			'Should return empty response when status code not 200'
		);

		Test.stopTest();
	}

	@IsTest
	private static void retrieveMessageByIdShouldReturnCorrectResponseWhenStatusCodeSuccess() {
		Test.setMock(HttpCalloutMock.class, new SuccessMock());

		Test.startTest();

		GmailPublicApiCalloutExecutor calloutExecutor = new GmailPublicApiCalloutExecutor();

		String messageId = 'Test1';
		String actualResponse = calloutExecutor.retrieveMessageById(messageId);

		String expectedResponse = '{"test":"test"}';

		Assert.areEqual(
			expectedResponse,
			actualResponse,
			'Should return correct response when status code 200'
		);

		Test.stopTest();
	}

	@IsTest
	private static void retrieveMessageByIdShouldReturnEmptyResponseWhenStatusCodeError() {
		Test.setMock(HttpCalloutMock.class, new ErrorMock());

		Test.startTest();

		GmailPublicApiCalloutExecutor calloutExecutor = new GmailPublicApiCalloutExecutor();

		String messageId = 'Test1';
		String actualResponse = calloutExecutor.retrieveMessageById(messageId);

		Assert.areEqual(
			'',
			actualResponse,
			'Should return correct response when status code not 200'
		);

		Test.stopTest();
	}

	@IsTest
	private static void sendMessageShouldReturnCorrectStatusCode() {
		Test.setMock(HttpCalloutMock.class, new SuccessMock());

		Test.startTest();

		GmailPublicApiCalloutExecutor calloutExecutor = new GmailPublicApiCalloutExecutor();

		Map<String, Object> messageInfo = new Map<String, Object>{
			'toAddress' => (Object) 'test',
			'subject' => (Object) 'test',
			'messageText' => (Object) 'test'
		};

		Integer actualStatusCode = calloutExecutor.sendMessage(messageInfo);

		Integer expectedStatusCode = 200;

		Assert.areEqual(expectedStatusCode, actualStatusCode, 'Should return correct status code');

		Test.stopTest();
	}

	private static void sendMessageShouldThrowExceptionWhenInvalidParametersPassed() {
		Test.setMock(HttpCalloutMock.class, new SuccessMock());

		Test.startTest();

		GmailPublicApiCalloutExecutor calloutExecutor = new GmailPublicApiCalloutExecutor();

		Map<String, Object> messageInfo = new Map<String, Object>();

		GmailPublicApiCalloutExecutor.InvalidArgumentException iaException = null;
		try {
			calloutExecutor.sendMessage(messageInfo);
		} catch (GmailPublicApiCalloutExecutor.InvalidArgumentException e) {
			iaException = e;
		}

		Assert.isTrue(iaException != null, 'Should throw exception when invalid params passed');

		Test.stopTest();
	}
}

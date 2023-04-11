@IsTest
private class ProcessEmailsSchedulerTest {
	private class RestMock implements HttpCalloutMock {
		public HttpResponse respond(HttpRequest request) {
			String responseJson = '';

			HTTPResponse res = new HTTPResponse();
			res.setHeader('Content-Type', 'text/json');
			res.setBody(responseJson);
			res.setStatusCode(200);

			return res;
		}
	}

	@IsTest
	private static void executeMethodShouldCorrectlyScheduleJob() {
		String cronExp = '0 0 13 * * ?';

		Test.setMock(HttpCalloutMock.class, new RestMock());

		Test.startTest();

		String jobId = System.schedule(
			'Test Process Emails',
			cronExp,
			new ProcessEmailsScheduler()
		);

		CronTrigger ctBeforeJobStarted = [
			SELECT Id, CronExpression, TimesTriggered, NextFireTime
			FROM CronTrigger
			WHERE Id = :jobId
		];

		Assert.areEqual(cronExp, ctBeforeJobStarted.CronExpression);
		Assert.areEqual(0, ctBeforeJobStarted.TimesTriggered);

		Test.stopTest();
	}
}

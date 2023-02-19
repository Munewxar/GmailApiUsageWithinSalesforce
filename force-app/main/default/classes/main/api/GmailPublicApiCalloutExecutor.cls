public with sharing class GmailPublicApiCalloutExecutor {
	private static final String RETRIEVE_MESSAGE_IDS_ENDPOINT = 'callout:Gmail_API/gmail/v1/users/test.public.api.sa@gmail.com/messages';
	private static final String RETRIEVE_MESSAGE_BY_ID_ENDPOINT = 'callout:Gmail_API/gmail/v1/users/test.public.api.sa@gmail.com/messages/';

	private static final Integer STATUS_CODE_SUCCESS = 200;

	public String retrieveMessageIds() {
		HttpResponse response = sendGetRequestToEndpoint(RETRIEVE_MESSAGE_IDS_ENDPOINT);

		if (response.getStatusCode() == STATUS_CODE_SUCCESS) {
			return response.getBody();
		}

		return '';
	}

	public String retrieveMessageById(String id) {
		String endpoint = RETRIEVE_MESSAGE_BY_ID_ENDPOINT + id;
		HttpResponse response = sendGetRequestToEndpoint(endpoint);

		if (response.getStatusCode() == STATUS_CODE_SUCCESS) {
			return response.getBody();
		}

		return response.getBody();
	}

	private HttpResponse sendGetRequestToEndpoint(String endpoint) {
		HttpRequest request = new HttpRequest();
		request.setEndpoint(endpoint);
		request.setMethod('GET');

		Http http = new Http();
		return http.send(request);
	}

	public void test() {
		// Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
		HttpRequest req = new HttpRequest();
		String toAddress = 'test.public.api.sa@gmail.com';
		String subject = 'Testing sending email from salesforce using GMail API';
		String mailBody = 'Testing sending email from salesforce using GMail API';
		String mbody =
			'{ "raw" : "' +
			EncodingUtil.base64Encode(
				Blob.valueof(
					'To: ' +
						toAddress +
						'\r\nContent-Type:text/plain; charset=utf-8;\r\nSubject: ' +
						subject +
						'\r\n\r\n' +
						mailBody
				)
			) +
			'"}';
		req.setHeader('Content-Length', mbody.length() + '');
		req.setHeader('Content-Type', 'application/json');

		req.setEndpoint(
			'callout:Gmail_API/gmail/v1/users/test.public.api.sa@gmail.com/messages/send'
		);
		//req.setEndpoint('https://gmail.googleapis.com');
		req.setMethod('POST');
		system.debug(mbody);
		req.setBody(mbody);
		// Send the request, and return a response
		Http h = new Http();
		HttpResponse res = h.send(req);
		system.debug(res);
	}
}

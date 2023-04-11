public with sharing class GmailPublicApiCalloutExecutor {
	private static final String RETRIEVE_MESSAGE_IDS_ENDPOINT = 'callout:Gmail_API/gmail/v1/users/test.public.api.sa@gmail.com/messages';
	private static final String RETRIEVE_MESSAGE_BY_ID_ENDPOINT = 'callout:Gmail_API/gmail/v1/users/test.public.api.sa@gmail.com/messages/';
	private static final String SEND_MESSAGE_ENDPOINT = 'callout:Gmail_API/gmail/v1/users/test.public.api.sa@gmail.com/messages/send';

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

	public Integer sendMessage(Map<String, Object> messageInfo) {
		String messageBody = generateMessageBody(messageInfo);
		HttpRequest request = generateSendMessageRequest(messageBody);

		Http http = new Http();
		HttpResponse response = http.send(request);

		return response.getStatusCode();
	}

	private String generateMessageBody(Map<String, Object> messageInfo) {
		String toAddress = messageInfo.get('toAddress').toString();
		String subject = messageInfo.get('subject').toString();
		String messageText = messageInfo.get('messageText').toString();

		String messageBody =
			'{ "raw" : "' +
			EncodingUtil.base64Encode(
				Blob.valueof(
					'To: ' +
						toAddress +
						'\r\nContent-Type:text/plain; charset=utf-8;\r\nSubject: ' +
						subject +
						'\r\n\r\n' +
						messageText
				)
			) +
			'"}';

		return messageBody;
	}

	private HttpRequest generateSendMessageRequest(String messageBody) {
		HttpRequest request = new HttpRequest();

		request.setHeader('Content-Length', messageBody.length() + '');
		request.setHeader('Content-Type', 'application/json');
		request.setEndpoint(SEND_MESSAGE_ENDPOINT);
		request.setMethod('POST');
		request.setBody(messageBody);

		return request;
	}
}

public with sharing class GmailJsonParser {
	private static final String ID_TOKEN = 'id';
	private Integer maxMessagesAmount;

	public GmailJsonParser(Integer maxMessagesAmount) {
		this.maxMessagesAmount = maxMessagesAmount;
	}

	public List<String> parseMessageIds(String messageIdsResponse) {
		List<String> messageIds = new List<String>();

		JSONParser parser = JSON.createParser(messageIdsResponse);

		Integer idsCounter = 0;

		while (parser.nextToken() != null && idsCounter < maxMessagesAmount) {
			Boolean isCurrentTokenIdFieldName =
				parser.getCurrentToken() == JSONToken.FIELD_NAME &&
				parser.getText() == ID_TOKEN;

			if (isCurrentTokenIdFieldName) {
				parser.nextToken();
				String id = parser.getText();
				messageIds.add(id);

				idsCounter++;
			}
		}

		return messageIds;
	}

	public String decodeMessage(String message) {
		if (message == null) {
			return '';
		}

		String formattedMessage = message.replace('-', '+');
		formattedMessage = formattedMessage.replace('_', '/');

		return EncodingUtil.base64Decode(formattedMessage).toString().trim();
	}

	public String parseSenderName(String sender) {
		if (sender == null) {
			return '';
		}

		if (!sender.contains('\u003c')) {
			return sender;
		}

		// sender received like: Mike Tyson <mike.tyson@gmail.com>
		return sender.substringBefore('\u003c').replaceAll('"', '').trim();
	}

	public String parseSenderEmail(String sender) {
		if (sender == null) {
			return '';
		}

		if (!sender.contains('\u003c')) {
			return sender;
		}

		// sender received like: Mike Tyson <mike.tyson@gmail.com>
		return sender.substringBetween('\u003c', '\u003e').trim();
	}
}

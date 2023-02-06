public with sharing class GmailJsonParser {
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
				parser.getText() == 'id';

			if (isCurrentTokenIdFieldName) {
				parser.nextToken();
				String id = parser.getText();
				messageIds.add(id);

				idsCounter++;
			}
		}

		return messageIds;
	}

	public MessageDto parseMessage(String messageResponse) {
		JSONParser parser = JSON.createParser(messageResponse);

		String id = '';
		String fromValue = '';
		String subjectValue = '';
		String messageValue = '';

		while (parser.nextToken() != null) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'id') {
				parser.nextToken();

				id = parser.getText();
			} else if (
				parser.getCurrentToken() == JSONToken.VALUE_STRING &&
				parser.getText() == 'From'
			) {
				parser.nextToken();
				parser.nextToken();

				fromValue = parser.getText();
			} else if (
				parser.getCurrentToken() == JSONToken.VALUE_STRING &&
				parser.getText() == 'Subject'
			) {
				parser.nextToken();
				parser.nextToken();

				subjectValue = parser.getText();
			} else if (
				parser.getCurrentToken() == JSONToken.FIELD_NAME &&
				parser.getText() == 'data'
			) {
				parser.nextToken();

				String encodedMessage = parser.getText();
				messageValue = decodeMessage(encodedMessage);

				break;
			}
		}

		return new MessageDto(id, fromValue, subjectValue, messageValue);
	}

	private String decodeMessage(String message) {
		String formattedMessage = message.replace('-', '+');
		formattedMessage = formattedMessage.replace('_', '/');

		return EncodingUtil.base64Decode(formattedMessage).toString();
	}
}

@IsTest
private class MessageDtoTest {
	@IsTest
	private static void parseShouldParseProvidedJson() {
		MessageDto dto = MessageDto.parse(JsonResponsesContainer.MESSAGE_RESPONSE);

		Assert.isTrue(dto != null, 'Should parse provided JSON');
	}
}

public with sharing class MessageDto {
	@AuraEnabled
	public String id;
	@AuraEnabled
	public String fromValue;
	@AuraEnabled
	public String subjectValue;
	@AuraEnabled
	public String messageValue;

	public MessageDto(String id, String fromValue, String subjectValue, String messageValue) {
		this.id = id;
		this.fromValue = fromValue;
		this.subjectValue = subjectValue;
		this.messageValue = messageValue;
	}
}

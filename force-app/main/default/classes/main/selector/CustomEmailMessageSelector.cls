public with sharing class CustomEmailMessageSelector {
	public Integer selectMessagesCount() {
		return [SELECT COUNT() FROM Custom_Email_Message__c];
	}

	public List<Custom_Email_Message__c> selectLastMessages(Integer messagesAmount) {
		return [
			SELECT Id, Message_Id__c
			FROM Custom_Email_Message__c
			ORDER BY CreatedDate DESC
			LIMIT :messagesAmount
		];
	}

	public List<Custom_Email_Message__c> selectMessagesWithOffset(
		Integer messagesLimit,
		Integer offset
	) {
		return [
			SELECT Id, Message_Id__c, Subject__c, Sender_Name__c, Sender_Email__c, Message_Text__c
			FROM Custom_Email_Message__c
			ORDER BY CreatedDate DESC
			LIMIT :messagesLimit
			OFFSET :offset
		];
	}
}

public with sharing class CustomEmailMessageSelector {
	public static List<Custom_Email_Message__c> selectMessages() {
		Map<Id, Custom_Email_Message__c> messageIdToMessageMap = new Map<Id, Custom_Email_Message__c>(
			[
				SELECT Id
				FROM Custom_Email_Message__c
				ORDER BY CreatedDate DESC
				LIMIT 100
			]
		);

		return messageIdToMessageMap;
	}

	public static List<Custom_Email_Message__c> selectMessagesWithOffset(Integer offset) {
		return [
			SELECT Id, Message_Id__c, Subject__c, Sender_Name__c, Sender_Email__c, Message_Text__c
			FROM Custom_Email_Message__c
			ORDER BY CreatedDate DESC
			LIMIT 50
			OFFSET :offset
		];
	}
}

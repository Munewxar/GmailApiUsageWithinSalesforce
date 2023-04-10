public with sharing class CustomEmailMessageSelector {
	public static Integer selectMessagesCount() {
		return [SELECT COUNT() FROM Custom_Email_Message__c];
	}

	public static List<Custom_Email_Message__c> selectLastHundredMessages() {
		return [
			SELECT Id, Message_Id__c
			FROM Custom_Email_Message__c
			ORDER BY CreatedDate DESC
			LIMIT 100
		];
	}

	public static List<Custom_Email_Message__c> selectMessagesWithOffset(Integer offset) {
		return [
			SELECT Id, Message_Id__c, Subject__c, Sender_Name__c, Sender_Email__c, Message_Text__c
			FROM Custom_Email_Message__c
			ORDER BY CreatedDate DESC
			LIMIT 10
			OFFSET :offset
		];
	}
}

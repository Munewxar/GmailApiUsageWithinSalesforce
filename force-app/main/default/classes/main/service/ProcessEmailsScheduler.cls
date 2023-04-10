global class ProcessEmailsScheduler implements Schedulable {
	global void execute(SchedulableContext sc) {
		ProcessEmailsHandler.callProcessEmails();
	}
}

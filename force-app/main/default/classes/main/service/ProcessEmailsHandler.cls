public class ProcessEmailsHandler {
	@future(callout=true)
	public static void callProcessEmails() {
		GmailPublicApiService service = new GmailPublicApiService();
		service.processEmails();
	}
}

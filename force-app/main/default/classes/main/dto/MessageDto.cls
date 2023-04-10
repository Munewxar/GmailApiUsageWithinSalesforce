public with sharing class MessageDto {
	public String id;
	public String threadId;
	public List<String> labelIds;
	public String snippet;
	public Payload payload;
	public Integer sizeEstimate;
	public String historyId;
	public String internalDate;

	public class Payload {
		public String partId;
		public String mimeType;
		public String filename;
		public List<Headers> headers;
		public Body body;
		public List<Parts> parts;
	}

	public class Headers {
		public String name;
		public String value;
	}

	public class Body {
		public Integer size;
	}

	public class Parts {
		public String partId;
		public String mimeType;
		public String filename;
		public List<Headers> headers;
		public PartBody body;
	}

	public class PartBody {
		public Integer size;
		public String data;
	}

	public static MessageDto parse(String json) {
		return (MessageDto) System.JSON.deserialize(json, MessageDto.class);
	}
}
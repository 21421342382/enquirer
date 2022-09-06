class Chat {
  Chat({
    required this.documentName,
    required this.documentString,
    required this.message,
    required this.receiver,
    required this.sender,
    required this.sentOrReceived,
    required this.time,
  });

  String documentName;
  String documentString;
  String message;
  String receiver;
  String sender;
  String sentOrReceived;
  String time;

  String get messageTime => time.split(" ").reversed.skip(2).toList().reversed.join(" ");

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      documentName: json["document_name"],
      documentString: json["document_string"],
      message: json["message"],
      receiver: json["receiver"],
      sender: json["sender"],
      sentOrReceived: json["sent_or_received"],
      time: json["time"],
    );
  }
}

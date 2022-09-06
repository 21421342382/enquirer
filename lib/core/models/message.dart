class Message {
  Message({
    required this.direction,
    required this.message,
    required this.profilePic,
    required this.sentBy,
    required this.sentById,
    required this.sentTo,
    required this.sentToId,
    required this.time,
  });

  String direction;
  String message;
  String profilePic;
  String sentBy;
  String sentById;
  String sentTo;
  String sentToId;
  String time;

  String get date => time.split(" ").reversed.skip(2).toList().reversed.join(" ");

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      direction: json["direction"],
      message: json["message"],
      profilePic: json["profile_pic"],
      sentBy: json["sent_by"],
      sentById: json["sent_by_id"].toString(),
      sentTo: json["sent_to"],
      sentToId: json["sent_to_id"].toString(),
      time: json["time"],
    );
  }
}

class MessageType {
  static final String sent = "sent";
  static final String received = "received";
}

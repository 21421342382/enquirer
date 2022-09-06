import 'package:arcopen_enquirer/core/models/message.dart';

class UserChatsResponse {
  UserChatsResponse({
    required this.messages,
  });

  List<Message> messages;

  factory UserChatsResponse.fromJson(Map<String, dynamic> json) {
    return UserChatsResponse(
      messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    );
  }
}

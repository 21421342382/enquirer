import 'package:arcopen_enquirer/core/models/chat.dart';

class ChatMessagesResponse {
  ChatMessagesResponse({
    required this.canSendMessage,
    required this.messages,
  });

  bool canSendMessage;
  List<Chat> messages;

  factory ChatMessagesResponse.fromJson(Map<String, dynamic> json) {
    return ChatMessagesResponse(
      canSendMessage: json["can_send_message"],
      messages: List<Chat>.from(json["messages"].map((x) => Chat.fromJson(x))),
    );
  }
}

import 'package:arcopen_enquirer/http/exceptions/request_exception.dart';
import 'package:arcopen_enquirer/http/responses/chat_messages_response.dart';
import 'package:arcopen_enquirer/http/responses/user_chats_response.dart';
import 'package:arcopen_enquirer/utils/repositories/base_repository.dart';
import 'package:dio/dio.dart';

class ChatsRepository extends BaseRepository {
  final String basePath = "/chats/api";

  Future<UserChatsResponse> allUserChats({required String userId}) async {
    try {
      final Response response = await client.get(path: "$basePath/allUserChats/$userId");
      return UserChatsResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<ChatMessagesResponse> chatMessages({required String userId, required String sentToId}) async {
    try {
      final Response response = await client.post(path: "$basePath/chatMessages/$userId", args: {
        "sent_to": sentToId,
      });
      return ChatMessagesResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }
}

import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/message.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/mixins/toast_mixin.dart';
import 'package:arcopen_enquirer/utils/repositories/chats_repository.dart';
import 'package:arcopen_enquirer/utils/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class InboxListController extends BaseController with ToastMixin {
  static final InboxListController shared = InboxListController();

  List<Message> messages = [];

  final TextEditingController searchController = TextEditingController();
  final ChatsRepository repository = ChatsRepository();
  void getInboxList() {
    setState(() {
      state = LoadingState.loading;
    });
    repository.allUserChats(userId: Okito.use<AuthService>().user.id).then((value) {
      setState(() {
        state = LoadingState.success;
        messages = value.messages;
      });
    }).catchError((e) {
      setState(() {
        state = LoadingState.failed;
      });
      this.showErrorToast("Failed to load chats. Please try again later.");
    });
  }

  filterData(String value) {
    if (value.isEmpty)
      getInboxList();
    else
      setState(() {
        messages = messages.where((element) {
          return element.message.toLowerCase().contains(value.toLowerCase()) || element.sentTo.toLowerCase().contains(value.toLowerCase()) || element.sentBy.toLowerCase().contains(value.toLowerCase()) || element.time.toLowerCase().contains(value.toLowerCase());
        }).toList();
      });
  }
}

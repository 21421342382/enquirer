import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/k_card.dart';
import 'package:arcopen_enquirer/http/requests/add_card_request.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/mixins/dialog_mixin.dart';
import 'package:arcopen_enquirer/utils/repositories/subscriptions_repository.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:okito/okito.dart';

class PayBodyController extends BaseController with DialogMixin {
  PayBodyController._internal();
  static final PayBodyController _singleton = PayBodyController._internal();

  final _repository = SubscriptionsRepository();
  List<KCard> cards = [];
  String? cardNumber;
  String? nameOnCard;
  String? expiryDate;
  String? cardType;
  String? cvv;

  factory PayBodyController() {
    return _singleton;
  }

  getCards() {
    setState(() {
      state = LoadingState.loading;
    });
    _repository.getCards().then((value) {
      setState(() {
        state = LoadingState.success;
      });
      cards = value.cards;
    }).catchError((e) {
      setState(() {
        state = LoadingState.failed;
      });
    });
  }

  addCard() {
    KLoader().show();

    _repository
        .addCard(
            request: AddCardRequest(
      cardNumber: cardNumber!,
      nameOnCard: nameOnCard!,
      expiryDate: expiryDate!,
      cardType: cardType!,
      cvv: cvv!,
    ))
        .then((value) {
      KLoader.hide();
      Okito.pop(result: true);
    }).catchError((e) {
      KLoader.hide();
      showErrorToast(e);
    });
  }
}

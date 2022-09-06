import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/k_card.dart';
import 'package:arcopen_enquirer/http/requests/add_card_request.dart';
import 'package:arcopen_enquirer/utils/repositories/subscriptions_repository.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:credit_card_input_form/model/card_info.dart';

class AddCardController extends BaseController {
  AddCardController._internal();

  static final AddCardController _singleton = AddCardController._internal();

  factory AddCardController() {
    return _singleton;
  }

  SubscriptionsRepository repository = SubscriptionsRepository();

  CardInfo? cardInfo;
  KCard? kCard;
  List<KCard> exitingCards = [];

  String retrieveTypeOfCard(String cardNumber) {
    final String formattedCardNumber = cardNumber.replaceAll(" ", "");
    if (formattedCardNumber.contains(RegExp(r'^4[0-9]{6,}$'))) {
      return "Visa";
    } else if (formattedCardNumber.contains(RegExp(
        r"^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}$"))) {
      return "MasterCard";
    } else if (formattedCardNumber.contains(RegExp(r"^3[47][0-9]{5,}$"))) {
      return "American Express";
    } else if (formattedCardNumber
        .contains(RegExp(r"^6(?:011|5[0-9]{2})[0-9]{3,}$"))) {
      return "Discover";
    } else if (formattedCardNumber
        .contains(RegExp(r"^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"))) {
      return "Diners Club";
    } else if (formattedCardNumber
        .contains(RegExp(r"^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"))) {
      return "JCB";
    } else {
      return "Unknown";
    }
  }

  void addPaymentMethod() {
    if (cardInfo != null) {
      if (exitingCards
          .where((element) => element.cardNumber == cardInfo!.cardNumber)
          .isNotEmpty) {
        this.showErrorToast("You've already added this card.");
        return;
      }
      if ((int.tryParse(cardInfo!.validate!.split("/").first) ?? 0) > 12) {
        this.showErrorToast("Invalid validity date.");
        return;
      }
      KLoader().show();
      repository
          .addCard(
              request: AddCardRequest(
                  cardNumber: cardInfo!.cardNumber!,
                  nameOnCard: cardInfo!.name!,
                  expiryDate: cardInfo!.validate!,
                  cardType: retrieveTypeOfCard(cardInfo!.cardNumber!),
                  cvv: cardInfo!.cvv!))
          .then((value) async {
        KLoader.hide();
        this.showSuccessToast("Payment method successfully added.");
      }).catchError((e) {
        KLoader.hide();
        this.showErrorToast(e.message);
      });
    } else {
      this.showErrorToast("Please fill all the card info.");
    }
  }
}

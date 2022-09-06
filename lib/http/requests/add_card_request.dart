import 'package:arcopen_enquirer/http/requests/base_request.dart';

class AddCardRequest extends BaseRequest {
  AddCardRequest(
      {required this.cardNumber,
      required this.nameOnCard,
      required this.expiryDate,
      required this.cardType,
      required this.cvv});

  final String cardNumber;
  final String nameOnCard;
  final String expiryDate;
  final String cardType;
  final String cvv;

  Map<String, dynamic> toJson() => {
        "card_number": cardNumber,
        "name_on_card": nameOnCard,
        "expiry_date": expiryDate,
        "card_type": cardType,
        "cvv": cvv
      };
}
